package com.sbs.hsb.ex1.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.hsb.ex1.dto.Board;
import com.sbs.hsb.ex1.dto.BoardApplyDoc;
import com.sbs.hsb.ex1.dto.Member;
import com.sbs.hsb.ex1.dto.Reply;
import com.sbs.hsb.ex1.dto.ReportDoc;
import com.sbs.hsb.ex1.dto.ResultData;
import com.sbs.hsb.ex1.service.BoardService;
import com.sbs.hsb.ex1.util.Util;

@Controller
public class BoardController {
	@Autowired
	private BoardService boardService;

	//신청서 리스트
	@RequestMapping("/usr/board/boardApplyList")
	public String showBoardApplyList(Model model) {
		// 페이징은 나중		
		List<BoardApplyDoc> BoardApplyDocs = boardService.getAllBoardApplyDocs();
		
		model.addAttribute("BoardApplyDocs", BoardApplyDocs);
		
		return "board/boardApplyList";
	}
	

	@RequestMapping("/usr/board/createBoard")
	public String showCreateBoard(Model model) {

		return "board/createBoard";
	}

	//create-board-jsp
	@RequestMapping("/usr/board/doSendBoardApplyDoc")
	public String doCreateBoard(@RequestParam Map<String, Object> param, HttpServletRequest req, Model model) {
		int loginedMemberId = (int) req.getAttribute("loginedMemberId");
		param.put("memberId", loginedMemberId);

		int newBoardApplyDocId = boardService.setBoardApplyDoc(param); // 신청서 저장

		if( newBoardApplyDocId == 1 ) {
			model.addAttribute("redirectUri", "/usr/board/createBoard");
			model.addAttribute("alertMsg", "옳바른 정보를 입력해주세요.");

			return "common/redirect";
		}
		
		String redirectUri = (String) param.get("redirectUri");
		model.addAttribute("redirectUri", redirectUri);
		model.addAttribute("alertMsg", "신청 완료!");
		// 추후에 myPage로 바로 이동 예정

		return "common/redirect";
	}

	// 게시판 증설 신청 name 중복 방지
	@RequestMapping("/usr/board/getNameDup")
	@ResponseBody
	public ResultData getNameDup(@RequestParam Map<String, Object> param, Model model) {
		String name = "";
		if (param.get("name").equals("")) {
			return new ResultData("X-1", "");
		}

		name = (String) param.get("name");
		return boardService.checkBoardNameable(name);
	}
	
	// 승인
	@RequestMapping("/usr/board/doBoardApply")
	public String doApplyForCreateBoard(@RequestParam Map<String, Object> param, Model model) {
		String randomCode = Util.getRandomPassword(10);
		boardService.getBoardCodeDup(randomCode);// 현재 생성된 board 랜덤 코드 중복 방지
		param.put("code", randomCode);// 랜덤 코드
		
		int newCreateBoard = boardService.doApplyForCreateBoard(param);// 커뮤니티 보드 만들기

		param.put("boardId", newCreateBoard);
//		boardService.docApplyConfirm(param);// 신청서에 applyStatus = 1
		boardService.doDelDocNameDup((String) param.get("name"));// 같은 이름으로 신청된 신청서들 전부 삭제 
		
		String redirectUri = (String) param.get("redirectUri");
		model.addAttribute("redirectUri", redirectUri);
		
		return "common/redirect";
	}
	
	// 거절
	@RequestMapping("/usr/board/doBoardReject")
	public String doBoardReject(@RequestParam Map<String, Object> param, Model model) {
		boardService.doBoardReject(param);// 커뮤니티 신청 거절
		
		String redirectUri = (String) param.get("redirectUri");
		model.addAttribute("redirectUri", redirectUri);
		
		return "common/redirect";
	}
	
	// 신고 목록
	@RequestMapping("/usr/board/{boardCode}-reportList")
	public String showReportList(Model model, @PathVariable("boardCode") String boardCode, HttpServletRequest req) {
		model.addAttribute("boardCode", boardCode);
		
		
		int loginedMemberId = (int) req.getAttribute("loginedMemberId");
		Board board = boardService.getBoardByCodeAndMId(boardCode, loginedMemberId);// 게시판 가져오기
		
		// 신고Doc 리스트 가져오기
		List<ReportDoc> reportDocs = boardService.getBAReportList(board.getId());
		
		
		for(ReportDoc reportDoc : reportDocs) {
			if(reportDoc.getReportType().equals("ba1")) {
				reportDoc.setReportType("부적절한 홍보 게시글");
			}
			if(reportDoc.getReportType().equals("ba2")) {
				reportDoc.setReportType("음란성 또는 청소년에게 부적합한 내용");
			}
			if(reportDoc.getReportType().equals("ba3")) {
				reportDoc.setReportType("명예훼손/사생활 침해 및 저작권침해등");
			}
			if(reportDoc.getReportType().equals("ba4")) {
				reportDoc.setReportType("기타");
			}
		}
		
		
		model.addAttribute("reportDocs", reportDocs);
	
		
		return "board/reportList";
	}
	
	// 신고 삭제
	@RequestMapping("/usr/board/doDeleteReportAjax")
	@ResponseBody
	public ResultData doDeleteReportAjax(int id, HttpServletRequest req) {
		boardService.deleteReport(id);

		return new ResultData("S-1", String.format("삭제되었습니다.", id));
	}

	//////////////////////////////MY-PAGE///////////////////////////////
	
	// 내 신청서 목록
	@RequestMapping("/usr/board/myPageBoardApplyList")
	public String showMyPageBoardApplyList(Model model, HttpServletRequest req) {
		int loginedMemberId = (int) req.getAttribute("loginedMemberId");
		
		List<BoardApplyDoc> myBoardApplyList = boardService.getMyBoardApplyList(loginedMemberId);
		
		model.addAttribute("myBoardApplyList", myBoardApplyList);
		
		return "board/myPageBoardApplyList";
	}
	
	// 내 커뮤니티 목록
	@RequestMapping("/usr/board/myPageBoardList")
	public String showMyPageBoardList(Model model, HttpServletRequest req) {
		int loginedMemberId = (int) req.getAttribute("loginedMemberId");
		
		List<Board> myBoardList = boardService.getMyBoardList(loginedMemberId);
		
		model.addAttribute("myBoardList", myBoardList);
		System.out.println("myBoardList : " + myBoardList);
		
		return "board/myPageBoardList";
	}
	 
	// 내 커뮤니티 관리	
	@RequestMapping("/usr/board/{boardCode}-manager")
	public String showDetail(Model model, @PathVariable("boardCode") String boardCode, HttpServletRequest req) {
		int loginedMemberId = (int) req.getAttribute("loginedMemberId");
		
		Board board = boardService.getBoardByCodeFromManager(boardCode, loginedMemberId);// 게시판 가져오기
		model.addAttribute("board", board);
		
		return "board/manager";
	}
	
	// 보드 수정
	@RequestMapping("/usr/board/{boardCode}-doBoardModify")
	public String doBoardModify(@RequestParam Map<String, Object> param, Model model, @PathVariable("boardCode") String boardCode) {
		
		boardService.changeRelIdForBoardDoorImg(param);//대문이미지 relId 변경
		
		String redirectUri = (String) param.get("redirectUri");
		model.addAttribute("redirectUri", redirectUri);

		return "common/redirect";
	}
	
	
	// 임시
	@RequestMapping("/usr/board/getBoard")
	@ResponseBody
	public ResultData doGetBoard(@RequestParam Map<String, Object> param, String data) {
		
		System.out.println("파람 " + param);
		System.out.println("아래 : " + data);
		
		Board board = boardService.getBoardByCode(param);
		
		System.out.println("보드 " + board);
		
		return new ResultData("S-1", "hi?", "board", board);
	}
}
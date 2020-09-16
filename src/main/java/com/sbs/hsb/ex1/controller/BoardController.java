package com.sbs.hsb.ex1.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.hsb.ex1.dto.BoardApplyDoc;
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
	
	@RequestMapping("/usr/board/doBoardApply")
	public String doApplyForCreateBoard(@RequestParam Map<String, Object> param, Model model) {
		String randomCode = Util.getRandomPassword(10);
		param.put("code", randomCode);
		
		int newCreateBoard = boardService.doApplyForCreateBoard(param);
		System.out.println("hihihi: " + newCreateBoard); 
		param.put("boardId", newCreateBoard);
		boardService.docApplyConfirm(param);
		boardService.doDelDocNameDup((String) param.get("name"));
		
		String redirectUri = (String) param.get("redirectUri");
		model.addAttribute("redirectUri", redirectUri);
		
		return "common/redirect";
	}
	
	@RequestMapping("/usr/board/doBoardReject")
	public String doBoardReject(@RequestParam Map<String, Object> param, Model model) {
		boardService.doBoardReject(param);
		
		String redirectUri = (String) param.get("redirectUri");
		model.addAttribute("redirectUri", redirectUri);
		
		return "common/redirect";
	}
	//////////////////////////////MY-PAGE///////////////////////////////
	
	// 내 신청서 목록
	@RequestMapping("/usr/board/myPageBoardList")
	public String showMyPageBoardList(Model model, HttpServletRequest req) {
		int loginedMemberId = (int) req.getAttribute("loginedMemberId");
		
		List<BoardApplyDoc> myBoardList = boardService.getMyBoardList(loginedMemberId);
		
		model.addAttribute("myBoardList", myBoardList);
		System.out.println("myBoardList : " + myBoardList);
		
		return "board/myPageBoardList";
	}
	
}
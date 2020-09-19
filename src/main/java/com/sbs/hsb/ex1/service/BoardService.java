package com.sbs.hsb.ex1.service;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.hsb.ex1.dao.BoardDao;
import com.sbs.hsb.ex1.dao.FileDao;
import com.sbs.hsb.ex1.dto.Board;
import com.sbs.hsb.ex1.dto.BoardApplyDoc;
import com.sbs.hsb.ex1.dto.File;
import com.sbs.hsb.ex1.dto.ResultData;
import com.sbs.hsb.ex1.util.Util;

@Service
public class BoardService {

	@Autowired
	private BoardDao boardDao;
	@Autowired
	private FileService fileService;
	@Autowired
	private FileDao fileDao;
	
	// 커뮤니티 보드 만들기
	public int doApplyForCreateBoard(Map<String, Object> param) {
		boardDao.doApplyForCreateBoard(param);// 커뮤니티 보드 만들기
		
		return boardDao.getBoardId(param);// 만들어진 커뮤니티 보드의 id가져오기
	}
	
	// 신청서에 applyStatus = 1
//	public void docApplyConfirm(Map<String, Object> param) {
//		boardDao.docApplyConfirm(param);
//	}
	
	// 커뮤니티 신청 거절
	public void doBoardReject(Map<String, Object> param) {
		boardDao.doBoardReject(param);
	}

	//신청서 저장
	public int setBoardApplyDoc(Map<String, Object> param) {
		//신청서이름과 현재존재하는 커뮤니티 이름을 비교
		int count = boardDao.getBoardNameDupCount((String) param.get("name"));
		
		if ( count == 1) {
			return count;
		}
		
		//신청서 저장
		boardDao.setBoardApplyDoc(param);
		
		return 0;
	}
	
	
	// 게시판 증설 신청 name 중복 방지
	public ResultData checkBoardNameable(String name) {
		int count = boardDao.getBoardNameDupCount(name);
		
		if (count == 0) {
			return new ResultData("S-1", "개설 가능한 커뮤니티 명입니다.", "loginId", name);
		}

		return new ResultData("F-1", "이미 존재하는 커뮤니티 입니다.", "loginId", name);
	}

	// 신청서 리스트
	public List<BoardApplyDoc> getAllBoardApplyDocs() {
		return boardDao.getAllBoardApplyDocs();
	}

	// 같은 이름으로 신청된 신청서들 전부 삭제 단, applyStatus = 1인 신청서 하나만 남긴다
	public void doDelDocNameDup(String name) {
		boardDao.doDelDocNameDup(name);
	}

	// 내 신청서 목록
	public List<BoardApplyDoc> getMyBoardApplyList(int loginedMemberId) {
		return boardDao.getMyBoardApplyList(loginedMemberId);
	}

	// 내 커뮤니티 목록
	public List<Board> getMyBoardList(int loginedMemberId) {
		return boardDao.getMyBoardList(loginedMemberId);
	}

	// 현재 생성된 board 랜덤 코드 중복 방지
	public int getBoardCodeDup(String randomCode) {
		int boardCodedup = -1;
		
		while( true ) {
			boardCodedup = boardDao.getBoardCodeDup(randomCode); 
			// 현재 생성된 board 랜덤 코드가, 기존 board 코드와 중복이 있는가
			
			if(boardCodedup == 0) {
				break;
			}
		}
		return boardCodedup;
	}

	// 보드 가져오기
	public Board getBoardByCodeFromManager(String boardCode, int loginedMemberId) {
		Board board = boardDao.getBoardByCodeFromManager(boardCode, loginedMemberId);
		
//		updateForPrintInfo(member);
		
		List<File> files = fileService.getFiles("board", board.getId() , "common", "doorImg");

		Map<String, File> filesMap = new HashMap<>();

		for (File file : files) {
			filesMap.put(file.getFileNo() + "", file);
		}
		
		System.out.println("filesMap : " + filesMap);

		Util.putExtraVal(board, "file__common__doorImg", filesMap);
		
		return board;
	}

	
	// 대문이미지 relId변경
	public void changeRelIdForBoardDoorImg(Map<String, Object> param) {
		int id = Util.getAsInt(param.get("id"));
		

		if(param.get("fileIdsStr").toString().length() != 0) { // input한 이미지가 있을 경우에만
			fileDao.deleteFiles("board", id);// 기존 회원 프로필 삭제
		}


		String fileIdsStr = (String) param.get("fileIdsStr");

		if (fileIdsStr != null && fileIdsStr.length() > 0) {
			fileIdsStr = fileIdsStr.trim();

			if (fileIdsStr.startsWith(",")) {
				fileIdsStr = fileIdsStr.substring(1);
			}
		}

		if (fileIdsStr != null && fileIdsStr.length() > 0) {
			fileIdsStr = fileIdsStr.trim();

			if (fileIdsStr.equals(",")) {
				fileIdsStr = "";
			}
		}

		if (fileIdsStr != null && fileIdsStr.length() > 0) {
			List<Integer> fileIds = Arrays.asList(fileIdsStr.split(",")).stream().map(s -> Integer.parseInt(s.trim())).collect(Collectors.toList());

			// 파일이 먼저 생성된 후에, 관련 데이터가 생성되는 경우에는, file의 relId가 일단 0으로 저장된다.
			// 그것을 뒤늦게라도 이렇게 고처야 한다.
			for (int fileId : fileIds) {
				fileService.changeRelId(fileId, id);
			}
		}
		
	}

}

package com.sbs.hsb.ex1.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.hsb.ex1.dao.BoardDao;
import com.sbs.hsb.ex1.dto.Board;
import com.sbs.hsb.ex1.dto.BoardApplyDoc;
import com.sbs.hsb.ex1.dto.ResultData;

@Service
public class BoardService {

	@Autowired
	private BoardDao boardDao;
	
	// 커뮤니티 보드 만들기
	public int doApplyForCreateBoard(Map<String, Object> param) {
		boardDao.doApplyForCreateBoard(param);// 커뮤니티 보드 만들기
		
		return boardDao.getBoardId(param);// 만들어진 커뮤니티 보드의 id가져오기
	}
	
	// 신청서에 applyStatus = 1
	public void docApplyConfirm(Map<String, Object> param) {
		boardDao.docApplyConfirm(param);
	}
	
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

}

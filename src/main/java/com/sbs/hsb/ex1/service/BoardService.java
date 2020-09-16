package com.sbs.hsb.ex1.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.hsb.ex1.dao.BoardDao;
import com.sbs.hsb.ex1.dto.BoardApplyDoc;
import com.sbs.hsb.ex1.dto.ResultData;

@Service
public class BoardService {

	@Autowired
	private BoardDao boardDao;
	
	public int doApplyForCreateBoard(Map<String, Object> param) {
		boardDao.doApplyForCreateBoard(param);
		
		return boardDao.getBoardId(param);
	}
	
	public void docApplyConfirm(Map<String, Object> param) {
		boardDao.docApplyConfirm(param);
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

	//신청서 리스트
	public List<BoardApplyDoc> getAllBoardApplyDocs() {
		return boardDao.getAllBoardApplyDocs();
	}

	public void doBoardReject(Map<String, Object> param) {
		boardDao.doBoardReject(param);
	}

	public void doDelDocNameDup(String name) {
		boardDao.doDelDocNameDup(name);
	}

}

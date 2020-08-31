package com.sbs.hsb.ex1.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.hsb.ex1.dao.BoardDao;
import com.sbs.hsb.ex1.dto.ResultData;

@Service
public class BoardService {

	@Autowired
	private BoardDao boardDao;
	
	public int createBoard(Map<String, Object> param) {
		return boardDao.createBoard(param);
	}

	public int setBoardApplyDoc(Map<String, Object> param) {
		return boardDao.setBoardApplyDoc(param);
	}

	public ResultData checkBoardNameable(String name) {
		int count = boardDao.getBoardNameDupCount(name);
		
		if (count == 0) {
			return new ResultData("S-1", "개설 가능한 커뮤니티 명입니다.", "loginId", name);
		}

		return new ResultData("F-1", "이미 존재하는 커뮤니티 입니다.", "loginId", name);
	}

}

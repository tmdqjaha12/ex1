package com.sbs.hsb.ex1.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbs.hsb.ex1.dto.BoardApplyDoc;

@Mapper
public interface BoardDao {

	void doApplyForCreateBoard(Map<String, Object> param);
	
	void docApplyConfirm(Map<String, Object> param);

	//신청서 저장
	int setBoardApplyDoc(Map<String, Object> param);

	//신청서이름과 현재존재하는 커뮤니티 이름을 비교
	int getBoardNameDupCount(@Param("name") String name);

	//신청서 리스트
	List<BoardApplyDoc> getAllBoardApplyDocs();

	void doBoardReject(Map<String, Object> param);

	int getBoardId(Map<String, Object> param);

	int getBoardApplyDocCount(Map<String, Object> param);

	void doDelDocNameDup(@Param("name") String name);

	// 내 신청서 목록
	List<BoardApplyDoc> getMyBoardList(@Param("loginedMemberId") int loginedMemberId);


}

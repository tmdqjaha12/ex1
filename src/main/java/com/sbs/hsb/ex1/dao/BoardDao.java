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

	int setBoardApplyDoc(Map<String, Object> param);

	int getBoardNameDupCount(@Param("name") String name);

	List<BoardApplyDoc> getAllBoardApplyDocs();

	void doBoardReject(Map<String, Object> param);

	int getBoardId(Map<String, Object> param);

	int getBoardApplyDocCount(Map<String, Object> param);

	void doDelDocNameDup(@Param("name") String name);


}

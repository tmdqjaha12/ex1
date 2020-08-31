package com.sbs.hsb.ex1.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbs.hsb.ex1.dto.BoardApplyDoc;

@Mapper
public interface BoardDao {

	int createBoard(Map<String, Object> param);

	int setBoardApplyDoc(Map<String, Object> param);

	int getBoardNameDupCount(@Param("name") String name);

	List<BoardApplyDoc> getAllBoardApplyDocs();

}

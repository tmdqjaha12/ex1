package com.sbs.hsb.ex1.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface BoardDao {

	int createBoard(Map<String, Object> param);

	int setBoardApplyDoc(Map<String, Object> param);

	int getBoardNameDupCount(@Param("name") String name);

}

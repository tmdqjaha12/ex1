package com.sbs.hsb.ex1.dao;

import java.sql.Connection;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbs.hsb.ex1.dto.Attr;

import ch.qos.logback.core.db.dialect.DBUtil;

@Mapper
public interface AttrDao {
	void setValue(Map<String, Object> param);

	String getValue(Map<String, Object> param);

	int remove(Map<String, Object> param);
	
	void userBanAttrDelete();
}
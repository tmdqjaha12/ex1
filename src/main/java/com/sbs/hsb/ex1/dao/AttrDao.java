package com.sbs.hsb.ex1.dao;

import java.sql.Connection;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbs.hsb.ex1.dto.Attr;

import ch.qos.logback.core.db.dialect.DBUtil;

@Mapper
public interface AttrDao {
//	public int setValue(String relTypeCode, int relId, String typeCode, String type2Code, String value) {
//		SecSql sql = new SecSql();
//
//		sql.append("INSERT INTO attr (regDate, updateDate, `relTypeCode`, `relId`, `typeCode`, `type2Code`, `value`)");
//		sql.append("VALUES (NOW(), NOW(), ?, ?, ?, ?, ?)", relTypeCode, relId, typeCode, type2Code, value);
//		sql.append("ON DUPLICATE KEY UPDATE");
//		sql.append("updateDate = NOW()");
//		sql.append(", `value` = ?", value);
//
//		return DBUtil.update(dbConn, sql);
//	}
//
//	public Attr get(String relTypeCode, int relId, String typeCode, String type2Code) {
//		SecSql sql = new SecSql();
//
//		sql.append("SELECT *");
//		sql.append("FROM attr");
//		sql.append("WHERE 1");
//		sql.append("AND `relTypeCode` = ?", relTypeCode);
//		sql.append("AND `relId` = ?", relId);
//		sql.append("AND `typeCode` = ?", typeCode);
//		sql.append("AND `type2Code` = ?", type2Code);
//
//		return new Attr(DBUtil.selectRow(dbConn, sql));
//	}
//
//	public String getValue(String relTypeCode, int relId, String typeCode, String type2Code) {
//		SecSql sql = new SecSql();
//	
//		sql.append("SELECT `value`");
//		sql.append("FROM attr");
//		sql.append("WHERE 1");
//		sql.append("AND `relTypeCode` = ?", relTypeCode);
//		sql.append("AND `relId` = ?", relId);
//		sql.append("AND `typeCode` = ?", typeCode);
//		sql.append("AND `type2Code` = ?", type2Code);
//
//		return DBUtil.selectRowStringValue(dbConn, sql);
//	}
//
//	public int remove(String relTypeCode, int relId, String typeCode, String type2Code) {
//		SecSql sql = new SecSql();
//
//		sql.append("DELETE FROM attr");
//		sql.append("WHERE 1");
//		sql.append("AND `relTypeCode` = ?", relTypeCode);
//		sql.append("AND `relId` = ?", relId);
//		sql.append("AND `typeCode` = ?", typeCode);
//		sql.append("AND `type2Code` = ?", type2Code);
//
//		return DBUtil.delete(dbConn, sql);
//	}

	void setValue(Map<String, Object> param);

	String getValue(Map<String, Object> param);
}
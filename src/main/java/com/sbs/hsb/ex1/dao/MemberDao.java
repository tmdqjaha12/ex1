package com.sbs.hsb.ex1.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbs.hsb.ex1.dto.Member;
import com.sbs.hsb.ex1.dto.ResultData;

@Mapper
public interface MemberDao {

	Member getMemberById(@Param("id") int id);

	void join(Map<String, Object> param);

	int getLoginIdDupCount(@Param("loginId") String loginId);
	
	int getNickNameDupCount(@Param("nickname") String nickname);

	int getEmailDupCount(@Param("email") String email);

	Member getMemberByLoginId(@Param("loginId") String loginId);

	void setModifyPassword(Map<String, Object> param);

	void doSecssion(@Param("id") int id);

	void doMemberModify(Map<String, Object> param);

	String getStringForFindId(Map<String, Object> param);

	int getMemberIdByLoginIdAndNameAndEmail(Map<String, Object> param);

}

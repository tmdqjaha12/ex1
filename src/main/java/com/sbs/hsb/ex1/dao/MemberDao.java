package com.sbs.hsb.ex1.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbs.hsb.ex1.dto.Member;

@Mapper
public interface MemberDao {

	Member getMemberById(@Param("id") int id);

	void join(Map<String, Object> param);

	int getLoginIdDupCount(@Param("loginId") String loginId);
	
	int getNickNameDupCount(@Param("nickname") String nickname);

	int getEmailDupCount(@Param("email") String email);

	Member getMemberByLoginId(@Param("loginId") String loginId);
}

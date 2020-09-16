package com.sbs.hsb.ex1.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbs.hsb.ex1.dto.Reply;

@Mapper
public interface ReplyDao {
	List<Reply> getForPrintReplies(Map<String, Object> param);

	void writeReply(Map<String, Object> param);

	void deleteReply(@Param("id") int id);

	Reply getForPrintReplyById(@Param("id") int id);

	void modifyReply(Map<String, Object> param);

	// 내 댓글 목록
	List<Reply> getMyReplyList(@Param("loginedMemberId") int loginedMemberId);
}
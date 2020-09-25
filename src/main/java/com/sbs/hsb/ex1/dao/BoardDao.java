package com.sbs.hsb.ex1.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbs.hsb.ex1.dto.Board;
import com.sbs.hsb.ex1.dto.BoardApplyDoc;
import com.sbs.hsb.ex1.dto.ReportDoc;

@Mapper
public interface BoardDao {

	// 커뮤니티 보드만들기
	void doApplyForCreateBoard(Map<String, Object> param);
	
	// 만들어진 커뮤니티 보드의 id 가져오기
	int getBoardId(Map<String, Object> param);
	
	// 커뮤니티 신청 거절
	void doBoardReject(Map<String, Object> param);
	
	// 신청서에 applyStatus = 1
//	void docApplyConfirm(Map<String, Object> param);

	//신청서 저장
	int setBoardApplyDoc(Map<String, Object> param);

	//신청서이름과 현재존재하는 커뮤니티 이름을 비교
	int getBoardNameDupCount(@Param("name") String name);

	//신청서 리스트
	List<BoardApplyDoc> getAllBoardApplyDocs();

	// 같은 이름으로 신청된 신청서들 전부 삭제
	void doDelDocNameDup(@Param("name") String name);

	// 내 신청서 목록
	List<BoardApplyDoc> getMyBoardApplyList(@Param("loginedMemberId") int loginedMemberId);

	// 내 커뮤니티 목록
	List<Board> getMyBoardList(@Param("loginedMemberId") int loginedMemberId);

	// 현재 생성된 board 랜덤 코드가, 기존 board 코드와 중복이 있는가
	int getBoardCodeDup(@Param("randomCode") String randomCode);

	// 보드 가져오기
	Board getBoardByCodeFromManager(@Param("code") String boardCode, @Param("memberId") int loginedMemberId);

	// 신고Doc 리스트 가져오기
	List<ReportDoc> getBAReportList(@Param("boardId") int id);

	// 신고Doc 삭제
	void deleteReport(@Param("id") int id);

	// HOT 커뮤니티
	List<Board> getHotBoards();
	
	// NEW 커뮤니티
	List<Board> getNewBoards();

	//
	Board getBoardByCode(Map<String, Object> param);
}

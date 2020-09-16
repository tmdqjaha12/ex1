package com.sbs.hsb.ex1.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbs.hsb.ex1.dto.Article;
import com.sbs.hsb.ex1.dto.Board;
import com.sbs.hsb.ex1.dto.Reply;

@Mapper
public interface ArticleDao {
	List<Article> getForPrintArticles();

	Article getForPrintArticleById(@Param("id") int id);
	
	Article getArticleById(@Param("id") int id);

	void write(Map<String, Object> param);

	void modify(Map<String, Object> param);

	Board getBoardByCode(String boardCode);

	void doDelete(@Param("memberId")int memberId,@Param("boardId") int boardId, @Param("id") int id);

	List<Board> getAllBoards();

	// not null boardId articleList Count
	int getForPrintListArticlesCount(@Param("boardId")int boardId, @Param("searchKeywordType")String searchKeywordType, @Param("searchKeyword")String searchKeyword);
	// null boardId articleList Count	
	int getNotBoardIdForPrintListArticlesCount(@Param("searchKeywordType")String searchKeywordType, @Param("searchKeyword")String searchKeyword);

	// not null boardId articleList
	List<Article> getForPrintListArticles(Map<String, Object> param);
	// null boardId articleList
	List<Article> getNotBoardIdForPrintListArticles(Map<String, Object> param);

	//조회수
	void increaseArticleHit(@Param("id") int id);

	Map<String, Object> getArticleLikeAvailable(int id, int loginedMemberId);

	//좋아요
	int getLikePointByMemberId(@Param("id") int id, @Param("memberId") int memberId);

	void likeArticle(@Param("id") int id, @Param("memberId") int memberId);

	List<Article> getMethForArticles(@Param("boardId") int boardId, @Param("limit") int limit);

//////////////////////////////////////////MYPAGE START//////////////////////////////////////////

	// 내 글 목록
	List<Article> getMyPageArticles(Map<String, Object> param);
	
}
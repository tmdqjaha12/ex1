package com.sbs.hsb.ex1.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbs.hsb.ex1.dto.Article;
import com.sbs.hsb.ex1.dto.Board;

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

	int getForPrintListArticlesCount1(@Param("boardId")int boardId, @Param("searchKeywordType")String searchKeywordType, @Param("searchKeyword")String searchKeyword);

	int getForPrintListArticlesCount2(@Param("boardId")int boardId);

	List<Article> getForPrintListArticles(Map<String, Object> param);

	void increaseArticleHit(@Param("id") int id);

	Map<String, Object> getArticleLikeAvailable(int id, int loginedMemberId);

	//좋아요
	int getLikePointByMemberId(@Param("id") int id, @Param("memberId") int memberId);

	void likeArticle(@Param("id") int id, @Param("memberId") int memberId);
}
package com.sbs.hsb.ex1.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sbs.hsb.ex1.dto.Article;
import com.sbs.hsb.ex1.dto.Board;
import com.sbs.hsb.ex1.service.ArticleService;
import com.sbs.hsb.ex1.service.BoardService;
import com.sbs.hsb.ex1.service.MemberService;

@Controller
public class HomeController {
	@Autowired
	private MemberService memberService;
	@Autowired
	private ArticleService articleService;
	@Autowired
	private BoardService boardService;

	@RequestMapping("/usr/home/main")
	public String showMain(Model model) {
		
		//boardList
		List<Board> boards = articleService.getAllBoards();
		model.addAttribute("boards", boards);
		
		//공지
		List<Article> notices = articleService.getMethForArticles("notice", 5);
		model.addAttribute("notices", notices);
		//업데이트
		List<Article> updates = articleService.getMethForArticles("update", 5);
		model.addAttribute("updates", updates);
		//문의
		List<Article> questions = articleService.getMethForArticles("question", 5);
		model.addAttribute("questions", questions);
		
		//HOT 게시물
		List<Article> hotArticles = articleService.getHotArticles();
		model.addAttribute("hotArticles", hotArticles);
		
		//HOT 커뮤니티
		List<Board> hotBoards = boardService.getHotBoards();
		model.addAttribute("hotBoards", hotBoards);
		
		//NEW 커뮤니티
		List<Board> newBoards = boardService.getNewBoards();
		model.addAttribute("newBoards", newBoards);
		
		return "home/main";
	}
	
	@RequestMapping("/")
	public String showIndex(Model model) {
		
		//boardList
		List<Board> boards = articleService.getAllBoards();
		model.addAttribute("boards", boards);
		
		//공지
		List<Article> notices = articleService.getMethForArticles("notice", 5);
		model.addAttribute("notices", notices);
		//업데이트
		List<Article> updates = articleService.getMethForArticles("update", 5);
		model.addAttribute("updates", updates);
		//문의
		List<Article> questions = articleService.getMethForArticles("question", 5);
		model.addAttribute("questions", questions);
		
		return "home/main";
	}
}

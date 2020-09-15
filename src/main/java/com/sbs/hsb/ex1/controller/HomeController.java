package com.sbs.hsb.ex1.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sbs.hsb.ex1.dto.Article;
import com.sbs.hsb.ex1.dto.Board;
import com.sbs.hsb.ex1.service.ArticleService;
import com.sbs.hsb.ex1.service.MemberService;

@Controller
public class HomeController {
	@Autowired
	private MemberService memberService;
	@Autowired
	private ArticleService articleService;

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
	
//	@RequestMapping("/usr/home/myPage")
//	public String showMyPage(HttpServletRequest req, HttpSession session) {
//		int loginedMemberId = (int) session.getAttribute("loginedMemberId");
//		String authCode = memberService.genEmailAuthCode(loginedMemberId);
//		
//		req.setAttribute("authCode", authCode);
//		
//		return "home/myPage";
//	}
	
	@RequestMapping("/usr/home/adminPage")
	public String showAdminPage(Model model) {
	
		
		return "home/adminPage";
	}
}

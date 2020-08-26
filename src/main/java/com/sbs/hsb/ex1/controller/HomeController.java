package com.sbs.hsb.ex1.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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
		
		List<Board> boards = articleService.getAllBoards();
		
		model.addAttribute("boards", boards);
		
		return "home/main";
	}
	
	@RequestMapping("/usr/home/myPage")
	public String showMyPage(HttpServletRequest req, HttpSession session) {
		int loginedMemberId = (int) session.getAttribute("loginedMemberId");
		String authCode = memberService.genEmailAuthCode(loginedMemberId);
		
		req.setAttribute("authCode", authCode);
		
		return "home/myPage";
	}
}

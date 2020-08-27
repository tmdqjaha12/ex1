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
public class BoardController {
	@Autowired
	private MemberService memberService;
	@Autowired
	private ArticleService articleService;

	@RequestMapping("/usr/board/createBoard")
	public String showMyPage(HttpServletRequest req, HttpSession session) {
		
		return "board/createBoard";
	}
}

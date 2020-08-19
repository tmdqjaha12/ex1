package com.sbs.hsb.ex1.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {

	@RequestMapping("/usr/home/main")
	public String showMain() {
		return "home/main";
	}
	
	@RequestMapping("/usr/home/myPage")
	public String showMyPage() {
		return "home/myPage";
	}
}

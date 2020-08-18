package com.sbs.hsb.ex1.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sbs.hsb.ex1.dto.ResultData;
import com.sbs.hsb.ex1.service.MemberService;
import com.sbs.hsb.ex1.util.Util;

@Controller
public class MemberController {
	@Autowired
	private MemberService memberService;
	// 회원 가입
	@RequestMapping("/usr/member/join")
	public String showJoin() {
		return "member/join";
	}
	
	@RequestMapping("/usr/member/doJoin")
	public String doJoin(@RequestParam Map<String, Object> param, Model model) {
		Util.changeMapKey(param, "loginPwReal", "loginPw");
		ResultData checkLoginIdJoinableResultData = memberService
				.checkLoginIdJoinable(Util.getAsStr(param.get("loginId")));

		if (checkLoginIdJoinableResultData.isFail()) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", checkLoginIdJoinableResultData.getMsg());
			return "common/redirect";
		}

		int newMemberId = memberService.join(param);

		String redirectUri = (String) param.get("redirectUri");
		model.addAttribute("redirectUri", redirectUri);

		return "common/redirect";
	}
//	System.out.println("param.get(\"redirectUri\") : " + param.get("redirectUri"));
//	System.out.println("param.get(\"loginPwReal\") : " + param.get("loginPwReal"));
//	System.out.println("param.get(\"loginId\") : " + param.get("loginId"));
//	System.out.println("param.get(\"loginPw\") : " + param.get("loginPw"));
//	System.out.println("param.get(\"loginPwConfirm\") : " + param.get("loginPwConfirm"));
//	System.out.println("param.get(\"name\") : " + param.get("name"));
//	System.out.println("param.get(\"nickname\") : " + param.get("nickname"));
//	System.out.println("param.get(\"email\") : " + param.get("email"));

	// 로그인
	@RequestMapping("/usr/member/login")
	public String showLogin() {
		return "member/login";
	}

	@RequestMapping("/usr/member/doLogin")
	public String doLogin() {
		return "home/main";
	}
}

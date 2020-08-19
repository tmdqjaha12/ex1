package com.sbs.hsb.ex1.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.hsb.ex1.dto.ResultData;
import com.sbs.hsb.ex1.service.MemberService;
import com.sbs.hsb.ex1.util.Util;

@Controller
public class MemberController {
	@Autowired
	private MemberService memberService;
	// 회원 가입 시작
	// 회원 가입 페이지
	@RequestMapping("/usr/member/join")
	public String showJoin() {
		return "member/join";
	}
	
	// 회원 가입
	@RequestMapping("/usr/member/doJoin")
	public String doJoin(@RequestParam Map<String, Object> param, Model model) {
		Util.changeMapKey(param, "loginPwReal", "loginPw");
		ResultData checkLoginIdJoinableResultData = memberService
				.checkLoginIdJoinable(Util.getAsStr(param.get("loginId")));
		ResultData checkNickNameJoinableResultData = memberService
				.checkNickNameJoinable(Util.getAsStr(param.get("nickname")));
		ResultData checkEmailJoinableResultData = memberService
				.checkEmailJoinable(Util.getAsStr(param.get("email")));

		if (checkLoginIdJoinableResultData.isFail() 
				&& checkNickNameJoinableResultData.isFail() 
					&& checkEmailJoinableResultData.isFail()) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "제대로 된 정보를 입력해주세요.");
			return "common/redirect";
		}

		int newMemberId = memberService.join(param);

		String redirectUri = (String) param.get("redirectUri");
		model.addAttribute("redirectUri", redirectUri);

		return "common/redirect";
	}
	
	// 회원 가입 아이디 중복 체크
	@RequestMapping("/usr/member/getLoginIdDup")
	@ResponseBody
	public ResultData getLoginIdDup(@RequestParam Map<String, Object> param, Model model) {
		String loginId = (String) param.get("loginId");
		return memberService.checkLoginIdJoinable(loginId);
	}
	
	// 회원 가입 별명 중복 체크
	@RequestMapping("/usr/member/getNickNameDup")
	@ResponseBody
	public ResultData getNickNameDup(@RequestParam Map<String, Object> param, Model model) {
		String nickname = (String) param.get("nickname");
		return memberService.checkNickNameJoinable(nickname);
	}
	
	// 회원 가입 이메일 중복 체크
	@RequestMapping("/usr/member/getEmailDup")
	@ResponseBody
	public ResultData getEmailDup(@RequestParam Map<String, Object> param, Model model) {
		String email = (String) param.get("email");
		return memberService.checkEmailJoinable(email);
	}
	
	// 회원 가입 끝
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

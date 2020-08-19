package com.sbs.hsb.ex1.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.hsb.ex1.dto.Member;
import com.sbs.hsb.ex1.dto.ResultData;
import com.sbs.hsb.ex1.service.MemberService;
import com.sbs.hsb.ex1.util.Util;

@Controller
public class MemberController {
	@Autowired
	private MemberService memberService;
	// 회원 가입 시작 //
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
	// 회원 가입 끝 //
	
	// 회원 정보 수정 시작 //
	// 회원 정보 수정을 위한 비밀번호 확인 페이지
	@RequestMapping("/usr/member/passwordForPrivate")
	public String showModifyPrivate() {
		return "member/passwordForPrivate";
	}
	
	// 회원 정보 수정을 위한 비밀번호 확인
	@RequestMapping("/usr/member/doPasswordForPrivate")
	public String showPasswordForPrivate(@RequestParam Map<String, Object> param, Model model, HttpSession session) {
		String loginedPw = (String) param.get("loginPwReal");
		int loginedMemberId = (int) session.getAttribute("loginedMemberId");
		Member member = memberService.getMemberById(loginedMemberId);
		
		if (member.getLoginPw().equals(loginedPw)) {
			return "member/modifyPassword";
		}
		
		String redirectUri = "/usr/member/passwordForPrivate";
		model.addAttribute("redirectUri", redirectUri);
		model.addAttribute("alertMsg", String.format("옳바른 정보를 입력해주세요."));

		return "common/redirect";
	}
	
	// 회원 비번 수정 페이지
	@RequestMapping("/usr/member/modifyPassword")
	public String showPasswordForPrivate() {
		return "member/modifyPassword";
	}
	
	// 회원 비번 수정
	@RequestMapping("/usr/member/doModifyPrivate")
	public String doModifyPrivate() {
		return "member/modifyPassword";
	}
		
	// 회원 정보 수정 끝 //
	
	// 로그인 시작 //
	// 로그인 페이지
	@RequestMapping("/usr/member/login")
	public String showLogin() {
		return "member/login";
	}

	// 로그인 
	@RequestMapping("/usr/member/doLogin")
	public String doLogin(String loginId, String loginPwReal, String redirectUri, Model model, HttpSession session) {
		String loginPw = loginPwReal;
		Member member = memberService.getMemberByLoginId(loginId);

		if (member == null) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "존재하지 않는 회원입니다.");
			return "common/redirect";
		}

		if (member.getLoginPw().equals(loginPw) == false) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "비밀번호가 일치하지 않습니다.");
			return "common/redirect";
		}

		session.setAttribute("loginedMemberId", member.getId());

		if (redirectUri == null || redirectUri.length() == 0) {
			redirectUri = "/usr/home/main";
		}

		model.addAttribute("redirectUri", redirectUri);
		model.addAttribute("alertMsg", String.format("%s님 반갑습니다.", member.getNickname()));

		return "common/redirect";
	}
	// 로그인 끝 //
	
	// 로그아웃 시작 //
	// 로그아웃
	@RequestMapping("/usr/member/doLogout")
	public String doLogout(HttpSession session, Model model, String redirectUri) {
		session.removeAttribute("loginedMemberId");

		if (redirectUri == null || redirectUri.length() == 0) {
			redirectUri = "/usr/home/main";
		}

		model.addAttribute("redirectUri", redirectUri);
		return "common/redirect";
	}
	// 로그아웃 끝 //
}


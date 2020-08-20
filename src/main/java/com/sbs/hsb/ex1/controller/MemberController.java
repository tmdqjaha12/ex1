package com.sbs.hsb.ex1.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
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
		
		String authCode = memberService.genEmailAuthCode(newMemberId); // 회원 attr 테이블 저장 & 인증코드
		memberService.genLastPasswordChangeDate(newMemberId); // 회원 업데이트 attr 테이블 저장
		memberService.genEmailAuthed(newMemberId, ""); // 회원 이메일 attr 테이블 저장
		
		memberService.sendAuthMail((String)param.get("email"), authCode, newMemberId); // 인증 이메일 발송

		String redirectUri = (String) param.get("redirectUri");
		model.addAttribute("redirectUri", redirectUri);
		model.addAttribute("alertMsg", String.format("회원가입 완료!"));

		return "common/redirect";
	}
	
	// 회원 인증authEmail
	@RequestMapping("/usr/member/authEmail")
	public String doAuthEmail(@RequestParam Map<String, Object> param, Model model, HttpServletRequest req) {
		int loginedMemberId = Util.getInt(req, "memberId");
		String strLoginedMemberId = "" + loginedMemberId;
		String authCode = Util.getString(req, "authCode");
		String email = Util.getString(req, "email");
		String redirectUri = "/usr/member/passwordForPrivate";
		
		if (memberService.isValidEmailAuthCode(strLoginedMemberId, authCode) == false) {//attr비교
			redirectUri = "/usr/home/myPage";
			model.addAttribute("redirectUri", redirectUri);
			model.addAttribute("alertMsg", String.format("인증번호를 다시 체크해주세요."));
			return "common/redirect";
		}
		
		memberService.genEmailAuthed(loginedMemberId, email);//attr 이메일저장	
		
		redirectUri = "/usr/home/main";
		model.addAttribute("redirectUri", redirectUri);
		model.addAttribute("alertMsg", String.format("인증이 완료되었습니다."));
		
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
	public ResultData getNickNameDup(@RequestParam Map<String, Object> param, Model model, HttpServletRequest req) {
		Member member = (Member) req.getAttribute("loginedMember");
		String loginedNickname = (String) member.getNickname();
		String nickname = (String) param.get("nickname");
		
		if(nickname.equals(loginedNickname)) {//현재 나의 별명
			return new ResultData("Z-1", "", "nickname", nickname);
		}
		
		return memberService.checkNickNameJoinable(nickname);
	}
	
	// 회원 가입 이메일 중복 체크
	@RequestMapping("/usr/member/getEmailDup")
	@ResponseBody
	public ResultData getEmailDup(@RequestParam Map<String, Object> param, Model model, HttpServletRequest req) {
		Member member = (Member) req.getAttribute("loginedMember");
		String loginedEmail = (String) member.getEmail();
		String email = (String) param.get("email");
		
		if(email.equals(loginedEmail)) {//현재 나의 이메일
			return new ResultData("Z-1", "", "email", email);
		}
		
		return memberService.checkEmailJoinable(email);
	}
	// 회원 가입 끝 //
	
	// 회원 정보 수정 시작 //
	// 회원 정보 수정을 위한 비밀번호 확인 페이지
	@RequestMapping("/usr/member/passwordForPrivate")
	public String showModifyPrivate(HttpServletRequest req) {
		String isvalTag = Util.getString(req, "isvalTag");
		
		req.setAttribute("isvalTag", isvalTag);
		
		return "member/passwordForPrivate";
	}
	
	// 회원 정보 수정을 위한 비밀번호 확인
	@RequestMapping("/usr/member/doPasswordForPrivate")
	public String showPasswordForPrivate(@RequestParam Map<String, Object> param, Model model, HttpSession session, HttpServletRequest req) {
		//비번확인
		String loginedPw = (String) param.get("loginPwReal");
		int loginedMemberId = (int) session.getAttribute("loginedMemberId");
		Member member = memberService.getMemberById(loginedMemberId);
		
		if (member.getLoginPw().equals(loginedPw)) {
			String isvalTag = Util.getString(req, "isvalTag");
			String redirectUri = "/usr/member/" + isvalTag;
			model.addAttribute("redirectUri", redirectUri);
			return "common/redirect";
		}
		
		String redirectUri = "/usr/member/passwordForPrivate";
		model.addAttribute("redirectUri", redirectUri);
		model.addAttribute("alertMsg", String.format("옳바른 정보를 입력해주세요."));

		return "common/redirect";
	}
	
	// 회원 비번 변경 페이지
	@RequestMapping("/usr/member/modifyPassword")
	public String showPasswordForPrivate(Model model, HttpSession session) {
		int loginedMemberId = (int) session.getAttribute("loginedMemberId");
		Member member = memberService.getMemberById(loginedMemberId);
		
		model.addAttribute("ooldPw", member.getLoginPw());
		
		
		return "member/modifyPassword";
	}
	
	// 회원 비번 변경
	@RequestMapping("/usr/member/doModifyPrivate")
	public String doModifyPrivate(@RequestParam Map<String, Object> param, Model model, HttpSession session) {
		// 기존비번과 같을 때
		int loginedMemberId = (int) session.getAttribute("loginedMemberId");
		Member member = memberService.getMemberById(loginedMemberId);
		String oldPw = member.getLoginPw();
		if(oldPw.equals(param.get("loginPwReal"))) {
			String redirectUri = "/usr/member/modifyPassword";
			model.addAttribute("redirectUri", redirectUri);
			model.addAttribute("alertMsg", String.format("기존 비번과 같습니다. 다시 확인해 주세요."));

			return "common/redirect";
		}
		
		// 비번 변경
		param.put("id", loginedMemberId);
		memberService.setModifyPassword(param);
		session.removeAttribute("loginedMemberId");//로그아웃
		
		String redirectUri = "/usr/member/login";
		model.addAttribute("redirectUri", redirectUri);
		model.addAttribute("alertMsg", String.format("비밀번호 수정 완료! 새 비밀번호로 로그인 해주세요."));

		return "common/redirect";
	}
	
	// 회원 탈퇴 페이지
	@RequestMapping("/usr/member/secession")
	public String showSecession() {
		return "member/secession";
	}
	
	// 회원 탈퇴 secession
	@RequestMapping("/usr/member/doSecession")
	public String doSecession(Model model, HttpSession session) {
		int loginedMemberId = (int) session.getAttribute("loginedMemberId");
		
		memberService.doSecssion(loginedMemberId);
		
		String redirectUri = "/usr/home/main";
		model.addAttribute("redirectUri", redirectUri);
		model.addAttribute("alertMsg", String.format("탈퇴 완료!"));
		
		session.removeAttribute("loginedMemberId");

		return "common/redirect";
	}
	
	// 회원 개인 정보 수정 페이지
	@RequestMapping("/usr/member/memberModify")
	public String showMemberModify() {
		return "member/memberModify";
	}
	
	// 회원 개인 정보 수정
	@RequestMapping("/usr/member/doMemberModify")
	public String doMemberModify(@RequestParam Map<String, Object> param, Model model, HttpSession session) {

//		if(memberService.getEmailAuthed(loginedMemberId).equals(email) == false) {
//			memberService.genEmailAuthed(loginedMemberId, "");//이메일 인증 초기화
//		}
//		
//		memberService.memberModify(loginedMemberId, nickname, email);
		
		return "common/redirect";
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


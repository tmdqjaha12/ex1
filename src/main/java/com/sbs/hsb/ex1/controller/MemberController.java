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
		// 중복 확인
		ResultData checkLoginIdJoinableResultData = memberService
				.checkLoginIdJoinable(Util.getAsStr(param.get("loginId")));
		ResultData checkNickNameJoinableResultData = memberService
				.checkNickNameJoinable(Util.getAsStr(param.get("nickname")));
		ResultData checkEmailJoinableResultData = memberService
				.checkEmailJoinable(Util.getAsStr(param.get("email")));

		if(checkLoginIdJoinableResultData.isFail() != false) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", checkLoginIdJoinableResultData.getMsg());
			return "common/redirect";
		}
		
		if(checkNickNameJoinableResultData.isFail() != false) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", checkNickNameJoinableResultData.getMsg());
			return "common/redirect";
		}
		
		if(checkEmailJoinableResultData.isFail() != false) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", checkEmailJoinableResultData.getMsg());
			return "common/redirect";
		}
		
//		if (checkLoginIdJoinableResultData.isFail() || checkNickNameJoinableResultData.isFail()
//				|| checkEmailJoinableResultData.isFail()) {
//			model.addAttribute("historyBack", true);
//			model.addAttribute("alertMsg", "제대로 된 정보를 입력해주세요.");
//			return "common/redirect";
//		}
		
		Map<String, Object> newParam = Util.getNewMapOf(param, "title", "body", "fileIdsStr");
		int newMemberId = memberService.join(param);// 회원가입

		String authCode = memberService.genEmailAuthCode(newMemberId); // 회원 attr 테이블 저장 & 인증코드
		memberService.genLastPasswordChangeDate(newMemberId); // 회원 업데이트 attr 테이블 저장
		memberService.genEmailAuthed(newMemberId, ""); // 회원 이메일 attr 테이블 저장

		memberService.sendAuthMail((String) param.get("email"), authCode, newMemberId); // 인증 이메일 발송

		String redirectUri = (String) param.get("redirectUri");
		model.addAttribute("redirectUri", redirectUri);
		model.addAttribute("alertMsg", String.format("회원가입 완료!"));

		return "common/redirect";
	}

	// myPage에서 메일 인증 발송
	@RequestMapping("/usr/member/doSendMail")
	public String doSendMail(@RequestParam Map<String, Object> param, Model model, HttpServletRequest req) {
		int loginedMemberId = Util.getInt(req, "memberId");
		int strLoginedMemberId = loginedMemberId;
		String authCode = memberService.genEmailAuthCode(loginedMemberId); // 회원 attr 테이블 저장 & 인증코드
		String email = Util.getString(req, "email");
		System.out.println("authCode : " + authCode);
		
		memberService.sendAuthMail(email, authCode, strLoginedMemberId); // 메일 발송

		String redirectUri = (String) param.get("redirectUri");
		model.addAttribute("redirectUri", redirectUri);
		model.addAttribute("alertMsg", String.format("인증메일 전송완료."));

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
		
		System.out.println("loginedMemberId : " + loginedMemberId);
		System.out.println("authCode : " + authCode);
		System.out.println("email : " + email);
		
		

		if (memberService.isValidEmailAuthCode(strLoginedMemberId, authCode) == false) {// attr비교
			redirectUri = "/usr/home/myPage";
			model.addAttribute("redirectUri", redirectUri);
			model.addAttribute("alertMsg", String.format("인증번호를 다시 체크해주세요."));
			return "common/redirect";
		}

		memberService.genEmailAuthed(loginedMemberId, email);// attr 이메일저장

		redirectUri = "/usr/home/main";
		model.addAttribute("redirectUri", redirectUri);
		model.addAttribute("alertMsg", String.format("인증이 완료되었습니다."));

		return "common/redirect";
	}

	// 회원 가입 아이디 중복 체크
	@RequestMapping("/usr/member/getLoginIdDup")
	@ResponseBody
	public ResultData getLoginIdDup(@RequestParam Map<String, Object> param, Model model) {
		String loginId = "";
		if( param.get("loginId").equals("") ) {
			return new ResultData("X-1", "");
		}
		
		loginId = (String) param.get("loginId");
		
		if( loginId.length() < 4 ) {
			return new ResultData("L-1", "경고! 4글자 미만", "loginId", loginId);
		}

		return memberService.checkLoginIdJoinable(loginId);
	}

	// 회원 가입 별명 중복 체크
	@RequestMapping("/usr/member/getNickNameDup")
	@ResponseBody
	public ResultData getNickNameDup(@RequestParam Map<String, Object> param, Model model) {
		String nickname = "";
		if( param.get("nickname").equals("") ) {
			return new ResultData("X-1", "");
		}
		
		nickname = (String) param.get("nickname");
		return memberService.checkNickNameJoinable(nickname);
	}

	// 회원 가입 이메일 중복 체크
	@RequestMapping("/usr/member/getEmailDup")
	@ResponseBody
	public ResultData getEmailDup(@RequestParam Map<String, Object> param, Model model) {
		String email = "";
		if( param.get("email").equals("") ) {
			return new ResultData("X-1", "");
		}
		
		email = (String) param.get("email");
		return memberService.checkEmailJoinable(email);
	}

	// 회원 가입 끝 //

	// 회원 정보 수정 시작 //
	// 회원정보 수정 별명 중복 체크
	@RequestMapping("/usr/member/getNickNameDupForMemberModify")
	@ResponseBody
	public ResultData getNickNameDup(@RequestParam Map<String, Object> param, Model model, HttpServletRequest req) {
		Member member = (Member) req.getAttribute("loginedMember");
		String loginedNickname = member.getNickname();
		String nickname = "";
		
		if( param.get("nickname").equals("") ) {//공백 검사
			return new ResultData("X-1", "");
		}

		nickname = (String) param.get("nickname");
		if (nickname.equals(loginedNickname)) {// 현재 나의 별명
			return new ResultData("Z-1", "현재 별명", "nickname", nickname);
		}
					
		return memberService.checkNickNameJoinable(nickname);
		
	}

	// 회원정보 수정 이메일 중복 체크
	@RequestMapping("/usr/member/getEmailDupFormMemberModify")
	@ResponseBody
	public ResultData getEmailDup(@RequestParam Map<String, Object> param, Model model, HttpServletRequest req) {
		Member member = (Member) req.getAttribute("loginedMember");
		String loginedEmail = (String) member.getEmail();
		String email = "";
		
		if( param.get("email").equals("") ) {//공백 검사
			return new ResultData("X-1", "");
		}
		
		email = (String) param.get("email");
		if (email.equals(loginedEmail)) {// 현재 나의 이메일
			return new ResultData("Z-1", "현재 이메일", "email", email);
		}

		return memberService.checkEmailJoinable(email);
	}

	// 회원 정보 수정을 위한 비밀번호 확인 페이지
	@RequestMapping("/usr/member/passwordForPrivate")
	public String showModifyPrivate(HttpServletRequest req) {
		String isvalTag = Util.getString(req, "isvalTag");

		req.setAttribute("isvalTag", isvalTag);

		return "member/passwordForPrivate";
	}

	// 회원 정보 수정을 위한 비밀번호 확인
	@RequestMapping("/usr/member/doPasswordForPrivate")
	public String showPasswordForPrivate(@RequestParam Map<String, Object> param, Model model, HttpSession session,
			HttpServletRequest req) {
		// 비번확인
		String loginedPw = (String) param.get("loginPwReal");
		int loginedMemberId = (int) session.getAttribute("loginedMemberId");
		Member member = memberService.getMemberById(loginedMemberId);

		if (member.getLoginPw().equals(loginedPw)) {
			String isvalTag = Util.getString(req, "isvalTag");
			String nextUri = "/usr/member/" + isvalTag;
			model.addAttribute("redirectUri", nextUri);
			return "common/redirect";
		}

		String redirectUri = (String) param.get("redirectUri");
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
		if (oldPw.equals(param.get("loginPwReal"))) {
			String redirectUri = "/usr/member/modifyPassword";
			model.addAttribute("redirectUri", redirectUri);
			model.addAttribute("alertMsg", String.format("기존 비번과 같습니다. 다시 확인해 주세요."));

			return "common/redirect";
		}

		// 비번 변경
		param.put("id", loginedMemberId);
		memberService.setModifyPassword(param);

		String authCode = memberService.genModifyPrivateAuthCode(loginedMemberId); // 비밀번호 수정 authCode 저장 및 return
		memberService.genLastPasswordChangeDate(loginedMemberId); // 비밀번호 수정 날짜 저장
		memberService.removeUseTempPassword(loginedMemberId);

		session.removeAttribute("loginedMemberId");// 로그아웃

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

		// VerifyRecaptchaController에 위임함

		return "";
	}

	// 회원 개인 정보 수정 페이지
	@RequestMapping("/usr/member/memberModify")
	public String showMemberModify() {
		return "member/memberModify";
	}

	// 회원 개인 정보 수정
	@RequestMapping("/usr/member/doMemberModify")
	public String doMemberModify(@RequestParam Map<String, Object> param, Model model, HttpSession session) {
		int loginedMemberId = (int) session.getAttribute("loginedMemberId");
		String oldEmail = (String) param.get("email");
		if (memberService.getEmailAuthed(loginedMemberId).equals(oldEmail) == false) {
			memberService.genEmailAuthed(loginedMemberId, "");// 이메일 인증 초기화
		}

		param.put("id", loginedMemberId);
		memberService.doMemberModify(param);// 수정

		String redirectUri = (String) param.get("redirectUri");
		model.addAttribute("redirectUri", redirectUri);

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
	public String doLogin(String loginId, String loginPwReal, String redirectUri, Model model, HttpServletRequest req,HttpSession session) {
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

		// 세션에 현재 로그인 멤버 저장
		session.setAttribute("loginedMemberId", member.getId());
		
		// 임시 비밀번호 관련
		boolean isUsedTempPassword = memberService.isValidUseTempPassword(member.getId());
		if(isUsedTempPassword) {
			model.addAttribute("redirectUri", "/usr/home/myPage");
			model.addAttribute("alertMsg", "임시비밀번호를 변경해주세요.");
			return "common/redirect";
		}
		
		// 비밀번호 변경일 관련
		String regDate = memberService.isValidLastPasswordChangeDate(member.getId());
		String nowRegDate = Util.getRegeDateNow();
		
		long paraDate = Util.getCalRegDate(regDate, nowRegDate);
		if(paraDate > 92) {
			model.addAttribute("redirectUri", "/usr/home/myPage");
			model.addAttribute("alertMsg", String.format("%s님 비밀번호 변경 권장(%d일 경과)", member.getNickname(), paraDate));
			return "common/redirect";
		}

		// 로그인 완료 - 메인 페이지로
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

	// Find 시작 //
	// 아이디 찾기 페이지
	@RequestMapping("/usr/member/findId")
	public String showFindId() {
		return "member/findId";
	}

	// 아이디 찾기
	@RequestMapping("/usr/member/doFindId")
	public String doFindId(@RequestParam Map<String, Object> param, Model model) {
		String loginId = memberService.getStringForFindId(param);
		String redirectUri = (String) param.get("redirectUri");
		model.addAttribute("redirectUri", redirectUri);

		if (loginId.length() != 0) {
			memberService.sendFindIdANDPwMail((String) param.get("email"), loginId, "id"); // 아이디 발송
			model.addAttribute("alertMsg", String.format("해당 이메일로 아이디가 발송되었습니다."));

			return "common/redirect";
		}

		model.addAttribute("redirectUri", "/usr/member/findId");
		model.addAttribute("alertMsg", String.format("존재하지 않는 계정입니다."));

		return "common/redirect";
	}

	// 비밀번호 찾기 페이지
	@RequestMapping("/usr/member/findPw")
	public String showFindPw() {
		return "member/findPw";
	}

	// 비밀번호 찾기
	@RequestMapping("/usr/member/doFindPw")
	public String doFindPw(@RequestParam Map<String, Object> param, Model model) {
		String id = memberService.getMemberIdByLoginIdAndNameAndEmail(param) + "";
		param.put("id", id);

		if (id.length() != 0) {
			String imshiPw = Util.getRandomPassword(8);
			String encryptSHA256ImshiPw = Util.encryptSHA256(imshiPw);
			param.put("loginPwReal", encryptSHA256ImshiPw);
			memberService.setModifyPassword(param);// 비밀번호 변경

			memberService.genUseTempPassword(id, "1");// 임시비번 발급시 attr에 1 저장

			memberService.sendFindIdANDPwMail((String) param.get("email"), imshiPw, "pw");// 임시 비번 발송

			model.addAttribute("redirectUri", (String) param.get("redirectUri"));
			model.addAttribute("alertMsg", String.format("임시비번이 발송되었습니다."));
			
			return "common/redirect";
		}

		model.addAttribute("redirectUri", "/usr/member/findPw");
		model.addAttribute("alertMsg", String.format("유효하지 않은 정보입니다."));
		
		return "common/redirect";
	}
	
	
//	// 회원 관리 페이지
//	@RequestMapping("/usr/member/administrate")
//	public String showAdministrate() {
//		return "member/administrate";
//	}
	
	// MY PAGE
	@RequestMapping("/usr/member/myPage")
	public String showMyPage(HttpServletRequest req, HttpSession session) {
		int loginedMemberId = (int) session.getAttribute("loginedMemberId");
		String authCode = memberService.genEmailAuthCode(loginedMemberId);
		
		req.setAttribute("authCode", authCode);
		
		return "member/myPage";
	}
	
	// 관리자 페이지
	@RequestMapping("/usr/member/adminPage")
	public String showAdminPage(Model model) {
	
		return "member/adminPage";
	}
	
	// 내 정보
	@RequestMapping("/usr/member/myInfo")
	public String showMyInfo(HttpServletRequest req, HttpSession session) {
		int loginedMemberId = (int) session.getAttribute("loginedMemberId");
		String authCode = memberService.genEmailAuthCode(loginedMemberId);
		
		req.setAttribute("authCode", authCode);
		
		return "member/myInfo";
	}
}

package com.sbs.hsb.ex1.service;

import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.sbs.hsb.ex1.dao.MemberDao;
import com.sbs.hsb.ex1.dto.Member;
import com.sbs.hsb.ex1.dto.ResultData;
import com.sbs.hsb.ex1.util.Util;

@Service
public class MemberService {
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private MailService mailService;
	@Autowired
	private AttrService attrService;
	@Value("${custom.siteMainUri}")
	private String siteMainUri;
	@Value("${custom.siteName}")
	private String siteName;

	// id로 회원 찾기
	public Member getMemberById(int id) {
		return memberDao.getMemberById(id);
	}

	// 회원 가입
	public int join(Map<String, Object> param) {
		memberDao.join(param);

		return Util.getAsInt(param.get("id"));
	}
	
	// 인증 메일 발송
	public void sendAuthMail(String email, String authCode, int newMemberId) {
		sendJoinCompleteMail(email, authCode, newMemberId);
	}

	// 인증 메일 발송
	private void sendJoinCompleteMail(String email, String authCode, int newMemberId) {
		String mailTitle = String.format("[%s] 가입이 완료되었습니다.", siteName);
		
		StringBuilder mailBodySb = new StringBuilder();
		mailBodySb.append("<h1>가입이 완료되었습니다.</h1>");
		mailBodySb.append(String.format("<p><a href=\"localhost:8085/usr/member/authEmail?email=%s&authCode=%s&memberId=%d\" target=\"_blank\">%s로</a> 이동</p>", email, authCode, newMemberId, siteName));

		mailService.send(email, mailTitle, mailBodySb.toString());
	}

	public ResultData checkLoginIdJoinable(String loginId) {
		int count = memberDao.getLoginIdDupCount(loginId);

		if (count == 0) {
			return new ResultData("S-1", "가입가능한 로그인 아이디 입니다.", "loginId", loginId);
		}

		return new ResultData("F-1", "이미 사용중인 로그인 아이디 입니다.", "loginId", loginId);
	}
	
	public ResultData checkNickNameJoinable(String nickname) {
		int count = memberDao.getNickNameDupCount(nickname);

		if (count == 0) {
			return new ResultData("S-1", "가입가능한 활동명 입니다.", "loginId", nickname);
		}

		return new ResultData("F-1", "이미 사용중인 활동명 입니다.", "loginId", nickname);
	}
	
	public ResultData checkEmailJoinable(String email) {
		int count = memberDao.getEmailDupCount(email);

		if (count == 0) {
			return new ResultData("S-1", "가입가능한 이메일 입니다.", "loginId", email);
		}

		return new ResultData("F-1", "이미 사용중인 이메 입니다.", "loginId", email);
	}

	public Member getMemberByLoginId(String loginId) {
		return memberDao.getMemberByLoginId(loginId);
	}

	public void setModifyPassword(Map<String, Object> param) {
		memberDao.setModifyPassword(param);
	}
	
	// 회원 개인 정보 수정 닉네임 이메일
	public void doMemberModify(Map<String, Object> param) {
		memberDao.doMemberModify(param);
	}

	// 탈퇴
	public void doSecssion(int id) {
		memberDao.doSecssion(id);
	}
	
	// 아이디 찾기
	public String getStringForFindId(Map<String, Object> param) {
		return memberDao.getStringForFindId(param);
	}
	
	// 아이디 메일 발송 하기
	public void sendFindIdMail(String eamil, String loginId) {
		String mailTitle = String.format("아이디 찾기 결과");
		
		StringBuilder mailBodySb = new StringBuilder();
		mailBodySb.append(String.format("<h1>아이디 : %s</h1>", loginId));
		mailService.send(eamil, mailTitle, mailBodySb.toString());
	}
	
	// attr //

	//▼set▼
	public String genEmailAuthCode(int actorId) {
		String authCode = UUID.randomUUID().toString();
		attrService.setValue("member__" + actorId + "__extra__emailAuthCode", authCode);
		return authCode;
	}// 가입시 혹은 이메일 인증코드 다시보내기 버튼 누를 때 마다 갱신 Code

	public String genLastPasswordChangeDate(int actorId) {
		String currentTime = Util.getRegeDateNow();
		attrService.setValue("member__" + actorId + "__extra__lastPasswordChangeDate", currentTime);

		return currentTime;
	}// 가입 혹은 패스워드 변경시 갱신 Code

	public String genEmailAuthed(int actorId, String email) {
		attrService.setValue("member__" + actorId + "__extra__emailAuthed", email);
		return email;
	}// 이메일인증__고객이 이메일의 링크를 클릭시 이 데이터가 생성 Code
	
	public String genModifyPrivateAuthCode(int actorId) {
		String authCode = UUID.randomUUID().toString();
		attrService.setValue("member__" + actorId + "__extra__modifyPrivateAuthCode", authCode);
		
		return authCode;
	}// 회원정보 수정시 Code
	
	public int removeUseTempPassword(int actorId) {
	    attrService.setValue("member__" + actorId + "__extra__useTempPassword", "");
		return 0;
	}// 임시패스워드 삭제 (비우기)
	
	//▼get▼
	public boolean isValidEmailAuthCode(String actorId, String authCode) {
		String authCodeOnDB = attrService.getValue("member__" + actorId + "__extra__emailAuthCode");
		return authCodeOnDB.equals(authCode);
	}// 이메일 인증 AuthCode Fact
	
	public String getEmailAuthed(int actorId) {
		String authCodeOnDB = attrService.getValue("member__" + actorId + "__extra__emailAuthed");
		return authCodeOnDB;
	}// 이메일 가져오기
}

package com.sbs.hsb.ex1.service;

import java.util.Map;

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
	@Value("${custom.siteMainUri}")
	private String siteMainUri;
	@Value("${custom.siteName}")
	private String siteName;

	public Member getMemberById(int id) {
		return memberDao.getMemberById(id);
	}

	public int join(Map<String, Object> param) {
		memberDao.join(param);

		sendJoinCompleteMail((String) param.get("email"));

		return Util.getAsInt(param.get("id"));
	}

	private void sendJoinCompleteMail(String email) {
		String mailTitle = String.format("[%s] 가입이 완료되었습니다.", siteName);

		StringBuilder mailBodySb = new StringBuilder();
		mailBodySb.append("<h1>가입이 완료되었습니다.</h1>");
		mailBodySb.append(String.format("<p><a href=\"%s\" target=\"_blank\">%s</a>로 이동</p>", siteMainUri, siteName));

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
}

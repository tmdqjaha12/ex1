package com.sbs.hsb.ex1.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.hsb.ex1.dto.ResultData;
import com.sbs.hsb.ex1.service.MemberService;
import com.sbs.hsb.ex1.util.VerifyRecaptcha;

@Controller
public class VerifyRecaptchaController {
	@Autowired
	private MemberService memberService;

	@ResponseBody
	@RequestMapping("/usr/member/VerifyRecaptcha")
	public ResultData VerifyRecaptcha(HttpServletRequest request, Model model, HttpSession session) {
		VerifyRecaptcha.setSecretKey("6Ldk98AZAAAAAB4vWpuUbi2hQ055NhATzre9vvZk");
		String gRecaptchaResponse = request.getParameter("recaptcha");
		
		System.out.println("testMessage : " + gRecaptchaResponse);
		
		// 0 = 성공, 1 = 실패, -1 = 오류
		try {
			if (VerifyRecaptcha.verify(gRecaptchaResponse)) {
				
				
//				String redirectUri = "/usr/home/main";
				int loginedMemberId = (int) session.getAttribute("loginedMemberId");
				
				memberService.doSecssion(loginedMemberId);//회원탈퇴
				session.removeAttribute("loginedMemberId");//로그아웃

				
				return new ResultData("S-1", "탈퇴성공");				
			}
			else
				return new ResultData("F-1", "탈퇴실패");
		} catch (IOException e) {
			e.printStackTrace();
			return new ResultData("F-2", "탈퇴실패");
		}
	}
}

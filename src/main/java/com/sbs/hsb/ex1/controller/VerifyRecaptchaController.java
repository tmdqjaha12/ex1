package com.sbs.hsb.ex1.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.hsb.ex1.util.VerifyRecaptcha;

@Controller
public class VerifyRecaptchaController {

	@ResponseBody
	@RequestMapping(value = "VerifyRecaptcha", method = RequestMethod.POST)
	public int VerifyRecaptcha(HttpServletRequest request) {
		VerifyRecaptcha.setSecretKey("6Ldk98AZAAAAAB4vWpuUbi2hQ055NhATzre9vvZk");
		String gRecaptchaResponse = request.getParameter("recaptcha");
		System.out.println("gRecaptchaResponse : " + gRecaptchaResponse);
		// 0 = 성공, 1 = 실패, -1 = 오류
		try {
			if (VerifyRecaptcha.verify(gRecaptchaResponse))
				return 0;
			else
				return 1;
		} catch (IOException e) {
			e.printStackTrace();
			return -1;
		}
	}
}

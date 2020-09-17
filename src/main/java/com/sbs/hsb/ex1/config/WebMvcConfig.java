package com.sbs.hsb.ex1.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {
	// beforeActionInterceptor 인터셉터 불러오기
	@Autowired
	@Qualifier("beforeActionInterceptor")
	HandlerInterceptor beforeActionInterceptor;

	// needToLoginInterceptor 인터셉터 불러오기
	@Autowired
	@Qualifier("needToLoginInterceptor")
	HandlerInterceptor needToLoginInterceptor;

	// needToLogoutInterceptor 인터셉터 불러오기
	@Autowired
	@Qualifier("needToLogoutInterceptor")
	HandlerInterceptor needToLogoutInterceptor;
	
	// needToUserLevelInterceptor 인터셉터 불러오기
	@Autowired
	@Qualifier("needToUserLevelInterceptor")
	HandlerInterceptor needToUserLevelInterceptor;

	// 이 함수는 인터셉터를 적용하는 역할을 합니다.
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		// beforeActionInterceptor 인터셉터가 모든 액션 실행전에 실행되도록 처리
		registry.addInterceptor(beforeActionInterceptor).addPathPatterns("/**").excludePathPatterns("/resource/**");

		// 로그인 없이도 접속할 수 있는 URI 전부 기술
		registry.addInterceptor(needToLoginInterceptor).addPathPatterns("/**").excludePathPatterns("/").excludePathPatterns("")
				.excludePathPatterns("/resource/**").excludePathPatterns("/usr/home/main")
				.excludePathPatterns("/usr/member/login").excludePathPatterns("/usr/member/doLogin")
				.excludePathPatterns("/usr/member/join").excludePathPatterns("/usr/member/doJoin")
				.excludePathPatterns("/usr/member/getLoginIdDup").excludePathPatterns("/usr/member/getNickNameDup")
				.excludePathPatterns("/usr/member/getEmailDup").excludePathPatterns("/usr/member/findId")
				.excludePathPatterns("/usr/member/doFindId").excludePathPatterns("/usr/member/findPw")
				.excludePathPatterns("/usr/member/doFindPw").excludePathPatterns("/usr/article/*-list")
				.excludePathPatterns("/usr/article/*-detail").excludePathPatterns("/usr/reply/getForPrintReplies")
				.excludePathPatterns("/usr/file/streamVideo").excludePathPatterns("/usr/file/doUploadAjax");
		
		// 로그인 상태에서 접속할 수 없는 URI 전부 기술
		registry.addInterceptor(needToLogoutInterceptor).addPathPatterns("/usr/member/login")
				.addPathPatterns("/usr/member/doLogin").addPathPatterns("/usr/member/join")
				.addPathPatterns("/usr/member/doJoin");
		
		// level 6미만에서 접속할 수 없는 URI 전부 기술
		registry.addInterceptor(needToUserLevelInterceptor).addPathPatterns("/usr/home/adminPage")
				.addPathPatterns("/usr/board/boardApplyList").addPathPatterns("/usr/board/doBoardApply")
				.addPathPatterns("/usr/board/doBoardReject");
	}
}
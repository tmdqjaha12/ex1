package com.sbs.hsb.ex1.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component("needToUserSixLevelInterceptor") // 컴포넌트 이름 설정
public class NeedToUserSixLevelInterceptor implements HandlerInterceptor {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		int userLever = (int) request.getAttribute("userLever");
		
		boolean isAjax = (boolean) request.getAttribute("isAjax");

		
		if(userLever < 6) {
			if (isAjax == false) {
				response.setContentType("text/html; charset=UTF-8");
				response.getWriter().append("<script>");
				response.getWriter().append("alert('관리자 권한이 없습니다.');");
				response.getWriter().append("location.replace('/usr/home/main');");
				response.getWriter().append("</script>");
				// 리턴 false;를 이후에 실행될 인터셉터와 액션이 실행되지 않음
			} else {
				response.setContentType("application/json; charset=UTF-8");
				response.getWriter().append("{\"resultCode\":\"F-A\",\"msg\":\"관리자 권한이 없습니다.\"}");
			}
			
			return false;
		}

		return HandlerInterceptor.super.preHandle(request, response, handler);
	}
}

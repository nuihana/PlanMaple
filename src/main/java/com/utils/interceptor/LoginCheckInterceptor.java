package com.utils.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.utils.WebConfig;

public class LoginCheckInterceptor extends HandlerInterceptorAdapter {

	static WebConfig config = new WebConfig();
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		if (!isSkip(request)) {
			
			HttpSession session = request.getSession();
			Object obj = session.getAttribute("login");
			
			if(obj == null){
				response.sendRedirect("/login");
				return false;
			}
			
		} 

		return true;
	}
	
	private boolean isSkip(HttpServletRequest request) {
		boolean resultFlag = false;
		String requestURI = request.getRequestURI();
		
		if(requestURI.contains("/login")) {
			resultFlag = true;
		} else if (requestURI.contains("/signup")) {
			resultFlag = true;
		} else if (requestURI.contains("/findUser")) {
			resultFlag = true;
		} else if (requestURI.contains("/passwordProc")) {
			resultFlag = true;
		} else if (requestURI.contains("/static")) {
			resultFlag = true;
		} else if (requestURI.contains("maplestory")) { //메이플스토리 정보 수집 url 1
			resultFlag = true;
		} else if (requestURI.contains("nexon")) { //메이플스토리 정보 수집 url 2
			resultFlag = true;
		}
		return resultFlag;
	}

}

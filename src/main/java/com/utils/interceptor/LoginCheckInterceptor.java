package com.utils.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.utils.WebConfig;
import com.vos.web.UserVo;

public class LoginCheckInterceptor extends HandlerInterceptorAdapter {

	static WebConfig config = new WebConfig();
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
			
//		HttpSession session = request.getSession();
//		Object obj = session.getAttribute("login");
//		
//		if(obj == null){
//			response.sendRedirect("/login");
//			return false;
//		}

		return true;
	}
}

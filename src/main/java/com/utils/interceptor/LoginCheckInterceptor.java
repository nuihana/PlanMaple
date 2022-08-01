package com.utils.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.utils.WebConfig;

public class LoginCheckInterceptor extends HandlerInterceptorAdapter {

	static WebConfig config = new WebConfig();
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		if (!isSkip(request)) {
			
//			HttpSession session = request.getSession();
//			if(session != null){
//				LoginVo loginVo = (LoginVo) session.getAttribute("loginVo");
//				
//				if (loginVo == null) {
//					response.sendRedirect(request.getContextPath() + "/login");
//					return false;
//				}
//			}else{
//				response.sendRedirect(request.getContextPath() + "/login");
//				return false;
//			}
		} 

		return true;
	}
	
	private boolean isSkip(HttpServletRequest request) {
		boolean resultFlag = false;
		String requestURI = request.getRequestURI();
		
		if(requestURI.contains("/login")) {
			resultFlag = true;
		} else if (requestURI.contains("/error")) {
			resultFlag = true;
		} else if (requestURI.contains("/test/")) {
			resultFlag = true;
		} else if (requestURI.contains("/v3/")) {
			resultFlag = true;
		} else if (requestURI.contains("/common/")) {
			resultFlag = true;
		}
		return resultFlag;
	}
}

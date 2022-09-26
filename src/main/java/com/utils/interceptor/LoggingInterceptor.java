package com.utils.interceptor;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.utils.WebConfig;

public class LoggingInterceptor extends HandlerInterceptorAdapter {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	static WebConfig config = new WebConfig();
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		if(config.getValue("log.show").equals("Y")){
			logger.info("====================Request Info====================");
			Enumeration enums = request.getParameterNames();
			while (enums.hasMoreElements()) {
				String paramName = (String) enums.nextElement();
				String[] parameters = request.getParameterValues(paramName);
	
				for (int i = 0; i < parameters.length; i++) {
					//system log 보고싶은 param 설정
					if(!config.getValue("log.param").equals("")){
						if(config.getValue("log.param").equals(paramName)){
							logger.info("parameter [" + paramName + "] " + parameters[i]);
						}
					}else{
						logger.info("parameter [" + paramName + "] " + parameters[i]);
					};
				}
			}
			logger.info("====================Request Info====================");
		}
		
		return true;
	}
}

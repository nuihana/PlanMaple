package com.controllers.core;

import javax.inject.Inject;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import com.utils.WebConfig;

@Controller
public class MainController {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	static WebConfig config = new WebConfig();
	
	@Inject
	private DataSource datsSource = null;

	private String buildVersion = "20221218_001";
	 
	public MainController() throws Exception {
		logger.info("init Project");
		
		Context context = null;
		try {
			context = (Context)(new InitialContext().lookup("java:/comp/env"));
			config.initalize((String) context.lookup("location"));
			datsSource = (DataSource) context.lookup("db");
		} catch (NamingException e) {
		} finally {
			if (context != null) context = null;
		}

		config.setValue("build.version", buildVersion);
		
		//UTC-Time존 세팅 : UTC > KST : AWS 서버시간을 직접 서울로 바꿔 필요없어짐
//		TimeZone.setDefault(TimeZone.getTimeZone("Asia/Seoul"));

		logger.info("OS->" + config.getValue("os.name"));
		logger.info("buildVersion->" + config.getValue("build.version"));
		
//		CheckThread chkThread = new CheckThread(datsSource);
//		Thread threadCheck = new Thread(chkThread);	
//		logger.info("threadCheck -> [" + threadCheck.getId() + "] " + threadCheck.getName());
//
//		threadCheck.start();		
	}
}

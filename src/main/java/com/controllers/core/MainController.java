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

	private String buildVersion = "20220730_001";
	 
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

		logger.info("OS->" + config.getValue("os.name"));
		logger.info("vscID->" + config.getValue("vscID"));
		logger.info("dbType->" + config.getValue("db.type"));

		config.setValue("build.version", buildVersion);
		
//		CheckThread chkThread = new CheckThread(datsSource);
//		Thread threadCheck = new Thread(chkThread);	
//		logger.info("threadCheck -> [" + threadCheck.getId() + "] " + threadCheck.getName());
//
//		threadCheck.start();		
	}
}

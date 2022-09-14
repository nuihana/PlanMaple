package com.controllers.core;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.services.web.ManagecodeService;
import com.services.web.ManagementService;
import com.utils.WebConfig;
import com.vos.web.ManagecodeVo;

@Component
@EnableScheduling
public class ResetScheduler {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	static WebConfig config = new WebConfig();
	
	@Inject
	ManagecodeService managecodeService;
	@Inject
	ManagementService managementService;
	
	@Scheduled(cron = "0 0 0 * * *")
	public void dailyReset() {
		logger.info("Daily Management Info Reset [start]");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("cycle", "D");
		
		managementService.updateManagementReset(map);

		logger.info("Daily Management Info Reset [end]");
	}
	
	@Scheduled(cron = "0 0 0 ? * MON")
	public void weeklyResetSunday() {
		logger.info("Weekly-Sunday Management Info Reset [start]");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("cycle", "S");
		
		managementService.updateManagementReset(map);
		
		logger.info("Weekly-Sunday Management Info Reset [end]");
	}
	
	@Scheduled(cron = "0 0 0 ? * THU")
	public void weeklyResetThursday() {
		logger.info("Weekly-Thursday Management Info Reset [start]");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("cycle", "T");
		
		managementService.updateManagementReset(map);
		
		logger.info("Weekly-Thursday Management Info Reset [end]");
	}
	
	@Scheduled(cron = "0 0 0 1 1/1 ?")
	public void MonthlyReset() {
		logger.info("Monthly Management Info Reset [start]");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("cycle", "M");
		
		managementService.updateManagementReset(map);
		
		logger.info("Monthly Management Info Reset [end]");
	}
}

package com.controllers.core;

import java.util.Calendar;
import java.util.HashMap;
import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.services.web.ManagecodeService;
import com.services.web.ManagementService;
import com.utils.WebConfig;
import net.javacrumbs.shedlock.spring.annotation.EnableSchedulerLock;
import net.javacrumbs.shedlock.spring.annotation.SchedulerLock;

@Component
@EnableScheduling
public class ResetScheduler {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	static WebConfig config = new WebConfig();
	
	@Inject
	ManagementService managementService;
	
	@Scheduled(cron = "0 0 0 * * *")
	public void dailyReset() {
		logger.info("Management Info Reset [start]");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("cycle", "D");
		
		managementService.updateManagementReset(map);
		
		Calendar cal = Calendar.getInstance();
		if (cal.get(Calendar.DAY_OF_WEEK) == 2) {
			map.clear();
			map.put("cycle", "S");
			
			managementService.updateManagementReset(map);
			logger.info("Weekly-Sunday Management Info Reset [done]");
		}
		
		if (cal.get(Calendar.DAY_OF_WEEK) == 5) {
			map.clear();
			map.put("cycle", "T");
			
			managementService.updateManagementReset(map);
			logger.info("Weekly-Thursday Management Info Reset [done]");
		}
		
		if (cal.get(Calendar.DAY_OF_MONTH) == 1) {
			map.clear();
			map.put("cycle", "M");
			
			managementService.updateManagementReset(map);
			logger.info("Monthly Management Info Reset [done]");
		}

		logger.info("Management Info Reset [end]");
	}
}

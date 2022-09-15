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

import net.javacrumbs.shedlock.core.SchedulerLock;
import net.javacrumbs.shedlock.spring.annotation.EnableSchedulerLock;

@Component
@EnableScheduling
@EnableSchedulerLock(defaultLockAtMostFor = "PT1M")
public class ResetScheduler {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	static WebConfig config = new WebConfig();
	
	@Inject
	ManagecodeService managecodeService;
	@Inject
	ManagementService managementService;
	
	@Scheduled(cron = "0 0 0 * * *")
	@SchedulerLock(
        name = "scheduler_lock", // 스케줄러 락 이름 지정. (이름이 동일한 스케줄러일 경우, 락의 대상이 된다.)
        lockAtLeastForString = "PT30S", // 락을 유지하는 시간을 설정한다.
        lockAtMostForString = "PT1M" // 보통 스케줄러가 잘 동작하여 잘 종료된 경우 잠금을 바로 해제하게 되는데, 스케줄러 오류가 발생하면 잠금이 해제되지 않는다. 이런 경우 잠금을 유지하는 시간을 설정한다.
    )
	public void dailyReset() {
		logger.info("Daily Management Info Reset [start]");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("cycle", "D");
		
		managementService.updateManagementReset(map);

		logger.info("Daily Management Info Reset [end]");
	}
	
	@Scheduled(cron = "0 0 0 ? * MON")
	@SchedulerLock(
        name = "scheduler_lock",
        lockAtLeastForString = "PT30S",
        lockAtMostForString = "PT1M"
    )
	public void weeklyResetSunday() {
		logger.info("Weekly-Sunday Management Info Reset [start]");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("cycle", "S");
		
		managementService.updateManagementReset(map);
		
		logger.info("Weekly-Sunday Management Info Reset [end]");
	}
	
	@Scheduled(cron = "0 0 0 ? * THU")
	@SchedulerLock(
        name = "scheduler_lock",
        lockAtLeastForString = "PT30S",
        lockAtMostForString = "PT1M"
    )
	public void weeklyResetThursday() {
		logger.info("Weekly-Thursday Management Info Reset [start]");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("cycle", "T");
		
		managementService.updateManagementReset(map);
		
		logger.info("Weekly-Thursday Management Info Reset [end]");
	}
	
	@Scheduled(cron = "0 0 0 1 1/1 ?")
	@SchedulerLock(
        name = "scheduler_lock",
        lockAtLeastForString = "PT30S",
        lockAtMostForString = "PT1M"
    )
	public void MonthlyReset() {
		logger.info("Monthly Management Info Reset [start]");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("cycle", "M");
		
		managementService.updateManagementReset(map);
		
		logger.info("Monthly Management Info Reset [end]");
	}
}

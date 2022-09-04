package com.controllers.web;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.services.web.CharacterService;
import com.services.web.ManagementService;
import com.utils.WebConfig;
import com.vos.web.CharacterVo;
import com.vos.web.ManagementVo;
import com.vos.web.ReturnVo;

@Controller
public class HomeController {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	static WebConfig config = new WebConfig();
	
	@Inject
	CharacterService characterService;
	@Inject
	ManagementService managementService;

	@RequestMapping(value = {"home"}, method = RequestMethod.GET)
	public @ResponseBody ModelAndView home(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model) {
		String user_seq = (String) session.getAttribute("loginSeq");
		
		List<CharacterVo> characterList = characterService.selectCharacterList(new CharacterVo(user_seq));
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		HashMap<String, String> selectMap = new HashMap<String, String>();
		map.put("characterCnt", characterList.size());
		selectMap.put("user_seq", user_seq);
		
		int manageSum = 0;
		List<Map<String, String>> leftManagementList = managementService.selectLeftManagementList(selectMap);
		for (Map<String, String> tmp : leftManagementList) {
			manageSum += Integer.parseInt(String.valueOf(tmp.get("CHARACTER_WORK")));
		}
		map.put("leftManagementCnt", manageSum);
		
		int deadlineSum = 0;
		Calendar cal = Calendar.getInstance();
		String dayOfWeek = cal.get(Calendar.DAY_OF_WEEK) + "";
		selectMap.put("day", dayOfWeek);
		List<Map<String, String>> deadlineManagementList = managementService.selectDeadlineManagementList(selectMap);
		for (Map<String, String> tmp : deadlineManagementList) {
			deadlineSum += Integer.parseInt(String.valueOf(tmp.get("CHARACTER_WORK")));
		}
		map.put("deadlineManagementCnt", deadlineSum);

		model.addAttribute("card_data", map);
		model.addAttribute("config", config);
		
		return new ModelAndView("/home", model);
	}
	
	@RequestMapping(value = {"homeDataAjax"}, method = RequestMethod.POST)
	public @ResponseBody ReturnVo homeDataAjax(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model) {
		String user_seq = (String) session.getAttribute("loginSeq");
		
		HashMap<String, String> selectMap = new HashMap<String, String>();
		selectMap.put("user_seq", user_seq);
		
		List<ManagementVo> serverLeftManagement = new ArrayList<ManagementVo>();
		List<Map<String, String>> leftManagementList = managementService.selectLeftManagementList(selectMap);
		for (Map<String, String> tmp : leftManagementList) {
			boolean flag = true;
			for (ManagementVo tmp_ : serverLeftManagement) {
				if (tmp_.getServer_code().equals(tmp.get("SERVER_CODE"))) {
					flag = false;
					
					tmp_.setComplete_count(Integer.parseInt(String.valueOf(tmp.get("CHARACTER_WORK"))) + Integer.parseInt(tmp_.getComplete_count()) + "");
				}
			}
			
			if (flag) {
				ManagementVo insertVo = new ManagementVo();
				insertVo.setServer_code(tmp.get("SERVER_CODE"));
				insertVo.setComplete_count(String.valueOf(tmp.get("CHARACTER_WORK")));
				serverLeftManagement.add(insertVo);
			}
		}
		
		if (serverLeftManagement.isEmpty()) {
			return new ReturnVo("NO", null, null);
		} else {
			return new ReturnVo("OK", null, serverLeftManagement);
		}
	}
}

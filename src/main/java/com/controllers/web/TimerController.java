package com.controllers.web;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.services.web.CharacterService;
import com.services.web.ManagementTimerService;
import com.utils.WebConfig;
import com.vos.web.CharacterVo;
import com.vos.web.ManagementTimerVo;
import com.vos.web.ReturnVo;
import com.vos.web.UserVo;

@Controller
public class TimerController {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	static WebConfig config = new WebConfig();
	
	@Inject
	CharacterService characterService;
	@Inject
	ManagementTimerService managementTimerSerivice;

	@RequestMapping(value = {"timer"}, method = RequestMethod.GET)
	public @ResponseBody ModelAndView timer(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model) {
		String user_seq = (String) session.getAttribute("loginSeq");
		
		List<CharacterVo> characterList = characterService.selectCharacterList(new CharacterVo(user_seq));

		List<ManagementTimerVo> farmTimerList = managementTimerSerivice.selectFarmTimerList(new CharacterVo(user_seq));
		
		model.addAttribute("characterList", characterList);
		model.addAttribute("farmTimerList", farmTimerList);
		
		model.addAttribute("loginSeq", user_seq);
		model.addAttribute("config", config);
		
		return new ModelAndView("/timer", model);
	}
	
	@RequestMapping(value = {"characterTimer"}, method = RequestMethod.POST)
	public @ResponseBody ModelAndView characterTimer(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			@ModelAttribute("characterVo") CharacterVo characterVo, ModelMap model) {
		
		List<ManagementTimerVo> characterTimerList = managementTimerSerivice.selectCharacterTimerList(characterVo);
		
		for (int i = 0, limit = characterTimerList.size(); i < limit; i++) {
			ManagementTimerVo tmpVo = characterTimerList.get(i);
			String voName = tmpVo.getTimer_code().contains("ACCE") ? "acceVo" : tmpVo.getTimer_code().contains("EQUI") ? "equiVo" : "alchVo";
			
			model.addAttribute(voName, tmpVo);
		}
		
		return new ModelAndView("/innerPage/innerCharacterTimer", model);
	}
	
	@RequestMapping(value = {"farmTimer"}, method = RequestMethod.POST)
	public @ResponseBody ModelAndView farmTimer(ManagementTimerVo managementTimerVo, ModelMap model) {
		
		ManagementTimerVo farmVo = managementTimerSerivice.selectFarmTimer(managementTimerVo);
		
		model.addAttribute("farmVo", farmVo);
		
		return new ModelAndView("/innerPage/innerFarmTimer", model);
	}
	
	@RequestMapping(value = {"farmList"}, method = RequestMethod.POST)
	public @ResponseBody ModelAndView farmList(HttpSession session, ModelMap model) {
		String user_seq = (String) session.getAttribute("loginSeq");

		List<ManagementTimerVo> farmTimerList = managementTimerSerivice.selectFarmTimerList(new CharacterVo(user_seq));
		
		model.addAttribute("farmTimerList", farmTimerList);
		
		return new ModelAndView("/innerPage/innerFarmList", model);
	}
	
	@RequestMapping(value = {"timerProc"}, method = RequestMethod.POST)
	public @ResponseBody ReturnVo managementProc (HttpSession session, ManagementTimerVo managementTimerVo) {
		int actionCnt = 0;
		String actionMessage = "";
		
		if (managementTimerVo.getProc_role().equalsIgnoreCase("character_save")) {
			actionMessage = "등록 되었습니다.";
			actionCnt = managementTimerSerivice.saveCharacterTimer(managementTimerVo);
		} else if (managementTimerVo.getProc_role().equalsIgnoreCase("refresh")) {
			actionMessage = "갱신 되었습니다.";
			actionCnt = managementTimerSerivice.refreshCharacterTimer(managementTimerVo);
		} else if (managementTimerVo.getProc_role().equalsIgnoreCase("timer_set")) {
			actionMessage = "시간이 변경되었습니다.";
			actionCnt = managementTimerSerivice.changeCharacterTimer(managementTimerVo);
		} else if (managementTimerVo.getProc_role().equalsIgnoreCase("farm_save")) {
			actionMessage = "등록 되었습니다.";
			
			if (managementTimerVo.getFarm_timer_list() != null && managementTimerVo.getFarm_timer_list().size() > 0) {
				for (ManagementTimerVo tmp : managementTimerVo.getFarm_timer_list()) {
					UserVo userVo = (UserVo) session.getAttribute("login");
					tmp.setTimer_target(userVo.getUser_seq());
					tmp.setTimer_target_type("U");
				}
				
				actionCnt += managementTimerSerivice.insertFarmTimer(managementTimerVo);
			}
		} else if (managementTimerVo.getProc_role().equalsIgnoreCase("farm_delete")) {
			actionMessage = "삭제 되었습니다.";
			actionCnt = managementTimerSerivice.deleteFarmTimer(managementTimerVo);
		} else if (managementTimerVo.getProc_role().equalsIgnoreCase("farm-refresh")) {
			actionMessage = "갱신 되었습니다.";
			actionCnt = managementTimerSerivice.refreshFarmTimer(managementTimerVo);
		}
		
		if (actionCnt == 0) {
			actionMessage = "변경할 데이터가 존재하지 않습니다.";
		}
		
		if (actionCnt > 0) {
			return new ReturnVo("YES", actionMessage, managementTimerVo);
		} else {
			return new ReturnVo("NO", actionMessage, null);
		}
	}
}

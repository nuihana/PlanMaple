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
		
		model.addAttribute("characterList", characterList);
		
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
	public @ResponseBody ModelAndView farmTimer(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			ModelMap model) {
		
		return new ModelAndView("/innerPage/innerFarmTimer", model);
	}
	
	@RequestMapping(value = {"timerProc"}, method = RequestMethod.POST)
	public @ResponseBody ReturnVo managementProc (ManagementTimerVo managementTimerVo) {
		int actionCnt = 0;
		String actionMessage = "";
		
		if (managementTimerVo.getProc_role().equalsIgnoreCase("character_save")) {
			actionMessage = "등록 되었습니다.";
			actionCnt = managementTimerSerivice.saveCharacterTimer(managementTimerVo);
		}
		
		if (actionCnt == 0) {
			actionMessage = "변경할 데이터가 존재하지 않습니다.";
		}
		
		if (actionCnt > 0) {
			return new ReturnVo("YES", actionMessage, null);
		} else {
			return new ReturnVo("NO", actionMessage, null);
		}
	}
}

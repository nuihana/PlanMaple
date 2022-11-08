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
import com.utils.WebConfig;
import com.vos.web.CharacterVo;

@Controller
public class TimerController {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	static WebConfig config = new WebConfig();
	
	@Inject
	CharacterService characterService;

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
		
		return new ModelAndView("/innerPage/innerCharacterTimer", model);
	}
	
	@RequestMapping(value = {"farmTimer"}, method = RequestMethod.POST)
	public @ResponseBody ModelAndView farmTimer(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			ModelMap model) {
		
		return new ModelAndView("/innerPage/innerFarmTimer", model);
	}
}

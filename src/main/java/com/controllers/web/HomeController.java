package com.controllers.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.utils.WebConfig;

@Controller
public class HomeController {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	static WebConfig config = new WebConfig();

	@RequestMapping(value = {"home"}, method = RequestMethod.GET)
	public @ResponseBody ModelAndView home(ModelMap model) {
		model.addAttribute("config", config);
		
		return new ModelAndView("/home", model);
	}
}

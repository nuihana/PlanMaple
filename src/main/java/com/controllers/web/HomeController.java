package com.controllers.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {

	@RequestMapping(value = {"home"}, method = RequestMethod.GET)
	public @ResponseBody ModelAndView home(ModelMap model) {
		
		return new ModelAndView("/home", model);
	}
}

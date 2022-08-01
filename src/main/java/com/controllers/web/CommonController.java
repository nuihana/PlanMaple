package com.controllers.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CommonController {

	@RequestMapping(value = {"", "/", "index"}, method = RequestMethod.GET)
	public @ResponseBody ModelAndView index(ModelMap model) {
		
		return new ModelAndView("/index", model);
	}
}

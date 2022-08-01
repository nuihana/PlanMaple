package com.controllers.web;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.services.web.LoginService;

@Controller
public class LoginController {
	
	@Inject
	LoginService loginService;

	@RequestMapping(value = {"login"}, method = RequestMethod.GET)
	public @ResponseBody ModelAndView login(ModelMap model) {
		model.addAttribute("test", loginService.getSelectTest());
		
		return new ModelAndView("/login", model);
	}
}

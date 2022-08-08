package com.controllers.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CommonController {

	@RequestMapping(value = {"", "/", "index"}, method = RequestMethod.GET)
	public @ResponseBody ModelAndView index(HttpServletRequest request, ModelMap model) {
		HttpSession session = request.getSession();
		Object obj = session.getAttribute("login");
		
		model.addAttribute("loginSession", obj);
		
		return new ModelAndView("/index", model);
	}
}

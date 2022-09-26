package com.controllers.web;

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

import com.utils.WebConfig;

@Controller
public class CommonController {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	static WebConfig config = new WebConfig();

	@RequestMapping(value = {"", "/", "index"}, method = RequestMethod.GET)
	public @ResponseBody ModelAndView index(HttpServletRequest request, ModelMap model) {
		HttpSession session = request.getSession();
		Object obj = session.getAttribute("login");
		
		model.addAttribute("loginSession", obj);
		
		return new ModelAndView("/index", model);
	}

	@RequestMapping(value = {"error"}, method = RequestMethod.GET)
	public @ResponseBody ModelAndView error(HttpServletRequest request, ModelMap model) {
		Object errCode = request.getParameter("code");
		errCode = errCode == null || errCode.equals("") ? "ERR_0000" : errCode;
		
		model.addAttribute("errCode", errCode);
		model.addAttribute("config", config);
		
		return new ModelAndView("/error", model);
	}
	
	@RequestMapping(value = {"logout"}, method = RequestMethod.POST)
	public @ResponseBody ModelAndView logout (HttpServletRequest request, HttpServletResponse response, ModelMap model) {
		HttpSession session = request.getSession();
		session.removeAttribute("login");
		session.removeAttribute("loginSeq");
		
		return new ModelAndView("/index", model);
	}
}

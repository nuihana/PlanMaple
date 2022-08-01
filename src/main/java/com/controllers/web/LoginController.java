package com.controllers.web;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.services.web.LoginService;
import com.vos.web.ReturnVo;
import com.vos.web.UserVo;

@Controller
public class LoginController {
	
	@Inject
	LoginService loginService;

	@RequestMapping(value = {"login"}, method = RequestMethod.GET)
	public @ResponseBody ModelAndView login(ModelMap model) {
//		UserVo reqUser = new UserVo();
//		reqUser.setUser_id("test");
//		reqUser.setUser_pw("test");
//		
//		model.addAttribute("user", loginService.selectUser(reqUser));
		
		return new ModelAndView("/login", model);
	}
	
	@RequestMapping(value = {"loginCheckAjax"}, method = RequestMethod.POST)
	public @ResponseBody ReturnVo loginCheckAjax(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			@ModelAttribute("userVo") UserVo reqUser, ModelMap model) {
		if (session.getAttribute("login") != null) {
			session.removeAttribute("login");
		}
		
		UserVo rstUser = loginService.selectUser(reqUser);
		
		if (rstUser != null) {
			session.setAttribute("login", rstUser);
			
			return new ReturnVo("OK", "home", rstUser);
		} else {
			return new ReturnVo("OK", "login", rstUser);
		}
	}
}
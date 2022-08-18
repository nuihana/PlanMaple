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
import org.springframework.web.bind.annotation.RequestParam;
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
	public @ResponseBody ModelAndView login(ModelMap model, @ModelAttribute("userVo") UserVo reqUser) {
		model.addAttribute("userVo", reqUser);
		
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
			session.setAttribute("loginSeq", rstUser.getUser_seq());
			
			session.setMaxInactiveInterval(60*60*24);
			
			return new ReturnVo("OK", "home", rstUser);
		} else {
			String returnUrl = "?";
			
			if (reqUser.getUser_id() != null && !reqUser.getUser_id().equals("")) {
				returnUrl += "user_id=" + reqUser.getUser_id() + "&";
			}
			
			if (reqUser.getUser_pw() != null && !reqUser.getUser_pw().equals("")) {
				returnUrl += "user_pw=" + reqUser.getUser_pw() + "&";
			}
			
			return new ReturnVo("NO", "login" + returnUrl, rstUser);
		}
	}
}
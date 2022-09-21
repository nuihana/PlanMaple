package com.controllers.web;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DuplicateKeyException;
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
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
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

	@RequestMapping(value = {"signup"}, method = RequestMethod.GET)
	public @ResponseBody ModelAndView signup(ModelMap model) {
		
		return new ModelAndView("/signup", model);
	}
	
	@RequestMapping(value = {"loginUserDuplChkAjax"}, method = RequestMethod.POST)
	public @ResponseBody ReturnVo loginUserDuplChkAjax(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			@ModelAttribute("userVo") UserVo reqUser, ModelMap model) {
		
		UserVo rstUser = loginService.selectUserIsExist(reqUser);
		
		if (rstUser != null) {
			return new ReturnVo("NO", null, rstUser);
		} else {
			return new ReturnVo("OK", null, null);
		}
	}
	
	@RequestMapping(value = {"signupAjax"}, method = RequestMethod.POST)
	public @ResponseBody ReturnVo signupAjax(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			@ModelAttribute("userVo") UserVo reqUser, ModelMap model) {
		
		int actionCnt = 0;
		String actionMessage = "";
		
		actionMessage = "등록 되었습니다.";
		try {
			actionCnt = loginService.insertUser(reqUser);
		} catch (DuplicateKeyException e) {
			actionMessage = "이미 존재하는 데이터입니다.";
		}
		
		if (actionCnt > 0) {
			return new ReturnVo("OK", actionMessage, reqUser);
		} else {
			return new ReturnVo("NO", actionMessage, null);
		}
	}

	@RequestMapping(value = {"password"}, method = RequestMethod.GET)
	public @ResponseBody ModelAndView password (HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model) {
		UserVo userVo = (UserVo) session.getAttribute("login");
		
		model.addAttribute("userVo", userVo);
		
		return new ModelAndView("/password", model);
	}
	
	@RequestMapping(value = {"passwordChkAjax"}, method = RequestMethod.POST)
	public @ResponseBody ReturnVo passwordChkAjax (HttpServletRequest request, HttpServletResponse response, HttpSession session,
			@ModelAttribute("userVo") UserVo reqUser, ModelMap model) {
		
		UserVo rstUser = loginService.selectUser(reqUser);
		
		if (rstUser != null) {
			return new ReturnVo("YES", null, rstUser);
		} else {
			return new ReturnVo("NO", null, null);
		}
	}
	
	@RequestMapping(value = {"passwordProc"}, method = RequestMethod.POST)
	public @ResponseBody ReturnVo passwordProc (HttpServletRequest request, HttpServletResponse response, HttpSession session,
			@ModelAttribute("userVo") UserVo reqUser, ModelMap model) {
		
		int actionCnt = 0;
		String actionMessage = "";
		
		actionCnt = loginService.updateUser(reqUser);
		
		if (actionCnt > 0) {
			actionMessage = "변경되었습니다.";
			
			session.removeAttribute("login");
			session.removeAttribute("loginSeq");
			
			return new ReturnVo("YES", actionMessage, reqUser);
		} else {
			actionMessage = "예상치 못한 오류가 발생하였습니다.";
			return new ReturnVo("NO", actionMessage, null);
		}
	}
}
package com.controllers.web;

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

import com.services.web.LoginService;
import com.services.web.UserService;
import com.vos.web.ReturnVo;
import com.vos.web.UserVo;

@Controller
public class UserController {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	LoginService loginService;
	@Inject
	UserService userService;

	@RequestMapping(value = {"user"}, method = RequestMethod.GET)
	public @ResponseBody ModelAndView user (HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model) {
		UserVo userVo = (UserVo) session.getAttribute("login");
		
		model.addAttribute("userVo", userVo);
		
		return new ModelAndView("/user", model);
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
		
		actionCnt = userService.updateUser(reqUser);
		
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
	
	@RequestMapping(value = {"userProc"}, method = RequestMethod.POST)
	public @ResponseBody ReturnVo userProc (HttpServletRequest request, HttpServletResponse response, HttpSession session,
			@ModelAttribute("userVo") UserVo reqUser, ModelMap model) {
		session.removeAttribute("login");
		session.removeAttribute("loginSeq");
		
		int actionCnt = 0;
		String actionMessage = "";
		
		if (reqUser.getProc_role().equalsIgnoreCase("delete")) {
			actionMessage = "삭제되었습니다.";
			actionCnt = userService.deleteUser(reqUser);
		}
		
		if (actionCnt > 0) {
			return new ReturnVo("YES", actionMessage, reqUser);
		} else {
			return new ReturnVo("NO", actionMessage, null);
		}
	}
}
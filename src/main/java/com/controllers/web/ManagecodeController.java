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

import com.services.web.ManagecodeService;
import com.utils.WebConfig;
import com.vos.web.ManagecodeVo;
import com.vos.web.ReturnVo;

@Controller
public class ManagecodeController {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	static WebConfig config = new WebConfig();
	
	@Inject
	ManagecodeService managecodeService;
	
	@RequestMapping(value = {"managecodeProc"}, method = RequestMethod.POST)
	public @ResponseBody ReturnVo managementProc (HttpServletRequest request, HttpServletResponse response, HttpSession session,
			@ModelAttribute("managecodeVo") ManagecodeVo managecodeVo, ModelMap model) {
		int actionCnt = 0;
		String actionMessage = "";
		
		if (managecodeVo.getProc_role().equals("insert")) {
			actionMessage = "입력 되었습니다.";
			actionCnt = managecodeService.insertManagecode(managecodeVo);
		} else if (managecodeVo.getProc_role().equals("delete")) {
			actionMessage = "삭제 되었습니다.";
			actionCnt = managecodeService.deleteManagecode(managecodeVo);
		} else if (managecodeVo.getProc_role().equals("update")) {
			actionMessage = "수정 되었습니다.";
			actionCnt = managecodeService.updateManagecode(managecodeVo);
		}
		
		if (actionCnt > 0) {
			return new ReturnVo("YES", actionMessage, null);
		} else {
			return new ReturnVo("NO", actionMessage, null);
		}
	}
	
	@RequestMapping(value = {"managecodePreview"}, method = RequestMethod.POST)
	public @ResponseBody ReturnVo managecodePreview (HttpServletRequest request, HttpServletResponse response, HttpSession session,
			@ModelAttribute("managecodeVo") ManagecodeVo managecodeVo, ModelMap model) {
		
		ManagecodeVo searchVo = managecodeService.selectManagementCodeInfo(managecodeVo);
		
		if (searchVo != null) {
			return new ReturnVo("YES", null, searchVo);
		} else {
			return new ReturnVo("NO", null, null);
		}
	}
}

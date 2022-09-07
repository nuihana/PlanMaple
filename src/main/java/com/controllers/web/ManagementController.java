package com.controllers.web;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

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

import com.services.web.CharacterService;
import com.services.web.ManagecodeService;
import com.services.web.ManagementService;
import com.utils.WebConfig;
import com.vos.web.CharacterVo;
import com.vos.web.ManagecodeVo;
import com.vos.web.ManagementVo;
import com.vos.web.ReturnVo;

@Controller
public class ManagementController {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	static WebConfig config = new WebConfig();

	@Inject
	CharacterService characterService;
	@Inject
	ManagecodeService managecodeService;
	@Inject
	ManagementService managementService;

	@RequestMapping(value = {"management"}, method = RequestMethod.GET)
	public @ResponseBody ModelAndView management(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model) {
		String user_seq = (String) session.getAttribute("loginSeq");
		
		HashMap<String, String> selectMap = new HashMap<String, String>();
		selectMap.put("user_seq", user_seq);
		Calendar cal = Calendar.getInstance();
		selectMap.put("day", cal.get(Calendar.DAY_OF_WEEK) + "");

		List<ManagecodeVo> headManagecodeList = new ArrayList<ManagecodeVo>();
		List<ManagecodeVo> bodyManagecodeList = new ArrayList<ManagecodeVo>();
		
		//전체 리스트
		List<ManagecodeVo> managecodeList = managecodeService.selectManagementCodeList(new CharacterVo(user_seq));
		//관리 캐릭터 목록
		List<CharacterVo> characterList = characterService.selectCharacterList(new CharacterVo(user_seq));
		//마감일 직전 숙제 코드 목록
		List<ManagecodeVo> deadlineList = managecodeService.selectDeadlineManagecodeList(selectMap);
		
		for (ManagecodeVo tmp : managecodeList) {
			if (tmp.getParant_code().equals("")) {
				headManagecodeList.add(tmp);
			} else {
				bodyManagecodeList.add(tmp);
				
				for (ManagecodeVo tmp_ : headManagecodeList) {
					if (tmp_.getManagement_code().equals(tmp.getParant_code())) {
						tmp_.setChid_count(Integer.parseInt(tmp_.getChid_count()) + 1 + "");
					}
				}
			}
		}
		
		for (ManagecodeVo tmp : bodyManagecodeList) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("code", tmp.getManagement_code());
			map.put("characterList", characterList);
			
			List<ManagementVo> targetManagementList = null;
			if (!characterList.isEmpty()) {
				targetManagementList = managementService.selectTargetManagementList(map);
			}
			
			for (CharacterVo tmp_ : characterList) {
				if (targetManagementList.contains(new ManagementVo(tmp.getManagement_code(), tmp_.getCharacter_seq()))) {
					ManagementVo tmpVo = targetManagementList.get(targetManagementList.indexOf(new ManagementVo(tmp.getManagement_code(), tmp_.getCharacter_seq())));
					tmpVo.setBelong_condition(tmp.getBelong_condition());
					tmpVo.setServer_code(tmp_.getCharacter_server_code());
					
					if (deadlineList.contains(new ManagecodeVo(tmp.getManagement_code()))) {
						tmpVo.setDeadline_flag("Y");
						tmp.addUnique_managementlist(tmpVo);
					} else {
						tmp.addUnique_managementlist(tmpVo);
					}
				} else {
					tmp.addUnique_managementlist(new ManagementVo());
				}
			}
		}
		
		model.addAttribute("headManagecodeList", headManagecodeList);
		model.addAttribute("bodyManagecodeList", bodyManagecodeList);
		
		model.addAttribute("characterList", characterList);
		
		model.addAttribute("config", config);
		
		return new ModelAndView("/management", model);
	}
	
	@RequestMapping(value = {"managementProc"}, method = RequestMethod.POST)
	public @ResponseBody ReturnVo managementProc (HttpServletRequest request, HttpServletResponse response, HttpSession session,
			@ModelAttribute("managementVo") ManagementVo managementVo, ModelMap model) {
		int actionCnt = 0;
		String actionMessage = "";
		
		if (managementVo.getProc_role().equals("update_seq")) {
			actionMessage = "수정 되었습니다.";
			actionCnt = managementService.updateManagement(managementVo);
		} else if (managementVo.getProc_role().equals("update_code")) {
			actionMessage = "수정 되었습니다.";
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("complete_count", managementVo.getComplete_count());
			map.put("management_code", managementVo.getManagement_code());
			map.put("belong_condition", managementVo.getBelong_condition());
			
			if (managementVo.getBelong_condition().equalsIgnoreCase("W")) {
				List<CharacterVo> sameServerCharacterList = characterService.selectWorldBelongCharacterList(managementVo);
				map.put("characterList", sameServerCharacterList);
			}
			
			actionCnt = managementService.updateManagementGroup(map);
		}
		
		if (actionCnt > 0) {
			return new ReturnVo("YES", actionMessage, null);
		} else {
			return new ReturnVo("NO", actionMessage, null);
		}
	}
}

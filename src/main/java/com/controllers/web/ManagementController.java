package com.controllers.web;

import java.util.ArrayList;
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

		List<ManagecodeVo> headManagecodeList = new ArrayList<ManagecodeVo>();
		List<ManagecodeVo> bodyManagecodeList = new ArrayList<ManagecodeVo>();
		
		//전체 리스트
		List<ManagecodeVo> managecodeList = managecodeService.selectManagementCodeList(new CharacterVo(user_seq));
		//관리 캐릭터 목록
		List<CharacterVo> characterList = characterService.selectCharacterList(new CharacterVo(user_seq));
		
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
			
			List<ManagementVo> targetManagementList = managementService.selectTargetManagementList(map);
			
			for (CharacterVo tmp_ : characterList) {
				if (targetManagementList.contains(new ManagementVo(tmp.getManagement_code(), tmp_.getCharacter_seq()))) {
					tmp.addUnique_managementlist(targetManagementList.get(targetManagementList.indexOf(new ManagementVo(tmp.getManagement_code(), tmp_.getCharacter_seq()))));
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
}

package com.controllers.web;

import java.util.ArrayList;
import java.util.List;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.utils.WebConfig;
import com.services.web.CharacterService;
import com.services.web.ManagecodeService;
import com.services.web.ManagementService;
import com.utils.Crawler;
import com.vos.web.CharacterVo;
import com.vos.web.ManagecodeVo;
import com.vos.web.ManagementVo;
import com.vos.web.ReturnVo;

@Controller
public class CharacterController {
	static WebConfig config = new WebConfig();
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	private Crawler crawler = new Crawler();
	
	private String[] serverList = {"미상", "미상", "리부트2", "리부트", "오로라", "레드", "이노시스", "유니온", "스카니아", "루나", "제니스", "크로아", "베라", "엘리시움", "아케인", "노바", "버닝", "버닝", "버닝", "버닝"};
	
	@Inject
	CharacterService characterService;
	@Inject
	ManagecodeService managecodeService;
	@Inject
	ManagementService managementService;

	@RequestMapping(value = {"character"}, method = RequestMethod.GET)
	public @ResponseBody ModelAndView character(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model) {
		String user_seq = (String) session.getAttribute("loginSeq");
		
		List<CharacterVo> characterList = characterService.selectCharacterList(new CharacterVo(user_seq));
		
		model.addAttribute("characterList", characterList);
		
		model.addAttribute("loginSeq", user_seq);
		model.addAttribute("config", config);
		
		return new ModelAndView("/character", model);
	}
	
	@RequestMapping(value = {"characterSearchAjax"}, method = RequestMethod.POST)
	public @ResponseBody ReturnVo characterSearchAjax (HttpServletRequest request, HttpServletResponse response, HttpSession session,
			@ModelAttribute("characterVo") CharacterVo characterVo, ModelMap model) {
		logger.info("characterSearchAjax : [" + characterVo.getCharacter_name() + "] 검색");
		
		String searchUrl = "https://maplestory.nexon.com/Ranking/World/Total?c=" + characterVo.getCharacter_name() + "&w=0";
		String searchRebootUrl = "https://maplestory.nexon.com/Ranking/World/Total?c=" + characterVo.getCharacter_name() + "&w=254";
		String[] dataArray = crawler.getCharacterInfoFromHTML(searchUrl).split("[|]");
		String[] rebootDataArray = crawler.getCharacterInfoFromHTML(searchRebootUrl).split("[|]");
		
		if (dataArray.length >= 5) {
			logger.info("characterSearchAjax : 검색 성공");
			return new ReturnVo("YES", null, new CharacterVo(dataArray[0], dataArray[1], dataArray[2], dataArray[3], serverList[Integer.parseInt(dataArray[3])], dataArray[4]));
		} else if (rebootDataArray.length >= 5) {
			logger.info("characterSearchAjax : 리부트 검색 성공");
			return new ReturnVo("YES", null, new CharacterVo(rebootDataArray[0], rebootDataArray[1], rebootDataArray[2], rebootDataArray[3], serverList[Integer.parseInt(rebootDataArray[3])], rebootDataArray[4]));
		} else {
			logger.info("characterSearchAjax : 검색 실패 [정보 없음]");
			return new ReturnVo("NO", null, null);
		}
	}
	
	@RequestMapping(value = {"characterPreview"}, method = RequestMethod.POST)
	public @ResponseBody ReturnVo characterPreview (HttpServletRequest request, HttpServletResponse response, HttpSession session,
			@ModelAttribute("characterVo") CharacterVo characterVo, ModelMap model) {
		
		CharacterVo selectVo = characterService.selectCharacter(characterVo);
		
		if (selectVo != null) {
			return new ReturnVo("YES", null, selectVo);
		} else {
			return new ReturnVo("NO", null, null);
		}
	}
	
	@RequestMapping(value = {"characterUpdateAjax"}, method = RequestMethod.POST)
	public @ResponseBody ReturnVo characterUpdateAjax (HttpServletRequest request, HttpServletResponse response, HttpSession session,
			@ModelAttribute("characterVo") CharacterVo characterVo, ModelMap model) {
		CharacterVo selectVo = characterService.selectCharacter(characterVo);
		
		logger.info("characterUpdateAjax : [" + selectVo.getCharacter_name() + "] 검색");
		
		String searchUrl = "https://maplestory.nexon.com/Ranking/World/Total?c=" + selectVo.getCharacter_name() + "&w=0";
		String[] dataArray = crawler.getCharacterInfoFromHTML(searchUrl).split("[|]");
		
		if (dataArray.length >= 5) {
			logger.info("characterUpdateAjax : 검색 성공");
			
			CharacterVo rstVo = new CharacterVo(dataArray[0], dataArray[1], dataArray[2], dataArray[3], serverList[Integer.parseInt(dataArray[3])], dataArray[4]);
			rstVo.setCharacter_seq(characterVo.getCharacter_seq());
			
			characterService.updateCharacterAPI(rstVo);
			
			return new ReturnVo("YES", null, rstVo);
		} else {
			logger.info("characterUpdateAjax : 검색 실패 [정보 없음]");
			return new ReturnVo("NO", null, null);
		}
	}
	
	@RequestMapping(value = {"characterEditProc"}, method = RequestMethod.POST)
	public @ResponseBody ReturnVo characterEditProc (HttpServletRequest request, HttpServletResponse response, HttpSession session,
			@ModelAttribute("characterVo") CharacterVo characterVo, ModelMap model) {
		
		int actionCnt = 0;
		String actionMessage = "";
		if (characterVo.getProc_role().equals("insert")) {
			actionMessage = "등록 되었습니다.";
			try {
				actionCnt = characterService.insertCharacter(characterVo);
			} catch (DuplicateKeyException e) {
				actionMessage = "이미 존재하는 데이터입니다.";
			}
		} else if (characterVo.getProc_role().equals("delete")) {
			actionMessage = "삭제 되었습니다.";
			actionCnt = characterService.deleteCharacter(characterVo);
		} else if (characterVo.getProc_role().equals("update")) {
			actionMessage = "수정 되었습니다.";
			characterVo.setCharacter_server(serverList[Integer.parseInt(characterVo.getCharacter_server_code())]);
			actionCnt = characterService.updateCharacter(characterVo);
		}
		
		if (actionMessage.equals("")) {
			actionMessage = "예상치 못한 오류가 발생하였습니다.";
		}
		
		if (actionCnt > 0) {
			return new ReturnVo("YES", actionMessage, null);
		} else {
			return new ReturnVo("NO", actionMessage, null);
		}
	}
	
	@RequestMapping(value = {"managecodeList"}, method = RequestMethod.POST)
	public @ResponseBody ModelAndView managecodeList(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			@ModelAttribute("characterVo") CharacterVo characterVo, ModelMap model) {
		List<ManagecodeVo> readyManagecodeList = new ArrayList<ManagecodeVo>();
		List<ManagecodeVo> ingManagecodeList = new ArrayList<ManagecodeVo>();
		
		//전체 리스트
		List<ManagecodeVo> managecodeList = managecodeService.selectManagementCodeList(characterVo);
		//진행중인 숙제
		List<ManagementVo> managementList = managementService.selectCharacterManagementList(characterVo);
		
		for (ManagecodeVo tmp : managecodeList) {
			boolean flag = true;
			int idx = 0;
			int rmv_idx = 0;
			
			if (tmp.getParant_code().equals("")) {
				readyManagecodeList.add(tmp);
				ingManagecodeList.add(tmp);
			} else {
				for (ManagementVo tmp_ : managementList) {
					if (tmp.getManagement_code().equals(tmp_.getManagement_code())) {
						flag = false;
						rmv_idx = idx;
						
						tmp.setUse_yn(tmp_.getUse_yn());
					}
					idx++;
				}
				
				if (flag) {
					readyManagecodeList.add(tmp);
				} else {
					ingManagecodeList.add(tmp);
					managementList.remove(rmv_idx);
				}
			}
		}
		
		model.addAttribute("readyManagecodeList", readyManagecodeList);
		model.addAttribute("ingManagecodeList", ingManagecodeList);
		
		return new ModelAndView("/innerPage/innerManagecodeList", model);
	}
	
	@RequestMapping(value = {"managecodeEditProc"}, method = RequestMethod.POST)
	public @ResponseBody ReturnVo managecodeEditProc (HttpServletRequest request, HttpServletResponse response, HttpSession session,
			@ModelAttribute("managementVo") ManagementVo managementVo, ModelMap model) {
		
		int actionCnt = 0;
		String actionMessage = "";
		
		if (managementVo.getProc_role().equals("insert")) {
			actionMessage = "등록 되었습니다.";
			for (String tmp : managementVo.getManagement_code().split(",")) {
				ManagementVo tmpVo = new ManagementVo(tmp, managementVo.getCharacter_seq());
				
				try {
					actionCnt = managementService.insertManagement(tmpVo);
				} catch (DuplicateKeyException e) {
					actionMessage = "이미 존재하는 데이터입니다.";
				}
			}
		} else if (managementVo.getProc_role().equals("delete")) {
			actionMessage = "제거 되었습니다.";
			for (String tmp : managementVo.getManagement_code().split(",")) {
				actionCnt = managementService.deleteManagementFromCode(new ManagementVo(tmp, managementVo.getCharacter_seq()));
			}
		} else if (managementVo.getProc_role().equals("alarmoff")) {
			actionMessage = "수정 되었습니다.";
			for (String tmp : managementVo.getManagement_code().split(",")) {
				ManagementVo tmpVo = new ManagementVo(tmp, managementVo.getCharacter_seq());
				tmpVo.setUse_yn("N");
				actionCnt = managementService.updateManagementAlarm(tmpVo);
			}
		} else if (managementVo.getProc_role().equals("alarmon")) {
			actionMessage = "수정 되었습니다.";
			for (String tmp : managementVo.getManagement_code().split(",")) {
				ManagementVo tmpVo = new ManagementVo(tmp, managementVo.getCharacter_seq());
				tmpVo.setUse_yn("Y");
				actionCnt = managementService.updateManagementAlarm(tmpVo);
			}
		}
		
		if (actionMessage.equals("")) {
			actionMessage = "예상치 못한 오류가 발생하였습니다.";
		}
		
		if (actionCnt > 0) {
			return new ReturnVo("YES", actionMessage, null);
		} else {
			return new ReturnVo("NO", actionMessage, null);
		}
	}
}

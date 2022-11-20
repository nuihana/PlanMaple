package com.services.web;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.vos.web.CharacterVo;
import com.vos.web.CommoncodeVo;
import com.vos.web.ManagementTimerVo;

@Service
public class ManagementTimerService {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private SqlSession sqlSession;

	public List<ManagementTimerVo> selectCharacterTimerList(CharacterVo characterVo) {
		return sqlSession.selectList("managementTimer.selectCharacterTimerList", characterVo);
	}

	@Transactional
	public int saveCharacterTimer(ManagementTimerVo managementTimerVo) {
		int result = 0;
		
		HashMap<String, String> reqMap = new HashMap<>();
		reqMap.put("code_group", "TIMER");
		
		managementTimerVo.setTimerCode(sqlSession.selectList("commoncode.selectCommoncode", reqMap));
		
		// 장신구제작
		if (managementTimerVo.getAcce().equalsIgnoreCase("0")) {
			result += sqlSession.delete("managementTimer.deleteCharacterTimer", managementTimerVo.getVo("ACCE_00"));
		} else if (managementTimerVo.getAcce().equalsIgnoreCase("1") || managementTimerVo.getAcce().equalsIgnoreCase("2")) {
			int editCnt = 0;
			editCnt += sqlSession.update("managementTimer.updateCharacterTimer", managementTimerVo.getVo("ACCE_00"));
			if (editCnt == 0) {
				editCnt += sqlSession.insert("managementTimer.insertManagementTimer", managementTimerVo.getVo("ACCE_00"));
			}
			
			result += editCnt;
		}
		
		// 장비제작
		if (managementTimerVo.getEqui().equalsIgnoreCase("0")) {
			result += sqlSession.delete("managementTimer.deleteCharacterTimer", managementTimerVo.getVo("EQUI_00"));
		} else if (managementTimerVo.getEqui().equalsIgnoreCase("1") || managementTimerVo.getEqui().equalsIgnoreCase("2")) {
			int editCnt = 0;
			editCnt += sqlSession.update("managementTimer.updateCharacterTimer", managementTimerVo.getVo("EQUI_00"));
			if (editCnt == 0) {
				editCnt += sqlSession.insert("managementTimer.insertManagementTimer", managementTimerVo.getVo("EQUI_00"));
			}
			
			result += editCnt;
		}
		
		// 연금술
		if (managementTimerVo.getAlch().equalsIgnoreCase("0")) {
			result += sqlSession.delete("managementTimer.deleteCharacterTimer", managementTimerVo.getVo("ALCH_00"));
		} else if (managementTimerVo.getAlch().equalsIgnoreCase("1") || managementTimerVo.getAlch().equalsIgnoreCase("2")) {
			int editCnt = 0;
			editCnt += sqlSession.update("managementTimer.updateCharacterTimer", managementTimerVo.getVo("ALCH_00"));
			if (editCnt == 0) {
				editCnt += sqlSession.insert("managementTimer.insertManagementTimer", managementTimerVo.getVo("ALCH_00"));
			}
			
			result += editCnt;
		}
		
		return result;
	}

	public int refreshCharacterTimer(ManagementTimerVo managementTimerVo) {
		return sqlSession.update("managementTimer.refreshCharacterTimer", managementTimerVo);
	}

	public int changeCharacterTimer(ManagementTimerVo managementTimerVo) {
		return sqlSession.update("managementTimer.changeCharacterTimer", managementTimerVo);
	}

	@Transactional
	public int insertFarmTimer(ManagementTimerVo managementTimerVo) {
		int result = 0;
		
		HashMap<String, String> reqMap = new HashMap<>();
		reqMap.put("code_group", "TIMER");
		
		List<CommoncodeVo> timer_code_list = sqlSession.selectList("commoncode.selectCommoncode", reqMap);
		
		for (ManagementTimerVo tmp : managementTimerVo.getFarm_timer_list()) {
			tmp.setTimerCode(timer_code_list);
			tmp.setVo();
			result += sqlSession.insert("managementTimer.insertManagementTimer", tmp);
		}
		
		return result;
	}

	public List<ManagementTimerVo> selectFarmTimerList(CharacterVo characterVo) {
		return sqlSession.selectList("managementTimer.selectFarmTimerList", characterVo);
	}

	public ManagementTimerVo selectFarmTimer(ManagementTimerVo managementTimerVo) {
		return sqlSession.selectOne("managementTimer.selectFarmTimer", managementTimerVo);
	}

	public int deleteFarmTimer(ManagementTimerVo managementTimerVo) {
		return sqlSession.delete("managementTimer.deleteFarmTimer", managementTimerVo);
	}

	public int refreshFarmTimer(ManagementTimerVo managementTimerVo) {
		return sqlSession.update("managementTimer.refreshFarmTimer", managementTimerVo);
	}
	
	public int selectDeadlineCnt(HashMap<String, Object> map) {
		return sqlSession.selectOne("managementTimer.selectDeadlineCnt", map);
	}
}
 
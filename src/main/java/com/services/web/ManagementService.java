package com.services.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vos.web.CharacterVo;
import com.vos.web.ManagementVo;

@Service
public class ManagementService {
	@Autowired
	private SqlSession sqlSession;

	public List<ManagementVo> selectCharacterManagementList(CharacterVo characterVo) {
		return sqlSession.selectList("management.selectCharacterManagementList", characterVo);
	}

	public List<ManagementVo> selectTargetManagementList(HashMap<String, Object> map) {
		return sqlSession.selectList("management.selectTargetManagementList", map);
	}

	public int insertManagement(ManagementVo managementVo) {
		return sqlSession.insert("management.insertManagement", managementVo);
	}

	public int deleteManagementFromCode(ManagementVo managementVo) {
		return sqlSession.delete("management.deleteManagementFromCode", managementVo);
	}

	public int updateManagement(ManagementVo managementVo) {
		return sqlSession.update("management.updateManagement", managementVo);
	}

	public void updateManagementReset(HashMap<String, Object> map) {
		sqlSession.update("management.updateManagementReset", map);
	}

	public List<Map<String, String>> selectLeftManagementList(HashMap<String, String> map) {
		return sqlSession.selectList("management.selectLeftManagementList", map);
	}

	public List<Map<String, String>> selectDeadlineManagementList(HashMap<String, String> map) {
		return sqlSession.selectList("management.selectDeadlineManagementList", map);
	}

	public int updateManagementGroup(HashMap<String, Object> map) {
		return sqlSession.update("management.updateManagementGroup", map);
	}

	public int updateManagementAlarm(ManagementVo managementVo) {
		return sqlSession.update("management.updateManagementAlarm", managementVo);
	}

	public int updateManagementByParantcode(ManagementVo managementVo) {
		return sqlSession.update("management.updateManagementByParantcode", managementVo);
	}
}

package com.services.web;

import java.util.List;

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

	public int insertManagement(ManagementVo managementVo) {
		return sqlSession.insert("management.insertManagement", managementVo);
	}

	public int deleteManagementFromCode(ManagementVo managementVo) {
		return sqlSession.delete("management.deleteManagementFromCode", managementVo);
	}
}

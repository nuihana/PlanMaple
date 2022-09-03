package com.services.web;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vos.web.CharacterVo;
import com.vos.web.ManagecodeVo;
import com.vos.web.ManagementVo;
import com.vos.web.UserVo;

@Service
public class ManagecodeService {
	@Autowired
	private SqlSession sqlSession;

	public ManagecodeVo selectManagementCodeInfo(ManagementVo managementVo) {
		return sqlSession.selectOne("managecode.selectManagementCodeInfo", managementVo);
	}

	public List<ManagecodeVo> selectManagementCodeList(CharacterVo characterVo) {
		return sqlSession.selectList("managecode.selectManagementCodeList", characterVo);
	}

	public List<ManagecodeVo> selectManagementCodeListByCondition(HashMap<String, Object> map) {
		return sqlSession.selectList("managecode.selectManagementCodeListByCondition", map);
	}

	public int insertManagecode(ManagecodeVo managecodeVo) {
		return sqlSession.insert("managecode.insertManagecode", managecodeVo);
	}
	
}

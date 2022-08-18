package com.services.web;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vos.web.CharacterVo;
import com.vos.web.ManagecodeVo;
import com.vos.web.UserVo;

@Service
public class ManagecodeService {
	@Autowired
	private SqlSession sqlSession;

	public List<ManagecodeVo> selectManagementCodeList(CharacterVo characterVo) {
		return sqlSession.selectList("managecode.selectManagementCodeList", characterVo);
	}
	
}

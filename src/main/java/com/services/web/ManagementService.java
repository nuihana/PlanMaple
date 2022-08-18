package com.services.web;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vos.web.ManagementVo;

@Service
public class ManagementService {
	@Autowired
	private SqlSession sqlSession;

	public int insertManagement(ManagementVo managementVo) {
		return sqlSession.insert("management.insertManagement", managementVo);
	}
}

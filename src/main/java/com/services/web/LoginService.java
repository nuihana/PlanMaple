package com.services.web;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginService {
	@Autowired
	private SqlSession sqlSession;
	
	public String getSelectTest() {
		return sqlSession.selectOne("login.selectTest");
	}
}

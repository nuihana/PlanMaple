package com.services.web;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vos.web.UserVo;

@Service
public class LoginService {
	@Autowired
	private SqlSession sqlSession;
	
	public UserVo selectUser(UserVo userVo) {
		return sqlSession.selectOne("login.selectUser", userVo);
	}
}

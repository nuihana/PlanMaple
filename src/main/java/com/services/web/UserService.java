package com.services.web;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vos.web.UserVo;

@Service
public class UserService {
	@Autowired
	private SqlSession sqlSession;

	public int updateUser(UserVo userVo) {
		return sqlSession.update("user.updateUser", userVo);
	}

	public int deleteUser(UserVo userVo) {
		sqlSession.delete("management.deleteUserManagement", userVo);
		sqlSession.delete("managecode.deleteUserManagecode", userVo);
		sqlSession.delete("character.deleteUserCharacter", userVo);
		return sqlSession.delete("user.deleteUser", userVo);
	}
}

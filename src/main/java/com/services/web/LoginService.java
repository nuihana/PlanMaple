package com.services.web;

import java.util.List;

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

	public UserVo selectUserIsExist(UserVo userVo) {
		return sqlSession.selectOne("login.selectUserIsExist", userVo);
	}

	public int insertUser(UserVo userVo) {
		return sqlSession.insert("login.insertUser", userVo);
	}

	public List<UserVo> selectUserByCharacter(UserVo userVo) {
		return sqlSession.selectList("login.selectUserByCharacter", userVo);
	}

	public UserVo selectUserByCharacterID(UserVo userVo) {
		return sqlSession.selectOne("login.selectUserByCharacterID", userVo);
	}
}

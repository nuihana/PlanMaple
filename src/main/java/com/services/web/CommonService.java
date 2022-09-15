package com.services.web;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vos.web.UserVo;

@Service
public class CommonService {
	@Autowired
	private SqlSession sqlSession;
	
	public UserVo selectUser(UserVo userVo) {
		return sqlSession.selectOne("common.selectUser", userVo);
	}

	public int updateUserMemo(UserVo userVo) {
		return sqlSession.update("common.updateUserMemo", userVo);
	}
}

package com.services.web;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vos.web.CharacterVo;
import com.vos.web.UserVo;

@Service
public class CharacterService {
	@Autowired
	private SqlSession sqlSession;

	public List<CharacterVo> selectCharacterList(CharacterVo characterVo) {
		return sqlSession.selectList("character.selectCharacterList", characterVo);
	}

	public int insertCharacter(CharacterVo characterVo) {
		return sqlSession.insert("character.insertCharacter", characterVo);
	}

	public int deleteCharacter(CharacterVo characterVo) {
		sqlSession.delete("management.deleteCharacterManagement", characterVo);
		return sqlSession.delete("character.deleteCharacter", characterVo);
	}
	
}

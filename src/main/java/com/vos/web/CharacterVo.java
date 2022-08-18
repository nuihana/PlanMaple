package com.vos.web;

public class CharacterVo {
	private String character_seq;
	private String character_name;
	private String character_level;
	private String character_class;
	private String character_server_code;
	private String character_server;
	private String character_img;
	
	private String sequence;
	private String user_seq;
	
	private String proc_role;
	
	public CharacterVo() {
		//default 생성자
	}
	
	public CharacterVo(String user_seq) {
		this.user_seq = user_seq;
	}
	
	public CharacterVo(String name, String class_, String img, String server_code, String server, String level) {
		this.character_name = name;
		this.character_class = class_;
		this.character_img = img;
		this.character_server_code = server_code;
		this.character_server = server;
		this.character_level = level;
	}
	
	public String getCharacter_seq() {
		return character_seq;
	}
	public void setCharacter_seq(String character_seq) {
		this.character_seq = character_seq;
	}
	public String getCharacter_name() {
		return character_name;
	}
	public void setCharacter_name(String character_name) {
		this.character_name = character_name;
	}
	public String getCharacter_level() {
		return character_level;
	}
	public void setCharacter_level(String character_level) {
		this.character_level = character_level;
	}
	public String getCharacter_class() {
		return character_class;
	}
	public void setCharacter_class(String character_class) {
		this.character_class = character_class;
	}
	public String getCharacter_server() {
		return character_server;
	}
	public void setCharacter_server(String character_server) {
		this.character_server = character_server;
	}
	public String getCharacter_img() {
		return character_img;
	}
	public void setCharacter_img(String character_img) {
		this.character_img = character_img;
	}
	public String getProc_role() {
		return proc_role;
	}
	public void setProc_role(String proc_role) {
		this.proc_role = proc_role;
	}
	public String getUser_seq() {
		return user_seq;
	}
	public void setUser_seq(String user_seq) {
		this.user_seq = user_seq;
	}
	public String getCharacter_server_code() {
		return character_server_code;
	}
	public void setCharacter_server_code(String character_server_code) {
		this.character_server_code = character_server_code;
	}
	public String getSequence() {
		return sequence;
	}
	public void setSequence(String sequence) {
		this.sequence = sequence;
	}

	@Override
	public String toString() {
		return "CharacterVo [character_seq=" + character_seq + ", character_name=" + character_name
				+ ", character_level=" + character_level + ", character_class=" + character_class
				+ ", character_server_code=" + character_server_code + ", character_server=" + character_server
				+ ", character_img=" + character_img + ", sequence=" + sequence + ", user_seq=" + user_seq
				+ ", proc_role=" + proc_role + "]";
	}
}

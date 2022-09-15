package com.vos.web;

public class UserVo {
	private String user_seq;
	private String user_id;
	private String user_pw;
	private String memo;
	private String login_flag;
	private String last_update;
	
	public UserVo() {
		//기본 생성자
	}
	
	public UserVo(String user_seq) {
		this.user_seq = user_seq;
	}
	
	public String getUser_seq() {
		return user_seq;
	}
	public void setUser_seq(String user_seq) {
		this.user_seq = user_seq;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_pw() {
		return user_pw;
	}
	public void setUser_pw(String iser_pW) {
		this.user_pw = iser_pW;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getLogin_flag() {
		return login_flag;
	}
	public void setLogin_flag(String login_flag) {
		this.login_flag = login_flag;
	}
	public String getLast_update() {
		return last_update;
	}
	public void setLast_update(String last_update) {
		this.last_update = last_update;
	}
	
	@Override
	public String toString() {
		return "UserVo [user_seq=" + user_seq + ", user_id=" + user_id + ", user_pW=" + user_pw + ", login_flag="
				+ login_flag + ", last_update=" + last_update + "]";
	}
}

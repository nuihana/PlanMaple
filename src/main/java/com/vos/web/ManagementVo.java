package com.vos.web;

public class ManagementVo {
	private String management_seq;
	private String management_code;
	private String character_seq;
	private String complete_count;
	private String sequence;
	private String use_yn;
	
	private String proc_role;
	private String server_code;
	private String deadline_flag = "N";
	private String parant_code;
	
	private String belong_condition;
	
	public ManagementVo() {
		//기본생성자
	}
	
	public ManagementVo(String code) {
		this.management_code = code;
	}
	
	public ManagementVo(String code, String cha_seq) {
		this.management_code = code;
		this.character_seq = cha_seq;
	}
	
	public ManagementVo(String code, String cha_seq, String count) {
		this.management_code = code;
		this.character_seq = cha_seq;
		this.complete_count = count;
	}
	
	public String getManagement_seq() {
		return management_seq;
	}
	public void setManagement_seq(String management_seq) {
		this.management_seq = management_seq;
	}
	public String getManagement_code() {
		return management_code;
	}
	public void setManagement_code(String management_code) {
		this.management_code = management_code;
	}
	public String getCharacter_seq() {
		return character_seq;
	}
	public void setCharacter_seq(String character_seq) {
		this.character_seq = character_seq;
	}
	public String getComplete_count() {
		return complete_count;
	}
	public void setComplete_count(String complete_count) {
		this.complete_count = complete_count;
	}
	public String getSequence() {
		return sequence;
	}
	public void setSequence(String sequence) {
		this.sequence = sequence;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public String getProc_role() {
		return proc_role;
	}
	public void setProc_role(String proc_role) {
		this.proc_role = proc_role;
	}
	public String getServer_code() {
		return server_code;
	}
	public void setServer_code(String server_code) {
		this.server_code = server_code;
	}
	public String getDeadline_flag() {
		return deadline_flag;
	}
	public void setDeadline_flag(String deadline_flag) {
		this.deadline_flag = deadline_flag;
	}
	public String getBelong_condition() {
		return belong_condition;
	}
	public void setBelong_condition(String belong_condition) {
		this.belong_condition = belong_condition;
	}
	public String getParant_code() {
		return parant_code;
	}
	public void setParant_code(String parant_code) {
		this.parant_code = parant_code;
	}
	
	@Override
	public String toString() {
		return "ManagementVo [management_seq=" + management_seq + ", management_code=" + management_code
				+ ", character_seq=" + character_seq + ", complete_count=" + complete_count + ", sequence=" + sequence
				+ ", use_yn=" + use_yn + ", proc_role=" + proc_role + "]";
	}

	@Override
	public boolean equals(Object obj) {
		ManagementVo vo = (ManagementVo) obj;
		
		if (vo.getManagement_code().equals(this.management_code) && vo.getCharacter_seq().equals(this.character_seq)) {
			return true;
		}
		
		return false;
	}
}

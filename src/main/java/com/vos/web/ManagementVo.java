package com.vos.web;

public class ManagementVo {
	private String management_seq;
	private String management_code;
	private String character_seq;
	private String complete_count;
	private String sequence;
	private String use_yn;
	
	private String proc_role;
	
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
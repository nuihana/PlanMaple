package com.vos.web;

public class ManagecodeVo {
	private String management_code;
	private String management_code_desc;
	private String parant_code;
	private String belong_condition;
	private String cycle_condition;
	private String complete_count;
	private String limit_level;
	private String public_flag;
	
	public String getManagement_code() {
		return management_code;
	}
	public void setManagement_code(String management_code) {
		this.management_code = management_code;
	}
	public String getManagement_code_desc() {
		return management_code_desc;
	}
	public void setManagement_code_desc(String management_code_desc) {
		this.management_code_desc = management_code_desc;
	}
	public String getParant_code() {
		return parant_code;
	}
	public void setParant_code(String parant_code) {
		this.parant_code = parant_code;
	}
	public String getBelong_condition() {
		return belong_condition;
	}
	public void setBelong_condition(String belong_condition) {
		this.belong_condition = belong_condition;
	}
	public String getCycle_condition() {
		return cycle_condition;
	}
	public void setCycle_condition(String cycle_condition) {
		this.cycle_condition = cycle_condition;
	}
	public String getComplete_count() {
		return complete_count;
	}
	public void setComplete_count(String complete_count) {
		this.complete_count = complete_count;
	}
	public String getLimit_level() {
		return limit_level;
	}
	public void setLimit_level(String limit_level) {
		this.limit_level = limit_level;
	}
	public String getPublic_flag() {
		return public_flag;
	}
	public void setPublic_flag(String public_flag) {
		this.public_flag = public_flag;
	}
	
	@Override
	public String toString() {
		return "ManageCodeVo [management_code=" + management_code + ", management_code_desc=" + management_code_desc
				+ ", parant_code=" + parant_code + ", belong_condition=" + belong_condition + ", cycle_condition="
				+ cycle_condition + ", complete_count=" + complete_count + ", limit_level=" + limit_level
				+ ", public_flag=" + public_flag + "]";
	}
}

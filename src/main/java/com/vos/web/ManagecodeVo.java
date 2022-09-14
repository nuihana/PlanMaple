package com.vos.web;

import java.util.ArrayList;
import java.util.List;

public class ManagecodeVo {
	private String management_code;
	private String management_code_desc;
	private String parant_code;
	private String belong_condition;
	private String cycle_condition;
	private String complete_count;
	private String limit_level;
	private String public_flag;
	
	private String proc_role;
	
	// character 페이지 알람 on/off 용도
	private String use_yn;
	// management 페이지 colspan 입력용도
	private String chid_count = "0";
	// management 페이지 체크박스 출력 용도
	private List<ManagementVo> unique_managementlist = new ArrayList<ManagementVo>();
	
	public ManagecodeVo() {
		//기본생성자
	}
	
	public ManagecodeVo(String code) {
		this.management_code = code;
	}
	
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
	public String getChid_count() {
		return chid_count;
	}
	public void setChid_count(String chid_count) {
		this.chid_count = chid_count;
	}
	public List<ManagementVo> getUnique_managementlist() {
		return unique_managementlist;
	}
	public void setUnique_managementlist(List<ManagementVo> unique_managementlist) {
		this.unique_managementlist = unique_managementlist;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	/**
	 * 
	 * @param managementVo unique_managementlist에 해당 Vo를 추가
	 */
	public void addUnique_managementlist(ManagementVo managementVo) {
		this.unique_managementlist.add(managementVo);
	}
	public String getProc_role() {
		return proc_role;
	}
	public void setProc_role(String proc_role) {
		this.proc_role = proc_role;
	}
	
	@Override
	public String toString() {
		return "ManageCodeVo [management_code=" + management_code + ", management_code_desc=" + management_code_desc
				+ ", parant_code=" + parant_code + ", belong_condition=" + belong_condition + ", cycle_condition="
				+ cycle_condition + ", complete_count=" + complete_count + ", limit_level=" + limit_level
				+ ", public_flag=" + public_flag + "]";
	}
	
	@Override
	public boolean equals(Object obj) {
		ManagecodeVo vo = (ManagecodeVo) obj;
		
		if (vo.getManagement_code().equals(this.management_code)) {
			return true;
		}
		
		return false;
	}
}

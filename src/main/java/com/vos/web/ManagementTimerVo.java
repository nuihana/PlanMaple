package com.vos.web;

import java.util.List;

public class ManagementTimerVo {
	private String timer_seq;
	private String timer_code;
	private String timer_target;
	private String timer_target_type;
	private String timer_value;
	private String timer_desc;
	
	private String proc_role;
	
	private String acce; // 장신구제작
	private String alch; // 연금술
	private String equi; // 장비제작
	
	private List<CommoncodeVo> timer_code_list;
	
	public ManagementTimerVo() {
		//default 생성자
	}
	
	private ManagementTimerVo(ManagementTimerVo timer, CommoncodeVo code) {
		this.timer_target = timer.getTimer_target();
		this.timer_target_type = timer.getTimer_target_type();
		
		this.timer_code = code.getCode();
		this.timer_value = (code.getValue() != null ? code.getTimerValue() : "0");
		this.timer_desc = (code.getCode_desc() != null ? code.getCode_desc() : "전문기술 - 유효기간");
	}
	
	public String getTimer_seq() {
		return timer_seq;
	}
	public void setTimer_seq(String timer_seq) {
		this.timer_seq = timer_seq;
	}
	public String getTimer_code() {
		return timer_code;
	}
	public void setTimer_code(String timer_code) {
		this.timer_code = timer_code;
	}
	public String getTimer_target() {
		return timer_target;
	}
	public void setTimer_target(String timer_target) {
		this.timer_target = timer_target;
	}
	public String getTimer_target_type() {
		return timer_target_type;
	}
	public void setTimer_target_type(String timer_target_type) {
		this.timer_target_type = timer_target_type;
	}
	public String getTimer_value() {
		return timer_value;
	}
	public void setTimer_value(String timer_value) {
		this.timer_value = timer_value;
	}
	public String getTimer_desc() {
		return timer_desc;
	}
	public void setTimer_desc(String timer_desc) {
		this.timer_desc = timer_desc;
	}
	public String getAcce() {
		return acce;
	}
	public void setAcce(String acce) {
		this.acce = acce;
	}
	public String getAlch() {
		return alch;
	}
	public void setAlch(String alch) {
		this.alch = alch;
	}
	public String getEqui() {
		return equi;
	}
	public void setEqui(String equi) {
		this.equi = equi;
	}
	public String getProc_role() {
		return proc_role;
	}
	public void setProc_role(String proc_role) {
		this.proc_role = proc_role;
	}

	public void setTimerCode(List<CommoncodeVo> selectList) {
		this.timer_code_list = selectList;
	}
	public ManagementTimerVo getVo(String value) {
		CommoncodeVo target = null;
		
		String code = value.contains("ACCE") ? acce : value.contains("EQUI") ? equi : alch;
		
		for (int i = 0, limit = timer_code_list.size(); i < limit; i++) {
			if (timer_code_list.get(i).getCode().equalsIgnoreCase(value + code)) {
				target = timer_code_list.get(i);
			}
		}
		
		if (target == null) {
			target = new CommoncodeVo();;
			target.setCode(value + code);
		}
		
		return new ManagementTimerVo(this, target);
	}
	
	@Override
	public String toString() {
		return "ManagementTimerVo [timer_seq=" + timer_seq + ", timer_code=" + timer_code + ", timer_target="
				+ timer_target + ", timer_target_type=" + timer_target_type + ", timer_value=" + timer_value
				+ ", timer_desc=" + timer_desc + ", proc_role=" + proc_role + ", acce=" + acce + ", alch=" + alch
				+ ", equi=" + equi + "]";
	}
}
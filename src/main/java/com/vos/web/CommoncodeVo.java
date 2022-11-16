package com.vos.web;

public class CommoncodeVo {
	private String code_group;
	private String code;
	private String code_desc;
	private String value;
	
	public String getCode_group() {
		return code_group;
	}
	public void setCode_group(String code_group) {
		this.code_group = code_group;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getCode_desc() {
		return code_desc;
	}
	public void setCode_desc(String code_desc) {
		this.code_desc = code_desc;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	
	public String getTimerValue() {
		StringBuilder sb = new StringBuilder();
		
		sb.append("INTERVAL ");
		sb.append(value.replaceAll("[^0-9]", ""));
		String unit = value.replaceAll("[0-9]", "").equalsIgnoreCase("H") ? " HOUR" : " DAY";
		sb.append(unit);
		
		return sb.toString();
	}
}

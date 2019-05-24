package com.yuanzhi.bean;

import java.util.HashMap;
import java.util.Map;

public class Msg {
	
	private String msg;
	
	private int code;
	
	private Map<String,Object> extend =new HashMap<String,Object>();

	public static Msg success() {
		Msg result = new Msg();
		result.setCode(100);
		result.setMsg("成功");
		return result;
	}
	
	public static Msg fail() {
		Msg result = new Msg();
		result.setCode(200);
		result.setMsg("失败");
		return result;
	}
	
	public Msg add(String key,Object value) {
		this.getExtend().put(key, value);
		return this;
	}
	
	
	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public Map<String, Object> getExtend() {
		return extend;
	}

	public void setExtend(Map<String, Object> extend) {
		this.extend = extend;
	}

	public Msg() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Msg(String msg, int code, Map<String, Object> extend) {
		super();
		this.msg = msg;
		this.code = code;
		this.extend = extend;
	}

	@Override
	public String toString() {
		return "Msg [msg=" + msg + ", code=" + code + ", extend=" + extend + "]";
	}

}

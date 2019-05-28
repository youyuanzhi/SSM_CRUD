package com.yuanzhi.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yuanzhi.bean.Department;
import com.yuanzhi.bean.Msg;
import com.yuanzhi.service.DepartmentService;

/**
 * 
 *处理和部门有关的请求 
 * @author youyz
 * @date 2019年5月27日
 */
@Controller
public class DepartmentController {
	
	@Autowired
	private DepartmentService departmentService;
	/**
	 * 返回所有部门信息
	 */
	
	@RequestMapping("/depts")
	@ResponseBody
	public Msg getDets() {
		List<Department> list=departmentService.getDepts();
		return Msg.success().add("depts",list);
	}
}

package com.yuanzhi.controller;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yuanzhi.bean.Employee;
import com.yuanzhi.service.EmployeeService;

@Controller
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;
	
	@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pn",defaultValue="1")Integer pn, Model model) {
//		这不是一个分页查询
//		引入PageHelper分页插件 ,传入页码以及每页的大小
		PageHelper.startPage(pn, 5);
//		startPage后面的查询就是分页的查询、
		
		List<Employee> emps=employeeService.getAll();
//		使用pageIndo包装查询后的结果
		PageInfo page= new PageInfo(emps,5);
		model.addAttribute("pageInfo",page);
		
		return"list";
	}
}

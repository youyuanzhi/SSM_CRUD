package com.yuanzhi.controller;



import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yuanzhi.bean.Employee;
import com.yuanzhi.bean.Msg;
import com.yuanzhi.service.EmployeeService;

@Controller
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;
	
	@ResponseBody
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
	public Msg saveEmp(Employee employee) {
		
		employeeService.updateEmp(employee);
		return Msg.success();
	}
	
	
	//根据id查询员工
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id")Integer id) {
		Employee employee=employeeService.getEmp(id);
		return Msg.success().add("emp", employee);
		
	}
	
	
	@ResponseBody
	@RequestMapping("/checkuser")
	public Msg checkuser(@RequestParam("empName")String empName) {
		
	String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
	if(!empName.matches(regx)) {
		return Msg.fail().add("va_msg", "用户名不规范");
	}
		
	boolean b =	employeeService.checkUser(empName);
		if(b) {
			return Msg.success();
		}else {
			return Msg.fail().add("va_msg", "用户名不可用");
		}

	}
	
	/*
	 * 员工保存
	 * 支持jsr303校验需要导入
	 * Hibernate validator的包
	 */

	@RequestMapping(value="/emp",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee,BindingResult result) {
		if(result.hasErrors()) {
		//校验失败返回失败，在模态框中显示失败的信息
			Map<String, Object>map= new HashMap<>();
			List<FieldError> errors = result.getFieldErrors();
			for(FieldError fieldError:errors) {
			/*	System.out.println("错误的字段名"+fieldError.getField());
				System.out.println("错误信息"+fieldError.getDefaultMessage());*/				
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields",map);
		}else {			
			employeeService.saveEmp(employee);
			return Msg.success();
		}
	}
	
	
	
	
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value="pn",defaultValue="1")Integer pn, Model model) {
//		这不是一个分页查询
//		引入PageHelper分页插件 ,传入页码以及每页的大小
		PageHelper.startPage(pn, 5);
//		startPage后面的查询就是分页的查询、
		
		List<Employee> emps=employeeService.getAll();
//		使用pageIndo包装查询后的结果
		PageInfo page= new PageInfo(emps,5);
		
		return Msg.success().add("PageInfo", page);
	}
	
	
//	@RequestMapping("/emps")
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

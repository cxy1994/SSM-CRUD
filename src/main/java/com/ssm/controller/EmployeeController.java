package com.ssm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ssm.bean.Employee;
import com.ssm.service.EmployeeService;
import com.ssm.utils.Msg;

@Controller
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;

	public String getEmps(
			@RequestParam(value = "pn", defaultValue = "1") Integer pn,
			Model model) {
		// 这不是一个分页查询
		// 引入PageHelper分页查询
		// 在查询之前只需要调用，传入页码以及分页的大小
		PageHelper.startPage(pn, 5);
		// startPage后面紧跟的这个查询就是一个分页查询
		List<Employee> employees = employeeService.getAll();

		// 使用PageInfo包装查询后的结果，只需要将PageInfo交给页面就行了
		// 封装了详细的分页信息，包括有我们查询出来的数据，传入连续显示的页数
		PageInfo<Employee> page = new PageInfo<Employee>(employees, 5);

		model.addAttribute("pageInfo", page);

		return "list";
	}

	// @ResponseBody会自动把返回值转为json字符串
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(
			@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
		PageHelper.startPage(pn, 5);
		// startPage后面紧跟的这个查询就是一个分页查询
		List<Employee> employees = employeeService.getAll();

		PageInfo<Employee> page = new PageInfo<Employee>(employees, 5);

		return Msg.sucess().add("pageInfo", page);
	}

	// @ResponseBody会自动把返回值转为json字符串
	@RequestMapping(value = "/emp", method = RequestMethod.POST)
	@ResponseBody
	public Msg saveEmps(Employee employee) {

		employeeService.saveEmps(employee);
		return Msg.sucess();
	}

	// @ResponseBody会自动把返回值转为json字符串
	@RequestMapping("/checkUser")
	@ResponseBody
	public Msg checkUser(@RequestParam("empName")String empName) {

		boolean flag = employeeService.checkUser(empName);
		if(flag){
			return Msg.sucess();
		}else{
			return Msg.fail();
		}
	}
}

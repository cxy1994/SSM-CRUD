package com.ssm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssm.bean.Department;
import com.ssm.service.DepartmentService;
import com.ssm.utils.Msg;

@Controller
public class DepartmentController {

	@Autowired
	DepartmentService departmentService;

	@RequestMapping("/depts")
	@ResponseBody
	public Msg getEmps() {
		List<Department> depts = departmentService.getDepts();
		return Msg.sucess().add("depts", depts);
	}
}

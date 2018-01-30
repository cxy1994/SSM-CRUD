package com.ssm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssm.bean.Employee;
import com.ssm.bean.EmployeeExample;
import com.ssm.bean.EmployeeExample.Criteria;
import com.ssm.dao.EmployeeMapper;

@Service
public class EmployeeService {

	@Autowired
	EmployeeMapper employeeMapper;
	

	public List<Employee> getAll() {
		// TODO Auto-generated method stub
		return employeeMapper.selectByExampleWithDept(null);
	}

	public void saveEmps(Employee employee) {
		// TODO Auto-generated method stub
		employeeMapper.insertSelective(employee);
	}

	public boolean checkUser(String empName) {
		// TODO Auto-generated method stub
		EmployeeExample employee = new EmployeeExample();
		Criteria criteria = employee.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long couts = employeeMapper.countByExample(employee);
		return couts == 0;
	}
	
}

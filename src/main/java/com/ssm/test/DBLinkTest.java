package com.ssm.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ssm.bean.Department;
import com.ssm.bean.Employee;
import com.ssm.dao.DepartmentMapper;
import com.ssm.dao.EmployeeMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:applicationContext.xml" })
public class DBLinkTest {

	@Autowired
	DepartmentMapper departmentMapper;

	@Autowired
	EmployeeMapper employeeMapper;

	@Autowired
	SqlSession sqlSession;

	/**
	 * @param args
	 */
	@Test
	public void test() {
		// employeeMapper.insertSelective(new
		// Employee(null,"chenxy","M","chenxy7@asiainfo.com",1));
		// 批量
		EmployeeMapper employeeMapper = sqlSession
				.getMapper(EmployeeMapper.class);
		String uid = "";
		for (int i = 0; i < 1000; i++) {
			uid = UUID.randomUUID().toString().substring(0, 5) + i;
			employeeMapper.insertSelective(new Employee(null, uid, "M", uid
					+ "@asiainfo.com", 1));
		}

		/*
		 * departmentMapper.insertSelective(new Department(null,"省网管中心"));
		 * departmentMapper.insertSelective(new Department(null,"省支撑中心"));
		 * departmentMapper.insertSelective(new Department(null,"大众分发组中心"));
		 */
	}

}

package com.ssm.test;

import com.github.pagehelper.PageInfo;
import com.ssm.bean.Employee;
import org.junit.Before;
import org.junit.Test;
import java.util.List;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = { "classpath:applicationContext.xml","file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml"})
public class MVCTest {

	@Autowired
	WebApplicationContext context;
	
	MockMvc mockMvc;
	
	@Before
	public void initMockMvc(){
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}
	
	@Test
	public void test() throws Exception{
		MvcResult rs = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "1")).andReturn();
		PageInfo page = (PageInfo) rs.getRequest().getAttribute("pageInfo");
		System.out.println("current"+page.getPageNum());
		System.out.println("total"+page.getPages());
		System.out.println("num"+page.getTotal());
		System.out.println("fre"+page);
		int[] num = page.getNavigatepageNums();
		for(int i : num){
			System.out.print(i+",");
		}
		
		List<Employee> list = page.getList();
		for (Employee employee : list) {
			System.out.println(employee.getEmpName());
		}
	}
}

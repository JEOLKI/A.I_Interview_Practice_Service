package com.aiinterview;

import javax.annotation.Resource;
import javax.sql.DataSource;

import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.jdbc.datasource.init.DatabasePopulatorUtils;
import org.springframework.jdbc.datasource.init.ResourceDatabasePopulator;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:/egovframework/spring/context-common.xml",
									"file:src/main/webapp/WEB-INF/config/egovframework/springmvc/dispatcher-servlet.xml",
									"classpath:/egovframework/spring/context-datasource_dev.xml",
									"classpath:/egovframework/spring/context-mapper.xml",
									"classpath:/egovframework/spring/context-properties.xml"})
@WebAppConfiguration
@Ignore
public class WebTestConfig {

	@Autowired // 스프링 빈의 타입이 일치하는 것을 주입 : 타입이 하나일때는 사용에 상관없다.
	private WebApplicationContext context;

	protected MockMvc mockMvc; // dispatcher servlet 역할을 하는 객체
	
	@Resource(name = "dataSource")
	private DataSource dataSource;

	@Before
	public void setup() {
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
		
		ResourceDatabasePopulator populator = new ResourceDatabasePopulator();
		populator.addScripts(new ClassPathResource("/db/initData.sql")); // 사용할 스크립트 경로
		populator.setContinueOnError(false); // 스크립트 실행중 에러 발생시 멈춤
		DatabasePopulatorUtils.execute(populator, dataSource);
	}

	@Ignore
	@Test
	public void dummy() {
	}

}

package com.aiinterview.chat.dao;

import static org.junit.Assert.*;

import javax.annotation.Resource;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.aiinterview.ModelTestConfig;

public class chatMapperTest extends ModelTestConfig {

	private static final Logger logger = LoggerFactory.getLogger(chatMapperTest.class);
	
	@Resource(name = "chatMapper")
	private ChatMapper chatMapper;
	
	
	@Test
	public void test() {
		fail("Not yet implemented");
	}

}

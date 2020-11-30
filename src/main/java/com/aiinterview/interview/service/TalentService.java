package com.aiinterview.interview.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.aiinterview.interview.dao.TalentMapper;


@Service("talentService")
public class TalentService{

	@Resource(name="talentMapper")
	private TalentMapper talentMapper;
}

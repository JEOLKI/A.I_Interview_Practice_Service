package com.aiinterview.plan.service;

import java.util.List;

import javax.annotation.Resource;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.aiinterview.plan.dao.PlanMapper;
import com.aiinterview.plan.vo.PlanVo;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Transactional
@Service("planService")
public class PlanService {

	@Resource(name = "planMapper")
	private PlanMapper planMapper;
	
	public List<PlanVo> planList() {
		return planMapper.planList();
	}

	
}

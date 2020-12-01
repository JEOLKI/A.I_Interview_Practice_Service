package com.aiinterview.plan.service;

import java.util.List;

import javax.annotation.Resource;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.aiinterview.plan.dao.PlanMapper;
import com.aiinterview.plan.vo.PlanUseVO;
import com.aiinterview.plan.vo.PlanVO;

@Transactional
@Service("planService")
public class PlanService {

	@Resource(name = "planMapper")
	private PlanMapper planMapper;
	
	public List<PlanVO> planList() {
		return planMapper.planList();
	}

	public PlanVO planContent(PlanVO pv) {
		return planMapper.planContent(pv);
	}
	
	
	public int planUseCreate(PlanUseVO puv) {
		return planMapper.planUseCreate(puv);
	}
	
	
}

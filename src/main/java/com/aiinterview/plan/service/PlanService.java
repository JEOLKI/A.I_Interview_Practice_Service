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
	
	public List<PlanVO> planList() throws Exception {
		return planMapper.planList();
	}

	public PlanVO planContent(PlanVO pv) throws Exception {
		return planMapper.planContent(pv);
	}
	
	
	public int planUseCreate(PlanUseVO puv) throws Exception {
		return planMapper.planUseCreate(puv);
	}
	
	public PlanUseVO planUseCheck(PlanUseVO puv) throws Exception {
		return planMapper.planUseCheck(puv);
	}
	
	public int create(PlanVO pv) throws Exception {
		return planMapper.create(pv);
	}
	
	public int update(PlanVO pv) throws Exception {
		return planMapper.update(pv);
	}
	
	public List<PlanUseVO> CashList(PlanUseVO puv)throws Exception{
		return planMapper.CashList(puv);
	}
	
	public List<PlanVO> planExcel()throws Exception{
		return planMapper.planExcel();
	}
	
	public List<PlanUseVO> planUseExcel()throws Exception{
		return planMapper.planUseExcel();
	}
}

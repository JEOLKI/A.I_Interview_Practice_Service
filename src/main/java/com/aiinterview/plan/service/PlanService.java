package com.aiinterview.plan.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.aiinterview.base.vo.BaseVO;
import com.aiinterview.plan.dao.PlanMapper;
import com.aiinterview.plan.vo.PlanStatisticsVO;
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
	
	public List<PlanVO> managePlan()throws Exception{
		return planMapper.managePlan();
	}
	
	public List<PlanUseVO> managePlanUse()throws Exception{
		return planMapper.managePlanUse();
	}
	
	public int planUseCount(PlanUseVO puv) throws Exception{
		return planMapper.planUseCount(puv);
	}
	
	public List<PlanUseVO> managePlanUseList(BaseVO bv)throws Exception{
		return planMapper.managePlanUseList(bv);
	}
	
	public int PlanUseCount() throws Exception{
		return planMapper.PlanUseCount();
	}
	
	
	public List<PlanUseVO> retrievePagingList(PlanUseVO planUseVO) throws Exception {
		return planMapper.retrievePagingList(planUseVO);
	}
	
	public int retrievePagingListCnt(PlanUseVO planUseVO) throws Exception {
		return planMapper.retrievePagingListCnt(planUseVO);
	}

	/**
	 * 전체 요금제 사용 통계 조회
	 * @param statisticMap
	 * @return
	 */
	public List<PlanStatisticsVO> retrieveTotalUse(Map<String, String> statisticMap) throws Exception {
		return planMapper.retrieveTotalUse(statisticMap);
	}

	/**
	 * 전체 요금제 매출 조회
	 * @param statisticMap
	 * @return
	 */
	public List<PlanStatisticsVO> retrieveTotalSale(Map<String, String> statisticMap) throws Exception  {
		return planMapper.retrieveTotalSale(statisticMap);
	}
	
	/**
	 * 해당 사용자의 요금제 마지막날을 조회하는 메서드
	 * @param memId
	 * @return
	 * @throws Exception 
	 */
	public int retrieveEndDate(String memId) throws Exception {
		return planMapper.retrieveEndDate(memId);
	}

	
	
	
	
}

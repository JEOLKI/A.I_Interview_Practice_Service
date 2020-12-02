package com.aiinterview.plan.dao;

import java.util.List;

import com.aiinterview.plan.vo.PlanUseVO;
import com.aiinterview.plan.vo.PlanVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("planMapper")
public interface PlanMapper {

	/**
	 * 전체 이용권 리스트를 불러오기 위한 메서드
	 * @return
	 */
	List<PlanVO> planList();
	
	/**
	 * 이용권을 클릭했을 때 나올 이용권 정보
	 * @return
	 */
	PlanVO planContent(PlanVO pv);
	
	/**
	 * 이용권을 구매하기위한 메서드
	 * @param 이용권구입에 들어갈 정보
	 * @return
	 */
	int planUseCreate(PlanUseVO puv);
	
	/**
	 * 이용권 기간동안에 구매내역을 조회하기 위한 메서드
	 * @param puv에 들어가는 endDate와 memId
	 * @return
	 */
	int planUseCheck(PlanUseVO puv);
	
}

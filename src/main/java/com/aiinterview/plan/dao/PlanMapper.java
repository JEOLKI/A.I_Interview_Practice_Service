package com.aiinterview.plan.dao;

import java.util.List;

import com.aiinterview.plan.vo.PlanVo;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("planMapper")
public interface PlanMapper {

	/**
	 * 전체 이용권 리스트를 불러오기 위한 메서드
	 * @return
	 */
	List<PlanVo> planList();
}

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
	List<PlanVO> planList() throws Exception;
	
	/**
	 * 이용권을 클릭했을 때 나올 이용권 정보
	 * @return
	 */
	PlanVO planContent(PlanVO pv) throws Exception;
	
	
	/**
	 * 관리자가 이용권을 생성하기 위한 메서드
	 * @param pv 이용권 정보
	 * @return
	 */
	int create(PlanVO pv) throws Exception;
	
	/**
	 * 관리자가 이용권을 변경하기 위한 메서드
	 * @param pv 이용권 변경정보
	 * @return
	 */
	int update(PlanVO pv) throws Exception;
	
	
	/**
	 * 결제내역을 불러오기 위한 메서드
	 * @return
	 * @throws Exception
	 */
	List<PlanUseVO> CashList(PlanUseVO puv) throws Exception;
	
	/**
	 * 요금별 정보를 엑셀로 출력하기 위한 메서드
	 * @return
	 */
	List<PlanVO> planExcel()throws Exception;
	
	/**
	 * 이용자들의 리스트를 엑셀로 출력하기 위한 메서드
	 * @return
	 */
	List<PlanUseVO> planUseExcel()throws Exception;
	
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
	PlanUseVO planUseCheck(PlanUseVO puv);
	
	
	/**
	 * 사용하고 있는사람이 있는지 확인하기 위한 메서드
	 * @param puv
	 * @return
	 */
	int planUseCount(PlanUseVO puv);
	
	
}













package com.aiinterview.plan.dao;

import java.util.List;
import java.util.Map;

import com.aiinterview.base.vo.BaseVO;
import com.aiinterview.plan.vo.PlanStatisticsVO;
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
	List<PlanVO> managePlan()throws Exception;
	
	/**
	 * 이용자들의 리스트를 엑셀로 출력하기 위한 메서드
	 * @return
	 */
	List<PlanUseVO> managePlanUse()throws Exception;
	
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
	
	/**
	 * 페이징처리를 한 이용권 유저들의 리스트를 불러오기 위한 메서드
	 * @param bv
	 * @return
	 */
	List<PlanUseVO> managePlanUseList(BaseVO bv);

	/**
	 * 페이지 전체 개수 
	 * @return
	 */
	int PlanUseCount();
	
	
	
	
	public List<PlanUseVO> retrievePagingList(PlanUseVO planUseVO) throws Exception;
	
	public int retrievePagingListCnt(PlanUseVO planUseVO) throws Exception;

	/**
	 * 전체 요금제 사용 통계 조회
	 * @param statisticMap
	 * @return
	 */
	List<PlanStatisticsVO> retrieveTotalUse(Map<String, String> statisticMap) throws Exception;


	/**
	 * 전체 요금제 매출 조회
	 * @param statisticMap
	 * @return
	 */
	List<PlanStatisticsVO> retrieveTotalSale(Map<String, String> statisticMap)throws Exception;

	int retrieveEndDate(String memId) throws Exception;

	
	
	
	
	
	
	
}













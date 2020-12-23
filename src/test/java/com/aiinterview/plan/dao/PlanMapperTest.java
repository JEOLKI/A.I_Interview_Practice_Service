package com.aiinterview.plan.dao;

import static org.junit.Assert.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;

import com.aiinterview.ModelTestConfig;
import com.aiinterview.plan.vo.PlanStatisticsVO;
import com.aiinterview.plan.vo.PlanUseVO;
import com.aiinterview.plan.vo.PlanVO;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

public class PlanMapperTest extends ModelTestConfig{

	@Resource(name = "planMapper")
	PlanMapper planMapper;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Test
	public void planListTest() throws Exception{
		
		/*** Given ***/
		
		/*** When ***/
		List<PlanVO> planList= planMapper.planList();
		/*** Then ***/
		assertEquals(3, planList.size());
		
	}
	
	@Test
	public void planContentTest() throws Exception{
		
		/*** Given ***/
		PlanVO pv = new PlanVO();
		pv.setPlanSq("1");
		/*** When ***/
		PlanVO resultPlanVO = planMapper.planContent(pv);
		/*** Then ***/
		assertEquals("1", resultPlanVO.getPlanPeriod());
	}
	
	@Test
	public void createTest() throws Exception{
		/*** Given ***/
		PlanVO pv = new PlanVO();
		pv.setPlanNm("2일 이용권");
		pv.setPlanPrice(3000);
		pv.setPlanPeriod("2");
		pv.setPlanExplain("특별 2일 이용권");
		/*** When ***/
		int result = planMapper.create(pv);
		/*** Then ***/
		assertEquals(1, result);
	}
	
	@Test
	public void updateTest() throws Exception{
		
		/*** Given ***/
		PlanVO pv = new PlanVO();
		pv.setPlanSq("2");
		/*** When ***/
		int result = planMapper.update(pv);
		/*** Then ***/
		assertEquals(1, result);
	}
	
	@Test
	public void cashListTest() throws Exception{
		/*** Given ***/
		PlanUseVO puv = new PlanUseVO();
		puv.setMemId("MEMBER1");
		/*** When ***/
		List<PlanUseVO> puvList = planMapper.CashList(puv);
		/*** Then ***/
		assertEquals(1, puvList.size());
	}
	
	@Test
	public void managePlanTest() throws Exception{
		
		/*** Given ***/
		
		/*** When ***/
		List<PlanVO> pvList = planMapper.managePlan();
		/*** Then ***/
		assertEquals(3, pvList.size());
	}
	
	@Test
	public void managePlanUseTest() throws Exception{
		/*** Given ***/

		/*** When ***/
		List<PlanUseVO>puvList =  planMapper.managePlanUse();
		/*** Then ***/
		assertEquals(3, puvList.size());
	}
	
	
	@Test
	public void planUseCreateTest() throws Exception{
		/*** Given ***/
		PlanUseVO puv = new PlanUseVO();
		puv.setPlanPeriod("2");
		puv.setMemId("MEMBER1");
		puv.setPlanSq("2");
		/*** When ***/
		int reuslt = planMapper.planUseCreate(puv);
		/*** Then ***/
		assertEquals(1, reuslt);
	}
	
	@Test
	public void planUseCheckTest() throws Exception{
	
		/*** Given ***/
		PlanUseVO puv = new PlanUseVO();
		puv.setMemId("MEMBER1");
		
		/*** When ***/
		PlanUseVO planUseCheck = planMapper.planUseCheck(puv);
		/*** Then ***/
		assertNull(planUseCheck);

	}
	@Test
	public void planUseCountTest() throws Exception{
		/*** Given ***/
		PlanUseVO puv = new PlanUseVO();
		puv.setMemId("MEMBER1");
		/*** When ***/
		int planUseCount = planMapper.planUseCount(puv);
		/*** Then ***/
		assertEquals(0, planUseCount);
		
	}
	
	@Test
	public void retrievePagingListTest() throws Exception{
		/*** Given ***/
		PlanUseVO planuseVO = new PlanUseVO();
		planuseVO.setPageUnit(propertiesService.getInt("pageUnit"));
		planuseVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(planuseVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(planuseVO.getPageUnit());
		paginationInfo.setPageSize(planuseVO.getPageSize());

		planuseVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		planuseVO.setLastIndex(paginationInfo.getLastRecordIndex());
		planuseVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		/*** When ***/
		List<PlanUseVO> planUseList =  planMapper.retrievePagingList(planuseVO);
		
		/*** Then ***/
		assertEquals(3, planUseList.size());
	}
	
	@Test
	public void retrievePagingListCntTest() throws Exception{
		
		/*** Given ***/
		
		/*** When ***/
		int result = planMapper.retrievePagingListCnt();
		/*** Then ***/
		assertEquals(3, result);
	}
	
	@Test
	public void totalStatisticsTest() throws Exception{
		/*** Given ***/
		String startDate = "2020-11-10";
		String endDate = "2020-12-12";
		String searchKeyword = "이용";
		Map<String, String> statisticMap = new HashMap<>();
		statisticMap.put("startDate", startDate);
		statisticMap.put("endDate", endDate);
		statisticMap.put("searchKeyword", searchKeyword);

		List<PlanStatisticsVO> totalUseList = null;

		
		/*** When ***/
		totalUseList = planMapper.retrieveTotalUse(statisticMap);
		/*** Then ***/
		assertEquals(3, totalUseList.size());
	}
	
	@Test
	public void totalSaleStatisticsTest() throws Exception{
		/*** Given ***/
		String startDate = "2020-11-10";
		String endDate = "2020-12-12";
		String searchKeyword = "이용";
		Map<String, String> statisticMap = new HashMap<>();
		statisticMap.put("startDate", startDate);
		statisticMap.put("endDate", endDate);
		statisticMap.put("searchKeyword", searchKeyword);

		List<PlanStatisticsVO> totalSaleList = null;
		
		/*** When ***/
		totalSaleList = planMapper.retrieveTotalSale(statisticMap);
		/*** Then ***/
		assertEquals(3, totalSaleList.size());
	}
	
	@Test
	public void retrieveEndDate() throws Exception{
		/*** Given ***/
		String memId= "TEST_ID";
		/*** When ***/
		int count = planMapper.retrieveEndDate(memId);
		/*** Then ***/
		assertEquals(0, count);
	}
	
	@Test
	public void retrieveDailySale() throws Exception{
		/*** Given ***/

		/*** When ***/
		List<PlanStatisticsVO> psvList =  planMapper.retrieveDailySale();
		/*** Then ***/
		assertEquals(1, psvList.size());
	}
	
}




















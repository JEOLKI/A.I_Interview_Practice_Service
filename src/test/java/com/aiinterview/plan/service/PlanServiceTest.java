package com.aiinterview.plan.service;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;

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

public class PlanServiceTest extends ModelTestConfig{
	
	@Resource(name = "planService")
	private PlanService planService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Test
	public void planListTest() throws Exception{
		
		/*** Given ***/
		
		/*** When ***/
		List<PlanVO> planList= planService.planList();
		/*** Then ***/
		assertEquals(3, planList.size());
		
	}
	@Test
	public void planContentTest() throws Exception{
		
		/*** Given ***/
		PlanVO pv = new PlanVO();
		pv.setPlanSq("1");
		/*** When ***/
		PlanVO resultPlanVO = planService.planContent(pv);
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
		int result = planService.create(pv);
		/*** Then ***/
		assertEquals(1, result);
	}
	
	@Test
	public void updateTest() throws Exception{
		
		/*** Given ***/
		PlanVO pv = new PlanVO();
		pv.setPlanSq("2");
		/*** When ***/
		int result = planService.update(pv);
		/*** Then ***/
		assertEquals(1, result);
	}
	
	@Test
	public void cashListTest() throws Exception{
		/*** Given ***/
		PlanUseVO puv = new PlanUseVO();
		puv.setMemId("MEMBER1");
		/*** When ***/
		List<PlanUseVO> puvList = planService.CashList(puv);
		/*** Then ***/
		assertEquals(1, puvList.size());
	}
	
	@Test
	public void managePlanTest() throws Exception{
		
		/*** Given ***/
		
		/*** When ***/
		List<PlanVO> pvList = planService.managePlan();
		/*** Then ***/
		assertEquals(3, pvList.size());
	}
	
	@Test
	public void managePlanUseTest() throws Exception{
		/*** Given ***/

		/*** When ***/
		List<PlanUseVO>puvList =  planService.managePlanUse();
		/*** Then ***/
		assertEquals(3, puvList.size());
	}
	
//	values(plan_use_sq.nextval, sysdate, sysdate+#{planPeriod}, #{memId}, #{planSq})
	
	@Test
	public void planUseCreateTest() throws Exception{
		/*** Given ***/
		PlanUseVO puv = new PlanUseVO();
		puv.setPlanPeriod("2");
		puv.setMemId("MEMBER1");
		puv.setPlanSq("2");
		/*** When ***/
		int reuslt = planService.planUseCreate(puv);
		/*** Then ***/
		assertEquals(1, reuslt);
	}
	
	@Test
	public void planUseCheckTest() throws Exception{
	
		/*** Given ***/
		PlanUseVO puv = new PlanUseVO();
		puv.setMemId("MEMBER1");
		
		/*** When ***/
		PlanUseVO planUseCheck = planService.planUseCheck(puv);
		/*** Then ***/
		assertNull(planUseCheck);

	}
	@Test
	public void planUseCountTest() throws Exception{
		/*** Given ***/
		PlanUseVO puv = new PlanUseVO();
		puv.setMemId("MEMBER1");
		/*** When ***/
		int planUseCount = planService.planUseCount(puv);
		/*** Then ***/
		assertEquals(0, planUseCount);
		
	}
//	retrievePagingList
//	retrievePagingListCnt
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
		List<PlanUseVO> planUseList =  planService.retrievePagingList(planuseVO);
		
		/*** Then ***/
		assertEquals(3, planUseList.size());
	}
	
	@Test
	public void retrievePagingListCntTest() throws Exception{
		
		/*** Given ***/
		
		/*** When ***/
		int result = planService.retrievePagingListCnt();
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
		totalUseList = planService.retrieveTotalUse(statisticMap);
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
		totalSaleList = planService.retrieveTotalSale(statisticMap);
		/*** Then ***/
		assertEquals(3, totalSaleList.size());
	}
	
	@Test
	public void retrieveEndDate() throws Exception{
		/*** Given ***/
		String memId= "TEST_ID";
		/*** When ***/
		int count = planService.retrieveEndDate(memId);
		/*** Then ***/
		assertEquals(0, count);
	}
	
	@Test
	public void retrieveDailySale() throws Exception{
		/*** Given ***/

		/*** When ***/
		List<PlanStatisticsVO> psvList =  planService.retrieveDailySale();
		/*** Then ***/
		assertEquals(1, psvList.size());
	}
}

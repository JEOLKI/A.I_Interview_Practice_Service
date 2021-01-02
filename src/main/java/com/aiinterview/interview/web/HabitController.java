package com.aiinterview.interview.web;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.aiinterview.analysis.service.HabitAnalysisService;
import com.aiinterview.analysis.vo.HabitAnalysisVO;
import com.aiinterview.interview.service.HabitService;
import com.aiinterview.interview.vo.HabitVO;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RequestMapping("/habit")
@Controller
public class HabitController {
	

	@Resource(name="habitService")
	private HabitService habitService;
	
	@Resource(name="habitAnalysisService")
	private HabitAnalysisService habitAnalysisService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	/* 페이징 처리 */
	@RequestMapping("/retrievePagingList.do")
	public String retrievePagingList(HabitVO habitVO, String pageUnit, Model model) {
		
		int pageUnitInt = pageUnit == null ? 10 : Integer.parseInt(pageUnit);
		model.addAttribute("pageUnit" , pageUnitInt);
		
		/** EgovPropertyService.sample */
		habitVO.setPageUnit(propertiesService.getInt("pageUnit"));
		habitVO.setPageSize(propertiesService.getInt("pageSize"));
		
		habitVO.setPageUnit(pageUnitInt);
		
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(habitVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(habitVO.getPageUnit());
		paginationInfo.setPageSize(habitVO.getPageSize());
		
		habitVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		habitVO.setLastIndex(paginationInfo.getLastRecordIndex());
		habitVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<HabitVO> resultList;
		try {
			if(!habitVO.getSearchUseYn().equals("Y")) { // 검색한 것이 아니면
				habitVO.setSearchKeyword("");	// 검색어 비워주기
			} else if(habitVO.getSearchUseYn().equals("Y") && habitVO.getSearchKeyword().equals("")) { // 검색한 뒤에 검색어를 비웠다면 
				habitVO.setSearchUseYn("N");	// 검색여부를 N으로 전환
			}
			resultList = habitService.retrievePagingList(habitVO);
			model.addAttribute("resultList", resultList);
			int totCnt = habitService.retrievePagingListCnt(habitVO);
			paginationInfo.setTotalRecordCount(totCnt);
			model.addAttribute("paginationInfo", paginationInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "manage/habitManage";
	}
	
	
	
	@RequestMapping(path ="/createProcess.do", method = {RequestMethod.POST} )
	public String createProcess(HabitVO habitVO ){
		
		
		try {
			habitService.create(habitVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/habit/retrievePagingList.do";  // 등록 성공시 습관어 관리 페이지 리다이렉트
	}
	
	@RequestMapping(path ="/updateProcess.do", method = {RequestMethod.POST})
	public String updateProcess(HabitVO habitVO, Model model) {
		
		try {
			int updateCnt = 0;
			for(int i =0; i<habitVO.getHabitSqs().length; i++) {
				HabitVO updateHabitVO = habitService.retrieveOne(habitVO.getHabitSqs()[i]);
				updateHabitVO.setHabitGb(habitVO.getHabitGbs()[i]);
				updateHabitVO.setHabitSt(habitVO.getHabitSts()[i]);
				updateCnt += habitService.update(updateHabitVO);
			}
			if(updateCnt==habitVO.getHabitSqs().length) {
				return "redirect:/habit/retrievePagingList.do"; // 업데이트 성공시 리다이렉트
			}else {
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "manage/habitManage";
	}
	
	@RequestMapping("/massiveCreateProcess.do")
	public ModelAndView createMassiveHabit(MultipartHttpServletRequest request){
		 MultipartFile excelFile = request.getFile("excelFile");
	        if(excelFile==null || excelFile.isEmpty()){
	            throw new RuntimeException("엑셀파일을 선택해 주세요");
	        }

	     File destFile = new File("D:\\"+excelFile.getOriginalFilename());
	     try {
	            excelFile.transferTo(destFile);
	            habitService.createMassiveHabit(destFile);
	        } catch (Exception e) {
	            throw new RuntimeException(e.getMessage(),e);
	        }

	     
	     ModelAndView view = new ModelAndView();
	        view.setViewName("redirect:/habit/retrievePagingList.do");
	        return view;

	}
	
	@RequestMapping("/list/excelDown.do")
	public String excelDown(Model model){

		// 출력할 리스트 가져오기
		List<HabitVO> habitList;
		try {
			habitList = habitService.retrieveList();
			// excel 파일 header 설정 
			List<String> header = new ArrayList<String>();
			header.add("HABIT_SQ");
			header.add("HABIT_GB");
			header.add("HABIT_ST");
			
			// excel 파일 data 설정
			List<Map<String, String>> data = new ArrayList<Map<String, String>>();
			
			for(int i = 0; i<habitList.size(); i++) {
				Map<String, String> map = new HashMap<>();
				map.put("HABIT_SQ", habitList.get(i).getHabitSq());
				map.put("HABIT_GB", habitList.get(i).getHabitGb());
				map.put("HABIT_ST", habitList.get(i).getHabitSt());
				data.add(map);
			}
			
			model.addAttribute("header",header);
			model.addAttribute("data",data);
			model.addAttribute("fileName","HABIT");
			model.addAttribute("sheetName","습관어 목록");
			model.addAttribute("titleSize", header.size());
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		

		return "excelView";
	}


	
	/* 습관어 통계 화면 */
	@RequestMapping("/statistics.do")
	public String statistics() {
		return "manage/habitStatistics";
	}
	
	/* 습관어 사용 리스트 */
	@RequestMapping("/retrieveHabitStatisticsList.do")
	public String retrieveHabitStatisticsList(String startDate, String endDate, Model model) {
		
		Map<String, String> statisticMap = new HashMap<>();
		statisticMap.put("startDate", startDate);
		statisticMap.put("endDate", endDate);
		
		List<HabitAnalysisVO> resultList = null;
		try {
			resultList =  habitAnalysisService.retrieveHabitUseCountList(statisticMap);
			model.addAttribute("resultList", resultList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "jsonView";
	}
}

package com.aiinterview.script.web;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.aiinterview.script.service.ScriptGubunService;
import com.aiinterview.script.service.ScriptService;
import com.aiinterview.script.vo.ScriptGubunVO;
import com.aiinterview.script.vo.ScriptTestVO;
import com.aiinterview.script.vo.ScriptVO;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RequestMapping("/scriptGubun")
@Controller
public class ScriptGubunController {
	@Resource(name="scriptGubunService")
	private ScriptGubunService scriptGubunService;
	
	@Resource(name="scriptService")
	private ScriptService scriptService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/* 페이징 리스트 별 스크립트 구분*/
	@RequestMapping("/retrievePagingList.do")
	public String retrievePagingList(@ModelAttribute("scriptGubunVO") ScriptGubunVO scriptGubunbVO, String pageUnit, Model model) {
		
		int pageUnitInt = pageUnit == null ? 10 : Integer.parseInt(pageUnit);
		model.addAttribute("pageUnit" , pageUnitInt);
		
		/** EgovPropertyService.sample */
		scriptGubunbVO.setPageUnit(propertiesService.getInt("pageUnit"));
		scriptGubunbVO.setPageSize(propertiesService.getInt("pageSize"));
		
		scriptGubunbVO.setPageUnit(pageUnitInt);
		
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(scriptGubunbVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(scriptGubunbVO.getPageUnit());
		paginationInfo.setPageSize(scriptGubunbVO.getPageSize());
		
		scriptGubunbVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		scriptGubunbVO.setLastIndex(paginationInfo.getLastRecordIndex());
		scriptGubunbVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<ScriptGubunVO> resultList;
		try {
			
			if(!scriptGubunbVO.getSearchUseYn().equals("Y")) { // 검색한 것이 아니면
				scriptGubunbVO.setSearchKeyword("");	// 검색어 비워주기
			} else if(scriptGubunbVO.getSearchUseYn().equals("Y") && scriptGubunbVO.getSearchKeyword().equals("")) { // 검색한 뒤에 검색어를 비웠다면 
				scriptGubunbVO.setSearchUseYn("N");	// 검색여부를 N으로 전환
			}
			
			resultList = scriptGubunService.retrievePagingList(scriptGubunbVO);
			model.addAttribute("scriptGbList", resultList);
			
			int totCnt =scriptGubunService.retrievePagingListCnt(scriptGubunbVO);
			paginationInfo.setTotalRecordCount(totCnt);
			
			model.addAttribute("paginationInfo", paginationInfo);
		} catch (Exception e) { }
		return "manage/scriptGubunManage";
	}
	

	@RequestMapping("/scriptManage.do")
	public String scriptManage(ScriptVO scriptVO, String scriptGbSq, String pageUnit, Model model) {
		
		ScriptGubunVO scriptGbVO = null;
		try {
			scriptGbVO = scriptGubunService.retrieve(scriptGbSq);
		
			model.addAttribute("scriptGbVO", scriptGbVO);
			model.addAttribute("scriptGbSq", scriptGbSq);
			
			// 정렬 개수
			int pageUnitInt = pageUnit == null ? 10 : Integer.parseInt(pageUnit);
			model.addAttribute("pageUnit" , pageUnitInt);
			
			
			/** EgovPropertyService.sample */
			scriptVO.setPageUnit(propertiesService.getInt("pageUnit"));
			scriptVO.setPageSize(propertiesService.getInt("pageSize"));
			
			scriptVO.setPageUnit(pageUnitInt);
			
			/** pageing setting */
			PaginationInfo paginationInfo = new PaginationInfo();
			paginationInfo.setCurrentPageNo(scriptVO.getPageIndex());
			paginationInfo.setRecordCountPerPage(scriptVO.getPageUnit());
			paginationInfo.setPageSize(scriptVO.getPageSize());
			
			scriptVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
			scriptVO.setLastIndex(paginationInfo.getLastRecordIndex());
			scriptVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			
			Map<String, Object> retrieveMap = new HashMap<>();
			retrieveMap.put("firstIndex", scriptVO.getFirstIndex());
			retrieveMap.put("lastIndex", scriptVO.getLastIndex());
			retrieveMap.put("scriptGbSq", scriptGbSq);
			retrieveMap.put("searchKeyword", scriptVO.getSearchKeyword());

			
			//활성 상태가 "Y"인 스크립트 구분만 리스트에 추가하여 scriptManage페이지로 전송
			List<ScriptGubunVO> scriptGbList = null;
			
			scriptGbList = scriptGubunService.retrieveList();
			List<ScriptGubunVO> availableGbList = new ArrayList<>();
			for (ScriptGubunVO scriptGb : scriptGbList) {
				if (scriptGb.getScriptGbSt().equals("Y")) {
					availableGbList.add(scriptGb);
				}
			}
			model.addAttribute("scriptGbList", availableGbList);
			
			if(!scriptVO.getSearchUseYn().equals("Y")) { // 검색한 것이 아니면
				scriptVO.setSearchKeyword("");	// 검색어 비워주기
			} else if(scriptVO.getSearchUseYn().equals("Y") && scriptVO.getSearchKeyword().equals("")) { // 검색한 뒤에 검색어를 비웠다면 
				scriptVO.setSearchUseYn("N");	// 검색여부를 N으로 전환
			}
			List<ScriptVO> resultList = scriptService.retrieveScriptGbScriptPagingList(retrieveMap);
			model.addAttribute("resultList", resultList);
			
			int totCnt = scriptService.retrieveScriptGbScriptPagingListCnt(scriptVO);
			
			paginationInfo.setTotalRecordCount(totCnt);
			model.addAttribute("paginationInfo", paginationInfo);
			return "manage/scriptManage";
		} catch (Exception e) { }
		return "manage/scriptManage";
	}
	
	/* 단일 등록 */
	@RequestMapping(path="/createProcess.do", method = {RequestMethod.POST})
	public String createProcess(String scriptGbContent, String scriptGbSt) {
		ScriptGubunVO scriptGbVO = new ScriptGubunVO(scriptGbContent, scriptGbSt);
		try {
			scriptGubunService.create(scriptGbVO);
		} catch (Exception e) { }
		return "redirect:/scriptGubun/retrievePagingList.do";
	}
	
	/* 일괄 등록 */
	@RequestMapping("/massiveCreateProcess.do")
	public String createMassiveScriptGb(MultipartHttpServletRequest request) {
		 MultipartFile excelFile = request.getFile("excelFile");
	        if(excelFile==null || excelFile.isEmpty()){
	            throw new RuntimeException("엑셀파일을 선택해 주세요");
	        }

	     File destFile = new File("D:\\"+excelFile.getOriginalFilename());
	     try {
	            excelFile.transferTo(destFile);
	            scriptGubunService.createMassiveScriptGubun(destFile);
	        } catch (Exception e) { }

	     destFile.delete();
	     return "redirect:/scriptGubun/retrievePagingList.do";
	}
	
	/* 수정 */
	@RequestMapping(path="/updateProcess.do", method = {RequestMethod.POST})
	public String updateProcess(@ModelAttribute("scriptGubunVO") ScriptGubunVO scriptGbVO){
		
		try {
				int updateCnt = 0;
				for(int i=0; i<scriptGbVO.getScriptGbSqs().length; i++) {
					ScriptGubunVO updateScriptGbVO = scriptGubunService.retrieve(scriptGbVO.getScriptGbSqs()[i]);
					updateScriptGbVO.setScriptGbContent(scriptGbVO.getScriptGbContents()[i]);
					updateScriptGbVO.setScriptGbSt(scriptGbVO.getScriptGbSts()[i]);
					updateCnt += scriptGubunService.update(updateScriptGbVO);
				}
			if(updateCnt == scriptGbVO.getScriptGbSqs().length) {
				return "redirect:/scriptGubun/retrievePagingList.do";
			}
		} catch (Exception e) { }
		return "manage/scriptGubunManage";
	}
	
	/* 일괄 다운로드 */
	@RequestMapping("/list/excelDown.do")
	public String excelDown(Model model) {
	
		//출력할 스크립트 구분 전체 리스트
		List<ScriptGubunVO> scriptGbList = null;
		try {
			scriptGbList = scriptGubunService.retrieveList();
		} catch (Exception e) { }
		
		//excel 파일의 header
		List<String> header = new ArrayList<String>();
		header.add("SCRIPT_GB_SQ");
		header.add("SCRIPT_GB_CONTENT");
		header.add("SCRIPT_GB_ST");

		//excel 파일의 data
		List<Map<String, String>> data = new ArrayList<Map<String, String>>();
		
		Map<String, String> map = null;
		for(ScriptGubunVO scriptGb : scriptGbList) {
			map = new HashMap<String, String>();
			map.put("SCRIPT_GB_SQ", scriptGb.getScriptGbSq());
			map.put("SCRIPT_GB_CONTENT", scriptGb.getScriptGbContent());
			map.put("SCRIPT_GB_ST", scriptGb.getScriptGbSt());
			data.add(map);
		}
		
		model.addAttribute("header", header);
		model.addAttribute("data", data);
		model.addAttribute("fileName", "SCRIPT_GUBUN");
		model.addAttribute("sheetName", "스크립트 구분목록");
		model.addAttribute("titleSize", header.size());
		
		return "excelView";
	}


	/* 통계 화면*/
	@RequestMapping(path = "/statistics.do", method = { RequestMethod.GET })
	public String statisticsView(Model model) throws Exception {
		
		//활성 상태가 "Y"인 스크립트 구분만 리스트에 추가하여 scriptManage페이지로 전송
		List<ScriptGubunVO> scriptGbList = null;

		scriptGbList = scriptGubunService.retrieveList();
		List<ScriptGubunVO> availableGbList = new ArrayList<>();
		for (ScriptGubunVO scriptGb : scriptGbList) {
			if (scriptGb.getScriptGbSt().equals("Y")) {
				availableGbList.add(scriptGb);
			}
		}
		model.addAttribute("scriptGbList", availableGbList);
		return "script/scriptGbStatistics";
	}
}
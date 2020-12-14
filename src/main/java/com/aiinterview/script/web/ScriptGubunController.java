package com.aiinterview.script.web;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.aiinterview.script.service.ScriptGubunService;
import com.aiinterview.script.service.ScriptService;
import com.aiinterview.script.vo.ScriptGubunVO;
import com.aiinterview.script.vo.ScriptVO;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RequestMapping("/scriptGubun")
@Controller
public class ScriptGubunController {
	private static final Logger logger = LoggerFactory.getLogger(ScriptGubunController.class);
	
	@Resource(name="scriptGubunService")
	private ScriptGubunService scriptGubunService;
	
	@Resource(name="scriptService")
	private ScriptService scriptService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	
	/* 페이징 리스트 별 스크립트 구분*/
	@RequestMapping("/retrievePagingList.do")
	public String retrievePagingList(@ModelAttribute("scriptGubunVO") ScriptGubunVO scriptGubunbVO, String pageUnit, Model model) throws Exception {
		
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

		List<ScriptGubunVO> resultList =scriptGubunService.retrievePagingList(scriptGubunbVO);
		model.addAttribute("scriptGbList", resultList);
		
		logger.debug("resultList : {}", resultList);

		int totCnt =scriptGubunService.retrievePagingListCnt(scriptGubunbVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("paginationInfo", paginationInfo);
		return "manage/scriptGubunManage";
	}
	

	@RequestMapping("/scriptManage.do")
	public String scriptManage(String scriptGbSq, String pageUnit, String pageIndex, String searchKeyword, Model model) {
		
		ScriptGubunVO scriptGbVO = null;
		try {
			scriptGbVO = scriptGubunService.retrieve(scriptGbSq);
		} catch (Exception e) {
		}
		model.addAttribute("scriptGbVO", scriptGbVO);
		
		// 정렬 개수
		int pageUnitInt = pageUnit == null ? 10 : Integer.parseInt(pageUnit);
		model.addAttribute("pageUnit" , pageUnitInt);
		
		// 현재 페이지 번호
		int pageIndexInt = pageIndex == null? 1 : Integer.parseInt(pageIndex);
		
		ScriptVO scriptVO = new ScriptVO(); 
		
		/** EgovPropertyService.sample */
		scriptVO.setPageUnit(propertiesService.getInt("pageUnit"));
		scriptVO.setPageSize(propertiesService.getInt("pageSize"));
		
		scriptVO.setPageUnit(pageUnitInt);
		scriptVO.setPageIndex(pageIndexInt);
		
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
		retrieveMap.put("searchKeyword", searchKeyword);
		
		
		List<ScriptVO> resultList = null;
		
		//활성 상태가 "Y"인 스크립트 구분만 리스트에 추가하여 scriptManage페이지로 전송
		List<ScriptGubunVO> scriptGbList = null;
		try {
			scriptGbList = scriptGubunService.retrieveList();
		} catch (Exception e) {
		}
		
		List<ScriptGubunVO> availableGbList = new ArrayList<>();
		for (ScriptGubunVO scriptGb : scriptGbList) {
			if (scriptGb.getScriptGbSt().equals("Y")) {
				availableGbList.add(scriptGb);
			}
		}
		model.addAttribute("scriptGbList", availableGbList);
		
		try {
			resultList = scriptService.retrieveScriptGbScriptPagingList(retrieveMap);
			model.addAttribute("scriptList", resultList);

			logger.debug("scriptList : {}", resultList);
			
			int totCnt = scriptService.retrievePagingListCnt(scriptVO);
			paginationInfo.setTotalRecordCount(totCnt);
			model.addAttribute("paginationInfo", paginationInfo);
			return "manage/scriptGbScriptManage";
		} catch (Exception e) {
		}
		
		return "manage/scriptGbScriptManage";
	}

	
	/* 단일 등록 */
	@RequestMapping(path="/createProcess.do", method = {RequestMethod.POST})
	public String createProcess(String scriptGbContent, String scriptGbSt) throws Exception {
		ScriptGubunVO scriptGbVO = new ScriptGubunVO(scriptGbContent, scriptGbSt);
		scriptGubunService.create(scriptGbVO);
		return "redirect:/scriptGubun/retrievePagingList.do";
	}
	
	/* 일괄 등록 */
	@RequestMapping("/massiveCreateProcess.do")
	public ModelAndView createMassiveScriptGb(MultipartHttpServletRequest request) throws Exception {
		 MultipartFile excelFile = request.getFile("excelFile");
	        if(excelFile==null || excelFile.isEmpty()){
	            throw new RuntimeException("엑셀파일을 선택해 주세요");
	        }

	     File destFile = new File("D:\\"+excelFile.getOriginalFilename());
	     try {
	            excelFile.transferTo(destFile);
	        } catch (IllegalStateException | IOException e) {
	            throw new RuntimeException(e.getMessage(),e);
	 
	        }

	     scriptGubunService.createMassiveScriptGubun(destFile);
	     
	     destFile.delete();

	     ModelAndView view = new ModelAndView();
	        view.setViewName("redirect:/scriptGubun/retrievePagingList.do");
	        return view;
	}
	
	/* 단일 수정 */
	@RequestMapping(path="/updateProcess.do", method = {RequestMethod.POST})
	public String updateProcess(ScriptGubunVO scriptGbVO) throws Exception {

		ScriptGubunVO scriptGbVo = scriptGubunService.retrieve((scriptGbVO.getScriptGbSq()));
		scriptGbVo.setScriptGbContent(scriptGbVO.getScriptGbContent());
		scriptGbVo.setScriptGbSt(scriptGbVO.getScriptGbSt());
		
		int updateCnt = scriptGubunService.update(scriptGbVo);
		
		if(updateCnt == 1) {
			return "redirect:/scriptGubun/retrievePagingList.do";
		}else {
			return "manage/scriptGubunManage";
		}
	}
	
	/* 일괄 다운로드 */
	@RequestMapping("/list/excelDown.do")
	public String excelDown(Model model) {
	
		//출력할 스크립트 구분 전체 리스트
		List<ScriptGubunVO> scriptGbList = null;
		try {
			scriptGbList = scriptGubunService.retrieveList();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
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
		model.addAttribute("sheetName", "SCRIPT_GUBUN");
	
		return "excelView";
	}

	
}
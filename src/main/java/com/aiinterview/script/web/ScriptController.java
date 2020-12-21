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

@RequestMapping("/script")
@Controller
public class ScriptController {
	@Resource(name = "scriptService")
	private ScriptService scriptService;

	@Resource(name = "scriptGubunService")
	private ScriptGubunService scriptGbService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/* 페이징 처리 한 조회 */
	@RequestMapping("/retrievePagingList.do")
	public String retrievePagingList(ScriptVO scriptVO, String pageUnit, Model model) throws Exception{
		
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

		List<ScriptVO> resultList = scriptService.retrievePagingList(scriptVO);
		model.addAttribute("resultList", resultList);

		int totCnt = scriptService.retrieveScriptGbScriptPagingListCnt(scriptVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		
		// 활성 상태가 "Y"인 스크립트 구분만 리스트에 추가하여 scriptManage페이지로 전송
		List<ScriptGubunVO> scriptGbList = scriptGbService.retrieveList();
		List<ScriptGubunVO> availableGbList = new ArrayList<ScriptGubunVO>();
		for (ScriptGubunVO scriptGb : scriptGbList) {
			if (scriptGb.getScriptGbSt().equals("Y")) {
				availableGbList.add(scriptGb);
			}
		}
		model.addAttribute("scriptGbList", availableGbList);
		return "manage/scriptManage";
	}
	
	/* 등록 */
	@RequestMapping(path = "/createProcess.do", method = { RequestMethod.POST })
	public String createProcess(String scriptContent, String scriptGbSq, String scriptSt){
		ScriptVO scriptVO = new ScriptVO(scriptContent, scriptSt, scriptGbSq);
		
		try {
			scriptService.create(scriptVO);
		} catch (Exception e) { }
		return "redirect:/scriptGubun/scriptManage.do?scriptGbSq="+scriptGbSq;
	}

	/* 일괄 등록 */
	@RequestMapping("/massiveCreateProcess.do")
	public String createMassiveScript(MultipartHttpServletRequest request, String scriptGbSq) {
		MultipartFile excelFile = request.getFile("excelFile");
		
		if(excelFile == null || excelFile.isEmpty()) {
			throw new RuntimeException("엑셀파일을 선택해 주세요.");
		}
		
		File destFile = new File("D:\\"+excelFile.getOriginalFilename());
		
		try {
			excelFile.transferTo(destFile);
		} catch (IllegalStateException | IOException e) {
			throw new RuntimeException(e.getMessage(), e);
		}
		
		try {
			scriptService.createMassiveScript(destFile, scriptGbSq);
		} catch (Exception e) { }
		
		destFile.delete();
        return "redirect:/scriptGubun/scriptManage.do?scriptGbSq="+scriptGbSq;
	}
	
	/* 단일 수정*/
	@RequestMapping("/updateProcess.do")
	public String updateProcess(ScriptVO scriptVO, String pageScriptGbSq, Model model){
		try {
			int updateCnt = 0;
			
			for(int i=0; i<scriptVO.getScriptGbSqs().length; i++) {
				ScriptVO updateScriptVO = scriptService.retrieve(scriptVO.getScriptSqs()[i]);
				updateScriptVO.setScriptContent(scriptVO.getScriptContents()[i]);
				updateScriptVO.setScriptSt(scriptVO.getScriptSts()[i]);
				updateScriptVO.setScriptGbSq(scriptVO.getScriptGbSqs()[i]);
				updateCnt += scriptService.update(updateScriptVO);
			}
			
			if (updateCnt == scriptVO.getScriptGbSqs().length) {
				return "redirect:/scriptGubun/scriptManage.do?scriptGbSq="+pageScriptGbSq;
			}
		} catch (Exception e) { }
		return "redirect:/scriptGubun/scriptManage.do?scriptGbSq="+pageScriptGbSq;
	}
	
	/* 일괄 다운로드 */
	@RequestMapping("/list/excelDown.do")
	public String excelDown(Model model, String scriptGbSq) {
	
		//출력할 스크립트 전체 리스트
		List<ScriptVO> scriptList = null;
		try {
			scriptList = scriptService.retrieveSelectList(scriptGbSq);
		} catch (Exception e) { }
		
		//excel 파일의 header
		List<String> header = new ArrayList<String>();
		header.add("SCRIPT_SQ");
		header.add("SCRIPT_CONTENT");
		header.add("SCRIPT_ST");
		header.add("SCRIPT_GB_SQ");

		//excel 파일의 data
		List<Map<String, String>> data = new ArrayList<Map<String, String>>();
		
		Map<String, String> map = null;
		for(ScriptVO script : scriptList) {
			map = new HashMap<String, String>();
			map.put("SCRIPT_SQ", script.getScriptSq());
			map.put("SCRIPT_CONTENT", script.getScriptContent());
			map.put("SCRIPT_ST", script.getScriptSt());
			map.put("SCRIPT_GB_SQ", script.getScriptGbSq());
			data.add(map);
		}
		
		model.addAttribute("header", header);
		model.addAttribute("data", data);
		model.addAttribute("fileName", "SCRIPT");
		model.addAttribute("sheetName", "SCRIPT");
		return "excelView";
	}
}
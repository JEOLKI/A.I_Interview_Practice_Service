package com.aiinterview.script.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aiinterview.script.service.ScriptGubunService;
import com.aiinterview.script.vo.ScriptGubunVO;

import egovframework.rte.fdl.property.EgovPropertyService;

@RequestMapping("/scriptGubun")
@Controller
public class ScriptGubunController {
	@Resource(name="scriptGubunService")
	private ScriptGubunService scriptGubunService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@RequestMapping(path="/manage.do", method = {RequestMethod.GET})
	public String scriptGubunManageView() {
		return "manage/scriptGubunManage";
	}
	
	/*전체 조회*/
	@RequestMapping(path="/list.do")
	public String retrieveScriptGubunList(Model model) throws Exception {
		List<ScriptGubunVO> scriptGbList = scriptGubunService.retrieveList();
		model.addAttribute("scriptGbList", scriptGbList);
		return "jsonView";
	}
	
	/* 단일 등록 */
	@RequestMapping(path="/createProcess.do", method = {RequestMethod.POST})
	public String createProcess(String scriptGbContent, String scriptGbSt) throws Exception {
		ScriptGubunVO scriptGbVo = new ScriptGubunVO(scriptGbContent, scriptGbSt);
		scriptGubunService.create(scriptGbVo);
		return "redirect:/scriptGubun/manage.do";
	}
	
	/* 단일 수정 */
	@RequestMapping(path="/updateProcess.do", method = {RequestMethod.POST})
	public String updateProcess(ScriptGubunVO scriptGbVO) throws Exception {
		System.out.println(scriptGbVO.getScriptGbSq());
		System.out.println(scriptGbVO.getScriptGbContent());
		System.out.println(scriptGbVO.getScriptGbSt());
		
		ScriptGubunVO scriptGbVo = scriptGubunService.retrieve((scriptGbVO.getScriptGbSq()));
		scriptGbVo.setScriptGbContent(scriptGbVO.getScriptGbContent());
		scriptGbVo.setScriptGbSt(scriptGbVO.getScriptGbSt());
		
		int updateCnt = scriptGubunService.update(scriptGbVo);
		
		if(updateCnt == 1) {
			return "redirect:/scriptGubun/manage.do";
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
	
//	/* 일괄 등록 */
//	@RequestMapping("/massiveCreateProcess.do")
//	public String createMassiveHabit(MultipartHttpServletRequest request) {
//		MultipartFile excelFile = request.getFile("excelFile");
//		if(excelFile == null || excelFile.isEmpty()) {
//			throw new RuntimeException("엑셀파일을 선택해주세요.");
//		}
//		
//		File destFile = new File("D:\\"+excelFile.getOriginalFilename());
//		
//		try {
//			excelFile.transferTo(destFile);
//		} catch (IllegalStateException | IOException e) {
//			throw new RuntimeException(e.getMessage(), e);
//		}
//		
//		try {
//			scriptGubunService.createMassiveScriptGubun(destFile);
//		} catch (Exception e) {
//		}
//		
//		destFile.delete();
//		
//		return "redirect:/scriptGubun/retrievePagingList.do";
//	}
	
//	/* 페이징 리스트 별 스크립트 구분*/
//	@RequestMapping("/retrievePagingList.do")
//	public String retrievePagingList(ScriptGubunVO scriptGbVO, String pageUnit, Model model) {
//		
//		int pageUnitInt = pageUnit == null ? 10 : Integer.parseInt(pageUnit);
//		model.addAttribute("pageUnit" , pageUnitInt);
//		
//		/** EgovPropertyService.sample */
//		scriptGbVO.setPageUnit(propertiesService.getInt("pageUnit"));
//		scriptGbVO.setPageSize(propertiesService.getInt("pageSize"));
//		
//		scriptGbVO.setPageUnit(pageUnitInt);
//		
//		/** pageing setting */
//		PaginationInfo paginationInfo = new PaginationInfo();
//		paginationInfo.setCurrentPageNo(scriptGbVO.getPageIndex());
//		paginationInfo.setRecordCountPerPage(scriptGbVO.getPageUnit());
//		paginationInfo.setPageSize(scriptGbVO.getPageSize());
//		
//		scriptGbVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
//		scriptGbVO.setLastIndex(paginationInfo.getLastRecordIndex());
//		scriptGbVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
//
//		List<ScriptGubunVO> resultList=null;
//		try {
//			resultList = scriptGubunService.retrievePagingList(scriptGbVO);
//		} catch (Exception e) {
//		}
//		model.addAttribute("resultList", resultList);
//
//		int totCnt=0;
//		try {
//			totCnt = scriptGubunService.retrievePagingListCnt(scriptGbVO);
//		} catch (Exception e) {
//		}
//		paginationInfo.setTotalRecordCount(totCnt);
//		model.addAttribute("paginationInfo", paginationInfo);
//		
//		return "script/scriptGubunManage";
//	}
//	
//	/* 샘플질문 검색*/
//	@RequestMapping(path = "/searchRetrieve.do")
//	public String searchRetrieve(String searchKeyword, Model model) {
//		List<ScriptGubunVO> scriptGbList = null;
//		try {
//			scriptGbList = scriptGubunService.searchRetrieve(searchKeyword);
//		} catch (Exception e) {
//		}
//		model.addAttribute("scriptGbList",scriptGbList);
//		return "jsonView";
//	}
	
}
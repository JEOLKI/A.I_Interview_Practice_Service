package com.aiinterview.script.web;

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

import com.aiinterview.script.service.ScriptGubunService;
import com.aiinterview.script.service.ScriptService;
import com.aiinterview.script.vo.ScriptVO;

import egovframework.rte.fdl.property.EgovPropertyService;

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
		model.addAttribute("sheetName", "스크립트 목록");
		model.addAttribute("titleSize", header.size());
		
		return "excelView";
	}
}
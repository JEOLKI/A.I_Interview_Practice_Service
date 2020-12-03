package com.aiinterview.analysis.web;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aiinterview.script.service.ScriptGubunService;
import com.aiinterview.script.service.ScriptService;
import com.aiinterview.script.vo.ScriptGubunVO;
import com.aiinterview.script.vo.ScriptVO;

@RequestMapping("/analysisresult")
@Controller
public class AnalysisResultController {
	@Resource(name = "scriptService")
	private ScriptService scriptService;

	@Resource(name = "scriptGubunService")
	private ScriptGubunService scriptGbService;
	
	@RequestMapping(path = "/main.do", method = { RequestMethod.GET })// 내 면접 클릭 했을 시
	public String analysisMain(Model model) {
		// 전체 스크립트 리스트
		List<ScriptVO> scriptList = null;
		try {
			scriptList = scriptService.retrieveList();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		model.addAttribute("scriptList", scriptList);
		// 전체 스크립트 구분 리스트
		List<ScriptGubunVO> scriptGbList = null;
		try {
			scriptGbList = scriptGbService.retrieveList();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		List<ScriptGubunVO> availableGbList = new ArrayList<ScriptGubunVO>();
		// 활성상태가 "Y"인 스크립트 구분 리스트
		for (ScriptGubunVO scriptGb : scriptGbList) {
			if (scriptGb.getScriptGbSt().equals("Y")) {
				availableGbList.add(scriptGb);
			}
		}

		System.out.println("==============================");
		System.out.println("scriptList : " + scriptList);
		System.out.println("==============================");

		System.out.println("available Gb List :" + availableGbList);

		System.out.println("==============================");

		model.addAttribute("scriptGbList", availableGbList);
		return "analysis/main";
	}
	
	@RequestMapping(path = "/interviewresult.do", method = { RequestMethod.GET })// 내 면접 클릭 했을 시
	public String interviewResultView() {
		return "analysis/interviewresult";
	}

	@RequestMapping(path = "/question.do", method = { RequestMethod.GET })// 내 면접 클릭 했을 시
	public String questionView() {
		return "analysis/memberQuestion";
	}
	
	@RequestMapping(path = "/interviewlist.do", method = { RequestMethod.GET })// 내 면접 클릭 했을 시
	public String interviewListView() {
		return "analysis/interviewList";
	}
	
}

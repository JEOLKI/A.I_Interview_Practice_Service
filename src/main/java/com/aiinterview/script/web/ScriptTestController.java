package com.aiinterview.script.web;

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

@RequestMapping("/scriptTest")
@Controller
public class ScriptTestController {
	@Resource(name = "scriptService")
	private ScriptService scriptService;

	@Resource(name = "scriptGubunService")
	private ScriptGubunService scriptGbService;

	@RequestMapping(path = "/view.do",  method = {RequestMethod.GET})
	public String scriptTestView(Model model) throws Exception {
		//전체 스크립트 리스트
		List<ScriptVO> scriptList = scriptService.retrieveList();
		model.addAttribute("scriptList", scriptList);
		//전체 스크립트 구분 리스트
		List<ScriptGubunVO> scriptGbList = scriptGbService.retrieveList();

		List<ScriptGubunVO> availableGbList = new ArrayList<ScriptGubunVO>();
		//활성상태가 "Y"인 스크립트 구분 리스트
		for (ScriptGubunVO scriptGb : scriptGbList) {
			if (scriptGb.getScriptGbSt().equals("Y")) {
				availableGbList.add(scriptGb);
			}
		}
		
		System.out.println("==============================");
		System.out.println("scriptList : "+scriptList);
		System.out.println("==============================");
		
		System.out.println("available Gb List :"+ availableGbList);
		
		System.out.println("==============================");
		
		model.addAttribute("scriptGbList", availableGbList);
		

		return "analysis/main";
	}

}
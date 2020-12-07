package com.aiinterview.script.web;

import java.util.ArrayList;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aiinterview.script.service.ScriptGubunService;
import com.aiinterview.script.service.ScriptService;

@RequestMapping("/scriptTest")
@Controller
public class ScriptTestController {
	private static final Logger logger = LoggerFactory.getLogger(ScriptTestController.class);

	@Resource(name = "scriptService")
	private ScriptService scriptService;

	@Resource(name = "scriptGubunService")
	private ScriptGubunService scriptGbService;

	@RequestMapping(path="/startTestView.do", method = { RequestMethod.GET })
	public String scriptTestView(Model model, String result){
		
		logger.debug("View result : {}", result);
		
		model.addAttribute("result", result);
		return "analysis/main";
	}
	
	@RequestMapping(path = "/startTest.do", method = { RequestMethod.POST })
	public String scriptTestProcess(Model model, String scriptContent, String scriptGbSq, String phraseDiv) {

		logger.debug("scriptContent : {}", scriptContent);
		logger.debug("scriptGbSq : {}", scriptGbSq);
		logger.debug("phraseDiv : {}", phraseDiv);
		
		ScriptTestController scriptTest = new ScriptTestController();

		ArrayList<String> systemScriptList = scriptTest.nGram(scriptContent); //스크립트에 출력된 출력 문
		ArrayList<String> memberScriptList = scriptTest.nGram(phraseDiv); //사용자가 말한스크립트 문

		int result = scriptTest.resultNGram(systemScriptList, memberScriptList);
		logger.debug("result : {}", result);
		
		model.addAttribute("result", result);
		
		return "redirect:/scriptTest/startTestView.do";
	}

	
	
	
	public ArrayList<String> nGram(String script) {
		ArrayList<String> list = new ArrayList<String>();
		ArrayList<String> result = new ArrayList<String>();
		
	
	
		for (int i = 0; i <= script.length() - 1; i++) {
			list.add(Character.toString(script.charAt(i)));
		}
	
	
		for (int i = 0; i < list.size() - 1; i++) {
			result.add(list.get(i) + list.get(i + 1));
			System.out.println(result.get(i));
		}
		System.out.println("----------------");
		return result;
	}
	
	
	
	

	public int resultNGram(ArrayList<String> systemScriptList, ArrayList<String> memberScriptList) {
		long count = 0;
		long size = systemScriptList.size();
		
		for (int i = 0; i < systemScriptList.size(); i++) {
			for (int j = 0; j < memberScriptList.size(); j++) {
				if (systemScriptList.get(i).equals(memberScriptList.get(j))) {
					//System.out.println("일치 횟수");
					count += 1;
				}
			}
		}
		
		//System.out.println("카운트 결과값 : " + count);
		//System.out.println("Size : " + size);
		//System.out.println("systemScriptList 사이즈" + systemScriptList.size());
		int result = (int) ((count * 100) / size);
		//System.out.println("결과값" + (float) ((count * 100) / size));
		return result;
	}
}

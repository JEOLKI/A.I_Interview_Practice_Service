package com.aiinterview.script.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aiinterview.member.vo.MemberVO;
import com.aiinterview.script.service.ScriptGubunService;
import com.aiinterview.script.service.ScriptService;
import com.aiinterview.script.service.ScriptTestService;
import com.aiinterview.script.vo.ScriptGubunVO;
import com.aiinterview.script.vo.ScriptTestVO;
import com.aiinterview.script.vo.ScriptVO;

@RequestMapping("/scriptTest")
@Controller
public class ScriptTestController {
	private static final Logger logger = LoggerFactory.getLogger(ScriptTestController.class);

	@Resource(name = "scriptTestService")
	private ScriptTestService scriptTestService;
	
	@Resource(name = "scriptService")
	private ScriptService scriptService;
	
	@Resource(name = "scriptGubunService")
	private ScriptGubunService scriptGbService;
	
	
	@RequestMapping(path = "/create.do")
	public String create(Model model, String performScript, HttpSession session, String scriptSq) {
		
		ScriptVO scriptVO=null;
		try {
			scriptVO = scriptService.retrieve(scriptSq);
		} catch (Exception e) {
			e.printStackTrace();
		}
		String scriptContent = scriptVO.getScriptContent();
		
		ScriptTestController scriptTest = new ScriptTestController();
		
		ArrayList<String> systemScriptList = scriptTest.nGram(scriptContent); //스크립트에 출력된 출력 문
		ArrayList<String> memberScriptList = scriptTest.nGram(performScript); //사용자가 말한스크립트 문

		int result = scriptTest.resultNGram(systemScriptList, memberScriptList);
		session.setAttribute("scriptTestResult", result);
		
		MemberVO memberVo = (MemberVO)session.getAttribute("S_MEMBER");
		String memId = memberVo.getMemId();
		
		ScriptTestVO scriptTestVO = new ScriptTestVO(result, performScript, memId, scriptSq); 
		
		try {
			scriptTestService.create(scriptTestVO);
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		
		model.addAttribute("result", result);
		return "analysis/scriptTestResult";
	}
	
	//문제 x
	@RequestMapping(path = "/testPopup.do", method = { RequestMethod.GET })
	public String testPopup(Model model) {
		List<ScriptVO> scriptList = null;
		try {
			scriptList = scriptService.retrieveList();
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 전체 스크립트 구분 리스트
		List<ScriptGubunVO> scriptGbList = null;
		try {
			scriptGbList = scriptGbService.retrieveList();
		} catch (Exception e) {
			e.printStackTrace();
		}

		List<ScriptGubunVO> availableGbList = new ArrayList<ScriptGubunVO>();
		// 활성상태가 "Y"인 스크립트 구분 리스트
		for (ScriptGubunVO scriptGb : scriptGbList) {
			if (scriptGb.getScriptGbSt().equals("Y")) {
				availableGbList.add(scriptGb);
			}
		}
		model.addAttribute("scriptList", scriptList);
		model.addAttribute("scriptGbList", availableGbList);
		return "script/testPopup";
	}
	
	
	@RequestMapping(path = "/retrieveScriptList.do", method = { RequestMethod.POST })
	public String retrieveSelectList(String scriptGbSq ,Model model) {
		
		//logger.debug("scriptGbSq : {}", scriptGbSq);
		
		List<ScriptVO> scriptList = null;
		try {
			scriptList = scriptService.retrieveSelectList(scriptGbSq);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		logger.debug("사이즈는 : {}",scriptList.size());
		int randomInt = (int)(Math.random()*scriptList.size());
		logger.debug("랜덤 번호는 : {}",randomInt);
		
		ScriptVO scriptVO = scriptList.get(randomInt);
		
		logger.debug("scriptVO : {}",scriptVO);
		model.addAttribute("scriptVO", scriptVO);
		return "jsonView";
	}
	
	
	/**
	 * 각각의 스크립트를 리스트내에 두 음절씩 분리하여 입력하는 메소드
	 * @param script
	 * @return ArrayList<String>
	 */
	public ArrayList<String> nGram(String script) {
		ArrayList<String> list = new ArrayList<String>();
		ArrayList<String> result = new ArrayList<String>();
	
		for (int i = 0; i <= script.length() - 1; i++) {
			list.add(Character.toString(script.charAt(i)));
		}
	
		for (int i = 0; i < list.size() - 1; i++) {
			result.add(list.get(i) + list.get(i + 1));
		}
		return result;
	}

	/**
	 * 분리된 리스트의 각 인덱스내의 값들을 비교하여
	 * 두 스크립트의 일치도를 반환하는 메소드
	 * @param systemScriptList
	 * @param memberScriptList
	 * @return int타입의 일치도 값
	 */
	public int resultNGram(ArrayList<String> systemScriptList, ArrayList<String> memberScriptList) {
		long count = 0;
		long size = systemScriptList.size();
		
		for (int i = 0; i < systemScriptList.size(); i++) {
			for (int j = 0; j < memberScriptList.size(); j++) {
				if (systemScriptList.get(i).equals(memberScriptList.get(j))) {
					count += 1;
				}
			}
		}
		return (int)((count * 100) / size);
	}
}

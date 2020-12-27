package com.aiinterview.script.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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
	@Resource(name = "scriptTestService")
	private ScriptTestService scriptTestService;
	
	@Resource(name = "scriptService")
	private ScriptService scriptService;
	
	@Resource(name = "scriptGubunService")
	private ScriptGubunService scriptGbService;
	
	
	@RequestMapping(path = "/create.do")
	public String create(String resultScript, String scriptSq, Model model,  HttpSession session) {
		ScriptVO scriptVO=null;
		try {
			scriptVO = scriptService.retrieve(scriptSq);
		} catch (Exception e) { }
		String scriptContent = scriptVO.getScriptContent();
		
		int lastIndex = resultScript.indexOf(".");
		resultScript = resultScript.substring(0, lastIndex); 
		
		Map<String, String> testScoreMap = new HashMap<String, String>();
		testScoreMap.put("scriptContent", scriptContent);
		testScoreMap.put("resultScript", resultScript);
		
		int result = scriptTestService.retrieveScore(testScoreMap);
 		String[] differentArr = getDifferentArr(scriptContent, resultScript);
		
		MemberVO memberVo = (MemberVO)session.getAttribute("S_MEMBER");
		String memId = memberVo.getMemId();
		
		ScriptTestVO scriptTestVO = new ScriptTestVO(result+"", resultScript, memId, scriptSq);
		
		try {
			scriptTestService.create(scriptTestVO);
		}catch(Exception ex) { }
		
		model.addAttribute("performScript", resultScript);
		model.addAttribute("result", result);
		model.addAttribute("differentArr", differentArr);
		return "jsonView";
	}
	
	@RequestMapping(path = "/testPopup.do", method = { RequestMethod.GET })
	public String testPopup(Model model) {
		List<ScriptGubunVO> scriptGbList = null;
		try {
			scriptGbList = scriptGbService.retrieveList();
		} catch (Exception e) {
			e.printStackTrace();
		}

		List<ScriptGubunVO> availableGbList = new ArrayList<ScriptGubunVO>();
		for (ScriptGubunVO scriptGb : scriptGbList) {
			if (scriptGb.getScriptGbSt().equals("Y")) {
				availableGbList.add(scriptGb);
			}
		}
		model.addAttribute("scriptGbList", availableGbList);
		return "script/testPopup";
	}
	
	@RequestMapping("/testStart.do")
	public String testStart(Model model, String scriptGbSq) {
		// 상단 탭 언어종류
		List<ScriptGubunVO> scriptGbList = null;
		try {
			scriptGbList = scriptGbService.retrieveList();
		} catch (Exception e) {
			e.printStackTrace();
		}

		List<ScriptGubunVO> availableGbList = new ArrayList<ScriptGubunVO>();
		for (ScriptGubunVO scriptGb : scriptGbList) {
			if (scriptGb.getScriptGbSt().equals("Y")) {
				availableGbList.add(scriptGb);
				if(scriptGb.getScriptGbSq().equals(scriptGbSq)) {
					model.addAttribute("scriptGbContent", scriptGb.getScriptGbContent());
				}
			}
		}
		model.addAttribute("scriptGbList", availableGbList);
		model.addAttribute("scriptGbSq", scriptGbSq);
		return "script/testStart";
	}
	
	@RequestMapping(path = "/retrieveScriptList.do")
	public String retrieveSelectList(String scriptGbSq ,Model model) {
		
		List<ScriptVO> scriptList = null;
		try {
			scriptList = scriptService.retrieveSelectList(scriptGbSq);
			ScriptGubunVO scriptGubunVO = scriptGbService.retrieve(scriptGbSq);
			model.addAttribute("scriptGbContent", scriptGubunVO.getScriptGbContent());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		int randomInt = (int)(Math.random()*scriptList.size());
		
		ScriptVO scriptVO = scriptList.get(randomInt);
		
		model.addAttribute("scriptVO", scriptVO);
		return "jsonView";
	}
	
	/*불일치 인덱스 구하는 메서드*/
	public String[] getDifferentArr(String scriptContent, String resultScript){
		
		String[] scriptContentArr = scriptContent.split(" ");
		String[] resultScriptArr = resultScript.split(" ");
		String[] differentArr;
		
		if(scriptContentArr.length <= resultScriptArr.length && scriptContentArr.length >0 ) { // 기준스크립트 < 결과 스크립트
			
			differentArr = new String[resultScriptArr.length];
			
			for(int i =0; i < scriptContentArr.length; i++) {
				if(!scriptContentArr[i].equals(resultScriptArr[i])) {
					differentArr[i] = resultScriptArr[i];
				}
			}
			for(int i=scriptContentArr.length; i<resultScriptArr.length; i++) {
				differentArr[i] = resultScriptArr[i];
			}
		} else {// 결과 스크립트 < 기준스크립트  
			differentArr = new String[resultScriptArr.length];
			for(int i =0; i < resultScriptArr.length; i++) {
				if(!scriptContentArr[i].equals(resultScriptArr[i])) {
					differentArr[i] = resultScriptArr[i];
				}
			}
		}
		return differentArr;
	}
	
	@RequestMapping(path = "/retrieveScriptTestList.do", method = { RequestMethod.GET })
	public String retrieveScriptTestList(String memId, Model model) {
		
		try {
			List<ScriptTestVO> scriptTestList = scriptTestService.retrieveList(memId);
			model.addAttribute("scriptTestList", scriptTestList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "jsonView";
	}
	
	/* 통계 : 스구별 스테에 사용된 스 사용 빈도*/
	@RequestMapping("/retrieveRankingList.do")
	public String retrieveRankingList(String scriptGbSq, String startDate, String endDate, Model model) {
		if(scriptGbSq==null) {
			List<ScriptGubunVO> scriptGbList = null;
			try {
				scriptGbList = scriptGbService.retrieveList();
			} catch (Exception e) { }
			
			for(ScriptGubunVO scriptGb : scriptGbList) {
				if(scriptGb.getScriptGbContent().equals("한국어")) {
					scriptGbSq = scriptGb.getScriptGbSq();
				}
			}
		}

		Map<String, String> statisticMap = new HashMap<>();
		statisticMap.put("startDate", startDate);
		statisticMap.put("endDate", endDate);
		statisticMap.put("scriptGbSq", scriptGbSq);
		
		List<ScriptTestVO> scriptRankingList = null;
		try {
			scriptRankingList = scriptTestService.retrieveRankingList(statisticMap);
			model.addAttribute("scriptRankingList", scriptRankingList);
		} catch (Exception e) { }
		return "jsonView";
	}
	
	/* 통계 : 스구별 점수 표준편차 */
	@RequestMapping("/retrieveScoreList.do")
	public String retrieveScoreList(String scriptGbSq, String startDate, String endDate, Model model) {
		if(scriptGbSq==null) {
			List<ScriptGubunVO> scriptGbList = null;
			try {
				scriptGbList = scriptGbService.retrieveList();
			} catch (Exception e) { }
			
			for(ScriptGubunVO scriptGb : scriptGbList) {
				if(scriptGb.getScriptGbContent().equals("한국어")) {
					scriptGbSq = scriptGb.getScriptGbSq();
				}
			}
		}
		
		Map<String, String> testScoreMap = new HashMap<String, String>();
		testScoreMap.put("startDate", startDate);
		testScoreMap.put("endDate", endDate);
		testScoreMap.put("scriptGbSq", scriptGbSq);
		
		List<ScriptTestVO> scriptScoreList = null;
		try {
			scriptScoreList = scriptTestService.retrieveScoreList(testScoreMap);
		} catch (Exception e) { }
		model.addAttribute("scriptScoreList", scriptScoreList);
		return "jsonView";
	}
}

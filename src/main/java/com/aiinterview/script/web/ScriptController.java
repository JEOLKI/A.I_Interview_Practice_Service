package com.aiinterview.script.web;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aiinterview.script.service.ScriptGubunService;
import com.aiinterview.script.service.ScriptService;
import com.aiinterview.script.vo.ScriptGubunVO;
import com.aiinterview.script.vo.ScriptVO;

@RequestMapping("/script")
@Controller
public class ScriptController {
	private static final Logger logger = LoggerFactory.getLogger(ScriptController.class);
	@Resource(name = "scriptService")
	private ScriptService scriptService;

	@Resource(name = "scriptGubunService")
	private ScriptGubunService scriptGbService;

	@RequestMapping(path = "/manage.do")
	public String scriptManageView(Model model) throws Exception {
		List<ScriptGubunVO> scriptGbList = scriptGbService.retrieveList();

		// 활성 상태가 "Y"인 스크립트 구분만 리스트에 추가하여 scriptManage페이지로 전송
		List<ScriptGubunVO> availableGbList = new ArrayList<ScriptGubunVO>();
		for (ScriptGubunVO scriptGb : scriptGbList) {
			if (scriptGb.getScriptGbSt().equals("Y")) {
				availableGbList.add(scriptGb);
			}
		}
		model.addAttribute("scriptGbList", availableGbList);

		return "manage/scriptManage";
	}

	@RequestMapping(path = "/list.do")
	public String retrieveList(Model model) throws Exception {
		List<ScriptVO> scriptList = scriptService.retrieveList();
		List<ScriptGubunVO> scriptGbList = scriptGbService.retrieveList();

		//전체 스크립트 리스트
		model.addAttribute("scriptList", scriptList);
		
		List<ScriptGubunVO> availableGbList = new ArrayList<ScriptGubunVO>();
		for (ScriptGubunVO scriptGb : scriptGbList) {
			if (scriptGb.getScriptGbSt().equals("Y")) {
				availableGbList.add(scriptGb);
			}
		}
		
		//활성상태가 "Y"인 스크립트 구분의 리스트
		model.addAttribute("scriptGbList", availableGbList);
		return "jsonView";
	}

	@RequestMapping(path = "/createProcess.do", method = { RequestMethod.POST })
	public String createProcess(String scriptContent, String scriptGbSq, String scriptSt) throws Exception {
		ScriptVO scriptVO = new ScriptVO(scriptContent, scriptSt, scriptGbSq);
		
		scriptService.create(scriptVO);
		return "redirect:/script/manage.do";
	}

	@RequestMapping(path = "/updateProcess.do", method = { RequestMethod.POST })
	public String updateProcess(ScriptVO scriptVO) throws Exception {
		
		ScriptVO scriptVo = scriptService.retrieve(scriptVO.getScriptSq());
		scriptVo.setScriptContent(scriptVO.getScriptContent());
		scriptVo.setScriptSt(scriptVO.getScriptSt());
		scriptVo.setScriptGbSq(scriptVO.getScriptGbSq());

		int updateCnt = scriptService.update(scriptVo);

		if (updateCnt == 1) {
			return "redirect:/script/manage.do";
		} else {
			return "manage/scriptManage";
		}
	}
	
	@RequestMapping(path = "/retrieveScriptList.do", method = { RequestMethod.POST })
	public String retrieveSelectList(String scriptGbSq ,Model model) {
		
		List<ScriptVO> scriptList = null;
		try {
			scriptList = scriptService.retrieveSelectList(scriptGbSq);
		} catch (Exception e) {
			// TODO Auto-generated catch block
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

}
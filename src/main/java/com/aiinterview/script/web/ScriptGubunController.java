package com.aiinterview.script.web;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aiinterview.script.service.ScriptGubunService;
import com.aiinterview.script.vo.ScriptGubunVO;

@RequestMapping("/scriptGubun")
@Controller
public class ScriptGubunController {
	@Resource(name="scriptGubunService")
	private ScriptGubunService scriptGubunService;
	
	@RequestMapping(path="/manage.do", method = {RequestMethod.GET})
	public String scriptGubunManageView() {
		return "manage/scriptGubunManage";
	}
	
	@RequestMapping(path="/list.do")
	public String retrieveScriptGubunList(Model model) throws Exception {
		List<ScriptGubunVO> scriptGbList = scriptGubunService.retrieveList();
		model.addAttribute("scriptGbList", scriptGbList);
		return "jsonView";
	}
	
	@RequestMapping(path="/createProcess.do", method = {RequestMethod.POST})
	public String createProcess(String scriptGbContent, String scriptGbSt) throws Exception {
		ScriptGubunVO scriptGbVo = new ScriptGubunVO(scriptGbContent, scriptGbSt);
		scriptGubunService.create(scriptGbVo);
		return "redirect:/scriptGubun/manage.do";
	}
	
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
	
	
}
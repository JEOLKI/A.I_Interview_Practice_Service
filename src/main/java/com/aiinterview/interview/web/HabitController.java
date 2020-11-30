package com.aiinterview.interview.web;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aiinterview.interview.service.HabitService;
import com.aiinterview.interview.vo.HabitVO;

@RequestMapping("/habit")
@Controller
public class HabitController {
	

	@Resource(name="habitService")
	private HabitService habitService;
	
	@RequestMapping("/manage.do")
	public String habitManageView() {
		return "habit/habitManage";
	}
	
	@RequestMapping("/list.do")
	public String retrieveHabitList(Model model) {
		
		List<HabitVO> habitList = habitService.retrieveHabitList();
		System.out.println("습관어 목록 "+ habitList);
		model.addAttribute("habitList", habitList);
		return "jsonView";
	}
	
	
	
	@RequestMapping(path ="/createProcess.do", method = {RequestMethod.POST} )
	public String createProcess(String habitGb, char habitSt, Model model) throws Exception {
		
		System.out.println("습관어 등록 - habitGb : " + habitGb);
		System.out.println("습관어 등록 - habitSt : " + habitSt);
		
		// habitVO 객체 생성
		HabitVO habitVO = new HabitVO();
		habitVO.setHabitGb(habitGb);
		habitVO.setHabitSt(habitSt);
		
		System.out.println("습관어 등록 - habitVO : " + habitVO);
		
		habitService.create(habitVO);
		
		System.out.println("습관어 등록 후");
		
		return "redirect:/habit/manage.do";  // 등록 성공시 습관어 관리 페이지 리다이렉트
	}
	
	@RequestMapping(path ="/updateProcess.do", method = {RequestMethod.POST})
	public String updateProcess(HabitVO habitVO, Model model) {
		System.out.println("습관어 수정 - habitVO : " + habitVO);
		
		int updateCnt = habitService.update(habitVO);
		System.out.println("습관어 수정 - updateCnt : " + updateCnt);
		if(updateCnt==1) {
			return "redirect:/habit/manage.do"; // 업데이트 성공시 리다이렉트
		}else {
			return "habit/habitManage";
		}
		
		
		
	}
	
}

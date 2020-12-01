package com.aiinterview.interview.web;

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
import org.springframework.web.servlet.ModelAndView;

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
	public String createProcess(String habitGb, String habitSt) throws Exception {
		
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
	
	@RequestMapping("/massiveCreateProcess.do")
	public ModelAndView createMassiveHabit(MultipartHttpServletRequest request) throws Exception {
		 MultipartFile excelFile = request.getFile("excelFile");
	        if(excelFile==null || excelFile.isEmpty()){
	            throw new RuntimeException("엑셀파일을 선택해 주세요");
	        }

	     File destFile = new File("D:\\"+excelFile.getOriginalFilename());
	     try {
	            excelFile.transferTo(destFile);
	        } catch (IllegalStateException | IOException e) {
	            throw new RuntimeException(e.getMessage(),e);
	 
	        }

	     habitService.createMassiveHabit(destFile);
	     
//	     FileUtils.deleteFile(destFile.getAbsolutePath());
	     destFile.delete();

	     ModelAndView view = new ModelAndView();
	        view.setViewName("redirect:/habit/manage.do");
	        return view;

	}
	
	@RequestMapping("/list/excelDown.do")
	public String excelDown(Model model) throws Exception {

		// 출력할 리스트 가져오기
		List<HabitVO> habitList = habitService.retrieveHabitList();

		
		// excel 파일 header 설정 
		List<String> header = new ArrayList<String>();
		header.add("HABIT_SQ");
		header.add("HABIT_GB");
		header.add("HABIT_ST");
		
		// excel 파일 data 설정
		List<Map<String, String>> data = new ArrayList<Map<String, String>>();

		for(int i = 0; i<habitList.size(); i++) {
			Map<String, String> map = new HashMap<>();
			map.put("HABIT_SQ", habitList.get(i).getHabitSq());
			map.put("HABIT_GB", habitList.get(i).getHabitGb());
			map.put("HABIT_ST", habitList.get(i).getHabitSt());
			data.add(map);
		}
		
		model.addAttribute("header",header);
		model.addAttribute("data",data);
		model.addAttribute("fileName","HABIT");
		model.addAttribute("sheetName","HABIT");

		return "excelView";
	}


}

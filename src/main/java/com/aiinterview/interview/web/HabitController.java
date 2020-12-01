package com.aiinterview.interview.web;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.aiinterview.interview.service.HabitService;
import com.aiinterview.interview.vo.HabitVO;
import com.aiinterview.interview.vo.QuestionGubunVO;

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
	public String createProcess(String habitGb, String habitSt, Model model) throws Exception {
		
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
	public void excelDown(HttpServletRequest request, HttpServletResponse response) throws Exception {

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

		// excel 파일 contentType : application/vnd.ms-excel; UTF-8
		response.setContentType("application/vnd.ms-excel; UTF-8");

		// 첨부파일임을 암시
		response.setHeader("Content-Disposition", "attachment; filename=HABIT.xlsx");

		// poi 라이브러리를 이용하여 엑셀 파일을 생성
		Workbook workbook = new XSSFWorkbook();// poi 라이브러리에서는 엑셀파일을 workbook이라고 함
		// sheet 만들어주기
		Sheet sheet = workbook.createSheet("HABIT");
		
		// 행 만들기
		int rowNum = 0;
		Row row = sheet.createRow(rowNum++);

		int column = 0;
		// header 설정
		for (String h : header) {
			// cell 만들기
			row.createCell(column++).setCellValue(h);
		}

		// data 설정
		for (Map<String, String> map : data) {
			// 행 생성
			row = sheet.createRow(rowNum++);

			// 셀 채우기
			column = 0; // 매 행마다 셀 인덱스값은 초기화 되어야 함
			row.createCell(column++).setCellValue(map.get("HABIT_SQ"));
			row.createCell(column++).setCellValue(map.get("HABIT_GB"));
			row.createCell(column++).setCellValue(map.get("HABIT_ST"));
		}
		OutputStream os = response.getOutputStream();
		workbook.write(os);

		os.flush();
		os.close();

		workbook.close();
	}


}

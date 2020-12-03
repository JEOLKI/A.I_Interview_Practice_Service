package com.aiinterview.plan.web;


import java.text.SimpleDateFormat;
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

import com.aiinterview.interview.vo.HabitVO;
import com.aiinterview.member.vo.MemberVO;
import com.aiinterview.member.web.LoginController;
import com.aiinterview.plan.service.PlanService;
import com.aiinterview.plan.vo.PlanUseVO;
import com.aiinterview.plan.vo.PlanVO;

@RequestMapping("/plan")
@Controller
public class PlanController {
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Resource(name = "planService")
	PlanService planService;
	
	@RequestMapping(path = "/planList.do", method = RequestMethod.GET)
	public String planListView(Model model) {
		
		return "plan/planList";
	}
	
	@RequestMapping(path = "/planListAjax.do", method = RequestMethod.GET)
	public String buyplanAjax(Model model) {
		List<PlanVO> planList;
		try {
			planList = planService.planList();
			model.addAttribute("planList", planList);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		
		return "jsonView";
	}
	
	@RequestMapping(path = "/planContent.do", method = RequestMethod.GET)
	public String planContentView(PlanVO pv, Model model, HttpSession session) {
		
		PlanVO pvContent;
		try {
			pvContent = planService.planContent(pv);
			PlanUseVO puv = new PlanUseVO();
			MemberVO mv = (MemberVO) session.getAttribute("S_MEMBER");
			puv.setMemId(mv.getMemId());
			
			int planUseCheck = planService.planUseCheck(puv);
			
			model.addAttribute("planUseCheck", planUseCheck);
			model.addAttribute("pvContent", pvContent);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		
		return "plan/planContent";
	}
	
	
	@RequestMapping(path = "/payPlanAjax.do", method = RequestMethod.GET)
	public String payPlanAjax(PlanVO pv, Model model) {
		
		PlanVO pvContent;
		try {
			pvContent = planService.planContent(pv);
			model.addAttribute("pvContent", pvContent);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "jsonView";
	}
	
	
	@RequestMapping(path = "/planUseCreate.do", method = RequestMethod.GET)
	public String planUseCreateView(PlanVO pv, HttpSession session) {
		
		
		PlanVO pvContent;
		try {
			pvContent = planService.planContent(pv);
			PlanUseVO puv = new PlanUseVO();
			puv.setPlanPeriod(pvContent.getPlanPeriod());
			
			MemberVO mv = (MemberVO) session.getAttribute("S_MEMBER");
			puv.setMemId(mv.getMemId());
			
			
			planService.planUseCreate(puv);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "member/membermain";
	}
	
	
	@RequestMapping(path = "/manage.do", method = RequestMethod.GET)
	public String createView() {
		
		return "manage/planManage";
	}
	
	
	
	@RequestMapping(path = "/create.do", method =  RequestMethod.POST)
	public String createProcess(PlanVO pv) {
		try {
			planService.create(pv);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "manage/planManage";
	}

	@RequestMapping(path = "/update.do", method = RequestMethod.GET)
	public String updateView(PlanVO pv) {
		
		try {
			planService.update(pv);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "manage/planManage";
	}
	
	
	@RequestMapping(path = "/totalPayList.do")
	public String totalPayList(HttpSession session) {
		PlanUseVO puv = new PlanUseVO();
		MemberVO mv = (MemberVO) session.getAttribute("S_MEMBER");
		puv.setMemId(mv.getMemId());
		try {
			planService.CashList(puv);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "plan/totalPayList";
	}
	
	
	@RequestMapping("/planExcel.do")
	public String planExcelDown(Model model) throws Exception{

		// 출력할 리스트 가져오기
		List<PlanVO> planList = planService.planExcel();
		System.out.println("헤더설정1");
		// excel 파일 header 설정 
		List<String> header = new ArrayList<String>();
		header.add("PLAN_SQ");
		header.add("PLAN_NM");
		header.add("PLAN_PRICE");
		header.add("PLAN_EXPLAIN");
		header.add("PLAN_ST");
		header.add("PLAN_PERIOD");
		System.out.println("헤더설정2");
		// excel 파일 data 설정
		List<Map<String, String>> data = new ArrayList<Map<String, String>>();

		for(int i = 0; i<planList.size(); i++) {
			Map<String, String> map = new HashMap<>();
			map.put("PLAN_SQ", planList.get(i).getPlanSq());
			map.put("PLAN_NM", planList.get(i).getPlanNm());
			map.put("PLAN_PRICE", Integer.toString(planList.get(i).getPlanPrice()));
			map.put("PLAN_EXPLAIN", planList.get(i).getPlanExplain());
			map.put("PLAN_ST", planList.get(i).getPlanSt());
			map.put("PLAN_PERIOD", planList.get(i).getPlanPeriod());
			
			data.add(map);
		}
		
		model.addAttribute("header",header);
		model.addAttribute("data",data);
		model.addAttribute("fileName","PLAN");
		model.addAttribute("sheetName","PLAN");

		return "excelView";
	}
	
	@RequestMapping("/planUseExcel.do")
	public String planUseExcel(Model model) throws Exception {

		// 출력할 리스트 가져오기
		List<PlanUseVO> planUseList = planService.planUseExcel();
		
		// excel 파일 header 설정 
		List<String> header = new ArrayList<String>();
		header.add("USE_SQ");
		header.add("START_DATE");
		header.add("END_DATE");
		header.add("MEM_ID");
		header.add("PLAN_SQ");
		
		
		// excel 파일 data 설정
		List<Map<String, String>> data = new ArrayList<Map<String, String>>();

		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		for(int i = 0; i<planUseList.size(); i++) {
			Map<String, String> map = new HashMap<>();
			map.put("USE_SQ", planUseList.get(i).getUseSq());
			map.put("START_DATE", transFormat.format(planUseList.get(i).getStartDate()));
			map.put("END_DATE", transFormat.format(planUseList.get(i).getEndDate()));
			map.put("MEM_ID", planUseList.get(i).getMemId());
			map.put("PLAN_SQ", planUseList.get(i).getPlanSq());
			
			data.add(map);
		}
		
		model.addAttribute("header",header);
		model.addAttribute("data",data);
		model.addAttribute("fileName","PLANUSE");
		model.addAttribute("sheetName","PLANUSE");

		return "excelView";
	}
	
	
	
	
	@RequestMapping(path = "/cashList.do", method = RequestMethod.GET)
	public String cashListView(Model model, HttpSession session) {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일"); 

		MemberVO mv  =(MemberVO) session.getAttribute("S_MEMBER");
		PlanUseVO puv = new PlanUseVO();
		puv.setMemId(mv.getMemId());
		try {
			List<PlanUseVO> cashList = planService.CashList(puv);
			List<String> startList = new ArrayList<>(); 
			List<String> endList = new ArrayList<>();
			
			for (int i = 0; i < cashList.size(); i++) {
						startList.add(sdf.format(cashList.get(i).getStartDate()));
						endList.add(sdf.format(cashList.get(i).getEndDate()));
			}
			model.addAttribute("cashList", cashList);
			model.addAttribute("startList", startList);
			model.addAttribute("endList", endList);
				
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "jsonView";
	}
	
	
	
	
	@RequestMapping(path = "/createe.do", method = RequestMethod.GET)
	public String createeView() {
		
		return "manage/planManagee";
	}
	
	
	
	@RequestMapping(path = "/payComplete.do")
	public String payComplete() {
		return "myProfile/myProfile";
	}
	
	
	
	
	
	@RequestMapping(path = "/buyPlanTest.do", method = RequestMethod.GET)
	public String buyPlanTest(Model model) {
		return "plan/buyPlanTest";
	}
	
	
	
	
}

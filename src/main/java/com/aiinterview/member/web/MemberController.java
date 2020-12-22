package com.aiinterview.member.web;


import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aiinterview.member.service.MemberService;
import com.aiinterview.member.vo.MemberVO;
import com.aiinterview.plan.service.PlanService;
import com.aiinterview.plan.vo.PlanUseVO;
import com.aiinterview.plan.vo.PlanVO;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RequestMapping("/member")
@Controller
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Resource(name = "memberService")
	private MemberService memberService;
	
	@Resource(name = "planService")
	private PlanService planService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@RequestMapping(path = "/test.do", method = { RequestMethod.GET })
	public String testView() {
		return "member/test";
	}

	@RequestMapping(path = "/retrieveid.do", method = { RequestMethod.GET })
	public String retrieveId(MemberVO memberVo, Model model){
		MemberVO searchMemberVo = null;
		try {
			searchMemberVo = memberService.retrieveId(memberVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		model.addAttribute("searchMemberVo", searchMemberVo);
		return "jsonView";
	}

	@RequestMapping(path = "/retrievepw.do", method = { RequestMethod.GET })
	public String retrievePw(MemberVO memberVo, Model model){
		MemberVO searchMemberVo = null;
		try {
			searchMemberVo = memberService.retrievePw(memberVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		model.addAttribute("searchMemberVo", searchMemberVo);
		return "jsonView";
	}
	
	@RequestMapping(path = "/updatepw.do", method = { RequestMethod.GET })
	public String updatePw(MemberVO memberVo, Model model){
		int updateCnt = 0;
		try {
			updateCnt = memberService.updatePw(memberVo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("updateCnt", updateCnt);
		return "jsonView";
	}
	
	@RequestMapping(path = "/idCheck.do", method = { RequestMethod.POST })
	public String idCheck(String memId, Model model){
		MemberVO memberVo = null;
		try {
			memberVo = memberService.retrieve(memId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("memberVo",memberVo);
		
		return "jsonView";
	}
	
	@RequestMapping(path = "/aliasCheck.do", method = { RequestMethod.POST })
	public String aliasCheck(String memAlias, Model model) {
		List<MemberVO>memberList =null;
		try {
			memberList = memberService.aliasCheck(memAlias);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		model.addAttribute("memberList",memberList);
		
		return "jsonView";
	}
	
	@RequestMapping(path = "/create.do", method = { RequestMethod.POST })
	public String create(MemberVO memberVo, Model model,RedirectAttributes ra){
		memberVo.setMemAuth("N");
		memberVo.setMemSt("Y");
		
		int insertCnt = 0;
		try {
			insertCnt = memberService.create(memberVo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("memberVo",memberVo);
		
		if(insertCnt == 1) {
			return "redirect:/login/main.do";
		}else {
			return "redirect:/login/join.do";
		}
	}
	
	@RequestMapping(path="/myprofileview.do", method= {RequestMethod.GET})
	public String myProfileView(HttpSession session, Model model) {
		 
		return "myProfile/myProfile";
	}
	
	
	@RequestMapping(path="/myPlanAjax.do", method= {RequestMethod.GET})
	public String myPlanAjax(HttpSession session, Model model) {
		MemberVO mv =  (MemberVO) session.getAttribute("S_MEMBER");
		String memId = mv.getMemId();
		PlanUseVO puv = new PlanUseVO();
		PlanVO pv = new PlanVO();
		puv.setMemId(memId);
		
		try {
			if (planService.planUseCount(puv) > 0) { // 이용중인 요금제가 존재
				PlanUseVO planUseCheck =  
						planService.planUseCheck(puv);
				
				pv.setPlanSq(planUseCheck.getPlanSq());
				PlanVO planUse = planService.planContent(pv);
				
				// 사용중인 요금제 날짜 설정 구문
				long calDate = planUseCheck.getEndDate().getTime() - planUseCheck.getStartDate().getTime();
				long calDateDays =calDate / (24*60*60*1000);
				planUseCheck.setTerm((int) (calDateDays = Math.abs(calDateDays))); 
				
				model.addAttribute("planUse", planUse);
				model.addAttribute("planUseCheck", planUseCheck);
			}else {
				puv.setTerm(-1);
				
				model.addAttribute("planUseCheck", puv);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "jsonView";
	}
	
	@RequestMapping(path="/deleteview.do", method= {RequestMethod.GET})
	public String deleteView() {
		return "myProfile/myProfileDelete";
	}
	
	@RequestMapping(path="/deleteprocess.do", method= {RequestMethod.GET})
	public String deleteProcess(String memId, HttpSession session){
		int deleteCnt = 0;
		try {
			deleteCnt = memberService.delete(memId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(deleteCnt == 1) {
			session.removeAttribute("S_MEMBER");
			return "redirect:/login/main.do";
		}else {
			return "redirect:/member/myprofileview.do";
		}
	}
	
	@RequestMapping(path = "/profile.do", method = { RequestMethod.GET })
	public String profile(String memId,Model model){
		MemberVO memberVo = null;
		try {
			memberVo = memberService.retrieve(memId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("memProfilePath", memberVo.getMemProfilePath());
		return "ProfileImgView";
	}
	
	@RequestMapping(path = "/updateview.do", method = { RequestMethod.GET })
	public String updateView(String memId,Model model) {
		return "myProfile/myProfileUpdate";
	}
	
	@RequestMapping(path = "/update.do", method = { RequestMethod.POST })
	public String update(MemberVO memberVo, Model model, HttpSession session,
			@RequestParam(name="profile",required = false) MultipartFile profile) {
		
		if(profile.getSize() > 0) {
			// 확장자 추출
			int index = profile.getOriginalFilename().lastIndexOf(".");
			String extension = profile.getOriginalFilename().substring(index + 1); 
			
			// 프로필파일 vo 등록
			memberVo.setMemProfileNm(profile.getOriginalFilename());
			String uploadFileName = UUID.randomUUID().toString() + "." + extension;
			memberVo.setMemProfilePath("d:\\final\\" +uploadFileName);
			
			// 파일 업로드
			File uploadFile = new File("d:\\final\\" + uploadFileName);
			try {
				profile.transferTo(uploadFile); // 업로드하는 메서드
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
			
			// 회원등록
			int updateCnt = 0;
			try {
				updateCnt = memberService.update(memberVo);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			if(updateCnt == 1) {
				try {
					session.setAttribute("S_MEMBER", memberService.retrieve(memberVo.getMemId()));
				} catch (Exception e) {
					e.printStackTrace();
				}
				return "redirect:/member/myprofileview.do";
			}else {
				return "myProfile/myProfileUpdate";
			}
		}else {
			int updateCnt = 0;
			try {
				updateCnt = memberService.update(memberVo);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			if(updateCnt == 1) {
				try {
					session.setAttribute("S_MEMBER", memberService.retrieve(memberVo.getMemId()));
				} catch (Exception e) {
					e.printStackTrace();
				}
				return "redirect:/member/myprofileview.do";
			}else {
				return "myProfile/myProfileUpdate";
			}
		}
		
	}
	
	@RequestMapping("/marketingAgree.do")
	public String marketingAgree() {
		return "agreement/marketingAgree";
	}
	
	@RequestMapping(path = "/retrievePagingList.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String retrievePagingList(MemberVO memberVO, String pageUnit, HttpSession session, ModelMap model) {
		int pageUnitInt = pageUnit == null ? 10 : Integer.parseInt(pageUnit);
		model.addAttribute("pageUnit" , pageUnitInt);
		
		/** EgovPropertyService.sample */
		memberVO.setPageUnit(propertiesService.getInt("pageUnit"));
		memberVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(memberVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(memberVO.getPageUnit());
		paginationInfo.setPageSize(memberVO.getPageSize());

		memberVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		memberVO.setLastIndex(paginationInfo.getLastRecordIndex());
		memberVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<MemberVO> resultList = new ArrayList<>();
		try {
			resultList = memberService.retrievePagingList(memberVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("resultList", resultList);

		int totCnt = 0;
		try {
			totCnt = memberService.retrievePagingListCnt(memberVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		return "manage/memberManage";
	}
	
	@RequestMapping(path ="/memberExcel.do")
	public String memberExcelDown(Model model) throws Exception {

		// 출력할 리스트 가져오기
		List<MemberVO> memberList = memberService.manageMember();
		System.out.println("헤더설정1");
		// excel 파일 header 설정
		List<String> header = new ArrayList<String>();
		header.add("아이디");
		header.add("비밀번호");
		header.add("관리자권한");
		header.add("회원상태");
		header.add("별명");
		header.add("이름");
		header.add("전화번호");
		header.add("기본주소");
		header.add("상세주소");
		header.add("우편번호");
		header.add("경력");
		header.add("학력");
		header.add("성별");
		header.add("목표회사");
		header.add("목표직무");
		header.add("구직시작기간");
		header.add("전공");
		// excel 파일 data 설정
		List<Map<String, String>> data = new ArrayList<Map<String, String>>();

		for (int i = 0; i < memberList.size(); i++) {
			Map<String, String> map = new HashMap<>();
			map.put("아이디", memberList.get(i).getMemId());
			map.put("비밀번호", memberList.get(i).getMemPw());
			map.put("관리자권한", memberList.get(i).getMemAuth());
			map.put("회원상태", memberList.get(i).getMemSt());
			map.put("별명", memberList.get(i).getMemAlias());
			map.put("이름", memberList.get(i).getMemNm());
			map.put("전화번호", memberList.get(i).getMemTel());
			map.put("기본주소", memberList.get(i).getMemAddr1());
			map.put("상세주소", memberList.get(i).getMemAddr2());
			map.put("우편번호", Integer.toString(memberList.get(i).getMemZipcode()));
			map.put("경력", memberList.get(i).getMemCareer());
			map.put("학력", memberList.get(i).getMemEduc());
			map.put("성별", memberList.get(i).getMemGender());
			map.put("목표회사", memberList.get(i).getMemTargetCompany());
			map.put("목표직무", memberList.get(i).getMemTargetJob());
			map.put("구직시작기간", memberList.get(i).getSearchJobDate());
			map.put("전공", memberList.get(i).getMemMajor());
			data.add(map);
		}

		model.addAttribute("header", header);
		model.addAttribute("data", data);
		model.addAttribute("fileName", "MEMBER");
		model.addAttribute("sheetName", "MEMBER");

		return "excelView";
	}
	
	@RequestMapping(path="authorityManage.do")
	public String authorityManage(MemberVO memberVO, String pageUnit, HttpSession session, ModelMap model) {
		int pageUnitInt = pageUnit == null ? 10 : Integer.parseInt(pageUnit);
		model.addAttribute("pageUnit" , pageUnitInt);
		
		/** EgovPropertyService.sample */
		memberVO.setPageUnit(propertiesService.getInt("pageUnit"));
		memberVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(memberVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(memberVO.getPageUnit());
		paginationInfo.setPageSize(memberVO.getPageSize());

		memberVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		memberVO.setLastIndex(paginationInfo.getLastRecordIndex());
		memberVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<MemberVO> resultList = new ArrayList<>();
		try {
			resultList = memberService.retrievePagingList(memberVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("resultList", resultList);

		int totCnt = 0;
		try {
			totCnt = memberService.retrievePagingListCnt(memberVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "manage/authorityManage";
	}
	
	@RequestMapping(path="authorityChange.do")
	public String authorityChange(MemberVO memberVO) {
		MemberVO changeMemberVO = null;
		try {
			changeMemberVO = memberService.retrieve(memberVO.getMemId());
		} catch (Exception e) {
			e.printStackTrace();
		}
		changeMemberVO.setMemAuth(memberVO.getMemAuth());
		try {
			memberService.update(changeMemberVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/member/authorityManage.do";
	}
	
	@RequestMapping(path="statistic.do")
	public String statistics() {
		return"manage/memberStatistic";
	}
	
	@RequestMapping(path="/majorStatistic.do")
	public String majorStatistic(Model model, MemberVO memberVO) {
		List<MemberVO> memberMajorList = null;
				
		try {
			memberMajorList = memberService.retrieveMajor(memberVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("memberMajorList",memberMajorList);
		return "jsonView";
	}
	
	@RequestMapping(path="/educationStatistic.do")
	public String educationStatistic(Model model, MemberVO memberVO) {
		List<MemberVO> memberEducationList = null;
		
		try {
			memberEducationList = memberService.retrieveEducation(memberVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("memberEducationList",memberEducationList);
		return "jsonView";
	}
	
	@RequestMapping(path="/searchJobDateStatistic.do")
	public String searchJobDateStatistic(Model model, MemberVO memberVO) {
		List<MemberVO> membersearchJobDateList = null;
		
		try {
			membersearchJobDateList = memberService.retrieveSearchJobDate(memberVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("membersearchJobDateList",membersearchJobDateList);
		return "jsonView";
	}
	
	@RequestMapping(path="/careerStatistic.do")
	public String careerStatistic(Model model, MemberVO memberVO) {
		List<MemberVO> memberCareerList = null;
		
		try {
			memberCareerList = memberService.retrieveCareer(memberVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("memberCareerList",memberCareerList);
		return "jsonView";
	}
	
	@RequestMapping(path="/genderStatistic.do")
	public String genderStatistic(Model model, MemberVO memberVO) {
		List<MemberVO> memberGenderList = null;
		
		try {
			memberGenderList = memberService.retrieveGender(memberVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("memberGenderList",memberGenderList);
		return "jsonView";
	}
	
}
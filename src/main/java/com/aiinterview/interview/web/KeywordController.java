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

import com.aiinterview.interview.service.KeywordMatchingService;
import com.aiinterview.interview.service.KeywordService;
import com.aiinterview.interview.service.TalentService;
import com.aiinterview.interview.vo.KeywordMatchingVO;
import com.aiinterview.interview.vo.KeywordVO;
import com.aiinterview.interview.vo.TalentVO;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RequestMapping("/keyword")
@Controller
public class KeywordController {

	@Resource(name="keywordService")
	private KeywordService keywordService;
	
	@Resource(name="keywordMathingService")
	private KeywordMatchingService keywordMathingService;
	
	@Resource(name="talentService")
	private TalentService talentService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	
	@RequestMapping("/retrievePagingList.do")
	public String retrievePagingList(KeywordVO keywordVO, TalentVO talentVO,Model model) throws Exception {
		
		/** EgovPropertyService.sample */
		keywordVO.setPageUnit(propertiesService.getInt("pageUnit"));
		keywordVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(keywordVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(keywordVO.getPageUnit());
		paginationInfo.setPageSize(keywordVO.getPageSize());
		

		
		keywordVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		keywordVO.setLastIndex(paginationInfo.getLastRecordIndex());
		keywordVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<KeywordVO> resultList = keywordService.retrievePagingList(keywordVO);
		model.addAttribute("resultList", resultList);

		int totCnt = keywordService.retrievePagingListCnt(keywordVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		
		/* 인재상 목록 추출 */
		List<TalentVO> talentList = talentService.retrieveUsingList();
		model.addAttribute("talentList", talentList);
		
		
		return "keyword/keywordManage";
	}
	
	
	/* 등록 */
	@RequestMapping("/createProcess.do")
	public String createKeywordProcess(KeywordVO keywordVO, String talentSq) throws Exception {


		keywordService.create(keywordVO,talentSq);

		return "redirect:/keyword/retrievePagingList.do";
	}
	
	
	/* 일괄 등록 */
	@RequestMapping("/massiveCreateProcess.do")
	public String createMassiveHabit(MultipartHttpServletRequest request) throws Exception {
		MultipartFile excelFile = request.getFile("excelFile");
		if (excelFile == null || excelFile.isEmpty()) {
			throw new RuntimeException("엑셀파일을 선택해 주세요");
		}

		File destFile = new File("D:\\" + excelFile.getOriginalFilename());
		try {
			excelFile.transferTo(destFile);
		} catch (IllegalStateException | IOException e) {
			throw new RuntimeException(e.getMessage(), e);

		}

		keywordService.createMassiveKyeword(destFile);

		destFile.delete();

		return "redirect:/keyword/retrievePagingList.do";

	}
	
	/* 일괄 다운로드 */
	@RequestMapping("/list/excelDown.do")
	public String excelDown(Model model) throws Exception {

		// 출력할 리스트 가져오기
		List<KeywordVO> keywordList = keywordService.retrieveList();

		
		//Model 객체에 header, data
		List<String> header = new ArrayList<String>();
		header.add("KEYWORD_SQ");
		header.add("KEYWORD_CONTENT");
		header.add("KEYWORD_ST");
		
		// excel 파일 data 설정
		List<Map<String, String>> data = new ArrayList<Map<String, String>>();

		for(int i = 0; i<keywordList.size(); i++) {
			Map<String, String> map = new HashMap<>();
			map.put("KEYWORD_SQ", keywordList.get(i).getKeywordSq());
			map.put("KEYWORD_CONTENT", keywordList.get(i).getKeywordContent());
			map.put("KEYWORD_ST", keywordList.get(i).getKeywordSt());
			data.add(map);
		}

		model.addAttribute("header",header);
		model.addAttribute("data",data);
		model.addAttribute("fileName","KEYWORD");
		model.addAttribute("sheetName","KEYWORD");
		
		return "excelView";
	}
	
	/* 키워드 수정 */
	@RequestMapping(path = "/updateProcess.do", method = { RequestMethod.POST })
	public String updateProcess(KeywordVO keywordVO, String talentSq, Model model) {

		int updateCnt = 0;
		try {
			updateCnt = keywordService.update(keywordVO, talentSq);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (updateCnt == 2) {
			return "redirect:/keyword/retrievePagingList.do"; // 업데이트 성공시 리다이렉트
		} else {
			return "keyword/keywordManage";
		}
	}
	
	
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	@RequestMapping("/create.do")
	public String create(String talentSq, String keywordContent, Model model) {
		// 1. keywordContent 값으로 키워드 테이블 조회 
		// 2. 일치하는 값 있으면 매칭 테이블에 해당  조합이 있는지 검사 -> 없을 시 keywordSq, talentSq, st=Y insert, 있다면 화면돌아가서 alert
		// 3. 불일치 -> 키워드 테이블에 insert, 매칭테이블에 insert
		
		// 1.
		KeywordVO keywordVO;
		String keywordSq = null;
		String matchingCnt = null;
		try {
			keywordVO = keywordService.retrieve(keywordContent);
			
			Map<String, String> createMap = new HashMap<>();
			
			if(keywordVO == null) { // 3.
				keywordSq = keywordService.create(keywordContent);
				if(Integer.parseInt(keywordSq)>0) {
					createMap.put("talentSq", talentSq);
					createMap.put("keywordSq", keywordSq);
					matchingCnt = keywordMathingService.create(createMap);
				}
			}else { // 2.
				keywordSq = keywordVO.getKeywordSq();
				createMap.put("talentSq", talentSq);
				createMap.put("keywordSq", keywordSq);
				KeywordMatchingVO  keywordMatchingVO = keywordMathingService.retrieve(createMap);
				if(keywordMatchingVO != null) {
					matchingCnt = keywordMathingService.create(createMap);
				} else {
					model.addAttribute("msg", "이미 등록된 키워드입니다.");
					return "talent/talentKeywordManage"; // 키워드 일치, 매칭 일치 시 되돌려보냄
				}
			}
			
			
		} catch (Exception e) {
		}
		if(keywordSq != null || matchingCnt !=null) {
			return "redirect:/talent/keywordManage.do?talentSq="+talentSq; // 둘다 insert 성공시 redirect
		}else {
			model.addAttribute("msg", "키워드 등록 실패");
			return "talent/talentKeywordManage"; // 키워드 일치, 매칭 일치 시 되돌려보냄
		}
		
		
	}
	
	@RequestMapping("/delete.do")
	public String delete(String talentSq, String keywordSq, Model model) {
		// 1. keywordSq, talentSq 값 매칭된 행 조회  -> 해당 행 삭제
		Map<String,	String> deleteMap = new HashMap<>();
		deleteMap.put("talentSq", talentSq);
		deleteMap.put("keywordSq", keywordSq);
		
		try {
			int deleteCnt = keywordMathingService.delete(deleteMap);
			
			if(deleteCnt>0) {
				return "redirect:/talent/keywordManage.do?talentSq="+talentSq;
			} else {
				model.addAttribute("msg", "키워드 삭제 실패");
			}
		} catch (Exception e) {
			model.addAttribute("msg", "키워드 삭제 실패");
		}
		return "talent/talentKeywordManage";
	}
}

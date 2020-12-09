package com.aiinterview.interview.web;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.aiinterview.analysis.vo.HabitAnalysisVO;
import com.aiinterview.analysis.vo.ImageAnalysisVO;
import com.aiinterview.analysis.vo.KeywordAnalysisVO;
import com.aiinterview.analysis.vo.RepeatAnalysisVO;
import com.aiinterview.board.vo.AttachmentVO;
import com.aiinterview.common.util.FileUploadUtil;
import com.aiinterview.interview.service.AnswerService;
import com.aiinterview.interview.service.HabitService;
import com.aiinterview.interview.service.KeywordMatchingService;
import com.aiinterview.interview.service.KeywordService;
import com.aiinterview.interview.vo.AnswerVO;
import com.aiinterview.interview.vo.HabitVO;
import com.aiinterview.interview.vo.KeywordMatchingVO;
import com.aiinterview.interview.vo.WiseNLU.Morpheme;
import com.aiinterview.interview.vo.WiseNLU.NameEntity;
import com.google.gson.Gson;

@RequestMapping("/answer")
@Controller
public class AnswerController {
	
	@Resource(name="answerService")
	private AnswerService answerSeivce;
	
	@Resource(name="habitService")
	private HabitService habitService;
	
	@Resource(name="keywordMatchingService")
	private KeywordMatchingService keywordMatchingService;
	
	@Resource(name="keywordService")
	private KeywordService keywordService;
	
	
	
	@RequestMapping(path="/create.do", method= {RequestMethod.POST})
	public String create(AnswerVO answerVO, @ModelAttribute("imageAnalysisVO") ImageAnalysisVO imageAnalysisVO, MultipartHttpServletRequest mtfRequest){
		
		System.out.println("앤서 이미지 분석 결과" + answerVO);
		System.out.println("이미지 분석 결과" + imageAnalysisVO);
		
		List<ImageAnalysisVO> imageAnalysisList = imageAnalysisVO.getImageAnalysisVOList();
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("imageAnalysisList", imageAnalysisList);
		
		// 추가한구문
		Iterator<String> iter = mtfRequest.getFileNames();
		MultipartFile answerVideo = null;
		String fieldName = "";
		while(iter.hasNext()) {
			String videoPath = "D:\\answerVideo\\" + UUID.randomUUID().toString() + ".webm";
			answerVO.setVideoPath(videoPath);
			map.put("answerVO", answerVO);
			
			fieldName = (String) iter.next(); // 파일이름, 위에서 file1과 file2로 보냈으니 file1, file2로 나온다.
			answerVideo = mtfRequest.getFile(fieldName); // 저장된 파일 객체
			
			System.out.println("결과 1 : " + fieldName);
			System.out.println("결과 2 : " + answerVideo);
			System.out.println("결과 3 : " + answerVideo.getName());
			System.out.println("결과 4 : " + answerVideo.getOriginalFilename());
			try {
				answerVideo.transferTo(new File(videoPath));
			} catch (IllegalStateException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		System.out.println("결과 6 : "+ answerVideo.getSize());

		// 추가한구문
		
		
		
		/* 영상 다운로드 */
//		MultipartFile answerVideo = mtfRequest.getFile("name");
//		System.out.println("영상" + answerVideo.getSize());
//		if(answerVideo.getSize() > 0) {
//			String videoPath = "D:\\answerVideo\\" + UUID.randomUUID().toString() + ".webm";
//			answerVO.setVideoPath(videoPath);
//			map.put("answerVO", answerVO);
//			File uploadVideo = new File(videoPath);
//			try {
//				answerVideo.transferTo(uploadVideo);
//			} catch (IllegalStateException | IOException e) {
//				e.printStackTrace();
//			}
//		}
		
		//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  언어 분석  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
		
		String script = answerVO.getAnsContent();
		
		
		/* 습관어 분석 */
		List<HabitVO> habitList;
		try {
			habitList = habitService.retrieveUsingList();
			HabitAnalysisVO habitAnalysisVO = null;
			
			List<HabitAnalysisVO> habitAnalysisVOList = new ArrayList<>();
			
			for(int i=0; i<habitList.size(); i++) {
				habitAnalysisVO = new HabitAnalysisVO(); 
				String[] habitArr = script.split(habitList.get(i).getHabitGb());
				habitAnalysisVO.setHabitSq(habitList.get(i).getHabitSq());
				habitAnalysisVO.setHabitCount(habitArr.length-1+"");
				habitAnalysisVOList.add(habitAnalysisVO);
			}
			map.put("habitAnalysisVOList", habitAnalysisVOList);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		
		
		/* 반복어 분석 */
		// 언어 분석 기술 문어/구어 중 한가지만 선택해 사용
        // 언어 분석 기술(문어)
//        String openApiURL = "http://aiopen.etri.re.kr:8000/WiseNLU";  
        // 언어 분석 기술(구어)
        String openApiURL = "http://aiopen.etri.re.kr:8000/WiseNLU_spoken";         
        String accessKey = "d119ee9a-e502-4236-8f15-61ac9e8dad04";   // 발급받은 API Key
        String analysisCode = "ner";        // 언어 분석 코드
        String text = script;           // 분석할 텍스트 데이터
        Gson gson = new Gson();
         
        Map<String, Object> request = new HashMap<>();
        Map<String, String> argument = new HashMap<>();
 
        argument.put("analysis_code", analysisCode);
        argument.put("text", text);
 
        request.put("access_key", accessKey);
        request.put("argument", argument);
 
        URL url;
        Integer responseCode = null;
        String responBodyJson = null;
        Map<String, Object> responeBody = null;
 
        try {
            url = new URL(openApiURL);
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("POST");
            con.setDoOutput(true);
 
            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
            wr.write(gson.toJson(request).getBytes("UTF-8"));
            wr.flush();
            wr.close();
 
            responseCode = con.getResponseCode();
            InputStream is = con.getInputStream();
            BufferedReader br = new BufferedReader(new InputStreamReader(is));
            StringBuffer sb = new StringBuffer();
 
            String inputLine = "";
            while ((inputLine = br.readLine()) != null) {
                sb.append(inputLine);
            }
            responBodyJson = sb.toString();
 
            // http 요청 오류 시 처리
            if ( responseCode != 200 ) {
                // 오류 내용 출력
                System.out.println("[error] " + responBodyJson);
            }
 
            responeBody = gson.fromJson(responBodyJson, Map.class);
            Integer result = ((Double) responeBody.get("result")).intValue();
            Map<String, Object> returnObject;
            List<Map> sentences;
 
            // 분석 요청 오류 시 처리
            if ( result != 0 ) {
                // 오류 내용 출력
                System.out.println("[error] " + responeBody.get("result"));
            }
 
            // 분석 결과 활용
            returnObject = (Map<String, Object>) responeBody.get("return_object");
            sentences = (List<Map>) returnObject.get("sentence");
 
            Map<String, Morpheme> morphemesMap = new HashMap<String, Morpheme>();
            Map<String, NameEntity> nameEntitiesMap = new HashMap<String, NameEntity>();
            List<Morpheme> morphemes = null;
            List<NameEntity> nameEntities = null;
 
            for( Map<String, Object> sentence : sentences ) {
                // 형태소 분석기 결과 수집 및 정렬
                List<Map<String, Object>> morphologicalAnalysisResult = (List<Map<String, Object>>) sentence.get("morp");
                for( Map<String, Object> morphemeInfo : morphologicalAnalysisResult ) {
                    String lemma = (String) morphemeInfo.get("lemma");
                    Morpheme morpheme = morphemesMap.get(lemma);
                    if ( morpheme == null ) {
                        morpheme = new Morpheme(lemma, (String) morphemeInfo.get("type"), 1);
                        morphemesMap.put(lemma, morpheme);
                    } else {
                        morpheme.count = morpheme.count + 1;
                    }
                }
 
                // 개체명 분석 결과 수집 및 정렬
                List<Map<String, Object>> nameEntityRecognitionResult = (List<Map<String, Object>>) sentence.get("NE");
                for( Map<String, Object> nameEntityInfo : nameEntityRecognitionResult ) {
                    String name = (String) nameEntityInfo.get("text");
                    NameEntity nameEntity = nameEntitiesMap.get(name);
                    if ( nameEntity == null ) {
                        nameEntity = new NameEntity(name, (String) nameEntityInfo.get("type"), 1);
                        nameEntitiesMap.put(name, nameEntity);
                    } else {
                        nameEntity.count = nameEntity.count + 1;
                    }
                }
            }
 
            if ( 0 < morphemesMap.size() ) {
                morphemes = new ArrayList<Morpheme>(morphemesMap.values());
                morphemes.sort( (morpheme1, morpheme2) -> {
                    return morpheme2.count - morpheme1.count;
                });
            }
 
            if ( 0 < nameEntitiesMap.size() ) {
                nameEntities = new ArrayList<NameEntity>(nameEntitiesMap.values());
                nameEntities.sort( (nameEntity1, nameEntity2) -> {
                    return nameEntity2.count - nameEntity1.count;
                });
            }
            
            
            // 반복어 리스트
            List<RepeatAnalysisVO> repeatList = new ArrayList<>();
            
            // 형태소들 중 명사들에 대해서 많이 노출된 순으로 출력 ( 최대 5개 )
            morphemes
                .stream()
                .filter(morpheme -> {
                    return morpheme.type.equals("NNG") ||
                            morpheme.type.equals("NNP") ||
                            morpheme.type.equals("NNB");
                })
                .limit(3)
                .forEach(morpheme -> {
                	// db에 보낼 반복어 객체 생성
                	RepeatAnalysisVO repeatAnalysisVO = new RepeatAnalysisVO();
                	repeatAnalysisVO.setRepeatContent(morpheme.text);
                	System.out.println(morpheme.text);
                	repeatAnalysisVO.setRepeatCount(morpheme.count+"");
                	System.out.println(morpheme.count+"");
                	repeatList.add(repeatAnalysisVO);
                });
            System.out.println("반복어 분석  : "+repeatList);
            map.put("repeatList", repeatList);
            
				
			
			/* 인재상 분석 */
			List<KeywordMatchingVO> keywordMatchingList = keywordMatchingService.retrieveList();
			
			List<KeywordAnalysisVO> keywordAnalysisList = new ArrayList<>();
			
			for(int i=0; i<keywordMatchingList.size(); i++) {
				String kyewordContent = keywordService.retrieveMathcingKeyword(keywordMatchingList.get(i).getKeywordSq());
				System.out.println("kyewordContent : " + kyewordContent);
				String[] keywordArr = script.split(kyewordContent);
				KeywordAnalysisVO keywordAnalysisVO = new KeywordAnalysisVO();
				keywordAnalysisVO.setKeywordSq(keywordMatchingList.get(i).getKeywordSq());
				keywordAnalysisVO.setTalentSq(keywordMatchingList.get(i).getTalentSq());
				keywordAnalysisVO.setKeywordCount(keywordArr.length-1+"");
				
				keywordAnalysisList.add(keywordAnalysisVO);
			}
			
			System.out.println("인재상 분석  : "+keywordAnalysisList);
			map.put("keywordAnalysisList", keywordAnalysisList);
			
			answerSeivce.create(map);
				
				
				
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }catch (Exception e) {
			e.printStackTrace();
		}
        
		
		return "jsonView";
	}
	
}

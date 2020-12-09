package com.aiinterview.script.web;

import java.io.DataOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Base64;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.aiinterview.member.vo.MemberVO;
import com.aiinterview.script.service.ScriptTestService;
import com.aiinterview.script.service.SpeechService;
import com.aiinterview.script.vo.ScriptTestVO;
import com.aiinterview.script.vo.SpeechVO;
import com.google.gson.Gson;


@RequestMapping("/speech")
@Controller
public class SpeechController {

	@Resource(name ="speechService")
	SpeechService speechService;
	
   @Resource(name = "scriptTestService")
   ScriptTestService scriptTestService;
	
   @RequestMapping(path="/speechChart.do", method = {RequestMethod.GET})
   public String speechChartView(Model model) {
	   SpeechVO sv = new SpeechVO();
//		MemberVO mv = (MemberVO) session.getAttribute("S_MEMBER");
//		sv.setMemId(mv.getMemId());
	    sv.setMemId("TEST_ID");
	    int count = 0;
	    try {
	    	
			List<SpeechVO> speechList = speechService.retrieve(sv);
			
			ScriptTestVO stVo = new ScriptTestVO();
//			MemberVO mv = (MemberVO) session.getAttribute("S_MEMBER");
//			stVo.setMemId(mv.getMemId());
			
			stVo.setMemId("TEST_ID");
			stVo.setScriptGbSq("1");
			
			List<ScriptTestVO> EnglishList = scriptTestService.retrieve(stVo);
			
			stVo.setScriptGbSq("4");
			List<ScriptTestVO> KoreanList = scriptTestService.retrieve(stVo);
			
			int[] data = {speechList.size(), EnglishList.size(), KoreanList.size()};
			for(int i= 0 ; i < data.length; i++) {
				if(data[i]> count) {
					count = data[i];
				}
			}
			
			model.addAttribute("count", count);
			model.addAttribute("EnglishList", EnglishList);
			model.addAttribute("KoreanList", KoreanList);
			model.addAttribute("speechList", speechList);
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
      return "speech/speechChart";
   }
   
   @RequestMapping(path="/speech.do", method = {RequestMethod.GET})
   public String scriptView() {
      
      return "speech/speech";
   }
   
   
   
    @RequestMapping(path = "/speecher.do", method = RequestMethod.POST)
	@ResponseBody
	public String blobTestR(Model model, MultipartHttpServletRequest Test, HttpSession session) {
		Iterator<String> iter = Test.getFileNames();
		MultipartFile mfile = null;
		String fieldName = "";
		String filePath = "";
		Map<String, String> map = new HashMap<>();
		SpeechVO sv = new SpeechVO();
	
		while (iter.hasNext()) {
			fieldName = (String) iter.next(); // 파일 여러개면 순서대로 나온다.
			mfile = Test.getFile(fieldName); // 저장된 파일 객체
			model.addAttribute("result1", mfile);

			try {
				String str = mfile.toString();
				String result = str.substring(str.lastIndexOf("@") + 1);
				filePath = "c:/vo/"+result+".pcm";
//				filePath = "c:/vo/PRO_M_20csg0029.pcm";
				mfile.transferTo(new File(filePath));
				map = analysis(filePath);
				
//				MemberVO mv = (MemberVO) session.getAttribute("S_MEMBER");
//				sv.setMemId(mv.getMemId());
				sv.setMemId("TEST_ID");
				sv.setSpeechScript(map.get("speechScript"));
				sv.setSpeechTestScore(map.get("speechScore"));
				
				speechService.create(sv);
				
				
				model.addAttribute("path", filePath);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return "redirect:/speech/speech.do";
	}
    
    public Map<String, String> analysis (String filePath) {
    	String openApiURL = "https://aiopen.etri.re.kr:8443/WiseASR/Pronunciation"; // 영어
        String accessKey = "268a9508-ee17-4008-bb9f-eebe99daf509";    // 발급받은 API Key
        String languageCode = "english";     // 언어 코드
//        String script = "center"; 
//        String aa =  "C:\\vo\\PRO_F_D01S03_01S.pcm";  // 녹음된 음성 파일 경로
        String audioFilePath = filePath;  // 녹음된 음성 파일 경로
        String score =null; //점수
        
        String audioContents = null;

        Gson gson = new Gson();

        Map<String, Object> request = new HashMap<>();
        Map<String, String> argument = new HashMap<>();
        Map<String, String> map = new HashMap<>();
        try {
            Path path = Paths.get(audioFilePath);
            byte[] audioBytes = Files.readAllBytes(path);
            audioContents = Base64.getEncoder().encodeToString(audioBytes);
        } catch (IOException e) {
            e.printStackTrace();
        }

        argument.put("language_code", languageCode);
//        argument.put("script", script);
        argument.put("audio", audioContents);

        request.put("access_key", accessKey);
        request.put("argument", argument);

        URL url;
        Integer responseCode = null;
        String responBody = null;
        try {
            url = new URL(openApiURL);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("POST");
            con.setDoOutput(true);

            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
            wr.write(gson.toJson(request).getBytes("UTF-8"));
            wr.flush();
            wr.close();

            responseCode = con.getResponseCode();
            InputStream is = con.getInputStream();
            byte[] buffer = new byte[is.available()];
            int byteRead = is.read(buffer);
            responBody = new String(buffer);

            System.out.println("[responseCode] " + responseCode);
            System.out.println("[responBody]");
            System.out.println(responBody);
            
            String str = responBody;
            String[] split = str.split(":");
            score = split[4].replace("}", ""); //score 점수 값
            String[] split2 = split[3].split(","); //script값
            
            map.put("speechScore", score);
            map.put("speechScript", split2[0]);
            
            System.out.println("스피치 점수"+map.get("speechScore"));
            System.out.println("스피치 스크립트"+map.get("speechScript"));
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
      	return map;
    }
    
    
}
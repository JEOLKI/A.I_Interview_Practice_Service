<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>AI-Interview</title>

<link rel="stylesheet"
   href="https://cdn.jsdelivr.net/npm/animate.css@3.5.2/animate.min.css">
<script async="" src="https://www.google-analytics.com/analytics.js"></script>

<link href="/css/main.8acfb306.chunk.css" rel="stylesheet">
<style type="text/css">/* Chart.js */
/*
 * DOM element rendering detection
 * https://davidwalsh.name/detect-node-insertion
 */
@
keyframes chartjs-render-animation {from { opacity:0.99;
   
}

to {
   opacity: 1;
}

}
.chartjs-render-monitor {
   animation: chartjs-render-animation 0.001s;
}

/*
 * DOM element resizing detection
 * https://github.com/marcj/css-element-queries
 */
.chartjs-size-monitor, .chartjs-size-monitor-expand,
   .chartjs-size-monitor-shrink {
   position: absolute;
   direction: ltr;
   left: 0;
   top: 0;
   right: 0;
   bottom: 0;
   overflow: hidden;
   pointer-events: none;
   visibility: hidden;
   z-index: -1;
}

.chartjs-size-monitor-expand>div {
   position: absolute;
   width: 1000000px;
   height: 1000000px;
   left: 0;
   top: 0;
}

.chartjs-size-monitor-shrink>div {
   position: absolute;
   width: 200%;
   height: 200%;
   left: 0;
   top: 0;
}

</style>
</head>
<body>
   <noscript>You need to enable JavaScript to run this app.</noscript>
   <div id="root">
      <div class="ServiceIntro">
          <%@ include file="/WEB-INF/views/layout/header.jsp" %>
         <main>
         <section class="hero">
         <div class="hero__content">
            <div class="wrapper">
               <div class="content__title">
                  노트북 하나로<br> 면접 트레이닝을
               </div>
               <div class="content__description">
                  AI_INTERVIEW는 다른 앱이나 프로그램을 설치할 필요 없이<br>언제 어디서든 간편하게 면접 트레이닝이 가능한
                  서비스입니다.
               </div>
            </div>
            <div class="hero__img">
               <img src="/images/hero-laptop.99095523.png" alt="">
            </div>
         </div>
         </section> <section class="install chrome">
         <div class="content-box first">
            <div class="wrapper">
               <div class="message wow fadeInUp">집에서도 손쉽게 혼자서도 부담없이</div>
               <div class="sub-message wow fadeInUp">
                  다른 프로그램이나 앱을 다운로드할 필요 없이<br>크롬 브라우저와 PC 또는 노트북, 카메라(웹캠), 마이크만
                  있으면 가능합니다.
               </div>
               <div class="chrome-message wow fadeInUp">
                  <div class="text">다른 브라우저를 사용하고 계신가요?</div>
                  <a href="https://www.google.com/intl/ko/chrome"
                     class="chrome-link green" target="blank">크롬브라우저 설치하러 가기<img
                     src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAcAAAAMCAYAAACulacQAAAABHNCSVQICAgIfAhkiAAAAGhJREFUGFd10LERgCAMheEXWnUHmQQ3ESYTNnESHYIePUwBRKCD7z/gQphWC6UM4uUgFmHRHqAdgJcBffEgYBwEBTtBizmY9Qkig5Rci/zzA3gC4m0LCsiXMHaAcQAV0pbf+E9InlT7FwGRLZg1T12ZAAAAAElFTkSuQmCC"
                     alt="" class="dash"></a>
               </div>
               <div class="needs-flex">
                  <div class="area">
                     <div class="box">
                        <img src="/images/chrome.90ee9563.png" alt=""
                           class="chrome">
                     </div>
                     <div class="label">크롬 브라우저</div>
                  </div>
                  <div class="sep"></div>
                  <div class="area">
                     <div class="box">
                        <img src="/images/PC_laptop.ae8b563b.png" alt=""
                           class="pc">
                     </div>
                     <div class="label">PC/노트북</div>
                  </div>
                  <div class="sep"></div>
                  <div class="big-area">
                     <div class="ab-comment">* 대부분의 노트북에 기본 탑재되어 있습니다 *</div>
                     <div class="area">
                        <div class="box">
                           <img src="/images/camera_webcam.650627bc.png" alt=""
                              class="camera">
                        </div>
                        <div class="label">카메라(웹캠)</div>
                     </div>
                     <div class="sep"></div>
                     <div class="area">
                        <div class="box">
                           <img src="/images/stand_mic.f99d71f2.png" alt=""
                              class="mic">
                        </div>
                        <div class="label">마이크</div>
                     </div>
                  </div>
               </div>
            </div>
         </div>
         </section> <section class="laptops">
         <div class="content">
            <div class="wrapper">
               <div class="content__img">
                  <img src="/images/service-laptop1.959a0410.png" alt=""
                     class="laptop1">
               </div>
               <div class="content__textarea wow fadeInUp">
                  <div class="textarea__title">
                     질문을 만들고,<br> <b>나만의 면접</b>을 시작하세요.
                  </div>
                  <div class="textarea__description">
                     최대 5개의 질문을 만들어 모의 면접을 진행해보세요.<br>원하는 질문을 검색하거나 직접 작성할 수
                     있습니다.
                  </div>
               </div>
            </div>
         </div>
         <div class="content flip">
            <div class="wrapper">
               <div class="content__textarea wow fadeInUp">
                  <div class="textarea__title">
                     <b>인공지능</b>과의<br>모의 면접
                  </div>
                  <div class="textarea__description">
                     실전 면접처럼 준비하고 면접을 진행해보세요.<br>인공지능이 실시간으로 면접을 녹화하고 분석합니다.<br>표정,
                     시선, 발성, 말 빠르기, 답변 내용 등을 분석합니다.
                  </div>
               </div>
            </div>
            <div class="content__img">
               <img src="/images/notebook.121a50c8.png" alt="">
            </div>
         </div>
         <div class="content">
            <div class="wrapper">
               <div class="content__img">
                  <img src="/images/service-laptop2.e0680f4b.png" alt="">
               </div>
               <div class="content__textarea wow fadeInUp">
                  <div class="textarea__title">
                     한 눈에 보는<br> <b>면접 분석 리포트</b>
                  </div>
                  <div class="textarea__description">
                     인공지능이 분석한 다양한 결과를 확인해보세요.<br>녹화된 면접 영상을 보며 고쳐야 할 점을 학습해보고,<br>분석
                     결과를 다른 사람에게 공유해보세요.
                  </div>
               </div>
            </div>
         </div>
         <div class="content flip">
            <div class="wrapper">
               <div class="content__textarea wow fadeInUp">
                  <div class="textarea__title">
                     <b>데이터 기반</b>으로<br>면접 능력을 높이세요.
                  </div>
                  <div class="textarea__description">
                     지금까지 보았던 면접들을 기록하여 그래프로 나타냅니다.<br>얼마나 성장했고 부족했는지 확인해보세요.
                  </div>
               </div>
            </div>
            <div class="content__img">
               <img src="/images/service-laptop3.17676e1e.png" alt=""
                  class="laptop3">
            </div>
         </div>
         </section>
<!--          <section class="video-analyze"> -->
<!--          <div class="live-video"> -->
<!--             <div class="live-video__header-text wow fadeInUp"> -->
<!--                <div class="header-text__title">면접관들이 보는 나는 어떨까요?</div> -->
<!--                <div class="header-text__sub-title"> -->
<!--                   보다 나은 면접능력 향상을 위한 <span>AI_INTERVIEW만의 평가지표</span> -->
<!--                </div> -->
<!--             </div> -->
<!--             <div class="live-video__title wow fadeInUp">실시간 영상분석</div> -->
<!--             <div class="live-video__description wow fadeInUp"> -->
<!--                AI_INTERVIEW는 당신의 빠른 성장을 위해 답변중에 일어난 표정변화, 시선처리,<br>목소리 등 특이사항들을 핀포인트 -->
<!--                체크하여 수정 지침을 타임라인 코멘트로 표시합니다. -->
<!--             </div> -->
<!--             <div class="live-video__interviewing-area"> -->
<!--                <video src="/images/landing_interviewing.0f7284d7.webm" -->
<!--                   class="interviewing-area__interviewing" autoplay="" loop="">비디오 -->
<!--                태그를 지원하지 않는 브라우저입니다.</video> -->
<!--                <img src="/images/service-comment.f5af33af.svg" alt=""> -->
<!--             </div> -->
<!--          </div> -->
<!--          </section> -->
         <section class="analyze"> <img
            src="/images/pc-landing-circles-1.8c1a4b77.png" alt=""
            class="circle1"> <article class="analyze-index">
         <div class="analyze-index__content">
            <div class="content__title">3가지 분류 기준에 맞춘 상세분석</div>
            <div class="content__boxs">
               <div class="boxs__box">
                  <div class="wrapper">
                     <div class="box__icon">
                        <img src="/images/pc-face-icon-color.c76c2f59.png" alt="">
                     </div>
                     <div class="box__text">시각 분석</div>
                  </div>
               </div>
               <div class="boxs__box">
                  <div class="wrapper">
                     <div class="box__icon">
                        <img src="/images/pc-voice-icon-color.dad36204.png" alt="">
                     </div>
                     <div class="box__text">음성 분석</div>
                  </div>
               </div>
               <div class="boxs__box">
                  <div class="wrapper">
                     <div class="box__icon">
                        <img src="/images/pc-word-icon-color.2c2d7dcb.png" alt="">
                     </div>
                     <div class="box__text">언어 분석</div>
                  </div>
               </div>
            </div>
         </div>
         </article> <article class="analyze-visual">
         <div class="analyze-visual__content">
            <div class="content__header">
               <img
                  src="data:image/png;base64,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"
                  alt="" class="face-gray-icon">
               <div class="header__title">시각 분석</div>
               <div class="header__description">
                  면접관은 면접자의 답변내용만이 아닌 비언어적 신호에도 주목합니다.<br>AI_INTERVIEW가 제공하는 도표로 자신의
                  모습을 점검해 보세요.
               </div>
            </div>
            <div class="content__wrapper">
               <img src="/images/pc-face-graph.92ce679a.png" alt="">
               <div class="wrapper__text-area">
                  <div class="text-area__title wow fadeInUp">
                     <span>표정 상태</span> 도표화
                  </div>
                  <div class="text-area__description wow fadeInUp">
                     질문을 받고 답변하는 동안 나의 얼굴에 드러난 표정, 감정의 <br>분포를 긍정ㆍ부정ㆍ당황ㆍ무표정 4가지로
                     나누어 퍼센테<br>이지로 측정하여 보여줍니다.
                  </div>
               </div>
            </div>
            <div class="content__wrapper">
               <div class="wrapper__text-area">
                  <div class="text-area__title wow fadeInUp">
                     <span>시선분포</span> 도표화
                  </div>
                  <div class="text-area__description wow fadeInUp">
                     시선의 흐름을 추적하여 답변 중에 시선이 오래 머무른 곳과 <br>잠깐이라도 눈을 흘긴 곳을 좌표상에
                     표시합니다.
                  </div>
               </div>
               <img src="/images/pc-sight-graph.cbde8eff.png" alt=""
                  class="sight-graph">
            </div>
         </div>
         </article> <article class="analyze-voice">
         <div class="analyze-voice__content">
            <div class="content__header">
               <img
                  src="data:image/png;base64,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"
                  alt="" class="voice-gray-icon">
               <div class="header__title">음성 분석</div>
               <div class="header__description">
                  면접자의 안정적인 스피치 템포와 발성상태는 자신의 말하고자 하는 내용을<br>온전히 전달하는데 필수적인
                  요소입니다.
               </div>
            </div>
            <div class="content__wrapper">
               <div class="wrapper__speech-tempo-box">
                  <img src="/images/slide_speech-tempo.ba3b5210.svg" alt=""
                     class="speech-tempo-graph">
                  <div class="speech-tempo-box__text">
                     답변하신 내용은 <span>1분 23초 ~ 1분 36초</span><br>안에 이야기하시면 적당한
                     속도입니다.<br>다시 한 번 연습해 보세요!
                  </div>
               </div>
               <div class="wrapper__text-area">
                  <div class="text-area__title wow fadeInUp">
                     <span>스피치 템포</span> 시각화
                  </div>
                  <div class="text-area__description wow fadeInUp">
                     답변한 내용의 총 음절을 답변 시간으로 나누어 사람이<br>편안하게 들을 수 있는 기준 분당 음절 수에서
                     얼마나<br>느리고 빠른지 측정합니다.
                  </div>
               </div>
            </div>
            <div class="content__wrapper">
               <div class="wrapper__volume-graph-box">
                  <img src="/images/pc-volume.fc73dfb2.png" alt=""
                     class="volume-graph-box__volume-graph">
               </div>
               <div class="wrapper__text-area">
                  <div class="text-area__title wow fadeInUp">
                     <span>발성상태</span> 확인
                  </div>
                  <div class="text-area__description wow fadeInUp">
                     전체 답변 시간동안 나타난 음성의 크기가 사람이 편안하게 <br>들을 수 있는 기준 음량에서 얼마나 크고
                     작은지 측정합니다.
                  </div>
               </div>
            </div>
         </div>
         </article> <article class="analyze-word">
         <div class="analyze-word__content">
            <div class="content__header">
               <img
                  src="data:image/png;base64,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"
                  alt="" class="header__word-gray-icon">
               <div class="header__title">언어 분석</div>
               <div class="header__description">
                  풍부한 어휘 구사와 절제된 잉여표현은 당신을 더욱 프로페셔널한 사람으로 보이게 합니다.<br>AI_INTERVIEW와 함께
                  자신의 어휘구사 상태를 체크하고 답변 속에 드러난 인재상을 확인해 보세요.
               </div>
            </div>
            <div class="content__wrapper">
               <div class="wrapper__my-answer">
                  <div class="my-answer__title">
                     <span>STT(Speech To Text)</span>를 통한 답변내용 자동추출
                  </div>
                  <div class="my-answer__box">
                     <img src="/images/profile-circle.15f7caef.png" alt=""
                        class="box__profile-circle">
                     <div class="box__textarea">
                        <div class="textarea__title">나의 답변</div>
                        <div class="textarea__description">
                           아 저에게 있어 <span>행복</span>이라는 감정을 가지는 것은 2번째 문제라고 생각합니다. <span>행복</span>은
                           그 때 그 때의 상황에 따라 달라집니다. 음 보다 근본적으로 삶을 풍요롭게 하는 것은 <span>행복</span>이
                           아니라 의미라고 생각합니다. 음 사람마다 그것의 정의는 다르겠으나 살면서 가장 가치있는 쾌감을 느끼는 순간은 내가
                           무언가 의미있는 일을 해냈다는 기쁨을 얻었을 때일 것입니다.
                        </div>
                     </div>
                  </div>
               </div>
            </div>
            <div class="content__graphs">
               <div class="graphs__habit">
                  <div class="habit__box">
                     <div class="box__tap">
                        <div class="tap__habit">습관어</div>
                        <div class="tap__repeat">반복어</div>
                     </div>
                     <img
                        src="data:image/png;base64,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"
                        alt="" class="habit__habit-graph">
                  </div>
                  <div class="habit__title wow fadeInUp">
                     <span>습관어ㆍ반복어</span> 사용 체크
                  </div>
                  <div class="habit__description wow fadeInUp">
                     습관적으로 사용하는 음성적 잉여표현과<br>문장 구성에 반복적으로 사용하는 단어를 감지하여 보여줍니다.
                  </div>
               </div>
               <div class="graphs__talent">
                  <div class="talent__box">
                     <img src="/images/pc-talent-graph.8b60dfb8.png" alt=""
                        class="box__talent-graph">
                  </div>
                  <div class="talent__title wow fadeInUp">
                     답변속에 나타난 <span>인재상</span> 체크
                  </div>
                  <div class="talent__description wow fadeInUp">
                     답변에 사용한 단어의 경향을 파악하여<br>답변에 드러난 면접자의 인재상을 그래프로 나타냅니다.
                  </div>
               </div>
            </div>
         </div>
         </article></section>
       
       
       <%@ include file="/WEB-INF/views/layout/footer.jsp" %>
       
         
         </main>
      </div>
   </div>
</body>
</html>
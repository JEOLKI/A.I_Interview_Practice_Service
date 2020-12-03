<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>AI_Interview</title>

<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
<script>
$(document).ready(function() {
	console.log("aa")
	console.log(1234)
	planListAjax();
	
});

function planListAjax(){
	
	$.ajax({url : "/plan/planListAjax.do",
		method : "get",
		dataType : "json",
		success : function(data){
			console.log(1234)
			console.log(data)
			var html = "";
			for(var i = 0; i< data.planList.length ; i++){
				var plan = data.planList[i];                                                    
				html +=	' <div class="box">                                                             '        ;
				html +=	' <div class="PaymentBox">                                                     '        ;
				html +=	'	<img src="/images/요금제이미지.png" alt="" class="bg">                         '           ;
				html +=	'	<div class="content-body">                                                  '        ;
				html +=	'		<div class="title sprint">'+plan.planNm+'</div>                                  '          ;
				html +=	'		<div class="price-area">                                                '        ;
				html +=	'			<div class="date-num">                                              '        ;
				html +=	'				<span>'+plan.planPeriod+'</span>일 이용권                                    '    ;
				html +=	'			</div>                                                              '        ;
				html +=	'			<div class="price-num"> ₩'+ plan.planPrice+'/'+plan.planPeriod +'<br>';
				html +=	'					 <span class="price">'+plan.fmtPlanPrice+'</span>                   '     ;
				
				html +=	'				<span class="original-price"></span>                              '        ;
				html +=	'			</div>                                                              '        ;
				html +=	'			<div class="func-message">무제한 면접 연습, 분석 제공</div>                 '           ;
				html +=	'		</div>                                                                  '        ;
				html +=	'		<div class="marketing-message">                                         '        ;
				html +=	'			<div class="point"></div>                                           '        ;
				html +=	'			<div class="txt">'+plan.planExplain+' </div>                                '    ;
				html +=	'		</div>                                                                  '        ;
				html +=	'	</div>                                                                      '        ;
				html +=	' </div>                                                                        '        ;
				html +=	"<button class='sprint' onclick=\"location.href='/plan/update.do?planSq="+plan.planSq+"'\">삭제하기</button>";
				html += '</div>            <br>               <br><br>                                              ';
			};
			$("#listajax").html(html);
		}
	})
	
}




</script>

<style>
#registDateNum{
	width : 50px;
	height : 50px; 
	font-size: 0.5em;
}
#registPrice{
	width : 100px;
}
#registTitle{
	width : 210px;
}
#registBtn{
	background-color: black;
}
.deleteBtn{
	background-color: black;
}
#verticalLine{
	border: 0.5px dotted black;
	margin: 0px 30px;
}
.box{
	display: inline-block;
}
#Nm{
	width : 180px;
}
.body{
	margin : 30px;
}
.down {
	text-align: center;
}

</style>

</head>
<body>
   <div id="root">
   	<div class="Main false">
        <%@ include file="/WEB-INF/views/layout/header.jsp" %>
<%--         <%@ include file="/WEB-INF/views/manage/managerleft.jsp" %> --%>
      <div class="Payment">
      
         <section class="hero">
			<div class="hero__content">
				<div class="content__title">요금제 관리</div>
			</div>
		</section>
		
         <div class="body">
         	<div class= "down">
           <a class= "down" href="/plan/planExcel.do">↓ 목록 내려받기</a>
           </div>
            <div class="payment-flex">
            
            <form action="/plan/create.do" method="post">
            	<div class="box">
                  <div class="PaymentBox">
                     <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAQwAAAHXCAYAAABJdWR/AAAABHNCSVQICAgIfAhkiAAAHRtJREFUeF7t3XuQXndZwPHnd37nvJe9dNPSNCVNLYRSHTMIhQq1LZo6XGqHWMqYgKhjkT9kRGBAERkFV7xUBhgQGYeRQUYduSRTaklpAZWGS2tBOgV01SkllmlaaFKbpns573vO+Z2f826SNmlz2z49ye55vh2QmXTz5DyfZ/3Ou5ckTk7gnxjjK0XkL0Tkx0/gzXkTBBBYWQIzIvJ259zNx3tsd7w3GP37GOOPRGTNibwtb4MAAitS4G7n3LOP9+QnGox4vEH8ewQQWNkCzrnj9uC4b3DgFQbBWNnvCzw9AscVIBjHJeINEEDgoADB4H0BAQROWEAbjEc/XIkx1if8q/KGCCCwIgWcc8khD37ET0Mc7XMYB3582snmGRe3bq1WpAAPjQACJyzgtmxJZduGKDJ9MBZPiMaRgnFYLGTPHhdvuaU84V+VN0QAgRUp4C6/PJPVq+OxovH4YDwWi407Epm9wMlZ9ybxppsGK1KAh0YAgRMWcFde2ZPd59YyeVeUHRvrI73SOEIw9n8YIjtPT2TyLr/moY7/0Xe+OHfCvypviAACK1Lg7Oe+fOKBM4ogsxcEWb+3PuSVxqMfmhwhGJsT2bjHSb/v5b6Qnp7V6UPf+ueHV6QAD40AAicscMZFL121t0wqOcdXkudBdqyOIttGX/A4YjCcyIFXFzPi102JX6jnsjL2ske+8dkHT/hX5Q0RQGBFCpz2oledmblBOZZMlLv2SZANEmTbtlEsDv5XDn2F4WR62smOHcn5u/p+37o8K6rxrCp9Z+72G0a/l4R/EECgxQITF191dpqFojdWFpM7fXX3ujzIxo21TC9+1WTxVcYTg7F9u3/G5KSfK0/LhoPY7XRi98Hbtu9qsROrIYCAiJx5yaZ1ReGG3Z4bTmSPlPfMzgbZtCkcOxhbZ9J1U7v8fDHeKdKxXietuw99ffsPEEUAgXYLnHHZpvOKKhl2qoXBeGe+2LVvXZAtG6qjB2Pz5kRmxK/tD9KFSd8p54te6nz/4W98bme7qdgOAQRWvegX11cx5Nl4ZzA2G4r781514PMYj37i8/APSUbBuHMuXTuV+vl+3S2j72cu9B7+2o3fhxMBBNotsOrFr3hWGf0gcyEfz5Ph/fuqIBdOVLLtsa+UHDEYa8ZCmo+7bpV0e1lM+g/fev3d7aZiOwQQWHXp1eeXrs7Tejjoz8fhAwu+WlIwSsn6mST9fbfd8D04EUCg3QJTl1z17FLqPJMyJxjtvjXbIaAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBg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" alt="" class="bg">
                     <div class="content-body">
                     
                       <input type="text" id="Nm" class="title sprint" name="planNm"  placeholder="명칭을 입력해주세요" >
                         
                        <div class="price-area">
                           <div class="date-num">
                              <span><input id="registDateNum" type="text" name="planPeriod" ></span>일 이용권
                           </div>
                           <div class="price-num">
                              <!-- ₩ 5,900 / 1일 --><br> <span class="price">₩ <input id="registPrice" name="planPrice" type="text" placeholder="금액"></span>
                              <span class="original-price"></span>
                           </div>
                           <div class="func-message">무제한 면접 연습, 분석 제공<br>VAT 포함
                           </div>
                        </div>
                        <div class="marketing-message">
                           <div class="point"></div>
                           <div class="txt"><input id="registMessage" type="text" name="planExplain" placeholder="설명을 입력해주세요"></div>
                        </div>
                     </div>
                  </div>
                  <button id="registBtn" type="submit">등록하기</button>
              	 </div>
              	 </form>
              	 
              	    <div id="verticalLine" class="box">
               </div>
               
                
               <a href="/plan/planUseExcel.do">↓ 목록 내려받기</a> 
               <div id = "listajax">
               
               </div>
               
               
               <div class="box">
                  <div class="PaymentBox">
                     <img src="data:image/png;base64,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gGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBg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" alt="" class="bg">
                     <div class="content-body">
                        <div class="title marathon">마라톤</div>
                        <div class="price-area">
                           <div class="date-num">
                              <span>5</span>일 이용권
                           </div>
                           <div class="price-num">
                              ₩ 4,180 / 1일<br> <span class="price">₩ 20,900</span><span
                                 class="original-price">29,500</span>
                           </div>
                           <div class="func-message">
                              무제한 면접 연습, 분석 제공<br>VAT 포함
                           </div>
                        </div>
                        <div class="marketing-message">
                           <div class="point"></div>
                           <div class="txt">취업은 마라톤! 꾸준하고 오랜 노력을 이길것은 없습니다.</div>
                        </div>
                     </div>
                  </div>
                  <button class="deleteBtn"
                     onclick="location.href='${cp }/plan/deletePlan'">삭제하기</button>
               </div>
               
               <div class="box">
                  <div class="PaymentBox">
                     <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAQwAAAHXCAYAAABJdWR/AAAABHNCSVQICAgIfAhkiAAAHRtJREFUeF7t3XuQXndZwPHnd37nvJe9dNPSNCVNLYRSHTMIhQq1LZo6XGqHWMqYgKhjkT9kRGBAERkFV7xUBhgQGYeRQUYduSRTaklpAZWGS2tBOgV01SkllmlaaFKbpns573vO+Z2f826SNmlz2z49ye55vh2QmXTz5DyfZ/3Ou5ckTk7gnxjjK0XkL0Tkx0/gzXkTBBBYWQIzIvJ259zNx3tsd7w3GP37GOOPRGTNibwtb4MAAitS4G7n3LOP9+QnGox4vEH8ewQQWNkCzrnj9uC4b3DgFQbBWNnvCzw9AscVIBjHJeINEEDgoADB4H0BAQROWEAbjEc/XIkx1if8q/KGCCCwIgWcc8khD37ET0Mc7XMYB3582snmGRe3bq1WpAAPjQACJyzgtmxJZduGKDJ9MBZPiMaRgnFYLGTPHhdvuaU84V+VN0QAgRUp4C6/PJPVq+OxovH4YDwWi407Epm9wMlZ9ybxppsGK1KAh0YAgRMWcFde2ZPd59YyeVeUHRvrI73SOEIw9n8YIjtPT2TyLr/moY7/0Xe+OHfCvypviAACK1Lg7Oe+fOKBM4ogsxcEWb+3PuSVxqMfmhwhGJsT2bjHSb/v5b6Qnp7V6UPf+ueHV6QAD40AAicscMZFL121t0wqOcdXkudBdqyOIttGX/A4YjCcyIFXFzPi102JX6jnsjL2ske+8dkHT/hX5Q0RQGBFCpz2oledmblBOZZMlLv2SZANEmTbtlEsDv5XDn2F4WR62smOHcn5u/p+37o8K6rxrCp9Z+72G0a/l4R/EECgxQITF191dpqFojdWFpM7fXX3ujzIxo21TC9+1WTxVcYTg7F9u3/G5KSfK0/LhoPY7XRi98Hbtu9qsROrIYCAiJx5yaZ1ReGG3Z4bTmSPlPfMzgbZtCkcOxhbZ9J1U7v8fDHeKdKxXietuw99ffsPEEUAgXYLnHHZpvOKKhl2qoXBeGe+2LVvXZAtG6qjB2Pz5kRmxK/tD9KFSd8p54te6nz/4W98bme7qdgOAQRWvegX11cx5Nl4ZzA2G4r781514PMYj37i8/APSUbBuHMuXTuV+vl+3S2j72cu9B7+2o3fhxMBBNotsOrFr3hWGf0gcyEfz5Ph/fuqIBdOVLLtsa+UHDEYa8ZCmo+7bpV0e1lM+g/fev3d7aZiOwQQWHXp1eeXrs7Tejjoz8fhAwu+WlIwSsn6mST9fbfd8D04EUCg3QJTl1z17FLqPJMyJxjtvjXbIaAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBgR4Bg2Lk1myKgFiAYakIGIGBHgGDYuTWbIqAWIBhqQgYgYEeAYNi5NZsioBYgGGpCBiBg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" alt="" class="bg">
                     <div class="content-body">
                        <div class="title marathon">마라톤</div>
                        <div class="price-area">
                           <div class="date-num">
                              <span>5</span>일 이용권
                           </div>
                           <div class="price-num">
                              ₩ 4,180 / 1일<br> <span class="price">₩ 20,900</span><span
                                 class="original-price">29,500</span>
                           </div>
                           <div class="func-message">
                              무제한 면접 연습, 분석 제공<br>VAT 포함
                           </div>
                        </div>
                        <div class="marketing-message">
                           <div class="point"></div>
                           <div class="txt">취업은 마라톤! 꾸준하고 오랜 노력을 이길것은 없습니다.</div>
                        </div>
                     </div>
                  </div>
                  <button class="deleteBtn"
                     onclick="location.href='${cp }/plan/deletePlan'">삭제하기</button>
               </div>
              	 
              	 
              	 
              </div>
              <br>
              <br>
              
               <hr>
               
<!--                	<div class="payment-flex" id = "listajax"> -->
				
<!-- 				</div>	 -->
				
				
		<div class="lower">
					<div class="notice">
						<div class="title ex" >이용권 유의사항</div>
							<div class="ex">
							- 해당 이용권은 PC에서 무제한으로 면접을 수행할 수 있는 이용권입니다.
							<br>- 녹화 및 분석된 면접 영상은 인터넷이 연결된 환경에서 얼마든지 볼 수 있습니다.
							<br>- 구입하신 이용권은 마이 페이지에서 확인할수 있습니다.<br>- 본 이용권의 금액은 부가세 10%가 포함되어 있는 금액입니다.<br>- 본
							이용권은 이용 시작일(구매일) 기준 7일 이내 청약철회 가능한 이용권입니다.<br>&ensp;단, 이용
							내역이 있는 경우 이용 금액 공제 후 환불합니다.<br>- 이용 시작일(구매일) 기준 7일 경과 후에는
							*이용 금액 공제 후 해지 가능합니다.<br>*이용 금액은 이미 경과된 시간(실제 사용 여부 불문)에
							상응하는 금액을 말합니다.<br>- 미성년자가 법정대리인 동의 없이 구매를 한 경우,법정대리인이 이를 취소할 수 있습니다.<br>
							</div>
						</div>
				</div>
				</div>
				<footer class="SemiFooter --undefined">
			</footer>
		</div>
		</div>
	</div>
   
</body>
</html>
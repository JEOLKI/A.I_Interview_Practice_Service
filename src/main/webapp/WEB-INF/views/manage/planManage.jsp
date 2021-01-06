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
	planListAjax();
	
	$('#registDateNum').on('input',function(){
		if(/[^0-9]/.test($("#registDateNum").val())){
			let str = $('#registDateNum').val();
			let edit = str.replace(/[^0-9.]/g,'');
			$('#registDateNum').val(edit);
		}
	})
	
	$('#registPrice').on('input',function(){
		if(/[^0-9]/.test($("#registPrice").val())){
			let str = $('#registPrice').val();
			let edit = str.replace(/[^0-9.]/g,'');
			$('#registPrice').val(edit);
		}
	})
	
	$("#registBtn").on("click", function(){
		var price = $("#registPrice").val();
		var date = $("#registDateNum").val();
		var Nm = $("#Nm").val();
		var message = $("#registMessage").val();
		var createForm = document.createForm;

		if(Nm == null || Nm == ""){
			alert("명칭을 입력해주세요")
		}
		else if(date == null || date == ""){
			alert("날짜를 입력해주세요")
		}
		else if(price == null || price == ""){
			alert("가격을 입력해주세요")
		}
		else if(message ==null || message == ""){
			alert("메시지를 입력해주세요")
		}else{
// 			$("#registBtn").submit(); 
			createForm.submit();
		}
	})
});

function planListAjax(){
	
	$.ajax({url : "/plan/planListAjax.do",
		method : "get",
		dataType : "json",
		success : function(data){
			console.log(1234)
			console.log(data)
			var html = "";
			var planClass = ['sprint', 'half', 'marathon']
			for(var i = 0; i< data.planList.length ; i++){
				var plan = data.planList[i];      
				
				html +=	' <div class="box">                                                             '        ;
				html +=	' <div class="PaymentBox">                                                     '        ;
				html +=	'	<img src="/images/요금제이미지.png" alt="" class="bg">                         '           ;
				html +=	'	<div class="content-body">                                                  '        ;
				html +=	'		<div class="title '+planClass[i]+'">'+plan.planNm+'</div>                                  '          ;
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
				html +=	"<button class='deleteBtn "+planClass[i]+"' onclick=\"location.href='/plan/update.do?planSq="+plan.planSq+"'\">삭제하기</button>";
				html += '<br>'
				html +=	' </div>                                                                        '        ;
				html += '</div>';
			};
			
			$("#listajax").html(html);
		}
	})
	
}

</script>

<style>

	body{
		background-color : #f5f7fb;
		padding: 30px;
	}

	#registDateNum{
		width : 70px;
		height : 50px; 
		font-size: 0.5em;
		text-align: center;
	}
	
	#registPrice{
		width : 145px;
		text-align: center;
	}
	
	#registTitle{
		width : 210px;
	}
	
	#registBtn, .deleteBtn{
		background-color: #000d22;
	}
	
	
	#verticalLine{
		border: 0.5px dotted black;
		margin: 0px 30px;
	}
	#registMessage{
		text-align: center;
	}
	
	.box{
		display: inline-block;
	}
	
	#Nm{
		width : 180px;
		text-align: left;
		color: black;
	}
	
	.contentBox{
		width: auto;
		padding: 20px 30px;
		background-color: white;
		border-radius: 10px;
		margin: 10px 0px;
		box-shadow: 5px 5px #EAEAEA;
		display: inline-block;
		float: left;
	}
	
	.excelBtn{
		display: inline-block;
		border: 1px solid #000d22;
		border-radius: 5px;
		padding: 1px 5px;
	}
	
	.excelBtn:hover{
	    background-color: #22741C;
	    border: 1px solid #22741C;
	    color: #fff;
	}
	input{
		border-radius: 5px;
		border: 1px solid black;
		
	}
	
</style>

</head>
<body>
	
	<h1>요금제 관리</h1>
	
	<div class="contentBox">
		<h3>요금제 목록</h3>
		
		<a class="excelBtn" href="/plan/planExcel.do">↓ excel 다운로드</a>  
		
		<div class="Payment" style="margin-top: 20px;">
			<div class="body" style="padding: 0px; width: 100%; background: white;">
				<div class="payment-flex"  style= "width : 100%; margin: 0px;" >
				
					<form name="createForm" action="/plan/create.do" method="post">
						<div class="box">
							<div class="PaymentBox">
							
								<img src="/images/요금제이미지.png" alt="" class="bg">
								
								<div class="content-body">
	                    
	                      				<input type="text" id="Nm" class="title sprint" name="planNm"  placeholder="명칭을 입력해주세요" >
	                        
		               			<div class="price-area">
		                  				<div class="date-num">
		                     				<span><input id="registDateNum" type="text" name="planPeriod" maxlength="4"></span>일 이용권
		                  				</div>
		                  				
		                  				<div class="price-num">
		                    				<br>
		                    				<span class="price">₩ <input id="registPrice" name="planPrice" type="text" placeholder="금액"></span>
		                  				</div>
		                  				
		                  				<div class="func-message">무제한 면접 연습, 분석 제공</div>
		               			</div>
		                       			
		               			<div class="marketing-message">
		               				<div class="point"></div>
									<div class="txt"><input id="registMessage" type="text" name="planExplain" placeholder="설명을 입력해주세요"></div>
		               			</div>
		                       			
								</div>
		                    			
								<button id="registBtn" type="button">등록하기</button>
		                				
							</div>
						</div>
	       	 		</form>
	           	 
	           	    <div id="verticalLine" class="box"></div>
	            
	            	<div id="listajax" style="width : 100%; background: transparent;">
	              	 
					</div>
					
				</div>
			</div>
		</div>
   </div>
</body>
</html>
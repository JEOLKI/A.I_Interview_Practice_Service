<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>


<title>Insert title here</title>
<style>
	.row{
		display:flex;
		flex-wrap:wrap;
		margin-right:-.75rem;
		margin-left:-.75rem
	}
	.col-xl-3{
 		position:relative; 
		width:100%;
		padding-right:.75rem;
		padding-left:.75rem;
		flex:0 0 25%;max-width:25%
	}
	.col-md-6{
		flex:0 0 50%;
		max-width:50%
		}
	.mb-4{
		margin-bottom:1.5rem!important;
	}
	.card{position:relative;display:flex;flex-direction:column;min-width:0;word-wrap:break-word;background-color:#fff;background-clip:border-box;border:1px solid #e3e6f0;border-radius:.35rem}
	.card-body{flex:1 1 auto;min-height:1px;padding:1.25rem;}
	.no-gutters{margin-right:0;margin-left:0}
	.no-gutters>.col,.no-gutters>[class*=col-]{padding-right:0;padding-left:0}
	.border-left-info{border-left:.25rem solid #36b9cc!important}
	.border-left-primary{border-left:.25rem solid #4e73df!important}
	.border-left-success{border-left:.25rem solid #1cc88a!important}
	.border-left-warning{border-left:.25rem solid #f6c23e!important}
	.align-items-center{align-items:center!important}
	.mr-2{margin-right:.5rem!important}
	.col, .col-auto{position:relative;width:100%;padding-right:.75rem;padding-left:.75rem}
	.text-gray-300{color:#dddfeb!important}
	.text-xs{font-size:.7rem}
	.mb-1{margin-bottom:.25rem!important}
	.mb-0{margin-bottom:0!important}
	.h5{margin-top:0;margin-bottom:.5rem}
	.text-success{color:#1cc88a!important}
	.py-2{padding-top:.5rem!important}
	
	
	.managerbox{
		margin-top: 100px;
        margin-left: 250px;
        width: 85%;
        height: 750px;
        border: none;
	}
	
	body{
		background-color : #f5f7fb;
	}
	
</style>
</head>
<body>

	<%@ include file="/WEB-INF/views/layout/header.jsp" %>
	
	<%@ include file="/WEB-INF/views/manage/manageLeft.jsp" %>
	
	<iframe class="w3-container managerbox" name="manage_content" src="/scriptGubun/retrievePagingList.do"></iframe>
	
</body>
</html>


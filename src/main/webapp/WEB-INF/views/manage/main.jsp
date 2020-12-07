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
</style>
</head>
<body>

	<%@ include file="/WEB-INF/views/layout/header.jsp" %>
	
	<%@ include file="/WEB-INF/views/manage/managerleft.jsp" %>
	
	<div class="w3-container contentbox" style="margin-left: 200px">
		<div class="row">
                        <!-- Earnings (Monthly) Card Example -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-primary shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">월 매출</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">$40,000</div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-calendar fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Earnings (Monthly) Card Example -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-success shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">연 매출</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">$215,000</div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

<!--                         Earnings (Monthly) Card Example -->
<!--                         <div class="col-xl-3 col-md-6 mb-4"> -->
<!--                             <div class="card border-left-info shadow h-100 py-2"> -->
<!--                                 <div class="card-body"> -->
<!--                                     <div class="row no-gutters align-items-center"> -->
<!--                                         <div class="col mr-2"> -->
<!--                                             <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Tasks -->
<!--                                             </div> -->
<!--                                             <div class="row no-gutters align-items-center"> -->
<!--                                                 <div class="col-auto"> -->
<!--                                                     <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">50%</div> -->
<!--                                                 </div> -->
<!--                                                 <div class="col"> -->
<!--                                                     <div class="progress progress-sm mr-2"> -->
<!--                                                         <div class="progress-bar bg-info" role="progressbar" style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div> -->
<!--                                                     </div> -->
<!--                                                 </div> -->
<!--                                             </div> -->
<!--                                         </div> -->
<!--                                         <div class="col-auto"> -->
<!--                                             <i class="fas fa-clipboard-list fa-2x text-gray-300"></i> -->
<!--                                         </div> -->
<!--                                     </div> -->
<!--                                 </div> -->
<!--                             </div> -->
<!--                         </div> -->

<!--                         Pending Requests Card Example -->
<!--                         <div class="col-xl-3 col-md-6 mb-4"> -->
<!--                             <div class="card border-left-warning shadow h-100 py-2"> -->
<!--                                 <div class="card-body"> -->
<!--                                     <div class="row no-gutters align-items-center"> -->
<!--                                         <div class="col mr-2"> -->
<!--                                             <div class="text-xs font-weight-bold text-warning text-uppercase mb-1"> -->
<!--                                                 Pending Requests</div> -->
<!--                                             <div class="h5 mb-0 font-weight-bold text-gray-800">18</div> -->
<!--                                         </div> -->
<!--                                         <div class="col-auto"> -->
<!--                                             <i class="fas fa-comments fa-2x text-gray-300"></i> -->
<!--                                         </div> -->
<!--                                     </div> -->
<!--                                 </div> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                     </div> -->
	
	</div>
	</body>
</html>


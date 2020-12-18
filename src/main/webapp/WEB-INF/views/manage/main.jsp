<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
<title>AI_INTERVIEW</title>

<style type="text/css">

	.managerbox{
		margin-top: 60px;
        margin-left: 200px;
        width: 90%;
        height: 830px;
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
	
	<iframe class="w3-container managerbox" name="manage_content" src="/login/manageStatistic.do"></iframe>
	
</body>
</html>


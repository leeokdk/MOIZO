<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    	<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/inc/header.jsp" %>
<meta charset="UTF-8">
<title>Teaming</title>
<style type="text/css">
div ul li{
	list-style: none;
}
a {text-decoration:none;}

#myTabContent {    width: 85%;
    height: 80%;
}

#myTabContent div {    
    height: 100%;
}
#profile {
height: 100%;}

#id_iframe {
width: 100%;
    height: 100%;
}
</style>
</head>
<body>	
<%@include file="/WEB-INF/inc/top.jsp" %>
<!-- <ul class="nav flex-column">
  <li class="nav-item">
    <a class="nav-link active" aria-current="page" href="#">유저 관리</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="#">모임 관리</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="#">공지사항 관리</a>
  </li>
</ul> -->

		<!-- 탭 화면 구성 -->
		<div class="moimTab" >
		<ul class="<!-- nav nav-tabs --> nav flex-column" id="myTab" role="tablist" >
			<li class="nav-item" id="tab1" role="presentation">
				<a class="nav-link active" id="home-tab" data-bs-toggle="tab"
					data-bs-target="#home" type="a" role="tab"
					aria-controls="home" aria-selected="true" style="cursor: pointer;">모임 관리</a>
			</li>
			<li class="nav-item" role="presentation" id="tab2">
				<a class="nav-link" id="profile-tab" data-bs-toggle="tab"
					data-bs-target="#profile" type="a" role="tab"
					aria-controls="profile" aria-selected="false" style="cursor: pointer;">유저 관리</a>
			</li>
			<li class="nav-item" role="presentation" id="tab3">
				<a class="nav-link" id="contact-tab" data-bs-toggle="tab"
					data-bs-target="#contact" type="a" role="tab"
					aria-controls="contact" aria-selected="false" style="cursor: pointer;">공지사항 관리</a>
			</li>
		</ul>
		
		
		<div class="tab-content" id="myTabContent" style="position: fixed; top: 13%; left: 13%;" >
			<div class="tab-pane fade show active" id="home" role="tabpanel"
				aria-labelledby="home-tab">
				<iframe src="moimListForAdmin" id="id_iframe"></iframe>
			</div>
			<div class="tab-pane fade" id="profile" role="tabpanel"
				aria-labelledby="profile-tab">
				<iframe src="userList"  id="id_iframe"></iframe>
				</div>
			<div class="tab-pane fade" id="contact" role="tabpanel" 
				aria-labelledby="contact-tab">
				<iframe src="noticeListForAdmin" id="id_iframe"></iframe>
				</div>
		</div>

	</div>
</body>
<%-- <script type="text/javascript">
	$(function() {
		
		$("#myTabContent").load("noticeList"); // 모임 소개

		$("ul#myTab li").click(function() {
			$("ul#myTab li").removeClass("active");
			$(this).addClass("active");

			var activeTab = $(this).attr("id");
			/* 	$("#" + activeTab).fadeIn(); */

			if (activeTab == "tab1") {
				$("#myTabContent").load("<%=request.getContextPath()%>/moim/moimView?moimCode=TR21");  // 모임소개
			} else if (activeTab == "tab2") {
				$("#myTabContent").load("<%=request.getContextPath()%>/moim/moimView?moimCode=TR22");  // 모임소개
			} else if (activeTab == "tab3") {
				$("#myTabContent").load("<%=request.getContextPath()%>/moim/moimView?moimCode=TR23");  // 모임소개
			}
		});
		//fn_mNotice_list();
	});
</script>
 --%>
</html>
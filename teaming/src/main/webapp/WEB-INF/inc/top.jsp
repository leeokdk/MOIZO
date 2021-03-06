<%@page import="java.util.Map"%>
<%@page import="com.moim.vo.LoginVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
a{color: black;}
</style>


<nav class="navbar navbar-expand-lg navbar-light bg-white" style="top-margin: 0px; top-padding: 0px; width: 100%; border-bottom: 1px solid #e6e6e6; margin-bottom: 3%;"  id="navbar" >
  <div class="container-fluid" >
    <a href="<%=request.getContextPath() %>/"><img src="<%=request.getContextPath()%>/resource/images/teaming_logo.png" class="navbar-brand" width="45" ></a>
 	<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button> 
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="<%=request.getContextPath() %>/">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" aria-current="page" href="<%=request.getContextPath() %>/admin/noticeList">전체 공지 게시판</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="<%=request.getContextPath() %>/moim/moimList">모임 리스트(검색)</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="<%=request.getContextPath() %>/moim/moimMake">모임 생성하기</a>
        </li>
      </ul>
    </div>
      <ul class="nav justify-content-end">
         	<%
         		Map<String , LoginVO> userInfoMap = (Map<String , LoginVO>)session.getValue("USER_INFO");
         		LoginVO userInfo = new LoginVO();
         		if(userInfoMap == null){
         	%>
           <li class="nav-item">
           <a class="nav-link" href="<%=request.getContextPath() %>/login/login">로그인</a></li>
            <li class="nav-item">
            <a class="nav-link" href="<%=request.getContextPath() %>/join/join">회원가입</a></li>
            <% 
         		}else{		// user_info 세션이 있다면				/* ${sessionScope.USER_INFO.userName} */
		         	userInfo = userInfoMap.get("NOPE");
		         	request.setAttribute("userInfoMap", userInfoMap);
	         		request.setAttribute("userInfo", userInfo);
       		%>
       		<!-- 매니저일 때 관리 페이지로 가기 -->
	         	<c:if test="${userInfo.roleName eq 'admin' }">
	         		<li class="nav-item" style="margin-top: 2.8%; text-align: center; padding-right:20px;"><a href="<%=request.getContextPath() %>/admin/admin">  관리  </a></li>
	         	</c:if>
       			<%-- ${LoginVO userInfo = sessionScope.USER_INFO; } --%>
       		<c:if test="${userInfo.userPic eq 'default'}">
      				<img alt="" src="<%=request.getContextPath() %>/resource/images/join/defaultProfile.png" width="45px" height="45px" style="border-radius: 50%; ">
       		</c:if>
       		<c:if test="${userInfo.userPic ne 'default' }">
		          	<img alt="" src="/img<%=userInfo.getUserPic()%>" width="45px" height="45px" style="border-radius: 50%;">
       		</c:if>
				<li class="nav-item dropdown"><!-- img = home/pc13/upload,,, userProfile/seulgiprofile -->
					<a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-expanded="false" style ="color: black;"><%=userInfo.getUserName()%>님 환영합니다.<span class="caret"></a>
					<ul class="dropdown-menu" style="position:fixed; top:68px; left:1720px" >
						<li><a
							href="<%=request.getContextPath() %>/user/info?userId=<%=userInfo.getUserId()%>">
								&nbsp;&nbsp;My page </a></li>
						<li><a
							href="<%=request.getContextPath() %>/moim/moimUser?userId=<%=userInfo.getUserId()%>">
								&nbsp;&nbsp;My moim </a></li>
						<li><hr class="dropdown-divider"></li>
						<li><a href="<%=request.getContextPath()%>/login/logout">
								&nbsp;&nbsp;LOGOUT </a></li>
					</ul>
				</li>		
       		<%
         		}
         	%>
          </ul>
  </div>
</nav>

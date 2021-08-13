<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    	<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">

<%@include file="/WEB-INF/inc/header.jsp" %>
<meta charset="UTF-8">
<title>SoMoim</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Batang&display=swap" rel="stylesheet">

<style type="text/css">
body,html {font-family: 'Gowun Batang', serif;}
a {text-decoration:none;}
</style>
</head>
<body>		
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<%@include file="/WEB-INF/inc/top.jsp" %>

<script type="text/javascript">
<!-- 로그인 관련 -->
<!-- 로그인 관련 -->
if(${not empty check}){
	if(${check.equals('n')}){
		Swal.fire({
			  position: 'top-end',
			  icon: 'error',
			  title: '${fail}',
			  showConfirmButton: false,
			  timer: 1500
			});
	}else if(${check.equals('y')}){
		Swal.fire({
			  position: 'top-end',
			  icon: 'success',
			  title: '${success}',
			  showConfirmButton: false,
			  timer: 1500
			});
	}
}

</script>


	<div class="container" style="padding-right: 10%; padding-left: 10%;">
		<h3 style="margin-bottom: 4%;">상세보기</h3>
		<table class="table">
			<tbody>
				<tr>
					<th scope="row" class="label" for="profile">Profile</th>
					<td style="color: #6c757d; border-radius: 1rem; width:150px; height: 150px" for="profile">
						<div style="width:200px; height:200px; ">
							<c:if test="${userInfo.userPic eq 'default'}">
			      				<img alt="" src="<%=request.getContextPath() %>/resource/images/join/defaultProfile.png" width="200px" height="200px">
			       			</c:if>
			       		<c:if test="${userInfo.userPic ne 'default' }">
					          	<img alt="" src="/img<%=userInfo.getUserPic()%>"width="200px" height="200px" >
			       		</c:if>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row">아이디</th>
					<td>${user.userId }</td>
				</tr>
				<tr>
					<th scope="row"h>회원명</th>
					<td>${user.userName }</td>
				</tr>
					<input type="hidden" value="${user.userPassword }">
				<tr>
					<th scope="row">자기소개 글</th>
					 <td>${user.userIntroduce }</td>
				</tr>
				<tr>
					<th scope="row">이메일</th>
					<td>${user.userEmail }</td>
				</tr>
				<tr >
					<th scope="row">취미</th>
					<td>
						${user.userHobbyNm }
					</td>
				</tr>
				<tr >
					<th scope="row">성별</th>	
					<c:if test="${user.userGender eq 'M' }">
						<td>남자</td>
					</c:if>
					<c:if test="${user.userGender eq 'F' }">
						<td>여자</td>
					</c:if>
				</tr>
				<tr>
					<th scope="row">나이</th>
					<td><input type="date" name="userAge"
						class="form-control input-sm" value='${user.userAge }'
						readonly="readonly"></td>
					<!-- 'YYYY-MM-DD'형태만 value값으로 들어갈수있어요 -->
				</tr>
				<tr >
					<th scope="row">지역</th>
					<td>
					${userLocation.localBigName} &nbsp; ${userLocation.localMidName} &nbsp; ${userLocation.localSmallName} &nbsp;
					</td> 
				</tr>
<%-- 				<tr>
					<th>탈퇴여부</th>
					<td>${user.userDelYn }</td>
				</tr>
				<tr> --%>
					<td colspan="2">
						<a href="<%=request.getContextPath() %>/"
							class="btn btn-default btn-sm"> <span
								class="glyphicon glyphicon-home" aria-hidden="true"></span>
								&nbsp;Home
						</a> 
						<a href='<%=request.getContextPath() %>/user/edit?userId=${user.userId }'
							class="btn btn-info btn-sm"> <span
								class="glyphicon glyphicon-king" aria-hidden="true"></span>
								&nbsp;수정
						</a>
					</td> 
				</tr>
			</tbody>
		</table>
	</div>
</body>

</html>
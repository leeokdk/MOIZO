
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">

<style type="text/css">
	.file_input_hidden { opacity:0; cursor:pointer; width: 100%; height: 80%; position: absolute; top: 10%; left: 0%;}
	.input_default_profile {cursor:pointer; }
	#id_profile{width: 70%;height: 80%;margin-left: 15%; margin-top: 5%;}
</style>
<%@ include file="/WEB-INF/inc/header.jsp"%>
</head>
<body>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>

	<%@include file="/WEB-INF/inc/top.jsp"%>

	<div class="container"  style="padding-right: 10%; padding-left: 10%;">
		<h3 style="margin-bottom: 4%;">회원 정보 수정</h3>
		<form:form action="modify" modelAttribute="user" enctype="multipart/form-data" id="id_edit">
			<table class="table">
				<tbody>
					<tr >
						<th scope="row" class="label" for="profile">Profile</th>
						<td style="border:1px solid #a094b8; color: #6c757d; width:250px; height: 250px" for="profile" width:250px; height: 250px">
							<label style="width: 100%; height: 210px; position: relative;">
								<c:if test="${userInfo.userPic eq 'default'}">
			      					<img alt="" id="id_profile" src="<%=request.getContextPath() %>/resource/images/join/defaultProfile.png" >
			       			</c:if>
			       			<c:if test="${userInfo.userPic ne 'default' }">
					        	  	<img alt="" id="id_profile" src="/img<%=userInfo.getUserPic()%>" >
			       			</c:if>
			       			<input type="file" class="file_input_hidden" name="upload_profile" id="upload_profile" accept="image/png, image/jpeg" onchange="change_profile(this)">
							</label>
							<input type="button" class="input_default_profile form-control" value="기본 프로필 사진" onclick="defualt_profile()" style="color:#c5c8cb">
						</td>
					</tr>
					<input type="hidden" name="userPic" id="userPic" value="">
					<tr>
						<th scope="row">아이디</th>
						<td>
							${user.userId }
							<input type="hidden" name="userId" value='${user.userId }' >
						</td>
					</tr>
					<tr>
						<th scope="row">회원명</th>
						<td>
							${user.userName }
							<input type="hidden" name="userName" value='${user.userName }' >
						</td>
					</tr>
							<input type="hidden" name="userPassword" value="${user.userPassword }" />
					<tr >
						<th scope="row">자기소개 글</th>
						 <td>
						 	<form:textarea path="userIntroduce" cssClass="form-control input-sm"/>
						</td>
					</tr>
					<tr>
						<th scope="row">이메일</th>
						<td>
							${user.userEmail }
							<input type="hidden" name="userEmail" value='${user.userEmail }' >
						</td>
					</tr>
					<tr >
						<th scope="row">취미</th>
						<td>
							${user.userHobbyNm }
							<input type="hidden" name="userHobby" value='${user.userHobby }' >
						</td>
					</tr>
					<tr >
						<th scope="row">성별</th>
						<td>	
							<c:if test="${user.userGender eq 'M'}">
								남자
							</c:if>
							<c:if test="${user.userGender eq 'F'}">
								여자
							</c:if>
							<input type="hidden" name="userGender" value='${user.userGender }' >
						</td>
					</tr>
					<tr>
						<th>나이</th>
						<td>
							${user.userAge }
							<input type="hidden" name="userAge" value='${user.userAge }'>
						</td>
						<!-- 'YYYY-MM-DD'형태만 value값으로 들어갈수있어요 -->
					</tr>
					<tr >
						<th scope="row">지역</th>
						<td>
							${user.localBigNm} &nbsp; ${user.localMidNm} &nbsp; ${user.localSmallNm} &nbsp;	
							<input type="hidden" name="localBigCode" value='${user.localBigCode }' >
							<input type="hidden" name="localMidCode" value='${user.localMidCode }' >
							<input type="hidden" name="localSmallCode" value='${user.localSmallCode }' >
						</td> 
					</tr>
					<tr>
						<td colspan="2">
							<a href="info.wow?userId=${user.userId }"
								class="btn btn-info btn-sm"> <span
									class="glyphicon glyphicon-list" aria-hidden="true"></span>
									&nbsp;이전
							</a>
							<input type="button" name="name" value="저장" onClick="editUser()" class="btn btn-sm btn-primary">
							<input type="button" name="name" value="삭제" onClick="deleteUser()" class="btn btn-sm btn-primary">
						</td>
					</tr>
				</tbody>
			</table>
		</form:form>
	</div>
		<%@include file="/WEB-INF/inc/bottom.jsp"%>
	
</body>
<!-- 파일 업로드 및 미리보기 스크립트 -->
<script type="text/javascript">
function defualt_profile() {
	var id_profile = document.getElementById("id_profile");
	id_profile.setAttribute("src", "<%=request.getContextPath() %>/resource/images/join/defaultProfile.png");
	
	var picInput = document.getElementsByName("userPic")[0];
	picInput.setAttribute("value", "default");
}

function change_profile(input) {
	// 사진 형식 가져오기 ( ex) png, jpg )
	var pictureSplit = input.value.split("/");
	var pictureSplit2 = pictureSplit[pictureSplit.length - 1].split(".");
	var picType = pictureSplit2[pictureSplit2.length - 1];
	
	// 사진 형식 넣기
	var picInput = document.getElementsByName("userPic")[0];
	picInput.setAttribute("value", picType);
	
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (inputfile) {
            $('#id_profile').attr('src', inputfile.target.result);
        }
        reader.readAsDataURL(input.files[0]);
    }
}    
</script>

<script type="text/javascript">
function editUser() {
    Swal.fire({
          title: '수정',
          text: "수정한 내역을 저장하시겠습니까?",
          icon: 'info',
          showCancelButton: true,
          confirmButtonColor: '#3085d6',
          cancelButtonColor: '#d33',
          confirmButtonText: 'Yes'
        }).then((result) => {
          if (result.isConfirmed) {
            $("#id_edit").submit();
          }
        })
}

function deleteUser() {
    Swal.fire({
          title: '삭제',
          text: "아이디를 삭제하시겠습니까?",
          icon: 'warning',
          showCancelButton: true,
          confirmButtonColor: '#3085d6',
          cancelButtonColor: '#d33',
          confirmButtonText: 'Yes'
        }).then((result) => {
          if (result.isConfirmed) {
            // form액션 속성을 변경 해줌
            $("#id_edit").attr("action", "delete");
            $("#id_edit").submit();
          }
        })

}
</script>
</html>
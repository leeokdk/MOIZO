<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<%
request.setCharacterEncoding("UTF-8");
%>
<html>
<head>
<%@ include file="/WEB-INF/inc/header.jsp"%>
<meta charset="UTF-8">

<title>Teaming</title>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Batang&display=swap" rel="stylesheet">
<style type="text/css">
body,html {font-family: 'Gowun Batang', serif;}

h3 {
margin-bottom: 5%
}
</style>

<script type="text/javascript">
<!-- 파일 업로드 및 미리보기 스크립트 -->
function defualt_img() {
	var moim_img = document.getElementById("moim_img");
	moim_img.setAttribute("src", "<%=request.getContextPath() %>/resource/images/moim/moim_noimg.jpg");
}

function change_img(input) {
	// 사진 형식 가져오기 ( ex) png, jpg )
	var pictureSplit = input.value.split("/");
	var pictureSplit2 = pictureSplit[pictureSplit.length - 1].split(".");
	var picType = pictureSplit2[pictureSplit2.length - 1];
	
	// 사진 형식 넣기
	var picInput = document.getElementsByName("moimImage")[0];
	picInput.setAttribute("value", picType);
	
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (inputfile) {
            $('#moim_img').attr('src', inputfile.target.result);
        }
        reader.readAsDataURL(input.files[0]);
    }
}    
<!-- 지역 셀렉트 박스용 스크립트 -->
function getLocation() {
	var bigCode = $('#big').val();
	var request = $.ajax({
		type : 'POST',
		data : {
			bigCode : bigCode
		},
		url : '/moim/locationDetail.ajax',
		dataType : "json",
		success : function(result) {
			$('#mid').empty();
			$('#mid').append('<option value="">--선택하세요--</option>');
			$.each(result, function(i, el){
				$('#mid').append('<option value="'+el.localMidCode+'">'+el.localMidName+'</option>');
			});
		},
		error : function(xhr, status, error) {
			console.log('status : ' + xhr.status);
		}
	});
}
 <!-- 컬럼 체크용(나이제한 설정용) -->
 function fn_check() {
	 console.log("함수실행");
	 var f = document.forms['regist'];

	 if(((f.moimLimitAge.value*1)<0) && ((f.moimLimitAgeEnd.value*1)<0)) {
		  Swal.fire('나이제한에 음수는 입력할 수 없습니다', '', 'error');
		  setTimeout(() => {
			  f.moimLimitAgeEnd.focus();
		}, 0);
	    return false;
	 }else if((f.moimLimitMaximum.value*1)<0) {
		  Swal.fire('모임정원에 음수는 입력할 수 없습니다', '', 'error');
		  setTimeout(() => {
			  f.moimLimitAgeEnd.focus();
		}, 0);
	    return false;
	 }else if((f.moimLimitAge.value == "") && (f.moimLimitAgeEnd.value != "")) {
		 Swal.fire('나이제한 값을 제대로 입력해주세요', '', 'error');
		  /* f.moimLimitAge.focus(); 이거 썼더니 커서만 옮겨가고 화면이 그대로임..*/
		  setTimeout(() => {
			  f.moimLimitAge.focus();
		}, 0);
	    return false;
	  }else if((f.moimLimitAge.value != "") && (f.moimLimitAgeEnd.value == "")) {
		  Swal.fire('나이제한 값을 제대로 입력해주세요', '', 'error');
		  setTimeout(() => {
			  f.moimLimitAgeEnd.focus();
		}, 0);
	    return false;
	  }else if((f.moimLimitAge.value*1) > (f.moimLimitAgeEnd.value*1)) {
		  Swal.fire('나이제한 시작 값이 제한 값보다 큽니다. 제대로 입력해주세요', '', 'error');
		  setTimeout(() => {
			  f.moimLimitAgeEnd.focus();
		}, 0);
	    return false;
	  }
	  else return true;
	}
</script>
</head>
<body>
<%@ include file="/WEB-INF/inc/top.jsp"%>
	<div class="container">
		<div class="page-header">
			<h3>
				소모임 <small>모임 만들기</small>
			</h3>
		</div>
		<form:form action="moimRegist" method="post" modelAttribute="moim" enctype="multipart/form-data" onsubmit="return fn_check()" name="regist">
			<table  class="table">
				<form:hidden path="moimCode" />	
				<tr>
					<th scope="row">모임 카테고리</th>
					<td><form:select path="hbCode" cssClass="form-select form-select-sm"  style="width: 140px;">
							<option value="">--선택하세요--</option>
							<form:options items="${hobbyList }" itemLabel="hbName"
								itemValue="hbCode" />
						</form:select></td>
				</tr>
				<tr>
					<th scope="row">모임 지역</th>
					<td><form:select path="localBigCode" id="big"
							onchange="getLocation()" cssClass="form-select form-select-sm"  style="width: 140px; display: inline;"> 
							<form:option value="">--선택하세요--</form:option>
							<form:options items="${locationList }" itemLabel="localBigName"
								itemValue="localBigCode" />
						</form:select> &nbsp; <form:select path="localMidCode" id="mid" cssClass="form-select form-select-sm"  style="width: 140px; display: inline;">
							<!-- append 영역 -->
							<form:option value="">--선택하세요--</form:option>
						</form:select></td>
				</tr>
				<tr>
					<th scope="row">소모임 이름</th>
					<td><form:input path="moimName" cssClass="form-control input-sm" style="width: 350px;"/></td>
				</tr>
				<tr>
					<th scope="row">참여 조건</th>
					<td>성별 제한 &nbsp;
					<input type="radio" name="moimLimitGender" value="">&nbsp;상관없음&nbsp;&nbsp; 
					<input type="radio" name="moimLimitGender" value="M">&nbsp;남자만&nbsp;&nbsp; 
					<input type="radio" name="moimLimitGender" value="F">&nbsp;여자만&nbsp;&nbsp;
						<br>나이 제한&nbsp; 
						<form:input path="moimLimitAge" name="limitAge" cssClass="form-control input-sm" style="width: 80px; display: inline;"/>
						&nbsp;~&nbsp; 
						<form:input path="moimLimitAgeEnd" name="limitAgeEnd" cssClass="form-control input-sm" style="width: 80px; display: inline;"/>
					</td>
				</tr>
				<tr>
					<th scope="row">모임 이미지</th>
					<td>
						<div class="card" style="height:541px; width:962px;">
							<img calss="card-img-top" id="moim_img" src="<%=request.getContextPath() %>/resource/images/moim/moim_noimg.jpg"
							style="height:541px; width:962px;">
						</div>
						<input type="file" name="upload_img" id="upload_img" accept="image/png, image/jpeg" onchange="change_img(this)" Class="form-control input-sm" style="color: #699bdc; width: 88px; display: inline; margin-top: 20px;">
						<input type="button" value="파일 삭제" onclick="defualt_img()" Class="form-control input-sm" style="color: rgba(0,0,0,0.78); width: 88px; display: inline;" >
					</td>
					<!-- 해당 사진 저장하기 -->
					<input type="hidden" name="moimImage">
				</tr>
				
				<tr>
					<th scope="row">모임소개글</th>
					<td><form:textarea path="moimIntroduce"
							cssClass="form-control" rows="10" /></td>
				</tr>
				<tr>
					<th scope="row">모임 정원</th>
					<td><form:input path="moimLimitMaximum" cssClass="form-control input-sm" style="width: 80px;" /></td>
				</tr>



				<tr>
					<td colspan="2">
						<div class="pull-left">
							<a href="moimList"> <span aria-hidden="true"></span>
								&nbsp;&nbsp;목록
							</a>
						</div>
						<div class="pull-right">
							<button type="submit" class="btn btn-sm btn-primary">
								<span aria-hidden="true"></span> &nbsp;저장
							</button>
						</div>
					</td>
				</tr>
			</table>
		</form:form>

	</div>
	<%@include file="/WEB-INF/inc/bottom.jsp"%>
</body>
</html>

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
<title>SoMoim</title>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Batang&display=swap" rel="stylesheet">
<style type="text/css">
body,html {font-family: 'Gowun Batang', serif;}
</style>
<script type="text/javascript">

/* $(document).ready(function(){
	var bigCode = $('#big').val();
	var midCode = ${moim.localMidCode};
	var request = $.ajax({
		type : 'POST',
		data : {
			bigCode : bigCode
		},
		url : '/moim/locationDetail.ajax',
		dataType : "json",
		success : function(result) {
			console.log("result", result);
			$('#mid').append('<option value="">--선택하세요--</option>');
			$.each(result, function(i, el){	
				console.log(i, "el", el);
				if(midCode == el.localMidCode){
					$('#mid').append('<option value="'+el.localMidCode+'" selected="selected">'+el.localMidName+'</option>');				
				}else{
					$('#mid').append('<option value="'+el.localMidCode+'">'+el.localMidName+'</option>');
				}
			});
		},
		error : function(xhr, status, error) {
			console.log('status : ' + xhr.status);
		}
	});
	$("select").attr("disabled","disabled");
});

function fieldDisabledCancel(){
	 //입력 필드 disabled 해제
	 $("select").removeAttr("disabled");
}; */
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
<!-- 컬럼 체크용(나이제한 설정용) -->
function fn_check() {
	 console.log("함수실행");
	 var f = document.forms['modify'];
	  if((f.moimLimitAge.value == "") && (f.moimLimitAgeEnd.value != "")) {
		  alert("나이제한 값을 제대로 입력해주세요");
		  /* f.moimLimitAge.focus(); 이거 썼더니 커서만 옮겨가고 화면이 그대로임..*/
		  setTimeout(() => {
			  f.moimLimitAge.focus();
		}, 0);
	    return false;
	  }else if((f.moimLimitAge.value != "") && (f.moimLimitAgeEnd.value == "")) {
		  alert("나이제한 값을 제대로 입력해주세요");
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
	<%@include file="/WEB-INF/inc/top.jsp"%>
	<div class="container">
		<div class="page-header">
			<h3>
				소모임 - <small>모임 수정하기</small>
			</h3>
		</div>
		<form:form action="moimModify" method="post" modelAttribute="moim" id="id_save" name="modify" enctype="multipart/form-data">
		<form:hidden path="moimCode"/>
			<table>
				<colgroup>
					<col width="20%" />
					<col />
				</colgroup>
				<tr>
					<th>모임 카테고리</th>
					<td>
						<form:input path="moimCategory" readonly="readonly" />
						<form:hidden path="hbCode" />
					</td>
				</tr>
				<tr>
					<th>모임 지역</th>
					<td>
						<form:input path="moimBigName" readonly="readonly" />
						<form:hidden path="localBigCode" />
						<form:input path="moimLocalName" readonly="readonly" />
						<form:hidden path="localMidCode" />
					</td>
				</tr>
				<tr>
					<th>소모임 이름</th>
					<td><form:input path="moimName" /></td>
				</tr>
				<tr>
					<th>참여 조건</th>
					<td>
						성별 제한<br> 
						<input type="radio" name="moimLimitGender" value="" 
							<c:if test='${moim.moimLimitGender eq null}'>checked="checked"</c:if> >&nbsp;상관없음&nbsp;&nbsp;
						<input type="radio" name="moimLimitGender" value="M"
							<c:if test='${moim.moimLimitGender eq "M"}'>checked="checked"</c:if> >&nbsp;남자만&nbsp;&nbsp;
						<input type="radio" name="moimLimitGender" value="F"
							<c:if test='${moim.moimLimitGender eq "F"}'>checked="checked"</c:if> >&nbsp;여자만&nbsp;&nbsp;
						<br>나이 제한&nbsp;
						<form:input path="moimLimitAge" />
						&nbsp;~&nbsp;
						<form:input path="moimLimitAgeEnd" />
					</td>
				</tr>
				<tr>
					<th>모임소개글</th>
					<td><form:textarea path="moimIntroduce"
							cssClass="form-control" rows="10" /></td>
				</tr>
				<tr>
					<th>모임 정원</th>
					<td><form:input path="moimLimitMaximum" /></td>
				</tr>
				<tr>
					<th>모임 이미지</th>
					<td>
						<div class="card" style="height:541px; width:962px;">
							<c:choose>
								<c:when test="${moim.moimImage eq 'default' }">
									<img src="<%=request.getContextPath() %>/resource/images/moim/moim_noimg.jpg" class="card-img-top" alt="no_image" id="moim_img"
											style="height:541px; width:962px;">
								</c:when>
								<c:otherwise>
									<img src="/img${moim.moimImage }" class="card-img-top" alt="no_image" id="moim_img"
											style="height:541px; width:962px;">
								</c:otherwise>
							</c:choose>
						</div>
						<input type="file" name="upload_img" id="upload_img" accept="image/png, image/jpeg" onchange="change_img(this)">
						<br><input type="button" value="기본 모임 사진" onclick="defualt_img()" style="color: #c5c8cb">
					</td>
					<!-- 해당 사진 저장하기 -->
					<form:hidden path="moimImage"/>
					<!-- <input type="hidden" name="moimImage">  -->
				</tr>

				<tr>
						<td colspan="2">
							<div class="pull-left">
							<% String userInfoMapGetId = userInfoMap.get("NOPE").getUserId(); %>
								<a href="moimUser?userId=<%=userInfoMapGetId %>" class="btn btn-info btn-sm"> <span class="glyphicon glyphicon-list" aria-hidden="true"></span> &nbsp;목록
								</a>
							</div>
							<div class="pull-right">
								<input type="button" name="name" value="저장" onClick="fn_save()" class="btn btn-sm btn-primary">
								<!-- 
								<button type="submit"  class="btn btn-sm btn-primary" onclick="fn_save()">
									<span class="glyphicon glyphicon-save" aria-hidden="true"></span> &nbsp;&nbsp;저장
								</button> -->

								<input type="button" name="name" value="삭제" onClick="fn_delete()" class="btn btn-sm btn-primary">
								<!-- 
								<button type="submit" class="btn btn-sm btn-danger" onclick="fn_delete()" >
									<span class="glyphicon glyphicon-remove" aria-hidden="true"></span> &nbsp;&nbsp;삭제
								</button> -->
								
								
							</div>
						</td>
					</tr>
			</table>
		</form:form>

	</div>
	<%@include file="/WEB-INF/inc/bottom.jsp"%>
</body>
<script type="text/javascript">
//------------------------------------------------모달
function fn_save() {
		Swal.fire({
			  title: '저장',
			  text: "수정한 내역을 저장하시겠습니까?",
			  icon: 'info',
			  showCancelButton: true,
			  confirmButtonColor: '#3085d6',
			  cancelButtonColor: '#d33',
			  confirmButtonText: 'Yes'
			}).then((result) => {
			  if (result.isConfirmed) {
			    $("#id_save").submit();
			  }
			})
	
}

function fn_delete() {
		Swal.fire({
			  title: '삭제',
			  text: "모임을 삭제하시겠습니까?",
			  icon: 'warning',
			  showCancelButton: true,
			  confirmButtonColor: '#3085d6',
			  cancelButtonColor: '#d33',
			  confirmButtonText: 'Yes'
			}).then((result) => {
			  if (result.isConfirmed) {
				// form액션 속성을 변경 해줌
				$("#id_save").attr("action", "moimDelete");
			    $("#id_save").submit();
			  }
			})
	
}		

<!-- 모달 관련 -->
if(${not empty succesModify}){
	Swal.fire({
		  position: 'top-end',
		  icon: 'success',
		  title: '성공적으로 수정되었습니다',
		  showConfirmButton: false,
		  timer: 1500
		})
};
</script>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<!DOCTYPE html>
<%request.setCharacterEncoding("UTF-8"); %>
<html>
<head>
<%@include  file="/WEB-INF/inc/header.jsp" %>
<meta charset="UTF-8">
<title>Teaming</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Batang&display=swap" rel="stylesheet">

<style type="text/css">
/* textarea 크기 조절 버튼 제거 */
textarea {resize: none;}
</style>
</head>

<body>
<%@include  file="/WEB-INF/inc/top.jsp" %>


<!-- TODO: moimCode를 가지고 있어야함 -->
	<div class="container">
		<div class="page-header">
			<h3>
				모임 공지 - <small>글 등록</small>
			</h3>
		</div>
		<!-- 우선 저장한 결과값을 볼수있도록 다시 moimView로 넘겨줌 -->
		<!-- TODO : 파일업로드 관련 설정이 안되어있어서 아직 추가 안함 -->
		<form:form action="moimNoticeRegist" method="post" modelAttribute="ManagerNotice" id="id_save">
		
			<table class="table">
					<form:hidden path="moimCode" />	
					<form:hidden path="mNoticeNo" />			
				<tr>
					<th scope="row">제목</th>
					<td><form:input path="mNoticeTitle"
							cssClass="form-control input-sm" /></td>
					<td><form:errors cssStyle="color: red;" path="mNoticeTitle" /></td>
				</tr>
				<tr>
					<th scope="row">작성자</th>
					<td><form:input path="mNoticeWriter"
							cssClass="form-control input-sm" /></td>
				</tr>
				<tr>
					<th scope="row">내용</th>
					<td> <form:textarea path="mNoticeContent" cssClass="form-control input-sm" id="id_textarea" rows="8"/></td>
					<td><form:errors cssStyle="color: red;" path="mNoticeContent" /></td>
				</tr>
				<tr>
					<th scope="row">첨부파일
						<button type="button" id="id_btn_new_file">추가</button>
					</th>
					<td class="file_area" scope="row">
						<div class="form-inline">
							<input type="file" name="boFiles" class="form-control">
							<button type="button" class="btn_delete btn btn-sm">삭제</button>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<div class="pull-left">
							<a href="/moim/moimView?moimCode=${moim.moimCode }" class="btn btn-default btn-sm"> <span
								class="glyphicon glyphicon-list" aria-hidden="true"></span>
								&nbsp;&nbsp;목록
							</a>
						</div>
						<div class="pull-right">
							<input type="button" name="name" value="저장" onClick="fn_save()" class="btn btn-sm btn-primary">
						</div>
					</td>
				</tr>
			</table>
		</form:form>

	</div>
	<!-- container -->
</body>
<script type="text/javascript">
$('#id_btn_new_file').click(function(){
	$('.file_area').append('<div class="form-inline">'
	+ '<input type="file" name="boFiles" class="form-control">'
	+ ' <button type="button" class="btn_delete btn btn-sm">삭제</button>'
	+ '</div>');
	});
	$('.file_area').on('click','.btn_delete', function(){
	$(this).closest('div').remove();
	});
	
	
/* 버튼을 누르면 글이 수정 되는 팝업 알림창 */
function fn_save() {
		Swal.fire({
			  title: '저장',
			  text: "글을 저장하시겠습니까?",
			  icon: 'success',
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


	
	</script>
	<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	
	
	
</html>
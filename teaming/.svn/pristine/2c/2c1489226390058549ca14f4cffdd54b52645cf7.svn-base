<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<%
request.setCharacterEncoding("UTF-8");
%>
<html>
<head>
<%@include file="/WEB-INF/inc/header.jsp"%>
<meta charset="UTF-8">
<title>Teaming</title>
</head>
<style>
body{
font-family: 'Gowun Dodum', sans-serif;
}
</style>
<body>
	<%@include file="/WEB-INF/inc/top.jsp"%>

	<!-- container -->
	<!-- TODO: 벨리데이션 추가하기 -->
	<div class="container">
		<div class="page-header">
			<h3>
				공지 게시판 - <small>글 수정</small>
			</h3>


		</div>

		<form:form action="moimNoticeModify" method="post" modelAttribute="moim" id="id_save" >
			<table class="table">

				<form:hidden path="moimCode" />	
				<form:hidden path="mNoticeNo" />

				<tbody>
					<tr>
						<th scope="row">제목</th>
						<td><form:input path="mNoticeTitle"
								cssClass="form-control input-sm" /></td>
						<td><form:errors cssStyle="color: red;" path="mNoticeTitle" /></td>
					
					</tr>
					<tr>
						<th scope="row">작성자</th>
						<td>${moim.mNoticeWriter }<form:hidden path="mNoticeWriter" /></td>
					</tr>
					<tr>
						<th scope="row">내용</th>
						<td><form:textarea path="mNoticeContent"
								cssClass="form-control input-sm" rows="10" /></td>
						<td><form:errors cssStyle="color: red;" path="mNoticeContent" /></td>
					
					</tr>
					<tr>
						<th scope="row">조회수</th>
						<td>${moim.mNoticeHit }</td>
					</tr>
					<tr>
						<th scope="row">최근등록일자</th>
						<td>${moim.mNoticeModDate eq null ? moim.mNoticeRegDate  : moim.mNoticeModDate }</td>
					</tr>
					<tr>
						<td colspan="2">
							<div class="pull-left">
								<a href="/manager/moimNoticeView?mNoticeNo=${moim.mNoticeNo}"
									class="btn btn-default btn-sm"> <span
									class="glyphicon glyphicon-list" aria-hidden="true"></span>
									&nbsp;&nbsp;목록
								</a>
							</div>
							<div class="pull-right">
							
					<input type="button" name="name" value="저장" onClick="fn_save()" class="btn btn-sm btn-primary">

					<input type="button" name="name" value="삭제" onClick="fn_delete()" class="btn btn-sm btn-danger">		
							</div>
						</td>
					</tr>
			</table>
		</form:form>

	</div>
	<!-- container -->

</body>
<script type="text/javascript">

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

/* 버튼을 누르면 글이 삭제 되는 팝업 알림창 */
function fn_delete() {
		Swal.fire({
			  title: '삭제',
			  text: "글을 삭제하시겠습니까?",
			  icon: 'error',
			  showCancelButton: true,
			  confirmButtonColor: '#3085d6',
			  cancelButtonColor: '#d33',
			  confirmButtonText: 'Yes'
			}).then((result) => {
			  if (result.isConfirmed) {
				// form액션 속성을 변경 해줌
				$("#id_save").attr("action", "moimNoticeDelete");
				
			    $("#id_save").submit();
			  }
			})
	
}			
			


</script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</html>

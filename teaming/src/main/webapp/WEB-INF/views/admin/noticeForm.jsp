<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@include file="/WEB-INF/inc/header.jsp" %>
<meta charset="UTF-8">
<title>Teaming</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Batang&display=swap" rel="stylesheet">
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>

</head>
<style type="text/css">
	body,html {font-family: 'Gowun Batang', serif;}
	h3 {margin-bottom: 5%}
	a {text-decoration-line: none;}
</style>
<body>

	<div class="container">
		<div class="page-header">
			<h3>공지게시판</h3>
		</div>
		<form:form action="noticeRegist" method="post" modelAttribute="aNotice">
			<table class="table">
				<form:hidden path="aNoticeNo" />
				<form:hidden path="aNoticeWriter"/>	
				<form:hidden path="aNoticeRegDate"/>
				<tr>
						<th scope="row">제목</th>
					<td><form:input path="aNoticeTitle"
							cssClass="form-control input-sm" /> <form:errors path="aNoticeTitle"
							cssClass="text-danger" /></td>
				</tr>
				<tr>
						<th scope="row">내용</th>
					<td><form:textarea path="aNoticeContent" cssClass="form-control"
							rows="10" /> <form:errors path="aNoticeContent"
							cssClass="text-danger"></form:errors></td>
				</tr>
				<tr>
					<td colspan="2">
						<div class="pull-left">
							<a href="noticeListForAdmin" class="btn btn-default btn-sm"> <span
								class="glyphicon glyphicon-list" aria-hidden="true"></span>
								&nbsp;목록
							</a>
						</div>
						<div class="pull-right">
							<button type="submit" class="btn btn-sm btn-primary">
								<span class="glyphicon glyphicon-save" aria-hidden="true"></span>
								저장
							</button>
						</div>
					</td>
				</tr>
			</table>
		</form:form>
	</div>
	<!-- container -->
		<%@include file="/WEB-INF/inc/bottom.jsp"%>
</body>
<!-- <script type="text/javascript">
	$('#id_btn_new_file')
			.click(
					function() {
						$('.file_area')
								.append(
										'<div class="form-inline">'
												+ '<input type="file" name="boFiles" class="form-control">'
												+ ' <button type="button" class="btn_delete btn btn-sm">삭제</button>'
												+ '</div>');
					});
	$('.file_area').on('click', '.btn_delete', function() {
		$(this).closest('div').remove();
	});
</script> -->
</html>



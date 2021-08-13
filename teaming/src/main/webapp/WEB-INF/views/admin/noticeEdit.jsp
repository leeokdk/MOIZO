
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- valid 검사를 위한 태그라이브러리 추가 -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Teaming</title>
<%@include file="/WEB-INF/inc/header.jsp"%>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Batang&display=swap" rel="stylesheet">
</head>

<style type="text/css">
body,html {font-family: 'Gowun Batang', serif;}
h3 {margin-bottom: 5%}
</style>


<body>

<c:if test="${e ne null }">
		<div class="alert alert-warning">
		해당 글이 존재하지 않습니다.</div>
		<a href="noticeList" class="btn btn-default btn-sm"> 
		<span class="glyphicon glyphicon-list" 
		aria-hidden="true">
		</span> &nbsp;목록
		</a>
</c:if>


<c:if test="${aNotice ne null }">
		<div class="container">
			<div class="page-header">
				<h3>
					총 공지게시판 
				</h3>
			</div>
			
			<!-- 폼태그를 대신함. valid 연결. 인풋타입 또한 폼인풋으로 전부 교체함. -->
			<form:form action="noticeModify" method="post" modelAttribute="aNotice">
				<table class="table">

					<tr>
						<th scope="row">글번호</th>
						<td>${aNotice.aNoticeNo }<form:hidden path="aNoticeNo" /></td>
					</tr>
					<tr>
						<th scope="row">제목</th>
						<td>
						<form:input path="aNoticeTitle" cssClass="form-control input-sm"/>
						<form:errors path="aNoticeTitle" cssClass="text-danger"/>
						</td>
					</tr>
					<tr>
						<th scope="row">작성자</th>
						<td>${aNotice.aNoticeWriterName }<form:hidden path="aNoticeWriterName"/></td>
					</tr>
					<tr>
						<th scope="row">내용</th>
						<td>
						<form:textarea path="aNoticeContent" cssClass="form-control input-sm"/>
						<form:errors path="aNoticeContent" cssClass="text-danger" />
						</td>
					</tr>
					<tr>
						<th scope="row">조회수</th>
						<td>${aNotice.aNoticeHit }</td>
					</tr>
					<tr>
						<th scope="row">최근등록일자</th>
						<td><c:if test="${aNotice.aNoticeModDate eq null }">${aNotice.aNoticeRegDate }</c:if> ${aNotice.aNoticeModDate }
						<form:hidden path="aNoticeModDate" /><form:hidden path="aNoticeRegDate"/><form:hidden path="aNoticeDelYn"/></td>
					</tr>
					<tr>
						<td colspan="2">
							<div class="pull-left">
								<a href="noticeListForAdmin" class="btn btn-info btn-sm"> <span class="glyphicon glyphicon-list" aria-hidden="true"></span> &nbsp;목록
								</a>
							</div>
							<div class="pull-right">

								
								<button type="submit"  class="btn btn-sm btn-primary">
									<span class="glyphicon glyphicon-save" aria-hidden="true"></span> &nbsp;저장
								</button>

								<button type="submit" formaction="noticeDelete" class="btn btn-sm btn-danger">
									<span class="glyphicon glyphicon-remove" aria-hidden="true"></span> &nbsp;삭제
								</button>
								
								
							</div>
						</td>
					</tr>
				</table>
			</form:form>

		</div>
		<!-- container -->
</c:if>

</body>
</html>



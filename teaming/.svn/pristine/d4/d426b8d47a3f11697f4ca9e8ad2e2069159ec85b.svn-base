<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<%@include file="/WEB-INF/inc/header.jsp"%>
</head>
<body>


		<c:if test="${e ne null }">
		<div class="alert alert-warning">
		글 등록 실패 .</div>
		<a href="freeList?moimCode=${free.moimCode }" class="btn btn-default btn-sm"> 
		<span class="glyphicon glyphicon-list" 
		aria-hidden="true">
		</span> &nbsp;목록
		</a>
		</c:if>


		<c:if test="${free ne null }">
		<div class="container">
			<div class="page-header">
				<h3>
					등록 성공!
				</h3>
			</div>

		<div class="pull-left">
			<a href="freeList?moimCode=${free.moimCode }" class="btn btn-info btn-sm"> <span class="glyphicon glyphicon-list" aria-hidden="true"></span> &nbsp;목록으로
			</a>


		<!-- container -->
		</c:if>
</body>
</html>



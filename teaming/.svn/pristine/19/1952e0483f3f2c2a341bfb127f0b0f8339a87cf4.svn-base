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
		수정 실패 .</div>
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
					수정 성공!
				</h3>
			</div>

		<div class="pull-left">
			<a href="freeList?moimCode=${free.moimCode }" class="btn btn-info btn-sm"> <span class="glyphicon glyphicon-list" aria-hidden="true"></span> &nbsp;목록으로
			</a>

		<div class="pull-left">
			<a href="freeView?freeNo=${free.freeNo }" class="btn btn-info btn-sm"> <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> &nbsp;해당 뷰
			</a>
								
		</div>
		<!-- container -->
		</c:if>
</body>
</html>



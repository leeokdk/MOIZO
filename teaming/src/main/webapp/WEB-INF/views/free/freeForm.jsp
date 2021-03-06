<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<!DOCTYPE html>
<html lang="ko">
<head>
<%@include file="/WEB-INF/inc/header.jsp"%>
</head>
<body>
<div class="container">
	<div class="page-header">
		<h3>자유게시판 - <small>글 등록</small></h3>
	</div>
	<form action="freeRegist" method="post">	
	<table class="table table-striped table-bordered">
		<colgroup>
			<col width="20%" />
			<col/>
		</colgroup>
		<tr>
			<th>제목</th>
			<td><input type="text" name="freeTitle" value="" class="form-control input-sm"  required="required" ></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td><input type="text" name="freeWriter" value=""  class="form-control input-sm" required="required" ></td>
		</tr>
		<tr>
			<th>모임코드</th>
			<td>${moimCode }<input type="hidden" name="moimCode" value="${moimCode }" ></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea rows="10" name="freeContent" class="form-control"></textarea>
			</td>
		</tr>
		<tr>
			<td colspan="2">
					 <div class="pull-left">
              <a href="freeList?moimCode=${moimCode }" class="btn btn-default btn-sm"> 
                <span class="glyphicon glyphicon-list" aria-hidden="true"></span>
                &nbsp;&nbsp;목록
              </a>
            </div>
            <div class="pull-right">
              <button type="submit" class="btn btn-sm btn-primary" > 
                <span class="glyphicon glyphicon-save" aria-hidden="true"></span>
                &nbsp;&nbsp;저장
              </button>
            </div>      
			</td>
		</tr>
	</table>
	</form>
	
</div><!-- container -->
</body>
</html>



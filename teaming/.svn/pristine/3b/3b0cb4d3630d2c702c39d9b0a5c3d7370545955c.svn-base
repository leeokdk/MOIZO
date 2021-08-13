<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/inc/header.jsp"%>
<title>자유게시판 - 글 보기</title>
</head>
<body>

 	<c:if test="${e ne null }">
	<div class="alert alert-warning">
			해당 글이 존재하지 않습니다.
			또는 조회수증가 실패했습니다.
	</div>	 
		<a href="freeList" class="btn btn-default btn-sm">
		<span class="glyphicon glyphicon-list" aria-hidden="true"></span>
		&nbsp;목록
	</a>
	</c:if>

<c:if test="${free ne null }">
		<div class="container">
			<div class="page-header">
				<h3>
					자유게시판 - <small>글 보기</small>
				</h3>
			</div>
			<table class="table table-striped table-bordered">
				<tbody>
					<tr>
						<th>글제목</th>
						<td>${free.freeTitle }</td>
					</tr>
					<tr>
						<th>작성자명</th>
						<td>${free.userName}</td>
					</tr>
					<!-- 비밀번호는 보여주지 않음  -->
					<tr>
						<th>내용</th>
						<td><textarea rows="10" name="freeContent" class="form-control input-sm" readonly="readonly">
						${free.freeContent }
					</textarea></td>
					</tr>
					<tr>
						<th>조회수</th>
						<td>${free.freeHit }</td>
					</tr>
					<tr>
						<th>최근등록일자</th>
						<td>${free.freeModDate eq null ? free.freeRegDate : free.freeModDate}</td>
					</tr>
					<tr>
						<th>삭제여부 </th>
						<td>${free.freeDelYn }</td>
					</tr>
					<tr>
						<td colspan="2">
							<div class="pull-left">
								<a href="freeList?moimCode=${free.moimCode }" class="btn btn-info btn-sm"> <span class="glyphicon glyphicon-list" aria-hidden="true"></span> &nbsp;목록으로
								</a>
							</div>
							<div class="pull-right">
								<a href="freeEdit?freeNo=${free.freeNo }" class="btn btn-success btn-sm"> <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> &nbsp;&nbsp;수정
								</a>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- container -->
</c:if>
</body>
</html>







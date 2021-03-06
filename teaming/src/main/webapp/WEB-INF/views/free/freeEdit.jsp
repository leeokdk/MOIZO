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
		해당 글이 존재하지 않습니다.</div>
		<a href="freeList" class="btn btn-default btn-sm"> 
		<span class="glyphicon glyphicon-list" 
		aria-hidden="true">
		</span> &nbsp;목록
		</a>
		</c:if>


		<c:if test="${free ne null }">
		<div class="container">
			<div class="page-header">
				<h3>
					자유게시판 - <small>글 수정</small>
				</h3>
			</div>
			<form action="freeModify" method="post">
				<table class="table table-striped table-bordered">
					<colgroup>
						<col width="20%" />
						<col />
					</colgroup>
						<input type="hidden" name="freeNo" value="${free.freeNo }">
					<tr>
						<th>제목</th>
						<td><input type="text" name="freeTitle" value="${free.freeTitle }" class="form-control input-sm" required="required"></td>
					</tr>
					<tr>
						<th>작성자</th>
						<td>${free.userName}<input type="hidden" name="freeWriter" value="${free.freeWriter}">
						</td>
					</tr>
						<input type="hidden" name="moimCode" value="${free.moimCode }">
					<tr>
						<th>내용</th>
						<td><textarea rows="10" name="freeContent" class="form-control input-sm">${free.freeContent }</textarea></td>
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
						<td colspan="2">
							<div class="pull-left">
								<a href="freeList?moimCode=${free.moimCode }" class="btn btn-info btn-sm"> <span class="glyphicon glyphicon-list" aria-hidden="true"></span> &nbsp;목록으로
								</a>
							</div>
							<div class="pull-right">
								<button type="submit"  class="btn btn-sm btn-primary">
									<span class="glyphicon glyphicon-save" aria-hidden="true"></span> &nbsp;&nbsp;저장
								</button>

								<button type="submit" formaction="freeDelete" class="btn btn-sm btn-danger">
									<span class="glyphicon glyphicon-remove" aria-hidden="true"></span> &nbsp;&nbsp;삭제
								</button>
								
								
							</div>
						</td>
					</tr>
				</table>
			</form>

		</div>
		<!-- container -->
		</c:if>
</body>
</html>



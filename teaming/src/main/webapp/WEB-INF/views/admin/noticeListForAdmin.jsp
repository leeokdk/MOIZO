
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="hn" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<%@include file="/WEB-INF/inc/header.jsp" %>
</head>
<style>
a {text-decoration:none;}
</style>
<body>
<%
	request.setCharacterEncoding("UTF-8");
%>

<div class="container">
	<form name="search" action="noticeListForAdmin" method="post">
		<input type="hidden" name="curPage" value="${searchVO.curPage }"> 
	   <input type="hidden" name="rowSizePerPage" value="${searchVO.rowSizePerPage }">
	</form>
	<div class="page-header">
		<h3>공지게시판 관리 - <small>글 목록</small></h3>
	</div>
		<!-- START : 목록건수 및 새글쓰기 버튼  -->
		<div class="row" style="margin-bottom: 10px;">
			<div class="col-sm-3 form-inline">
				전체 ${searchVO.totalRowCount }건
			</div>
				<div class="col-sm-2 col-sm-offset-7 text-right">
					<a href="noticeForm" class="btn btn-primary btn-sm"> <span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span> &nbsp;새글쓰기
					</a>
				</div>
		</div>
		
<div class="row">
    <div class="col-sm-2 col-sm-offset-10 text-right" style="margin-bottom: 5px;" >
    </div>
</div>
	<table class="table table-hover">
	<thead>
		<tr>
			<th scope="col">글번호</th>
			<th scope="col">제목</th>
			<th scope="col">작성자</th>
			<th scope="col">등록일</th>
			<th scope="col">조회수</th>
		</tr>
	</thead>	
	<tbody>
	<c:forEach items="${aNoticeList}" var="aNotice">
			<tr class="text-center">
				<td>${aNotice.rnum}</td>
				<td class="text-left">
					<a href="noticeViewForAdmin?aNoticeNo=${aNotice.aNoticeNo }" style="color: black;"> 
						${aNotice.aNoticeTitle }
					</a>
				</td>
				<td>${aNotice.aNoticeWriterName }</td>
				<td>${aNotice.aNoticeModDate eq null ? aNotice.aNoticeRegDate : aNotice.aNoticeModDate }</td>
				<td>${aNotice.aNoticeHit }</td>
			</tr>
	</c:forEach>
	</tbody>
	</table>
	<!-- 페이지네이션 -->
	<hn:paging searchVO="${searchVO }" linkPage="noticeList"></hn:paging>
		
</div><!-- container --> 
</body>

<script type="text/javascript">
		// 변수 정의
		var f = document.forms['search'];

		// 함수 정의

		// 각 이벤트 등록
		// 페이지 링크 클릭
		$('ul.pagination li a[data-page]').click(function(e) {
			e.preventDefault(); // 이벤트 전파 방지,  <a>의 기본 클릭이벤트를 막기위함
			// data-page에 있는 값을 f.curPage.value에 설정, 서브밋
			f.curPage.value = $(this).data('page');
			f.submit();
		}); // ul.pagination li a[data-page]

		// 검색 버튼 클릭
		$(f).submit(function(e) {
			e.preventDefault();
			f.curPage.value = 1;
			f.submit();
		}); // f.submit

		// 목록 갯수 변경
		// id_rowSizePerPage 변경되었을 때
		// 페이지 1, 목록수 = 현재값 으로 변경 후 서브밋
		$('#id_rowSizePerPage').change(function(e) {
			f.curPage.value = 1;
			f.rowSizePerPage.value = this.value;
			f.submit();
		}); // '#id_rowSizePerPage'.change

		// 초기화 버튼 클릭
		$('#id_btn_reset').click(function() {
			f.curPage.value = 1;
			f.searchWord.value = "";
			f.searchType.options[0].selected = true;
			f.searchCategory.options[0].selected = true;
		}); // #id_btn_reset.click

		// jQuery에서 클래스 삭제 및 추가, 내용 변경
		$('#id_search_area').on(
				'shown.bs.collapse',
				function() {
					$('#searchTap').removeClass('fa-chevron-down').addClass(
							'fa-chevron-up');
					$('#id_seach_show span').html('&nbsp; 검색열기');
				});

		$('#id_search_area').on(
				'hidden.bs.collapse',
				function() {
					$('#searchTap').removeClass('fa-chevron-up').addClass(
							'fa-chevron-down');
					$('#id_seach_show span').html('&nbsp; 검색열기');
				});
		
		
		
		
	</script>
	
</html>







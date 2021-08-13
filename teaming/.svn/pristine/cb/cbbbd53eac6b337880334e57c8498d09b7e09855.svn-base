<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="hn" tagdir="/WEB-INF/tags" %>
<%request.setCharacterEncoding("UTF-8"); %> 

<!DOCTYPE html>
<html lang="ko">
<head>
<%@include file="/WEB-INF/inc/header.jsp" %>
</head>
<body>



<div class="container">
<!-- START : 검색 폼  -->
		<div class="panel panel-default">
			<div class="panel-body">
				<form name="search" action="freeList" method="post" class="form-horizontal">
				<input type="hidden" name="moimCode" value="${searchVO.moimCode }">
					<input type="hidden" name="curPage" value="${searchVO.curPage}"> <input type="hidden" name="rowSizePerPage" value="${searchVO.rowSizePerPage}">
					<div class="row">
						<div class="col-sm-1">
							<select id="id_searchType" name="searchType" class="form-control input-sm">
								<option value="T" ${searchVO.searchType eq "T" ? "selected='selected'" : "" }>제목</option>
								<option value="W" ${searchVO.searchType eq "W" ? "selected='selected'" : "" }>작성자</option>
								<option value="C" ${searchVO.searchType eq "C" ? "selected='selected'" : "" }>내용</option>
							</select>
						</div>
						<div class="col-sm-2">
							<input type="text" name="searchWord" class="form-control input-sm" value="${searchVO.searchWord }" placeholder="검색어">
						</div>
						<div class="col-sm-2 col-sm-offset-9 text-right">
							<button type="button" id="id_btn_reset" class="btn btn-sm btn-default">
								<i class="fa fa-sync"></i> &nbsp;&nbsp;초기화
							</button>
						</div>
						<div class="col-sm-1 text-right">
							<button type="submit" class="btn btn-sm btn-primary ">
								<i class="fa fa-search"></i> &nbsp;&nbsp;검 색
							</button>
						</div>
					</div>
				</form>

			</div>
		</div>
		<!-- END : 검색 폼  -->

		<div class="row" style="margin-bottom: 10px;">
			<div class="col-sm-2 col-sm-offset-7 text-right">
				<a href="freeForm?moimCode=${searchVO.moimCode }" class="btn btn-primary btn-sm"> <span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span> &nbsp;새글쓰기
				</a>
			</div>
		</div>
		<!-- END : 목록건수 및 새글쓰기 버튼  -->

	<div class="page-header">
		<h3>자유게시판 - <small>글 목록 <br>확인${searchVO.moimCode } </small></h3>
	</div>
<div class="row">
    <div class="col-sm-2 col-sm-offset-10 text-right" style="margin-bottom: 5px;" >
        
    </div>
</div>
	<table class="table table-striped table-bordered table-hover">
	<colgroup>
		<col width="10%" />
		<col width="15%" />
		<col />
		<col width="10%" />
		<col width="15%" />
		<col width="10%" />
	</colgroup>
	<thead>
		<tr>
			<th>글번호</th>
			<th>제목</th>
			<th>내용</th>
			<th>작성자</th>
			<th>등록일</th>
			<th>조회수</th>
		</tr>
	</thead>	
	<tbody>
		<c:forEach items="${freeList}" var="free">
			<tr class="text-center">
				<td>${free.rnum}</td>
				<td>${free.freeTitle}</td>
				<td class="text-left">
					<a href="freeView?freeNo=${free.freeNo}">
						${free.freeContent}
					</a>
				</td>
				<td>${free.userName}</td>
				<td>${free.freeRegDate}</td>
				<td>${free.freeHit}</td>
			</tr>
		</c:forEach>
	</tbody>
	</table>
	
		<!-- START : 페이지네이션  -->
	<hn:paging searchVO="${searchVO }" linkPage="freeList"></hn:paging>
		<!-- END : 페이지네이션  -->
	
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







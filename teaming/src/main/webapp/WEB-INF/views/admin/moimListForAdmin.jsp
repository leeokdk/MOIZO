
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- valid 검사를 위한 태그라이브러리 추가 -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<%@ taglib prefix="hn" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<%@include file="/WEB-INF/inc/header.jsp"%>
</head>
<style>
a {text-decoration:none;}
</style>
<body>
		<!-- START : 검색 폼  -->
		<div class="container-mg">
				<form name="search" action="moimListForAdmin" method="post">
					<input type="hidden" name="curPage" value="${searchVO.curPage }"> <input type="hidden" name="rowSizePerPage" value="${searchVO.rowSizePerPage }">
					
					<div class="row">						
							<div class="col-sm-1">
								<input type="text" name="searchWord" class="form-control input-sm" value="${searchVO.searchWord }" placeholder="모임 이름 검색">
							</div>
							<div class="col-sm-2">
								<div class="col-sm">
								<select id="id_searchHobby" name="searchHobby" class="form-select" aria-label="Floating label" >
									<option value="">-- 관심사 --</option>
									<c:forEach items="${hobbyList}" var="hobby">
										<option value="${hobby.hbCode}" ${hobby.hbCode eq searchVO.searchHobby ? 'selected' : '' }>${hobby.hbName}</option>
									</c:forEach>
								</select>
								</div>
							</div>
						<div class="col-sm-2">
							<div class="col-sm">
									<select id="id_searchLocationBig" name="searchLocationBig" onchange="getLocation()" class="form-select" aria-label="Floating label" >
										<option value="">-- 시/도 --</option>
										<c:forEach items="${locationList}" var="big">
											<option value="${big.localBigCode}" ${big.localBigCode eq searchVO.searchLocationBig ? 'selected' : '' }>${big.localBigName}</option>
										</c:forEach>
									</select>
							</div>
						</div>
						<div class="col-sm-2">
							<div class="col-sm">
								<select id="id_searchLocationMid" name="searchLocationMid" class="form-select" aria-label="Floating label" >
									<option value="">-- 시/군/구 --</option>
								</select>
							</div>
						</div>
					</div>
					<div class="form-group">
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
		<!-- END : 검색 폼  -->
		<!-- 모임 리스트 뿌리기 -->
		<table class="table table-hover">
		<thead>
			<tr>
				<th scope="col">모임 사진</th>
				<th scope="col">모임 이름</th>
				<th scope="col">지역</th>
				<th scope="col">매니저</th>
				<th scope="col">모임 카테고리</th>
				<th scope="col">모임 현재 인원</th>
			</tr>
		</thead>
			<tbody>
			<c:forEach items="${moimList}" var="moim">
				<tr>
					<td>
						<c:choose>
							<c:when test="${moim.moimImage eq null}">
								<img src="/resource/images/moim/moim_noimg.jpg" alt="no_image" width="70px" height="70px">
							</c:when>
							<c:otherwise>
								<img src="/img${moim.moimImage }" width="70px" height="70px">
							</c:otherwise>
						</c:choose>
					</td>
					<td>
						${moim.moimName }
					</td>
					<td>
						${moim.moimBigName } ${moim.moimLocalName }
					</td>
					<td>
						${moim.managerId }
					</td>
					<td>
						${moim.moimCategory }
					</td>
					<td>
						${moim.moimMemberCount}명
					</td>
					<td>
						<button onclick="moim_delete('${moim.moimCode}')">삭제</button>
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<!-- 페이지네이션 -->
	<hn:paging searchVO="${searchVO }" linkPage="moimListForAdmin"></hn:paging>
</body>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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

	// 초기화 버튼 클릭
	$('#id_btn_reset').click(function() {
		f.curPage.value = 1;
		f.searchAge.value = "";
		f.searchHobby.options[0].selected = true;
		f.searchLocationBig.options[0].selected = true;
		f.searchLocationMid.options[0].selected = true;
		f.searchGender.options[0].selected = true;
	}); // #id_btn_reset.click

	<!-- 지역 셀렉트 박스용 스크립트 -->
	function  getLocation() {
		var bigCode = $('#id_searchLocationBig').val();
		var request = $.ajax({
			type : 'POST',
			data : {
				bigCode : bigCode
			},
			url : '/moim/locationDetail.ajax',
			dataType : "json",
			success : function(result) {
				$('#id_searchLocationMid').empty();
				$('#id_searchLocationMid').append('<option value="">--선택하세요--</option>');
				$.each(result, function(i, el){
					$('#id_searchLocationMid').append('<option value="'+el.localMidCode+'">'+el.localMidName+'</option>');
				});
			},
			error : function(xhr, status, error) {
				console.log('status : ' + xhr.status);
			}
		});
	}
	
	/* 모임 삭제 */
	function moim_delete(moimCode) {
		var moimInfo = {"moimCode" : moimCode};
		$.ajax({
			type:"POST" ,
			url: "/admin/moimDelete.ajax" ,				// 상대 경로 사용시 매핑은 /join/email.wow
			data: JSON.stringify(moimInfo),				// String 형식으로 전환, 해당메서드에서 application/json으로 변환해주기에 맵(오브젝트) 형식으로 보내면 에러가 남.
			dataType: "text",
			contentType: 'application/json; charset=UTF-8',
			success:function(data){
				if(data == "TRUE"){
		 			Swal.fire({
						  position: 'center',
						  icon: 'success',
						  title: "모임 삭제 완료",
						  showConfirmButton: false,
						  timer: 1500
					}); 
		 			location.reload();
				}else if(data == "FALSE"){
		 			Swal.fire({
						  position: 'center',
						  icon: 'error',
						  title: "모임 삭제 실패",
						  showConfirmButton: false,
						  timer: 1500
					}); 
				}
			}
		});
	}
</script>
</html>



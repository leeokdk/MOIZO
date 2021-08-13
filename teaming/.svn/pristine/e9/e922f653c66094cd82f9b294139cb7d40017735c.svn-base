<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="hn" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<%
request.setCharacterEncoding("UTF-8");
%>
<html>
<head>
<%@ include file="/WEB-INF/inc/header.jsp"%>
<meta charset="UTF-8">
<title>Teaming</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Batang&display=swap" rel="stylesheet">

<style type="text/css">
label { float: left; }
body,html {font-family: 'Gowun Batang', serif;}
h3 {margin-bottom: 5%}
</style>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
<%@ include file="/WEB-INF/inc/top.jsp"%>
	<div class="container">
		<div class="page-header">
			<h3>
				모임 리스트
			</h3>
		</div>
		<!-- START : 검색 폼  -->
		<div class="container-mg">
				<form name="search" action="moimList" method="post">
					<input type="hidden" name="curPage" value="${searchVO.curPage }"> <input type="hidden" name="rowSizePerPage" value="${searchVO.rowSizePerPage }">
					
					<div>
							<div style=" width: 500px; margin-bottom: 2%;">
								<div class="form-floating">
								<select id="id_searchHobby" name="searchHobby" class="form-select" aria-label="Floating label" >
									<option value="">-- 관심사 --</option>
									<c:forEach items="${hobbyList}" var="hobby">
										<option value="${hobby.hbCode}" ${hobby.hbCode eq searchVO.searchHobby ? 'selected' : '' }>${hobby.hbName}</option>
									</c:forEach>
								</select>
								<label for="id_searchHobby" class="control-label">카테고리</label>
								</div>
							</div>
						<div class="row g-2">
							<div class="col-sm">
								<div class="form-floating">
									<select id="id_searchLocationBig" name="searchLocationBig" onchange="getLocation()" class="form-select" aria-label="Floating label" >
										<option value="">-- 시/도 --</option>
										<c:forEach items="${locationList}" var="big">
											<option value="${big.localBigCode}" ${big.localBigCode eq searchVO.searchLocationBig ? 'selected' : '' }>${big.localBigName}</option>
										</c:forEach>
									</select>
								<label for="id_searchLocationBig" class="control-label">지역 대분류</label>
								</div>
							</div>
							<div class="col-sm">
								<div class="form-floating">
								<select id="id_searchLocationMid" name="searchLocationMid" class="form-select" aria-label="Floating label" >
									<option value="">-- 시/군/구 --</option>
								</select>
								<label for="id_searchLocationBig" class="control-label">지역 중분류</label>
								</div>
							</div>
						</div>
						<div class="row" style=" margin-top: 2%">
							<p>가입조건</p>
							<div class="col">
								<input type="radio" name="searchGender" value="">&nbsp;상관없음&nbsp;&nbsp; 
								<input type="radio" name="searchGender" value="M">&nbsp;남자만&nbsp;&nbsp; 
								<input type="radio" name="searchGender" value="F">&nbsp;여자만&nbsp;&nbsp;
								<label for="id_searchGender" style=" margin-right: 2%">성별</label>
							</div>
							<div class="col">
								<input name="searchAge" placeholder="숫자만 입력가능" Class="form-control input-sm" style="width: 140px; display: inline;"/>
								<label for="id_searchAge" class="control-label" style="margin-top: 1.5%; margin-right: 3%;">나이</label>
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
		<hr>
		<!-- 모임 리스트 뿌리기 -->
		<div class="row row-cols-1 row-cols-md-3 g-4">
			<c:forEach items="${moimList}" var="moim">
				<div class="col">
					<div class="card h-100">
				
				<!-- 좋아요 부분 -->
				<div style="font-size:24px;" class="ms-auto">
					<span name="heart_cnt">${moim.moimLike }</span>
					
					<span name="heart_me">
						<a href="#" class="heart_a" onclick="fn_like('${moim.moimCode}')">
							<c:if test="${likeList ne null }">
								<c:forEach items="${likeList }" var="like">
									<c:if test="${like.moimCode eq moim.moimCode }">
										<i class="fa fa-heart" aria-hidden="true" style="color:#699bdc;"></i>&nbsp;
									</c:if>
								</c:forEach>
							</c:if>
						</a>
					</span>
				</div>
				<figure class="figure" style="margin-bottom: 0px; padding-bottom: 0px;">
					<c:choose>
						<c:when test="${moim.moimImage eq 'default' }">
							<img src="/resource/images/moim/moim_noimg.jpg" class="card-img-top" alt="no_image" style="max-height: 230px;">
						</c:when>
						<c:otherwise>
							<img src="/img${moim.moimImage }" class="card-img-top" alt="no_image" style="max-height: 230px;">
						</c:otherwise>
					</c:choose>
					<figcaption class="figure-caption text-end"><span class="badge bg-white text-dark">모임정원</span>
					<i class="fa fa-caret-right"></i>
					<span class="badge bg-moim">${moim.moimMemberCount}/${moim.moimLimitMaximum }</span>&nbsp;</figcaption>
				</figure>
						<div class="card-body">
							<h5 class="card-title">
								<a href="moimView?moimCode=${moim.moimCode }">${moim.moimName }</a>
							</h5>
							<p class="card-text">
								<small class="text-muted">
								#${moim.moimCategory }&nbsp;
								#${moim.moimBigName}&nbsp;${moim.moimLocalName}
								<c:if test="${moim.moimLimitGender ne null }">
									#<c:choose><c:when test="${moim.moimLimitGender eq 'F'}">여자만</c:when><c:otherwise>남자만</c:otherwise></c:choose>
								&nbsp;</c:if>
								<c:if test="${moim.moimLimitAge ne null }">#${moim.moimLimitAge }세~${moim.moimLimitAgeEnd }세</c:if>
								</small><br>
								<c:choose>
									<c:when test="${fn:length(moim.moimIntroduce) >= 50 }">
										${fn:substring(moim.moimIntroduce,0,50)}...
									</c:when>
									<c:otherwise>
										${moim.moimIntroduce }
									</c:otherwise>
								</c:choose>
							</p>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>

	</div>
		<!-- 페이지네이션 -->
	<hn:paging searchVO="${searchVO }" linkPage="moimList"></hn:paging>

	<%@include file="/WEB-INF/inc/bottom.jsp"%>
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
		f.searchAge.value = "";
		f.searchHobby.options[0].selected = true;
		f.searchLocationBig.options[0].selected = true;
		f.searchLocationMid.options[0].selected = true;
		f.searchGender.options[0].selected = true;
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

	<!-- like 기능 -->
	$('.heart_a').click(function(e) {
		e.preventDefault();
		<% if(userInfoMap != null){ %>
			if($(this).find('i').attr('class') == 'fa fa-heart-o' ){
				$(this).find('i').attr('class','fa fa-heart');
				$save = $(this).parent('span').prev().text();
				$save *= 1; //string을 number로
				$(this).parent('span').prev().empty();
				$(this).parent('span').prev().text($save+1);
			}else{
				$(this).find('i').attr('class','fa fa-heart-o');
				$save = $(this).parent('span').prev().text();
				$save *= 1; //string을 number로
				$(this).parent('span').prev().empty();
				$(this).parent('span').prev().text($save-1);
			}
		<% } %>
	});
	function need_login() {
		Swal.fire({
				  position: 'center',
				  icon: 'warning',
				  title: 'service for user',
				  text: '로그인 해주세요',
				  showConfirmButton: false,
				  timer: 1500
		}); 
	};
	function fn_like(moimCode) {
		<% if(userInfoMap == null){ %>
			return need_login();
		<%}%>
		var moimCode = moimCode;
  		var request = $.ajax({
			type : 'POST',
			data : {
				moimCode : moimCode
			},
			url : '/moim/userlike.ajax',
			dataType : "text",
			success : function(result) {
				Swal.fire({
					  position: 'center',
					  icon: 'info',
					  title: 'success',
					  text: result,
					  showConfirmButton: false,
					  timer: 1500
			}); 
			},
			error : function(xhr, status, error) {
				console.log('status : ' + xhr.status);
			}
		}); 
	};
	
	$(document).ready(function() {
		$heart = $(".heart_a");
		<% if(userInfoMap == null){ %>
			$heart.append('<i class="fa fa-heart-o" aria-hidden="true" style="color:#699bdc;"></i>&nbsp;');
		<%}else{%>
			if($("i.fa-heart").length != 0){
				$heart.each(function(idx, el){
					if($(el).find('i.fa').length == 0){
						$(el).append('<i class="fa fa-heart-o" aria-hidden="true" style="color:#699bdc;"></i>&nbsp;');
					}
				}); // each
			}else{
				$heart.append('<i class="fa fa-heart-o" aria-hidden="true" style="color:#699bdc;"></i>&nbsp;');
			}
		<%}%>
	});
	
	<!-- 지역 셀렉트 박스용 스크립트 -->
	function  getLocation() {
		var bigCode = $('#id_searchLocationBig').val();
		var request = $.ajax({
			type : 'POST',
			data : {
				bigCode : bigCode
			},
			url : '/moim/locationDetail.ajax',
			dataType : "application/json; charset=UTF-8",
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
	
</script>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<%
request.setCharacterEncoding("utf-8");
%>
<html>
<head>
<%@include file="/WEB-INF/inc/header.jsp"%>
<title>Teaming</title>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Batang&display=swap" rel="stylesheet">
<!-- toastr css 라이브러리 -->
<link rel="stylesheet" type="text/css" href="http://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css" />
<style type="text/css">
body,html {font-family: 'Gowun Batang', serif;}
div.container-lg {margin-bottom: 50px}
/*오버레이 스타일*/
    .overlay_info {white-space:nowrap; border-radius: 6px; margin-bottom: 12px; float:left; position: relative; border: 1px solid #ccc; border-bottom: 2px solid #ddd;background-color:#fff;}
    .overlay_info:nth-of-type(n) {border:0; box-shadow: 0px 1px 2px #888;}
    .overlay_info a {display: block; background: #699bdc; background: #699bdc url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center; text-decoration: none; color: #fff; padding:12px 36px 12px 14px; font-size: 14px; border-radius: 6px 6px 0 0}
    .overlay_info .desc {padding:14px;position: relative; min-width: 190px; height: 56px}
    .overlay_info img {vertical-align: top;}
    .overlay_info .address {font-size: 12px; color: #333; position: absolute; left: 14px; right: 14px; top: 14px; white-space: normal}
    .overlay_info:after {content:'';position: absolute; margin-left: -11px; left: 50%; bottom: -12px; width: 22px; height: 12px; background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png) no-repeat 0 bottom;}
</style>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=09c02aa60973d4ad1717f433279eb3b4&libraries=services,clusterer"></script>
<!-- toastr js 라이브러리 -->
<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
</head>
<body>
	<%@include file="/WEB-INF/inc/top.jsp"%>
	
<script type="text/javascript">
<!-- 검색 관련 -->
var f = document.forms['search'];
	function searchData(e){
		e.preventDefault();
		f.submit();
	};

<!-- 로그인 관련 -->
if(${not empty check}){
	if(${check.equals('n')}){
		Swal.fire({
			  position: 'center',
			  icon: 'error',
			  title: '${fail}',
			  showConfirmButton: false,
			  timer: 1500
			});
	}else if(${check.equals('y')}){
		Swal.fire({
			  position: 'center',
			  icon: 'success',
			  title: '${success}',
			  showConfirmButton: false,
			  timer: 1500
			});
	}
};
</script>
<script type="text/javascript">
<!-- 알람 -->
if(${not empty myMoimList}){
	<c:forEach items="${myMoimList}" var="mymo">
		if(${mymo.moimSparemeberCount} > 0){
			toastr.options.onclick = function() {
				window.open('<%=request.getContextPath()%>/moim/moimView?moimCode='+'${mymo.moimCode}','_self');
			}; 
			toastr.info('가입신청이'+${mymo.moimSparemeberCount}+'건 들어왔습니다','${mymo.moimName}',{timeOut: 5000});
		};
	</c:forEach>
};
if(${not empty moimSchedule_swal}){
	<c:forEach items="${moimSchedule_swal}" var="sch">
	toastr.options.onclick = function() {
		window.open('<%=request.getContextPath()%>/moim/moimView?moimCode='+'${sch.moimCode}','_self');
	}; 
	toastr.warning('일정이 내일입니다. 확인해주세요.','${sch.moimName}',{timeOut: 5000});
	</c:forEach>
};
</script>
	<div class="container-xl">
		<!-- 검색창 -->
		<div
			style="margin-left: 10rem; margin-right: 10rem; margin-top: 0; margin-bottom: 3rem; padding: 1rem;">
			<form name="search" action="/moim/moimList" method="post">
				<div class="input-group input-group-lg" style="top: 10px">
					<span class="input-group-text" id="inputGroup-sizing-lg"
						style="border-right: 0px; background-color: #ffffff; height: 70px;">
						<i class="fa fa-search fa-2" aria-hidden="true"></i>
					</span> <input type="text" class="form-control"
						aria-label="Sizing example input" name="searchWord"
						aria-describedby="inputGroup-sizing-lg" preholder="소모임을 입력해주세요"
						style="border-left: 0px; height: 70px;"
						onkeypress="if( event.keyCode == 13 ){searchData(e);}">
				</div>
			</form>
		</div>
		<!-- 검색창end -->

		<!-- 랭킹 3위 -->
		<div class="container-lg">
		<h2 class="text-uppercase fw-bold">
			지금 가장 <font color="#699bdc">HOT</font>한 모임을 확인해보세요
		</h2>
			<div id="carouselExampleDark" class="carousel carousel-dark slide" data-bs-ride="carousel">
				<div class="carousel-indicators">
					<button type="button" data-bs-target="#carouselExampleDark"
						data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
					<button type="button" data-bs-target="#carouselExampleDark"
						data-bs-slide-to="1" aria-label="Slide 2"></button>
					<button type="button" data-bs-target="#carouselExampleDark"
						data-bs-slide-to="2" aria-label="Slide 3"></button>
				</div>
				<div class="carousel-inner">
				<c:forEach items="${moimList }" var="moim">
					<div class="carousel-item" data-bs-interval="5000">
						<c:choose>
							<c:when test="${moim.moimImage eq 'default' }">
								<a href="/moim/moimView?moimCode=${moim.moimCode }"><img src="/resource/images/moim/moim_noimg.jpg" class="d-block w-100" alt="no_image" 
										style="height:720px;"></a>
							</c:when>
							<c:otherwise>
								<a href="/moim/moimView?moimCode=${moim.moimCode }"><img src="/img${moim.moimImage }" class="d-block w-100" alt="no_image" 
										style="height:720px; opacity:0.7;"></a>
							</c:otherwise>
						</c:choose>
						<div class="carousel-caption d-none d-md-block">
							<h5>${moim.moimName }</h5>
							<p>	<c:choose>
									<c:when test="${fn:length(moim.moimIntroduce) >= 50 }">
										${fn:substring(moim.moimIntroduce,0,50)}...
									</c:when>
									<c:otherwise>
										${moim.moimIntroduce }
									</c:otherwise>
								</c:choose></p>
						</div>
					</div>
				</c:forEach>
				</div>		
				<button class="carousel-control-prev" type="button"
					data-bs-target="#carouselExampleDark" data-bs-slide="prev">
					<span class="carousel-control-prev-icon" aria-hidden="true"></span>
					<span class="visually-hidden">Previous</span>
				</button>
				<button class="carousel-control-next" type="button"
					data-bs-target="#carouselExampleDark" data-bs-slide="next">
					<span class="carousel-control-next-icon" aria-hidden="true"></span>
					<span class="visually-hidden">Next</span>
				</button>		
			</div>
		</div>
		<div class="container-lg">
		<h2 class="text-uppercase fw-bold">
			가장 <font color="#699bdc">가까운</font> 소모임은 어떠세요?
		</h2>
			<div id="map" style="width:100%;height:500px;"></div>
			
		</div>
		<div class="container-lg">
		<h2 class="text-uppercase fw-bold">
			오늘은 <font color="#699bdc" id="random_cate">${randHbName}</font> 소모임을 추천합니다!
		</h2>
		<div class="row row-cols-1 row-cols-md-3 g-4">
			<c:forEach items="${moimList_pro}" var="moimp">
				<div class="col">
					<div class="card h-100">				
					<c:choose>
						<c:when test="${moimp.moimImage eq 'default' }">
							<img src="/resource/images/moim/moim_noimg.jpg" class="card-img-top" alt="no_image" style="max-height: 230px;">
						</c:when>
						<c:otherwise>
							<img src="/img${moimp.moimImage }" class="card-img-top" alt="no_image" style="max-height: 230px;">
						</c:otherwise>
					</c:choose>
						<div class="card-body">
							<h5 class="card-title">
								<a href="/moim/moimView?moimCode=${moimp.moimCode }">${moimp.moimName }</a>
							</h5>
							<p class="card-text">
								<small class="text-muted">
								#${moimp.moimCategory }&nbsp;
								#${moimp.moimBigName}&nbsp;${moimp.moimLocalName}
								<c:if test="${moimp.moimLimitGender ne null }">
									#<c:choose><c:when test="${moimp.moimLimitGender eq 'F'}">여자만</c:when><c:otherwise>남자만</c:otherwise></c:choose>
								&nbsp;</c:if>
								<c:if test="${moimp.moimLimitAge ne null }">#${moimp.moimLimitAge }세~${moimp.moimLimitAgeEnd }세</c:if>
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
		</div><!-- container-lg -->

	</div><!-- end .container -->
	<%@include file="/WEB-INF/inc/bottom.jsp"%>
</body>
<script type="text/javascript">
<!-- 랭킹 -->
$(document).ready(function() {
	$("div.carousel-inner").children('.carousel-item:eq(0)').addClass('active');
	$("div.carousel-inner").children('.carousel-item:eq(1)').attr('data-bs-interval', '5000');
	$("div.carousel-inner").children('.carousel-item:eq(2)').removeAttr('data-bs-interval');
});

<!-- map -->
		$.ajax({
			type : 'POST',
			url : '/moim/moimmap.ajax',
			dataType : "json",
			contentType: 'application/json; charset=UTF-8',
			async: false,
			success : function(result) {
				console.log(result);

				var map = new kakao.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
			        center : new kakao.maps.LatLng(36.2683, 127.6358), // 지도의 중심좌표
			        level : 13 // 지도의 확대 레벨
			    });
			    
				// 주소-좌표 변환 객체를 생성합니다
				var geocoder = new kakao.maps.services.Geocoder();
				// 주소로 좌표를 검색합니다
				var maxNum = result.vo.length;
				var moimNameClone = [];
				var moimCodeClone = [];
				for(var i=0; i<maxNum; i++){
					moimNameClone.push(result.vo[i].moimName);
					moimCodeClone.push(result.vo[i].moimCode);
					geocoder.addressSearch(result.vo[i].moimAdress, function(rs, status) {
					    // 정상적으로 검색이 완료됐으면 
					   if ("OK" == kakao.maps.services.Status.OK) {
					      
					   		// 마커가 표시될 위치입니다 
					      var markerPosition  = new kakao.maps.LatLng(rs[0].y, rs[0].x);
					      // 마커를 생성합니다
 					      var marker = new kakao.maps.Marker({
					          position: markerPosition
					      }); 
					      // 마커가 지도 위에 표시되도록 설정합니다
					      marker.setMap(map);
					      
					      var content = '<div class="overlay_info" >';
					      content += '    <a href="<%=request.getContextPath()%>/moim/moimView?moimCode='+moimCodeClone.pop()+'" target="_self">';
					      content += '		<strong>'+moimNameClone.pop()+'</strong></a>';
					      content += '    <div class="desc">';
					      content += '        <span class="address">'+rs[0].address_name+'</span>';
					      content += '    </div>';
					      content += '</div>';
					      
						    // 인포윈도우를 생성합니다
						    var infowindow = new kakao.maps.InfoWindow({
						        content : content,
						        removable : true
						    });	
						    
						 	// 마커에 클릭이벤트를 등록합니다
						    kakao.maps.event.addListener(marker, 'click', function() {
						    	infowindow.open(map, marker);
						    });

					    } //if 
					});    
				}; //for문 
				
			},
			error : function(xhr, status, error) {
				console.log('status : ' + xhr.status);
				alert(error);
			}
		});
</script>
</html>
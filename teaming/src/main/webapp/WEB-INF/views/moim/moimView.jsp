<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="avo" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<%
request.setCharacterEncoding("UTF-8");
%>
<html>
<head>
<%@include file="/WEB-INF/inc/header.jsp"%>
<meta charset="UTF-8">
<title>Teaming</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Batang&display=swap" rel="stylesheet">
<style type="text/css">
body,html {font-family: 'Gowun Batang', serif;}

/* {	cursor: url(cursor.cur), url } */

/* 전역 적용 안됨 */
::selection {
  background: #699bdc;
   color: #fff;
}

textarea {resize: none;}
.quickmenu {
	background-color: #F0F0F0;
	position: absolute;
	top: 20%;
	right: 10%;
	padding: 3px 10px
	padding: 3rem; 
    background-color: #fff;
    box-shadow: 0 0.3rem 0.6rem 0 rgb(0 0 0 / 10%);
}
   
div, ul, li {-webkit-box-sizing: border-box;-moz-box-sizing: border-box;box-sizing: border-box;padding:0;margin:0}

a {text-decoration:none;}
	
	
.content {position:relative;min-height:1000px;}


div.quickmenu  a i.fa  {color : rgba(0, 0, 0, 0.28)} 

div.quickmenu  a i.schedule-enter-active {color:#699bdc; }

</style>
<body>
 

<%@include file="/WEB-INF/inc/top.jsp"%>
	
<!-- 일정 DIV 스크롤을 따라다님  -->
<div class="quickmenu">
		

<div class="card" style="width: 22rem;">
  <div class="card-body">
    <h6 class="card-title">모임 일정</h6>
    
    <!--  DNA  일정 팝업	 AJAX로 들고옴 -->
    <div id="id_schedule">
    	
    	<!--  AJAX 부분~ -->
		
	</div>
	
<c:if test="${userInfoMap ne null }">
	<c:choose>
		<c:when test="${userInfoMap.get(moim.moimCode) eq null }">
			<div class="pull-right">
				<button class="btn btn-primary" type="button" onclick="join_member()">소모임 가입하기</button>
			</div>
		</c:when>
		
		<c:when test="${userInfoMap.get(moim.moimCode).roleName.equals('SPAREMEMBER')}">
			<input readonly="readonly" value="가입 승인 중입니다." style="border: none; text-align: center;">
							<div class="spinner-border text-info" role="status" style="position: absolute; margin-left: -80px;  width: 20px; height: 20px;">
								<span class="visually-hidden">Loading...</span>
							</div>
						</c:when>
		
		<c:when test="${userInfoMap.get(moim.moimCode).roleName.equals('MANAGER')}">
		<hr>
			<div class="pull-left">
				 <button class="btn btn-primary" type="button" onclick="popup_edit()"  style="margin-top: 2%">일정 관리</button>
			</div>
			<div class="pull-right">
				 <button class="btn btn-primary" type="button" onclick="popup_form()" style="margin-top: 2%">일정 등록</button>
			</div>
		</c:when>
	
	</c:choose>
</c:if>				
		
               
  
  </div>
</div> 
</div>
<!--  DNA  일정 팝업	 -->




<!-- 모임 설명  -->

	<div class="container" style="padding-right: 20%;">
		
		<h2 class="mName" style="margin-top: 5%">${moim.moimName }</h2>
		<h6><i class="fa fa-align-justify"></i> 
		${ moimCategory} ${moimLocalName }
		 <c:choose><c:when test="${moimCategory eq null }">${moim.moimCategory }</c:when>
		 <c:otherwise>${moimCategory }</c:otherwise></c:choose>
		 &nbsp; &nbsp;<i class="fa fa-map-marker"></i>
		 <c:choose><c:when test="${moimLocalName eq null }">${moim.moimLocalName }</c:when>
		 <c:otherwise>${moimLocalName }</c:otherwise></c:choose>
		 &nbsp; &nbsp;
		<c:if test="${moim.moimLimitAge ne null }"> <i class="fa fa-check"></i>${moim.moimLimitAge}살 ~ ${moim.moimLimitAgeEnd}살</c:if>
		<c:if test="${moim.moimLimitGender ne null }"> &nbsp; &nbsp;${moim.moimLimitGender eq 'F' ?  '<i class="fa fa-check"></i> 여자만' : '<i class="fa fa-check"></i>&nbsp;&nbsp;남자만' }  &nbsp; &nbsp;</c:if>
		<i class="fa fa-users"></i>최대 ${moim.moimLimitMaximum }명
		</h6>
		
		
		<div>
			<c:choose>
				<c:when test="${moim.moimImage eq 'default' }">
					<img src="/resource/images/moim/moim_noimg.jpg" class="img-fluid" alt="no_image" style="height:541px; width:962px;">
				</c:when>
				<c:when test="${moimImage ne null}">
					<img src="/img${moimImage }" class="img-fluid" alt="no_image" style="height:541px; width:962px;">
				</c:when>
				<c:otherwise>
					<img src="/img${moim.moimImage }" class="img-fluid" alt="no_image" style="height:541px; width:962px;">
				</c:otherwise>
			</c:choose>
		</div>
		
<!-- 매니저면 글쓰기 버튼이 보임 -->
	<c:if test="${userInfoMap ne null }">
		<c:choose>
			<c:when test="${userInfoMap.get(moim.moimCode).roleName.equals('MANAGER')}">
				<div class="row">
				    <div class="col-sm-2 col-sm-offset-10 text-right" style="margin-bottom: 5px;" >
				        <a href="/moimManager/moimNoticeForm?moimCode=${moimCode }" class="btn btn-primary btn-sm"> 
				        	<span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>
				        	&nbsp;새글쓰기
						</a>
				    </div>
				</div>
			</c:when>
		</c:choose>
	</c:if>
	
	<!-- // START : 공지 게시판 목록 영역   -->
	<!-- Member와 manager만 보이게 -->
 	<c:if test="${userInfoMap ne null }">
		<c:choose>
			<c:when test="${userInfoMap.get(moim.moimCode).roleName.equals('MANAGER') || userInfoMap.get(moim.moimCode).roleName.equals('MEMBER') }">
				<table class="table table-hover" style="text-align: center;">
					<thead>
						<tr>
							<th scope="col"><i class="fa fa-asterisk"></i></th>
							<th scope="col">TITLE</th>
							<th scope="col">WRITER</th>
							<th scope="col">DATE</th>
							<th scope="col">VIEW</th>
						</tr>
					</thead>
					<tbody id="id_mNotice_list_area">
						<!-- 이부분에 Ajax가 채워짐  -->
					</tbody>
				</table>
				
			<!-- 페이징 -->			
			<nav aria-label="Page navigation example">
				<ul class="pagination justify-content-center" id = "id_page">
						<!-- 이부분에 Ajax가 채워짐  -->
				</ul>
			</nav>
		
 		</c:when>
	</c:choose>
</c:if>		
	<!-- // END : 공지 게시판 목록 영역   -->




		<!-- 탭 화면 구성 -->
		<div class="moimTab">
		<ul class="nav nav-tabs" id="myTab" role="tablist">
			<li class="nav-item" id="tab1" role="presentation">
				<button class="nav-link active" id="home-tab" data-bs-toggle="tab"
					data-bs-target="#home" type="button" role="tab"
					aria-controls="home" aria-selected="true">모임 소개</button>
			</li>
			<li class="nav-item" role="presentation" id="tab2">
				<button class="nav-link" id="profile-tab" data-bs-toggle="tab"
					data-bs-target="#profile" type="button" role="tab"
					aria-controls="profile" aria-selected="false">맴버</button>
			</li>
			<li class="nav-item" role="presentation" id="tab3">
				<button class="nav-link" id="contact-tab" data-bs-toggle="tab"
					data-bs-target="#contact" type="button" role="tab"
					aria-controls="contact" aria-selected="false">게시판</button>
			</li>

		</ul>
		<div class="tab-content" id="myTabContent">
			<div class="tab-pane fade show active" id="home" role="tabpanel"
				aria-labelledby="home-tab">...</div>
			<div class="tab-pane fade" id="profile" role="tabpanel"
				aria-labelledby="profile-tab">...</div>
			<div class="tab-pane fade" id="contact" role="tabpanel"
				aria-labelledby="contact-tab">...</div>
		</div>

	</div>

</div>	<!-- container 종료  -->
	
<!-- Footer -->
<footer class="text-center text-lg-start bg-moim text-light">

	<!-- Section: Links  -->
	<section style="margin-top: 8%;">
		<div class="container text-center text-md-start mt-5">
			<!-- Content -->
			<h6 class="text-uppercase fw-bold mb-4">Teaming</h6>
			<p>Teaming, the Best website to create Moim in the world</p>
		</div>
	</section>
	<!-- Section: Links  -->

	<!-- Copyright -->
	<div class="text-center p-4"
		style="background-color: rgba(0, 0, 0, 0.05);">
		      <address>
                        Copyright © 2021
                        <a href="http://www.nextit.or.kr/"><strong style="color: white;">MOIZO</strong></a>
                        All Rights Reserved.
                  </address>
		
</div>
	<!-- Copyright -->
</footer>
<!-- Footer -->

</body>
<!-- Tap을 위한 스크립트 -->
<script type="text/javascript">
$(document).ready(function() {
		
		$("#myTabContent").load("moimIntroduce?moimCode=${moim.moimCode}"); // 모임 소개

		$("ul#myTab li").click(function() {
			$("ul#myTab li").removeClass("active");
			$(this).addClass("active");

			var activeTab = $(this).attr("id");
			/* 	$("#" + activeTab).fadeIn(); */

			if (activeTab == "tab1") {
				$("#myTabContent").load("moimIntroduce?moimCode=${moim.moimCode}");  // 모임소개
			} else if (activeTab == "tab2") {
				$("#myTabContent").load("moimMemberList?moimCode=${moim.moimCode}"); // 맴버리스트
			} else if (activeTab == "tab3") {
				$("#myTabContent").load("freeList?moimCode=${moim.moimCode}"); // 자유게시판
			} else if (activeTab == "tab4") {
				$("#myTabContent").load("banana4?moimCode=${moim.moimCode}"); // 사진게시판
			}
		});
		//fn_mNotice_list();
	});
</script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script type="text/javascript">
var params = {"curPage" : 1, "rowSizePerPage": 3 ,"boardCode": "NTMA", "moimCode" : '${moim.moimCode}'};


// 현재 사용자가 해당 모임의 스케줄 참여 리스트를 가져와 화면 제어 
function fn_moim_schedule_by_user_list(){	
	$.ajax({
		 type		: 'POST'
		,url 		: '<c:url value="/schedule/scheduleListByUser" />'
		,dataType	: 'JSON'	// 서버 (Controller 메소드 리턴)에서 받을 데이터 타입
		,data 		: params			 
		,success	: function (data) {	
			console.log('data', data);
			if(data.result) {
				$.each(data.data, function(index, element) {
					$('#id_sch_' + element.mScheduleNo).find('a i').addClass('schedule-enter-active');					
				}); // each	
			}	
		}	// success
		,error	: function (req, st, err) {
			console.log('req', req);			
			console.log('st', st);
			console.log('err', err);
		}
	})

	
} // fn_moim_schedule_by_user_list()

/* 일정 가져오는 ajax */
 function fn_schedule_list() {
	$.ajax({
		 type		: 'POST'
		,url 		: '<c:url value="/schedule/scheduleList" />'
		,dataType	: 'JSON'	// 서버 (Controller 메소드 리턴)에서 받을 데이터 타입
		,data 		: params			 //url 요청 시 파라미터 정보 
		,success	: function (data) {	//data = map
			// 댓글 목록 영역에 list 개수 만큼 댓글 추가
			// 더보기 기능 조건 $(curPage +=1)
			console.log('data', data);
			if(data.result) {
				$div = $('#id_schedule');
				$div.empty()
					var str ='';
					var popup = 'onclick="window.open(this.href ,\'_blank\',\'width = 600, height = 600, left = 100, top = 50\'); return false;"';
					// 현재날짜 
					var today = new Date();   
				$.each(data.data, function(index, element) {	
					console.log(Date.parse(today)<Date.parse(element.mScheduleModDate));
					console.log(Date.parse(today)>=Date.parse(element.mScheduleModDate));
				str+= '<div class="card" style="border: 1px solid rgba(0, 0, 0, 0.3); margin-bottom: 3%;">'
					 + ' <ul class="list-group list-group-flush">'
					 + '   <li class="list-group-item" style="font-size: 95%;  display: flex;">'
					 + '      <div class="left" style="flex: 0 0 auto; display: inline-block;">'
					 + '        <p class="time" style="display: flex; margin: auto; align-items: center; padding-bottom: 2%;">'
					 +'           <span>'+ element.mScheduleModDate +'</span>'
					 +'           <span>&nbsp;|&nbsp;</span>'
					 +'           <span>'+ element.mScheduleStartTime + '~' + element.mScheduleEndTime + '</span></p>'
					 +'         <p class="status" style="display: flex; margin: auto; align-items: center;">'
					 +'          <input type="hidden" value="'+ element.mScheduleNo + '" id= "id_sch2_' + element.mScheduleNo + '" > '
					 +'           <span class="id_edit2" style="display: none;"><a href="/schedule/scheduleEdit?mScheduleNo=' + element.mScheduleNo+'"   ' + 
							 popup + 
							 '>' + element.mSchedulePlace + '&nbsp;<i class="fa fa-edit"></i></a></span>'
					 +'           <span class="id_edit">' + element.mSchedulePlace + '</span>'
					 +'           <span style="margin-left: auto;"><span class="cls-schedule-enter">신청&nbsp;'+ element.mScheduleEnter +'</span>&nbsp;/&nbsp;정원&nbsp;' + element.mScheduleEnterMax +'</span></p></div>  '
					 +'       <div class="right" id="id_sch_' + element.mScheduleNo + '"   style="flex: 1 1 auto; display: inline-block; padding-top: 3%; padding-left: 81%; position: absolute;">';
					
					 //계획날짜가 현재날짜를 지났을 경우 못 누르게 막기 
					 if(Date.parse(today) <= Date.parse(element.mScheduleModDate)){
						<c:if test="${userInfoMap.get(moim.moimCode) == null }">
						str+='         <span  class="check" name="heart_me" style="display: flex;">'
						 +'              <i class="fa fa-check-circle fa-2x " aria-hidden="true" style="color: rgba(0, 0, 0, 0.3);"></i></a>'
						 + '        </span>';
						</c:if>					 			 
						<c:if test="${userInfoMap.get(moim.moimCode) != null }">
						 str+='         <span  class="check" name="heart_me" style="display: flex;">'
						 +'           <a href="#" class="heart_a" onclick="fn_like(this, \'' + element.moimCode +'\',' + element.mScheduleNo + ' )">'
						 +'              <i class="fa fa-check-circle fa-2x " aria-hidden="true"></i></a>'
						 + '        </span>';
						</c:if>
					 }else{
							<c:if test="${userInfoMap.get(moim.moimCode) == null }">
							str+='         <span  class="check" name="heart_me" style="display: flex;">'
								+'           <a href="#" class="heart_a" onclick="fn_nonono()">'
								 +'              <i class="fa fa-check-circle fa-2x " aria-hidden="true" style="color: rgba(198, 118, 126, 1);"></i></a>'
								 + '        </span>';
							</c:if>					 			 
							<c:if test="${userInfoMap.get(moim.moimCode) != null }">
							 str+='         <span  class="check" name="heart_me" style="display: flex;">'
							 +'           <a href="#" class="heart_a" onclick="fn_nonono2()">'
							 +'              <i class="fa fa-check-circle fa-2x " aria-hidden="true"></i></a>'
							 + '        </span>';
							</c:if>
					 }
					 str+='</div></li></ul></div>';
			}); // each
			$div.append(str);
			}	// if
			
			data.data	// list	
			data.result	// true.false
			data.count	// list.size()
			fn_moim_schedule_by_user_list(); // 현재 사용자 스케줄 참여 목록 
		}	// success
		,error		: function (req, st, err) {
			alert(st);			
		}
	})
	
} // fn_schedule_list

<!-- 소모임공지 게시글을 위한 스크립트  -->
function fn_mNotice_list() {
	// fn_mNotice_list는 반복해서 사용, AJAX에서 요청해서 DB접근 후 replyVOList를 가져와서 화면에 출력
	// 새로고침 안하고 바로바로 화면에 적용
	console.log(params);
	
	$.ajax({
		 type		: 'POST'
		,url 		: '<c:url value="/moim/moimNoticeList" />'
		,dataType	: 'JSON'	// 서버 (Controller 메소드 리턴)에서 받을 데이터 타입
		,data 		: params			 //url 요청 시 파라미터 정보 
		,success	: function (data) {	//data = map
			// 댓글 목록 영역에 list 개수 만큼 댓글 추가
			// 더보기 기능 조건 $(curPage +=1)
			
			if(data.result) {
				$tbody = $('#id_mNotice_list_area');
				//$tbody.remove();
				$tbody.empty()
					var str ='';
				
					$.each(data.data, function(index, element) {	//list를 반복하는데 index, element()				
					var dt = element.mNoticeModDate == "" || element.mNoticeModDate == null ? element.mNoticeRegDate  : element.mNoticeModDate 
					str+= '<tr><th scope="row" style="width: 70px;"> &nbsp;'+ element.rNum 	
						 + '<td class="text-left" style="width: 250px;"><a href="/moimManager/moimNoticeView?mNoticeNo='+element.mNoticeNo+'">'+element.mNoticeTitle + '</a></td>'
						 +'<td>'+ element.mNoticeWriter +'</td>'
					     +'<td>'+ dt + '</td>'
					     +'<td>' + element.mNoticeHit + '</td>'
						 +'</tr>';
				}); // each
				$tbody.append(str);

				$page = $("#id_page");
				$page.empty();
				var paging = "";
				var pag = data.pagination;
				
					paging+= '<li class="page-item"><a class="page-link" href="#" data-page="1"><span aria-hidden="true">&laquo;</span></a></li>'
						
					
						
					 if(pag.firstPage != 1) {
					 paging+= '<li><a href="#" data-page="'+(pag.firstPage-1)+'" class="page-link"><span aria-hidden="true">&lt;</span></a></li>'
					} 
					
					for(i = pag.firstPage; i <= pag.lastPage; i++ ) {
						 if(pag.curPage != i){
							 paging += '<li class="page-item"><a class="page-link" href="#" data-page='+ i +'>'+ i +'</a></li>'
						 } else {
							 paging += '<li class="active"><a class="page-link" href="#" data-page='+ i +'>'+ i +'</a></li>' 
						 }
					}	//for문 
 					 if(pag.lastPage != pag.totalPageCount ){
 						paging+= '<li><a class="page-link" href="#"  data-page="'+ (pag.lastPage+1)+'">&gt;</span></a></li>'
					 }
 					
 					paging+='<li class="page-item"> <a class="page-link" href="#"  data-page="'+(pag.totalPageCount)+'" aria-label="Next"> <span aria-hidden="true">&raquo;</span> </a> </li>'
					
				
								
				$page.append(paging);
				
				
				$('#id_page li a').on('click',  function(e) {				
					e.preventDefault(); 
					fn_submit($(this).data('page'));
				}); // ul.pag
				
			}	// if
			data.data	// list	
			data.result	// true.false
			data.count	// list.size()
		}	// success
		,error		: function (req, st, err) {
			alert(st);			
		}
	})
	
} // fn_mNotice_list


function fn_submit(p) {
 	params.curPage = p;
 	console.log('test ====  '+  params.curPage);
	
	fn_mNotice_list();
}

$(document).ready( function() {
	fn_schedule_list(); // 스케쥴 목록 


	// 이벤트 전파 방지,  <a>의 기본 클릭이벤트를 막기위함
	//$('ul.pagination justify-content-center li a').click(function(e) {
	$('#id_page li a').click(function(e) {				
		e.preventDefault(); 
		// data-page에 있는 값을 f.curPage.value에 설정, 서브밋
		f.curPage.value = $(this).data('page');
		f.submit();
	}); // ul.pagination li a[data-page]
	
	
		//다음 버튼 클릭
		$('#btn_list_next').click(function(e) { 
			params.curPage += 1;
			fn_mNotice_list();
			
		}); 
		
		//이전 버튼 클릭
		$('#btn_list_Previous').click(function(e) { 
			params.curPage -= 1;
			fn_mNotice_list();
		}); // #btn_reply_list_more.click
		
		
		fn_mNotice_list();
			
		/* 스크롤 따라다니는 div */
		  var currentPosition = parseInt($(".quickmenu").css("top"));
		  $(window).scroll(function() {
		    var position = $(window).scrollTop(); 
		    $(".quickmenu").stop().animate({"top":position+currentPosition+"px"},1000);
		  });
			
			
		}); // ready
		
	

/* 모임 일정 등록 팝업창  */		
function popup_form() {
	var url = "/schedule/scheduleForm?moimCode=${moimCode }";
	var name = "scheduleForm";
	var option = "width = 600, height = 600, left = 100, top = 50, location=no";
	//location=no 주소창 표시 안함
	
	/* 자식 개수 구해서 3개를 넘으면 게시물 등록 할 수 없다는 알럿창 띄우기 */
	 var ele = document.getElementById('id_schedule');
	 var eleCount = ele.childElementCount;
	 console.log( "eleCount "+ eleCount);
	
	if(eleCount == 3) {
		Swal.fire({
			  icon: 'error',
			  title: '작성 실패',
			  text: '일정은 3개까지만 등록 가능합니다.',
			})
	} else {
		window.open(url,name,option);
	}
	
	
	
 




 
}

/* 수정 버튼 */
function popup_edit() {
	$(".id_edit2").toggle(); // show -> hide , hide -> show
	$(".id_edit").toggle(); 
}


<!-- 체크 기능 start -->
function toggleEnter($obj_i){
		$obj_i.toggleClass('schedule-enter-active');
}


function fn_like(obj, moimCode, scheduleId) {
	var $obj = $(obj);
	var moimCode = moimCode;
	var scheduleId = scheduleId;
		var request = $.ajax({
		type : 'POST',
		data : {
			moimCode : moimCode
		  , mScheduleNo : scheduleId	
		},
		url : '/schedule/changeScheduleEnter.ajax',
		/* dataType : "json", */
		success : function(data) {
			if(data.result){
				
				toggleEnter($obj.find("i"));
				$obj.closest('li.list-group-item').find('.cls-schedule-enter').text(data.vo.mScheduleEnter);
			}else{
				alert(data.message);
			}
		},
		error : function(xhr, status, error) {
			console.log('xhr : ' + xhr);
			console.log('status : ' + status);		
			console.log('error : ' + error);
		}
	}); 
}

function fn_nonono() {
	Swal.fire({
		  icon: 'error',
		  title: '참여 불가',
		  text: '일정시간이 지나 참여할 수 없습니다.',
		})
}
function fn_nonono2() {
	Swal.fire({
		  icon: 'error',
		  title: '변경 불가',
		  text: '일정시간이 지나 참여여부를 변경할 수 없습니다.',
		})
}

$(document).ready(function() {
	$heart = $(".heart_a");
	$heart.each(function(idx, el){
		if($(el).find('i.fa').length == 0){
			$(el).append('<i class="fa fa-check-circle fa-2x" aria-hidden="true" style="color:rgb(0,0,0,0.28);"></i>&nbsp;');
		}
	}); // each
	
});
<!-- 체크 기능 end -->


/************************* 가입 버튼용 함수 */
function join_member() {
 	var join_params = {"roleName":"SPAREMEMBER","moimCode":'${moim.moimCode}'};
	var request = $.ajax({
		type : 'POST',
		data : JSON.stringify(join_params),
		url : '/moim/joinMoim.ajax',
		dataType : "text",
		contentType: 'application/json; charset=UTF-8',
		success : function(data) {
 			Swal.fire({
					  position: 'center',
					  icon: 'success',
					  title: data,
					  showConfirmButton: false,
					  timer: 1500
			}); 
 			location.reload();
		},
		error : function(xhr, status, error, data) {
			console.log('status : ' + xhr.status);
			Swal.fire({
				  position: 'center',
				  icon: 'error',
				  title: data,
				  showConfirmButton: false,
				  timer: 1500
			});
			location.reload();
		}
	}); 
	
}
function out_member() {
 	var join_params = {"roleName":"MEMBER","moimCode":'${moim.moimCode}'};
	var request = $.ajax({
		type : 'POST',
		data : JSON.stringify(join_params),
		url : '/moim/outMoim.ajax',
		dataType : "text",
		contentType: 'application/json; charset=UTF-8',
		success : function(data) {
 			Swal.fire({
				  position: 'center',
				  icon: 'success',
				  title: data,
				  showConfirmButton: false,
				  timer: 1500
			});
 			location.reload();
		},
		error : function(xhr, status, error) {
			console.log('status : ' + xhr.status);
			Swal.fire({
				  position: 'center',
				  icon: 'error',
				  title: data,
				  showConfirmButton: false,
				  timer: 1500
			});
			location.reload();
		}
	}); 
	
}
/************************* 가입/탈퇴 버튼용 함수 */
</script>
</html>

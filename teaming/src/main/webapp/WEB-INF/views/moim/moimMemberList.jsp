<%@page import="java.util.Map"%>
<%@page import="com.moim.vo.LoginVO"%>
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
<body>		
	<!-- // START : 멤버 게시판 목록 영역   -->
					
					
					<h6>현재 멤버</h6>
					<table class="table table-hover">
						<thead>
							<tr>
								<th scope="col">유저 사진</th>
								<th scope="col">유저 아이디</th>
								<th scope="col">유저 이름</th>
								<th scope="col">유저 취미</th>
								<th scope="row">지역</th>
							</tr>
						</thead>
						<tbody id="id_member_list_area">
							<!-- 이부분에 Ajax가 채워짐  -->
						</tbody>
					</table>

			<!-- pagination{s} -->
	<nav aria-label="Page navigation example">
		<ul class="pagination justify-content-center" id = "member_page">
					<!-- 이부분에 Ajax가 채워짐  -->
			</ul>
		</nav>
			<!-- pagination{e} -->
			
			<!-- // END : 멤버 게시판 목록 영역   -->



<!-- // START : 예비멤버 게시판 목록 영역   -->
<c:if test="${managerCheck.roleName == 'MANAGER' }">
					<h6>신청 멤버</h6>
					<table class="table table-hover">
						<thead>
							<tr>
								<th scope="col">유저 사진</th>
								<th scope="col">유저 아이디</th>
								<th scope="col">유저 이름</th>
								<th scope="col">유저 취미</th>
								<th scope="row">지역</th>
							</tr>
						</thead>
						<tbody id="id_spare_list_area">
							<!-- 이부분에 Ajax가 채워짐  -->
						</tbody>
					</table>

			<!-- pagination{s} -->
	<nav aria-label="Page navigation example">
		<ul class="pagination justify-content-center" id = "spare_page">
					<!-- 이부분에 Ajax가 채워짐  -->
			</ul>
		</nav>
			<!-- pagination{e} -->
			
			<!-- // END : 예비멤버 게시판 목록 영역   -->
</c:if>
					
</body>
<script type="text/javascript">
var memParams = {"curPage" : 1, "rowSizePerPage": 4 , "moimCode" : '${searchVO.moimCode}'};

<!-- 소모임공지 게시글을 위한 스크립트  -->
function fn_member_list(mem) {
	// fn_mNotice_list는 반복해서 사용, AJAX에서 요청해서 DB접근 후 replyVOList를 가져와서 화면에 출력
	// 새로고침 안하고 바로바로 화면에 적용
	console.log(memParams);
	console.log(mem);
	var c_url = '';
	var btn_nm = '';
	if(mem == 'member'){
		c_url = '/moim/moimMemberList.ajax';
		btn_nm = '추방';
	}else if(mem == 'spare'){
		c_url = '/moim/moimSpareMemberList.ajax';
		btn_nm = '승인';
	}
	console.log(c_url);
		$.ajax({
			 type		: 'POST'
			,url 		: c_url
			,dataType	: 'JSON'	// 서버 (Controller 메소드 리턴)에서 받을 데이터 타입
			,data 		: memParams			 //url 요청 시 파라미터 정보 
			,success	: function (data) {	//data = map
				// 댓글 목록 영역에 list 개수 만큼 댓글 추가
				// 더보기 기능 조건 $(curPage +=1)
				
				if(data.result) {
					$tbody = $('#id_' + mem + '_list_area');
					//$tbody.remove();
					$tbody.empty()
						var str ='';
						var imgSrc = '';	
						$.each(data.data, function(index, element) {	//list를 반복하는데 index, element()
						if(element.userPic == 'default'){
							imgSrc = '<%=request.getContextPath() %>/resource/images/join/defaultProfile.png';
						}else{
							imgSrc = '/img' + element.userPic;
						} 
						str+= '<tr>'
							+ '<th scope="row">' 
							+ 		'<img alt="" src="' + imgSrc + '"  style="' + 'width: 50px; height: 50px;' + '">'
							+'</th>'
							 + '<td class="text-left">' + element.userId + '</td>'
							 +'<td>'+ element.userName +'</td>'
						     +'<td>' + element.userHobbyNm + '</td>'
						     +'<td>' + element.localBigNm + '&nbsp;' + element.localMidNm + '&nbsp;' + element.localSmallNm +  '</td>'
						<c:if test="${managerCheck.roleName == 'MANAGER' }"> 
							     + '<td> <input type="button" id="' + mem + '_btn" onclick="fn_' + mem + '(\''+element.userId+'\', this)" value="' + btn_nm + '"> </td>'
						</c:if>
							 +'</tr>';
					}); // each
					$tbody.append(str);
					/* params.curPage += 1; */
					/* $tbody.html(str); */			
					
					$page = $("#" + mem + "_page");
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
					
					
					$('#' + mem + '_page li a').on('click',  function(e) {				
						e.preventDefault(); 
						fn_submit($(this).data('page'), mem);
					}); // ul.pag
					
				}	// if
				data.data	// list	
				data.result	// true.false
				data.count	// list.size()
			}	// success
			,error:function(request,status,error){
	       	 console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
	       }
		})
	}
 // fn_member_list		
function fn_submit(p, mem) {
 	memParams.curPage = p;
 	console.log('test ====  '+  memParams.curPage);
	
 	fn_member_list(mem);
}
 
$(document).ready(function() {
	/* fn_member_list('member'); */
	fn_member_list('spare');
	fn_member_list('member');
});


// member_btn
// 탈퇴 하게 하기.
function fn_member(userId, obj) {
	var memberInfo = {"userId" : userId, "moimCode" : '${searchVO.moimCode}'};
	$.ajax({
		type:"POST" ,
		url: "/moim/outMoimForManager.ajax" ,				// 상대 경로 사용시 매핑은 /join/email.wow
		data: JSON.stringify(memberInfo),
		dataType: "text",
		contentType: 'application/json; charset=UTF-8',
		success:function(data){
			if(data == "TRUE"){
	 			Swal.fire({
					  position: 'center',
					  icon: 'success',
					  title: "강제 추방",
					  showConfirmButton: false,
					  timer: 1500
				}); 
	 			location.reload();
			}else if(data == "FALSE"){
	 			Swal.fire({
					  position: 'center',
					  icon: 'error',
					  title: "강제 추방 실패",
					  showConfirmButton: false,
					  timer: 1500
				}); 
			}
		}
	});
}
// 신청 받기
function fn_spare(userId, obj) {
	var memberInfo = {"userId" : userId, "moimCode" : '${searchVO.moimCode}'};
	$.ajax({
		type:"POST" ,
		url: "/moim/joinMoimForManager.ajax" ,				// 상대 경로 사용시 매핑은 /join/email.wow
		data: JSON.stringify(memberInfo),	
		//data:  {"userId" : userId, "moimCode" : '${searchVO.moimCode}'},
		dataType: "text",
		contentType: 'application/json; charset=UTF-8',
		success:function(data){
			if(data == "TRUE"){
	 			Swal.fire({
					  position: 'center',
					  icon: 'success',
					  title: "가입 신청을 수락하셨습니다.",
					  showConfirmButton: false,
					  timer: 1500
				}); 
	 			location.reload();
			}else if(data == "FALSE"){
	 			Swal.fire({
					  position: 'center',
					  icon: 'error',
					  title: "가입 신청 처리 불가",
					  showConfirmButton: false,
					  timer: 1500
				}); 
			}
		}
	});
}

</script>
</html>



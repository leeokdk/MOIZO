<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/inc/header.jsp"%>
<meta charset="UTF-8">
<title>Teaming</title>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Batang&display=swap" rel="stylesheet">
<style type="text/css">
body,html {font-family: 'Gowun Batang', serif;}
div.container-lg {margin-bottom: 50px}
a {text-decoration:none;}
</style>
</head>
<body>
	<%@include file="/WEB-INF/inc/top.jsp"%>
<div class="container-lg">

	<!-- 탭 화면 구성 -->
	<div class="moimTab" >
		<ul class="<!-- nav nav-tabs --> nav flex-column" id="myTab" role="tablist" >
			<li class="nav-item" id="tab1" role="presentation">
				<a class="nav-link active" id="join-tab" data-bs-toggle="tab"
					data-bs-target="#joinMoim" type="a" role="tab"
					aria-controls="joinMoim" aria-selected="true" style=" cursor: pointer;">가입모임 관리</a>
			</li>	
			<li class="nav-item" id="tab2" role="presentation">
				<a class="nav-link " id="like-tab" data-bs-toggle="tab"
					data-bs-target="#likeMoim" type="a" role="tab"
					aria-controls="likeMoim" aria-selected="true" style=" cursor: pointer;">관심모임 관리</a>
			</li>	
		<!-- 알림기능

 			<li class="nav-item" role="presentation" id="tab3">
				<a class="nav-link" id="contact-tab" data-bs-toggle="tab" data-bs-target="#contact" 
					type="a" role="tab" aria-controls="contact" aria-selected="false">알림하고싶다</a>
		style="position: fixed; top: 13%; left: 13%;
		<div class="tab-content" id="myTabContent">
			</li> -->
		<div class="tab-content" id="myTabContent" >
			<div class="tab-pane fade show active" id="joinMoim" role="tabpanel" aria-labelledby="join-tab"></div>
			<div class="tab-pane fade" id="likeMoim" role="tabpanel" aria-labelledby="like-tab"></div>
				<!-- 
					<iframe src="joinMoimList" width="1500px" height="1500px" /> 
		    <div class="tab-pane fade show active" id="joinMoim" role="tabpanel" 
		    	aria-labelledby="join-tab"></div>
		    <div class="tab-pane fade" id="likeMoim" role="tabpanel" 
		    	aria-labelledby="like-tab"></div>
				-->
				<!-- <iframe src="likeMoimList" width="1500px" height="1500px" /> -->
			<!-- 알림 기능 만들면 여기 넣으면 될듯 
			<div class="tab-pane fade" id="contact" role="tabpanel" aria-labelledby="contact-tab">
			
			</div>-->
		</div>
	</div><!-- moimTab -->
	
</div><!-- container -->
</body>
<script type="text/javascript">
var fn_load_content=function(gubunId){
	console.log(gubunId);
	var v_url = "joinMoimList";
	if(gubunId == "likeMoim"){
		v_url = "likeMoimList";
	}
	$target = $('#' + gubunId);
	$.ajax({
		type : 'GET',
		url : v_url,
		dataType : "html",
		contentType: 'text/html; charset=UTF-8',		
		success : function(result) {
			//console.log('result ----------------------------');
			//console.log(result);
			//console.log('------------------------------------------');
			console.log('target', $target);
			$target.html(result);
			// $target.empty().append(result);
			$target.addClass('active');
		},  // success 
		error : function(xhr, status, error) {
			console.log('status : ' + xhr.status);
			alert(error);
		} // error
	}); // end ajax	
	
} // end fn_load_content


// -----------------------------------------------
fn_load_content('joinMoim');

$("#tab2").click(function() {
	fn_load_content('likeMoim');
});
//------------------------------------------------모달
function fn_moim_out(code) {
    Swal.fire({
          title: 'OUT',
          text: "모임을 탈퇴하시겠습니까?",
          icon: 'warning',
          showCancelButton: true,
          confirmButtonColor: '#3085d6',
          cancelButtonColor: '#d33',
          confirmButtonText: 'Yes'
        }).then((result) => {
          if (result.isConfirmed) {
      			console.log(code);
        	  $.ajax({
        			type : 'POST',
        			url : '/moim/outMoim.ajax',
        			data : {
        				moimCode : code
        			},
        			dataType : "text",
        			success : function(result) {
						alert(result);
        			},  // success 
        			error : function(xhr, status, error) {
        				console.log('status : ' + xhr.status);
        				alert(error);
        			} // error
        		}); // end ajax	
          }
        })

}
if(${not empty succesDelete}){
	Swal.fire({
		  position: 'top-end',
		  icon: 'success',
		  title: '성공적으로 삭제되었습니다',
		  showConfirmButton: false,
		  timer: 1500
		})
}
// -----------------------------------------------
</script>

</html>
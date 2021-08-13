<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<%request.setCharacterEncoding("UTF-8"); %>
<html>
<head>
<%@include  file="/WEB-INF/inc/header.jsp" %>
<meta charset="UTF-8">
<title>Teaming</title>
</head>
<body>
<!-- Tab을 위해서는 introduce를 따로 빼야함 -->
<!-- //TODO : 내용 꾸밀 간격줘야함   -->

<div class="container">
	<div class="highlight">
  	
  	<h5>INFO::</h5>
	<pre>${moim.moimIntroduce }</pre>
	<h5>MANAGER::</h5>
	<div id="id_managerInfo">
		<!-- 여기에 append -->
	</div>
	
	</div><!-- highlight -->
</div><!-- container -->
<script type="text/javascript">
	$(document).ready(function() {
		var moimCode = '${moim.moimCode}';
		$.ajax({
			type : 'POST',
			data : {
				moimCode : moimCode
			},
			url : '/moim/managerInfo.ajax',
			dataType : "json",
			success : function(result) {
				console.log(result);
				//현재 나이 구하기 
				var age = result.userAge.substr(0,4);
				age *= 1;
				var today = new Date();   
				var year = today.getFullYear(); // 년도
				year *= 1;
				age = year-age;
				var contents = '';
				contents += '  <div class="row">';
				contents += '    <div class="col-sm-2" style="text-align: center;">';
				if(result.userPic == 'default'){
	  				contents += '<img alt="" src="<%=request.getContextPath() %>/resource/images/join/defaultProfile.png" width="100px" height="100px" style="border-radius: 50%; ">';
				}
				if(result.userPic != 'default'){
	  				contents += '<img alt="" src="/img'+result.userPic+'" width="60px" height="60px" style="border-radius: 80%;">';
				}
				contents += '    </div>';
				contents += '    <div class="col-sm-9">';
				contents += '      <div class="row">';
				contents += '        <div class="col-8 col-sm-6">';
				contents += '<strong>'+result.userName+'('+result.userId+')</strong><br>';
				contents += '<p class="text-muted" style="margin:0px; padding:0px; font-size:11px;">';
				contents += '#만'+age+'세 #관심사는 '+result.userHobbyNm+'</p>';
  				contents += result.userIntroduce;
				contents += '</div></div></div></div>';
				$('#id_managerInfo').append(contents);
			},
			error : function(xhr, status, error) {
				console.log('status : ' + xhr.status);
			}
		});
	});
</script>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<!doctype html>
<html lang="ko">
<head>
<%@include file="/WEB-INF/inc/header.jsp"%>
<title>Teaming</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">

<!-- 회원가입 css -->
<link  href="<%=request.getContextPath() %>/resource/forJoin/css/style.css" rel="stylesheet" >
<style type="text/css">
	.file_input_hidden { opacity:0; cursor:pointer; width: 100%; height: 66%; position: absolute; top: 10%; left: 0%;}
	.input_default_profile {cursor:pointer; }
	#id_profile{width: 70%;height: 80%;margin-left: 15%; margin-top: 5%;}
	
</style>

    <!-- sweetAlert -->
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    
</head>
<body class="img" style="background-image:url(<%=request.getContextPath()%>/resource/images/join/bg.jpg">
<%@include file="/WEB-INF/inc/top.jsp"%>
<section class="ftco-section">
<div class="container">
<div class="row justify-content-center">
<div class="col-md-6 text-center mb-5">
<h2 class="heading-section">Sign Up</h2>
</div>
</div>
<div class="row justify-content-center">
<div class="col-md-7 col-lg-5">
<div class="login-wrap">
<h3 class="text-center mb-4">Create Your Account</h3>

<form:form action="regist" class="signup-form" modelAttribute="user" enctype="multipart/form-data">
	<div class="form-group mb-3">
		<a data-toggle="tab" href='javascript:void(0);' onclick='joinStep("one");'>이용약관 동의  <span class="required">(필수)</span></a>
		<form:checkbox path="agreeYn" value="Y" id="one" onclick="return false;"/> <br>
		
		<a data-toggle="tab" href='javascript:void(0);' onclick='joinStep("two");'>개인정보 수집 및 이용에 대한 동의  <span class="required">(필수)</span></a>
		<form:checkbox path="privacyYn" value="Y" id="two" onclick="return false;" /> <br>
		
		<a data-toggle="tab" href='javascript:void(0);' onclick='joinStep("three");'>이벤트 등 프로모션 알림 메일 수신</a>
		<form:checkbox path="eventYn" value="Y" id="three" onclick="return false;" />
	</div>

	<div class="form-group mb-3">
		<label class="label" for="profile">Profile</label>
		<label style="border:1px solid #a094b8; color: #6c757d; border-radius: 1rem; height: 250px" for="profile">
			<img alt="" id="id_profile" src="<%=request.getContextPath() %>/resource/images/join/camera.png">
			<input type="file" class="file_input_hidden" name="upload_profile" id="upload_profile" accept="image/png, image/jpeg" onchange="change_profile(this)">
		</label>
		<input type="button" class="input_default_profile form-control" value="기본 프로필 사진" onclick="defualt_profile()" style="color:#c5c8cb">
	</div>
	<!-- 해당 사진 저장하기 -->
	<input type="hidden" name="userPic" id="userPic" value="">
	<form:errors path="userPic" />
	
	<div class="form-group mb-3">
		<label class="label" for="userId">UserID</label>
		<input type="text" class="form-control" placeholder="asd1234" name="userId" id="userId" required="required">
		<span class="icon fa fa-address-card-o "></span>
	</div>
	<form:errors path="userId" />
	
	<div class="form-group mb-3">
		<button onclick="fn_idCheck()" id="idBtn" class="form-control btn btn-primary submit px-5">중복 체크</button>
	</div>
		<form:errors path="idCheckYn" />
	
	<div class="form-group mb-3">
		<label class="label" for="userName">User Name</label>
		<input type="text" class="form-control" placeholder="홍길동" name="userName">
		<span class="icon fa fa-user-o"></span>
	</div>
		<form:errors path="userName" />
	
	<div class="form-group mb-3">
		<label class="label" for="password">Password</label>
		<input id="password" type="password" class="form-control" placeholder="Password" name="userPassword">
		<span toggle="#password" class="fa fa-fw fa-eye field-icon toggle-password"></span>
		<span class="icon fa fa-lock"></span>
	</div>
		<form:errors path="userPassword" />

	<div class="form-group mb-3">
		<label class="label" for="userIntroduce">User Introduce</label>
		 <textarea name="userIntroduce"  cols="20" class="form-control" rows="3" placeholder="소개글을 입력해주세요."></textarea>
		<span class="icon fa fa-commenting-o"></span>
	</div>
			<form:errors path="userIntroduce" />

	<div class="form-group mb-3">
		<label class="label" for="email">Email Address</label>
		<input type="text" class="form-control" placeholder="johndoe@gmail.com" name="userEmail">
		<span class="icon fa fa-paper-plane-o"></span>
	</div>
		<form:errors path="userEmail" />
	
	<div class="form-group mb-3" id="emailCheckDiv">
		<button onclick="fn_mail()" id="mailBtn" class="form-control btn btn-primary submit px-5">인증 메일 발송</button>
	</div>
		<form:errors path="emailCheckYn" />
		
	<div class="form-group mb-3">
		<label class="label" for="local">Hobby</label>
		<select id="id_selectHobby" name="userHobby" class="form-control input-sm">
				<option value="">-- 전체 --</option>
				<c:forEach items="${hobbyList}" var="hb">
					<option value="${hb.hbCode}"  >${hb.hbName}</option>
				</c:forEach>
		</select>
		<span class="icon fa fa-bookmark-o"></span>
	</div>
		<form:errors path="userHobby" />
	
	<div class="form-group mb-3">
		<label class="label" for="gender">Gender</label>
		<select id="selectGender" name="userGender" class="form-control input-sm" >
				<option value="M">남성</option>
				<option value="F">여성</option>
		</select>
		<span class="icon fa fa-venus-mars"></span>
	</div>
		<form:errors path="userGender" />
	
	<div class="form-group mb-3">
		<label class="label" for="age">Age</label>
		<input type="date" class="form-control" name="userAge" >
	</div>
		<form:errors path="userAge" />
	
	<div class="form-group mb-3">
		<label class="label" for="local">Local</label>
		<form:select path="localBigCode" id="big" onchange="getMidLocation();" class="form-control input-sm">
			<form:option value="">--선택하세요--</form:option>
			<form:options items="${locationList }" itemLabel="localBigName"
				itemValue="localBigCode" />
		</form:select>  
		<span class="icon fa fa-map-marker"></span>
	</div>
		<form:errors path="localBigCode" />
	<div class="form-group mb-3">	
		<form:select path="localMidCode" id="mid" onchange="getSmallLocation();" class="form-control input-sm">
			<!-- append 영역 -->
			<form:option value="">--선택하세요--</form:option>
		</form:select>
		<span class="icon fa fa-map-marker"></span>
	</div>
		<form:errors path="localMidCode" />
	<div class="form-group mb-3">
		<form:select path="localSmallCode" id="small" class="form-control input-sm">
			<!-- append 영역 -->
			<form:option value="">--선택하세요--</form:option>
		</form:select>
		<span class="icon fa fa-map-marker"></span>
	</div>
		<form:errors path="localSmallCode" />
	
	<div class="form-group">
		<button type="submit" class="form-control btn btn-primary submit px-3">Sign Up</button>
	</div>
	<div class="form-group">
		<button type="submit" formaction="cancel" class="form-control btn btn-primary submit px-3">Cancel</button>
	</div>
	<input type="hidden" name="idCheckYn" value="" id="idCheckYn">
	<input type="hidden" name="emailCheckYn" value="" id="emailCheckYn">
</form:form>
<p>I'm already a member! <a data-toggle="tab" href="login.co.kr">Sign In</a></p>
</div>
</div>
</div>
</div>
</section>
	<script src="<%=request.getContextPath() %>/resource/forJoin/js/jquery.min.js"></script>
  <script src="<%=request.getContextPath() %>/resource/forJoin/js/popper.js"></script>
  <script src="<%=request.getContextPath() %>/resource/forJoin/js/bootstrap.min.js"></script>
  <script src="<%=request.getContextPath() %>/resource/forJoin/js/main.js"></script>
<script defer src="https://static.cloudflareinsights.com/beacon.min.js" data-cf-beacon='{"rayId":"671042fcfb7a1eb3","token":"cd0b4b3a733644fc843ef0b185f98241","version":"2021.6.0","si":10}'></script>
<!-- alert 관련 부트스트랩 -->
<!-- 파일 업로드 및 미리보기 스크립트 -->
<script type="text/javascript">
function defualt_profile() {
	var id_profile = document.getElementById("id_profile");
	id_profile.setAttribute("src", "<%=request.getContextPath() %>/resource/images/join/defaultProfile.png");
	
	var picInput = document.getElementsByName("userPic")[0];
	picInput.setAttribute("value", "default");
}

function change_profile(input) {
	// 사진 형식 가져오기 ( ex) png, jpg )
	var pictureSplit = input.value.split("/");
	var pictureSplit2 = pictureSplit[pictureSplit.length - 1].split(".");
	var picType = pictureSplit2[pictureSplit2.length - 1];
	
	// 사진 형식 넣기
	var picInput = document.getElementsByName("userPic")[0];
	picInput.setAttribute("value", picType);
	
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (inputfile) {
            $('#id_profile').attr('src', inputfile.target.result);
        }
        reader.readAsDataURL(input.files[0]);
    }
}    
</script>
<!-- 지역 select 가져오기 스크립트 -->
<script type="text/javascript">
function  getMidLocation() {
	var bigCode = $('#big').val();
	var request = $.ajax({
		type : 'POST',
		data : {
			bigCode : bigCode
		},
		url : '/moim/locationDetail.ajax',
		dataType : "json",
		success : function(result) {
			$('#mid').empty();
			$('#mid').append('<option value="">--선택하세요--</option>');
			$.each(result, function(i, el){
				$('#mid').append('<option value="'+el.localMidCode+'">'+el.localMidName+'</option>');
			});
		},
		error : function(xhr, status, error) {
			console.log('status : ' + xhr.status);
		}
	});
}
function  getSmallLocation() {
	var midCode = $('#mid').val();
	var request = $.ajax({
		type : 'POST',
		data : {
			midCode : midCode
		},
		url : '/moim/locationDetail2.ajax',
		dataType : "json",
		success : function(result) {
			$('#small').empty();
			$('#small').append('<option value="">--선택하세요--</option>');
			$.each(result, function(i, el){
				$('#small').append('<option value="'+el.localSmallCode+'">'+el.localSmallName+'</option>');
			});
		},
		error : function(xhr, status, error) {
			console.log('status : ' + xhr.status);
		}
	});
}
</script>

<!-- mail 인증 -->
<script type="text/javascript">
function fn_mail() {
	event.preventDefault();		//form 내부 버튼은 전부 submit이라 기존 이벤트 삭제
	var mailInput = document.getElementsByName("userEmail")[0].value;
	$.ajax({
		type:"POST" ,
		url: "/join/mailsend?mail=" + mailInput ,				// 상대 경로 사용시 매핑은 /join/email.wow
		//data: {"mail":mailInput} ,
		success:function(data){
			document.getElementById("mailBtn").innerHTML = "재전송";
			var par = document.getElementById("mailBtn").parentElement; // 상위 div
			par.innerHTML += "<br> <br>";
			
			var input = document.createElement("input");
			input.type = "text";
			input.setAttribute("id", "mailCheckInput");
			input.setAttribute("class", "form-control");
			input.setAttribute("style", "width:50%; display: inline-block;");
			
			var btn = document.createElement("button");
			btn.setAttribute("onclick", "fn_mailCheck(" + data + ")");
			btn.innerHTML = "확인";
			btn.setAttribute("id", "mailCheckBtn");
			btn.setAttribute("class", "form-control btn btn-primary submit px-5");
			btn.setAttribute("style", "width:50%; display: inline-block;");
			par.append(input);
			par.append(btn);
			
		}
	});
}
function fn_mailCheck(data) {
	event.preventDefault();
	
	var mailCheckInput = document.getElementById("mailCheckInput").value;
	console.log("내가 입력한 것 = " + mailCheckInput + ", 인증번호 = " + data );
	if(data == mailCheckInput ){
		swal("Good job!", "이메일 인증 완료", "success");
		var par = document.getElementById("mailBtn").parentElement;

		par.innerHTML = "";
		var newP = document.createElement("p");
		newP.innerHTML = "이메일 인증 완료";
		par.appendChild(newP);
		
		// 이메일 체크 validation 값 넣기
		var emailValidation = document.getElementById("emailCheckYn");
		emailValidation.setAttribute("value", "Y");
	}else{
		swal("Fail!", "이메일 인증 실패", "error");
		var emailValidation = document.getElementById("emailCheckYn");
		emailValidation.setAttribute("value", "");
	}
}
</script>

<!-- id 중복 확인 -->
<script type="text/javascript">
function fn_idCheck() {
	event.preventDefault();		//form 내부 버튼은 전부 submit이라 기존 이벤트 삭제
	var userId = document.getElementById("userId").value;
	// 아이디 입력안했으면 안되게
	if((userId == '' || userId == null || userId.search(/\s/) != -1)){
		swal("Error!", "아이디를 입력해주세요!",  "error");
		return false;
	}
	$.ajax({
		type:"POST" ,
		url: "/join/idCheck?userId=" + userId ,				// 상대 경로 사용시 매핑은 /join/email.wow
		//data: {"mail":mailInput} ,
		success:function(data){
			if(data == "true"){
				swal("Good job!", "해당 아이디는 사용이 가능합니다.",  "success");
				var par = document.getElementById("idBtn").parentElement;
				var idBtn = document.getElementById("idBtn");
				par.removeChild(idBtn);
				var newP = document.createElement("p");
				newP.innerHTML = "아이디 중복 체크 완료";
				par.appendChild(newP);
				var idValidation = document.getElementById("idCheckYn");
				idValidation.setAttribute("value", "Y");
			}else if(data == "false"){
				swal("Error!", "해당 아이디는 이미 사용중입니다.",  "error");
				document.getElementById("idBtn").innerHTML = "재전송";
				var idValidation = document.getElementById("idCheckYn");
				idValidation.setAttribute("value", "");
			}
		}
	});
}
</script>

<!-- 이용약관 -->
<script type="text/javascript">
function joinStep(step) {
	var stepContent = "";
	if(step == "one"){
		stepContent = 'Study 사이트에 오신것을 환영합니다. \n Study 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. \n본 약관은 다양한 서비스의 이용과 관련하여 본 사이트 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 네이버 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다. \n서비스를 이용하시거나 회원으로 가입하실 경우 여러분은 본 약관 및 관련 운영 정책을 확인하거나 동의하게 되므로, 잠시 시간을 내시어 주의 깊게 살펴봐 주시기 바랍니다.';
	}else if(step == "two"){
		stepContent = '정보통신망법 규정에 따라 회원가입 신청하시는 분께 수집하는 개인정보에 대하여 알려드립니다. \n1. 개인정보의 수집 항목  \n2. 개인정보의 수집 및 이용목적 \n3. 개인정보의 보유 및 이용기간 \n위 사항을 안내 드리오니 자세히 읽은 후 동의하여 주시기 바랍니다.';
	}else if(step == "three"){
		stepContent = 'Study가 제공하는 이벤트/프로모션 알림 정보를 메일로 받습니다. Study가 제공하는 이벤트/프로모션 알림 정보를 메일로 받습니다. \n1. 본 사이트가 직접 운영하는 통합서비스들의 소식과 혜택, 쿠폰 등 유용한 정보를 메일로 제공합니다. \n2. 추후 새로운 서비스가 추가될 경우, 본 동의를 한 사용자에게 자동으로 해당 서비스의 메일을 수신할 수 있게 됩니다. \n3. 만약 사용자가 앞으로 이벤트/ 프로모션 알림 메일을 받고 싶지 않을 경우, [마이페이지 > 설정 > 내 개인정보 관리] 본 동의를 철회할 수 있습니다.';                                                   
	}
	var check = document.getElementById(step);
	swal({
		  title: "Are you sure?",
		  text: stepContent,
		  icon: "info",
		  buttons: true,
		  dangerMode: true,
		})
		.then((willDelete) => {
		  if (willDelete) {
			check.checked = true;
		    swal("체크 완료!", {
		      icon: "success",
		    });
		  } else {
			  check.checked = false;
		  }
	});
}
</script>
</body>
</html>

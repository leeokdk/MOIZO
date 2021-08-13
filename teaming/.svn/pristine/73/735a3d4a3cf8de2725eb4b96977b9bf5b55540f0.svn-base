<%@page import="com.moim.common.CookieUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@include file="/WEB-INF/inc/header.jsp"%>
<title>Teaming</title>
<meta charset="UTF-8">

	<link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">
	
	<link rel="stylesheet" href="<%=request.getContextPath() %>/resource/forLogin/css/style.css">
    <!-- sweetAlert -->
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	</head>
	<%@include file="/WEB-INF/inc/top.jsp"%>
	
	<script type="text/javascript">
	if(${not empty check}){
		if(${check.equals('n')}){
			Swal.fire({
				  position: 'top-end',
				  icon: 'error',
				  title: '${fail}',
				  showConfirmButton: false,
				  timer: 1500
				});
		}else if(${check.equals('y')}){
			Swal.fire({
				  position: 'top-end',
				  icon: 'success',
				  title: '${success}',
				  showConfirmButton: false,
				  timer: 1500
				});
		}
	}
	</script>
	<body class="img js-fullheight" style="background-image:url(<%=request.getContextPath()%>/resource/images/login/bg.jpg">
	<section class="ftco-section">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-6 text-center mb-5">
					<h2 class="heading-section">Login</h2>
				</div>
			</div>
			<div class="row justify-content-center">
				<div class="col-md-6 col-lg-4">
					<div class="login-wrap p-0">
		      	<h3 class="mb-4 text-center">Have an account?</h3>
		      	
		      	
		      	<form action="login" class="signin-form" method="post">
		      	
		      	
		      		<div class="form-group">
		      			<input type="text" class="form-control" placeholder="Username" required name="userId">
		      		</div>
		      		
		      		
	            <div class="form-group">
	              <input id="password-field" type="password" class="form-control" placeholder="Password" required name="userPassword">
	              <span toggle="#password-field" class="fa fa-fw fa-eye field-icon toggle-password"></span>
	            </div>
	            
	            <div class="form-group">
	            	<button type="submit" class="form-control btn btn-primary submit px-3">Sign In</button>
	            </div>
	            
	            
	          </form>
	          <p class="w-100 text-center">&mdash; Teaming &mdash;</p>
	          <div class="social d-flex text-center">
	          	<!-- <a href="#" class="px-2 py-2 mr-md-1 rounded"><span class="ion-logo-facebook mr-2"></span> Facebook</a>
	          	<a href="#" class="px-2 py-2 ml-md-1 rounded"><span class="ion-logo-twitter mr-2"></span> Twitter</a> -->
	          </div>
		      </div>
				</div>
			</div>
		</div>
	</section>

	<script src="<%=request.getContextPath() %>/resource/forLogin/js/jquery.min.js"></script>
  <script src="<%=request.getContextPath() %>/resource/forLogin/js/popper.js"></script>
  <script src="<%=request.getContextPath() %>/resource/forLogin/js/bootstrap.min.js"></script>
  <script src="<%=request.getContextPath() %>/resource/forLogin/js/main.js"></script>

	</body>
</html>
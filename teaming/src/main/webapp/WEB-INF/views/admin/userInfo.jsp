<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    	<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/inc/header.jsp" %>
<meta charset="UTF-8">
<title>회원관리</title>
</head>
<body>		
	<div class="container">
		<h3>회원관리</h3>
		<table class="table">
			<tbody>
				<tr >
					<th scope="row">Profile</th>
					<td style="border:1px solid #a094b8; color: #6c757d; border-radius: 1rem; width:70px; height: 70px" for="profile">
						<img alt="" id="id_profile" src="/img${user.userPic }">
					</td>
				</tr>
				<tr>
					<th scope="row">아이디</th>
					<td>${user.userId }</td>
				</tr>
				<tr>
					<th scope="row">회원명</th>
					<td>${user.userName }</td>
				</tr>
				<tr>
					<th scope="row">비밀번호</th>
					<td>${user.userPassword }</td>
				</tr>
				<tr >
					<th scope="row">자기소개 글</th>
					 <td>${user.userIntroduce }</td>
				</tr>
				<tr>
					<th scope="row">이메일</th>
					<td>${user.userEmail }</td>
				</tr>
				<tr >
					<th scope="row">취미</th>
					<td>
						${user.userHobbyNm }
					</td>
				</tr>
				<tr >
					<th scope="row">성별</th>	
					<c:if test="${user.userGender eq 'M' }">
						<td>남자</td>
					</c:if>
					<c:if test="${user.userGender eq 'F' }">
						<td>여자</td>
					</c:if>
				</tr>
				<tr>
					<th scope="row">나이</th>
					<td><input type="date" name="userAge"
						class="form-control input-sm" value='${user.userAge }'
						readonly="readonly"></td>
					<!-- 'YYYY-MM-DD'형태만 value값으로 들어갈수있어요 -->
				</tr>
				<tr >
					<th scope="row">지역</th>
					<td>
					${userLocation.localBigName} &nbsp; ${userLocation.localMidName} &nbsp; ${userLocation.localSmallName} &nbsp;
					</td> 
				</tr>
<%-- 				<tr>
					<th>탈퇴여부</th>
					<td>${user.userDelYn }</td>
				</tr>
				<tr> --%>
					<td colspan="2">
						<a href="<%=request.getContextPath() %>/"
							class="btn btn-default btn-sm"> <span
								class="glyphicon glyphicon-home" aria-hidden="true"></span>
								&nbsp;Home
						</a> 
						<a href='<%=request.getContextPath() %>/user/edit?userId=${user.userId }'
							class="btn btn-info btn-sm"> <span
								class="glyphicon glyphicon-king" aria-hidden="true"></span>
								&nbsp;수정
						</a>
						<button type="button" onclick="deleteUser()" class="btn btn-info btn-sm">
							<span class="glyphicon glyphicon-king" aria-hidden="true"></span>
							&nbsp;삭제
						</button>
					</td> 
				</tr>
			</tbody>
		</table>
	</div>
</body>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script type="text/javascript">
const swalWithBootstrapButtons = Swal.mixin({
	  customClass: {
	    confirmButton: 'btn btn-success',
	    cancelButton: 'btn btn-danger'
	  },
	  buttonsStyling: false
	})

	function deleteUser() {
		swalWithBootstrapButtons.fire({
		  title: 'Are you sure?',
		  text: "You won't be able to revert this!",
		  icon: 'warning',
		  showCancelButton: true,
		  confirmButtonText: 'Yes, delete it!',
		  cancelButtonText: 'No, cancel!',
		  reverseButtons: true
		}).then((result) => {
		  if (result.isConfirmed) {
		  /*   swalWithBootstrapButtons.fire(
		      'Deleted!',
		      'Your file has been deleted.',
		      'success'
		    ) */
		    window.location.href='<c:url value="/user/deleteUser?userId=${user.userId }"/>';
		   <%-- location.href = "<%=request.getContextPath() %>/user/deleteUser?userId=${user.userId }"; --%>
		  } else if (
		    /* Read more about handling dismissals below */
		    result.dismiss === Swal.DismissReason.cancel
		  ) {
		    swalWithBootstrapButtons.fire(
		      'Cancelled',
		      'Your ID is safe :)',
		      'error'
		    )
		  }
		})		
	}
</script>
</html>
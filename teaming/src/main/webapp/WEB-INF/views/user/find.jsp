
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/inc/header.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/inc/top.jsp"%>

	<div class="container">
		<h3>비밀번호 찾기</h3>
		<form:form action="modify.wow" method="post" modelAttribute="member">
			<table class="table table-striped table-bordered">
				<tbody>
					<tr>
						<th>아이디</th>
						<td>
							${member.memId }
							<form:hidden path="memId"/>
							<form:errors path="memId" />
							<%-- <input type="hidden" name="memId"
							value="${member.memId }"> --%>	
						</td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td>
							<form:password path="memPass" cssClass="form-control input-sm" />
							<form:errors path="memPass" />
							<!-- <input type="password" name="memPass"
							class="form-control input-sm" pattern="\w{4,}"
							title="알파벳과 숫자로 4글자 이상 입력"> -->
						</td>
					</tr>
					<tr>
						<th>회원명</th>
						<td>
							<form:input path="memName" cssClass="form-control input-sm"/>
							<form:errors path="memName" />
							<%-- <input type="text" name="memName"
							class="form-control input-sm" value="${member.memName }"
							required="required" pattern="[가-힣]{2,}" title="한글로 2글자 이상 입력"> --%>
						</td>
					</tr>
					<tr>
						<th>우편번호</th>
						<td>
							<form:input path="memZip" cssClass="form-control input-sm"/>
							<form:errors path="memZip" />
							<%-- <input type="text" name="memZip"
							class="form-control input-sm" value='${member.memZip }'> --%>
						</td>
					</tr>
					<tr>
						<th>주소</th>
						<td>
							<form:input path="memAdd1" cssClass="form-control input-sm"/>
							<form:errors path="memAdd1" />
							<form:input path="memAdd2" cssClass="form-control input-sm"/>
							<form:errors path="memAdd2" />
							<%-- <input type="text" name="memAdd1"
							class="form-control input-sm" value='${member.memAdd1 }'>
							<input type="text" name="memAdd2" class="form-control input-sm"
							value='${member.memAdd2 }'> --%>
						</td>
					</tr>
					<tr>
						<th>생일</th>
						<td>
							<input type="date" name="memBir"
							class="form-control input-sm" value='${member.memBir }'>
						</td>
					</tr>
					<tr>
						<th>메일</th>
						<td>
							<form:input path="memMail" cssClass="form-control input-sm"/>
							<form:errors path="memMail" />
							<%-- <input type="email" name="memMail"
							class="form-control input-sm" required="required"
							value='${member.memMail }'> --%>
						</td>
					</tr>
					<tr>
						<th>핸드폰</th>
						<td>
							<form:input path="memHp" cssClass="form-control input-sm"/>
							<form:errors path="memHp" />
							<%-- <input type="tel" name="memHp"
							class="form-control input-sm" value='${member.memHp }'> --%>
						</td>
					</tr>
					<tr>
						<th>직업</th>
						<td>
							<form:select path="memJob" cssClass="form-control input-sm">
								<form:option value="">-- 직업 선택 --</form:option>
								<form:options items="${jobList }" itemLabel="commNm" itemValue="commCd" />
							</form:select>
							<%-- <select name="memJob" class="form-control input-sm">
								<option value="">-- 직업 선택 --</option>
								<c:forEach items="${jobList }" var="job">
									<option value="${job.commCd }"
										${member.memJob eq job.commCd ? "selected='selected'" :""}>${job.commNm }</option>
								</c:forEach>
							</select> --%>
						</td>
					</tr>
					<tr>
						<th>취미</th>
						<td>
							<form:select path="memHobby" cssClass="form-control input-sm">
								<form:option value="">-- 취미 선택 --</form:option>
								<form:options items="${hobbyList }" itemLabel="commNm" itemValue="commCd" />
							</form:select>
							<%-- <select name="memHobby" class="form-control input-sm">
								<c:forEach items="${hobbyList }" var="hob">
									<option value="${hob.commCd }"
										${member.memHobby eq hob.commCd ? "selected='selected'" :""}>${hob.commNm }</option>
								</c:forEach>
							</select> --%>
						</td>
					</tr>
					<tr>
						<th>마일리지</th>
						<td>${member.memMileage }</td>
					</tr>
					<tr>
						<th>탈퇴여부</th>
						<td>${member.memDelYn }</td>
					</tr>
					<tr>
						<td colspan="2"><a href="info.wow"
							class="btn btn-info btn-sm"> <span
								class="glyphicon glyphicon-list" aria-hidden="true"></span>
								&nbsp;뒤로가
						</a>
							<button type="submit" class="btn btn-primary">
								<span class="glyphicon glyphicon-heart" aria-hidden="true"></span>
								&nbsp;&nbsp; 저장
							</button>

							<button type="submit" formaction="delete.wow"
								class="btn btn-danger btn-sm">
								<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
								&nbsp;&nbsp; 삭제
							</button></td>
					</tr>
				</tbody>
			</table>
		</form:form>
	</div>


</body>
</html>
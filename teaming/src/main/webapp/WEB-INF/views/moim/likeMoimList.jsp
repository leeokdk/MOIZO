<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

	<div class="container-xl">
		<div class="container-lg">
			<h2 class="text-uppercase fw-bold">
				내가 가입신청을 한 소모임  
			</h2>
			<div class="row row-cols-1 row-cols-md-3 g-4">
				<c:forEach items="${myMoimList}" var="moim">
					<div class="col">
						<div class="card h-100">				
						<c:choose>
							<c:when test="${moim.moimImage eq 'default' }">
								<img src="/resource/images/moim/moim_noimg.jpg" class="card-img-top" alt="no_image" style="max-height: 230px;">
							</c:when>
							<c:otherwise>
								<img src="/img${moim.moimImage }" class="card-img-top" alt="no_image" style="max-height: 230px;">
							</c:otherwise>
						</c:choose>
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
								</c:choose></p>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div><!-- container-lg -->
				<div class="container-lg">
			<h2 class="text-uppercase fw-bold">
				내가 좋아요를 누른 소모임 
			</h2>
			<div class="row row-cols-1 row-cols-md-3 g-4">
				<c:forEach items="${myLikeMoimList}" var="moimL">
					<div class="col">
						<div class="card h-100">				
						<c:choose>
							<c:when test="${moimL.moimImage eq 'default' }">
								<img src="/resource/images/moim/moim_noimg.jpg" class="card-img-top" alt="no_image" style="max-height: 230px;">
							</c:when>
							<c:otherwise>
								<img src="/img${moimL.moimImage }" class="card-img-top" alt="no_image" style="max-height: 230px;">
							</c:otherwise>
						</c:choose>
							<div class="card-body">
								<h5 class="card-title">
									<a href="moimView?moimCode=${moimL.moimCode }">${moimL.moimName }</a>
								</h5>
								<p class="card-text">
									<small class="text-muted">
									#${moimL.moimCategory }&nbsp;
									#${moimL.moimBigName}&nbsp;${moimL.moimLocalName}
									<c:if test="${moimL.moimLimitGender ne null }">
										#<c:choose><c:when test="${moimL.moimLimitGender eq 'F'}">여자만</c:when><c:otherwise>남자만</c:otherwise></c:choose>
									&nbsp;</c:if>
									<c:if test="${moimL.moimLimitAge ne null }">#${moimL.moimLimitAge }세~${moimL.moimLimitAgeEnd }세</c:if>
									</small><br>
								<c:choose>
									<c:when test="${fn:length(moim.moimIntroduce) >= 50 }">
										${fn:substring(moim.moimIntroduce,0,50)}...
									</c:when>
									<c:otherwise>
										${moim.moimIntroduce }
									</c:otherwise>
								</c:choose></p>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div><!-- container-lg -->

	</div><!-- end .container -->

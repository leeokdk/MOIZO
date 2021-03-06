<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

	<div class="container-xl">
		<div class="container-lg">
			<h2 class="text-uppercase fw-bold">
				내가 만든 소모임
			</h2>
			<div class="row row-cols-1 row-cols-md-3 g-4">
				<c:forEach items="${myMoimList_M}" var="moim">
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
								</c:choose>
									</p>
							</div>
							<div class="card-footer text-end">
					        <small class="text-muted">
					        		<a href="moimEdit?moimCode=${moim.moimCode }">모임관리</a>
					        </small>
					      </div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div><!-- container-lg -->
		<div class="container-lg">
			<h2 class="text-uppercase fw-bold">
				내가 가입한 소모임
			</h2>
			<div class="row row-cols-1 row-cols-md-3 g-4">
				<c:forEach items="${myMoimList}" var="moimM">
					<div class="col">
						<div class="card h-100">				
						<c:choose>
							<c:when test="${moimM.moimImage eq 'default' }">
								<img src="/resource/images/moim/moim_noimg.jpg" class="card-img-top" alt="no_image" style="max-height: 230px;">
							</c:when>
							<c:otherwise>
								<img src="/img${moimM.moimImage }" class="card-img-top" alt="no_image" style="max-height: 230px;">
							</c:otherwise>
						</c:choose>
							<div class="card-body">
								<h5 class="card-title">
									<a href="moimView?moimCode=${moimM.moimCode }">${moimM.moimName }</a>
								</h5>
								<p class="card-text">
									<small class="text-muted">
									#${moimM.moimCategory }&nbsp;
									#${moimM.moimBigName}&nbsp;${moimM.moimLocalName}
									<c:if test="${moimM.moimLimitGender ne null }">
										#<c:choose><c:when test="${moimM.moimLimitGender eq 'F'}">여자만</c:when><c:otherwise>남자만</c:otherwise></c:choose>
									&nbsp;</c:if>
									<c:if test="${moimM.moimLimitAge ne null }">#${moimM.moimLimitAge }세~${moimM.moimLimitAgeEnd }세</c:if>
									</small><br>
								<c:choose>
									<c:when test="${fn:length(moimM.moimIntroduce) >= 50 }">
										${fn:substring(moimM.moimIntroduce,0,50)}...
									</c:when>
									<c:otherwise>
										${moimM.moimIntroduce }
									</c:otherwise>
								</c:choose>
									</p>
							</div>
	 						<div class="card-footer text-end">
					        <small class="text-muted">
					        	<a href="#" onclick="fn_moim_out('${moimM.moimCode}')" id="outMoim" >모임탈퇴</a>
					        </small>
					      </div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div><!-- container-lg -->
		

	</div><!-- end .container -->
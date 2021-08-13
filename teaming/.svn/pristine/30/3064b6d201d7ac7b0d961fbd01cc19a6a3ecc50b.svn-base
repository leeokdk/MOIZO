<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ attribute name="searchVO" type="com.moim.vo.PagingVO" %>
<%@ attribute name="linkPage"  required="true"%>




	 <!-- START : 페이지네이션  -->
	
<nav aria-label="Page navigation example">
	<ul class="pagination justify-content-center">
	
	<!-- 첫 페이지  -->
		<li class="page-item"><a class="page-link" href="${linkPage }?curPage=1" data-page="1" aria-label="Previous"> <span aria-hidden="true">&laquo;</span> </a> </li>
			
				<!-- 이전 페이지 -->
				<c:if test="${searchVO.firstPage ne 1 }">
					<li><a class="page-link" href="${linkPage }?curPage=${searchVO.firstPage-1 }" data-page="${searchVO.firstPage-1 }""><span aria-hidden="true">&lt;</span></a></li>
				</c:if>
			
			<!-- 페이지 넘버링  -->
				<c:forEach begin="${searchVO.firstPage }" end="${searchVO.lastPage }" var="i">
				
					<c:if test="${searchVO.curPage ne i}">
						<li class="page-item"><a class="page-link" href="${linkPage }?curPage=${i }" data-page="${i }">${i }</a></li>
					</c:if>
				
					<c:if test="${searchVO.curPage eq i}">
						<li class="active"><a class="page-link" href="#">${i }</a></li> 
					</c:if>
				
				</c:forEach>
				
					<!-- 다음  페이지  -->
				<c:if test="${searchVO.lastPage ne searchVO.totalPageCount}">
					<li><a class="page-link" href="${linkPage }?curPage=${searchVO.lastPage+1 }" data-page="${searchVO.lastPage+1 }"><span aria-hidden="true">&gt;</span></a></li>
				</c:if>
				
		<!-- 마지막 페이지 -->
		<li class="page-item"> <a class="page-link" href="${linkPage }?curPage=${searchVO.totalPageCount }" data-page="${searchVO.totalPageCount }" aria-label="Next"> <span aria-hidden="true">&raquo;</span> </a> </li>
	</ul>
</nav>

<!-- END : 페이지네이션  --> 
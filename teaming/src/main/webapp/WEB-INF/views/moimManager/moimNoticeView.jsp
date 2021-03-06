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
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Batang&display=swap" rel="stylesheet">
<style>
body,html {font-family: 'Gowun Batang', serif;}
div.container {padding-left: 10%; padding-right: 10%} 


</style>
<body>
<%@include  file="/WEB-INF/inc/top.jsp" %>
<!-- container -->

	<div class="container">
			<div class="page-header">
				<h3>
					공지 게시판 - <small>글 보기</small>
				</h3>
				
				
			</div>


		<table class="table table-bordered">
			<tbody>
				<tr>
					<th scope="row">등록일자</th>
					<td>${moim.mNoticeModDate eq null ? moim.mNoticeRegDate  : moim.mNoticeModDate }</td>
				</tr>
				<tr>
					<th scope="row">글제목</th>
					<td>${moim.mNoticeTitle }</td>
				</tr>
				<tr>
					<th scope="row">작성자명</th>
					<td>${moim.mNoticeWriter }</td>
				</tr>
				<tr>
					<th scope="row">내용</th>
					<td><textarea rows="8" name="boContent" class="form-control input-sm">${moim.mNoticeContent }</textarea>
					</td>
				</tr>
				<tr>
					<th scope="row">조회수</th>
					<td>${moim.mNoticeHit }</td>
				</tr>
				<tr>
					<th scope="row">삭제여부</th>
					<td>${moim.mNoticeDelYn }</td>
				</tr>
<%-- 				<tr>
					<th>좋아요</th>
					<td><input type="button" value="♥" onclick="goodCheck()"/> ${vo.good}</td>
				</tr> --%>
					<%-- <tr>
						<th>첨부파일</th>
						<td><c:forEach var="f" items="${moim.attaches}"
								varStatus="st">
								<div>
									# 파일 ${st.count} <a
										href="<c:url value='/attach/download/${f.atchNo}' />"
										target="_blank"> <span class="glyphicon glyphicon-save"
										aria-hidden="true"></span> ${f.atchOriginalName}
									</a> Size : ${f.atchFancySize} Down : ${f.atchDownHit} Date :
									${f.atchRegDate}
								</div>
							</c:forEach></td>
					</tr> --%>
				
					<td colspan="2">
						<div class="pull-left">
							<a href="/moim/moimView?moimCode=${moim.moimCode }" class="btn btn-light btn-sm">
								&nbsp;목록
							</a>
						</div>
						
						
						<div class="pull-right">
							<a href="moimNoticeEdit?mNoticeNo=${moim.mNoticeNo }"
								class="btn btn-info btn-sm"> 
								&nbsp;수정
							</a>
						</div>
					</td>
				</tr>
			</tbody>
		</table>

		<!-- reply container -->
	
	<!-- // START : 댓글 등록 영역  -->
			<div class="panel panel-default">
				<div class="panel-body form-horizontal">
					<form name="frm_reply"
						action="<c:url value='/reply/replyRegist' />" method="post"
						onclick="return false;">
						<input type="hidden" name="reParentNo" value="${moim.mNoticeNo}">
						<input type="hidden" name="reCategory" value="MOIM">
						<div class="form-group">
							<label class="col-sm-2  control-label">댓글</label>
							<!--textarea 에 {sessionScope.PREPAGE} 와 같이 작성 내용 세션저장 가능-->
							<div class="col-sm-8">
								<textarea rows="3" name="reContent" class="form-control"></textarea>
							</div>
							<div class="col-sm-2">
								<button id="btn_reply_regist" type="button"
									class="btn btn-sm btn-info">등록</button>
							</div>
						</div>
					</form>
				</div>
			</div>
			<!-- // END : 댓글 등록 영역  -->
			
			<!-- // START : 댓글 목록 영역  -->
			<div id="id_reply_list_area">
				<div class="row">
					<div class="col-sm-2 text-right">아보카도</div>
					<div class="col-sm-6">
						<pre>내용</pre>
					</div>
					<div class="col-sm-2">12/30 23:45</div>
					<div class="col-sm-2">
						<button name="btn_reply_edit" type="button"
							class=" btn btn-sm btn-info">수정</button>
						<button name="btn_reply_delete" type="button"
							class="btn btn-sm btn-danger">삭제</button>
					</div>
				</div>
			</div>

			<div class="row text-center" id="id_reply_list_more">
				<a id="btn_reply_list_more"
					class="btn btn-sm btn-default col-sm-10 col-sm-offset-1"> <span
					class="glyphicon glyphicon-chevron-down" aria-hidden="true"></span>
					더보기
				</a>
			</div>
			<!-- // END : 댓글 목록 영역  -->
	</div> <!-- container  -->
			
			<!-- START : 댓글 수정용 Modal -->
			<div class="modal fade" id="id_reply_edit_modal" role="dialog">
				<div class="modal-dialog">
					<!-- Modal content-->
					<div class="modal-content">
						<form name="frm_reply_edit"
							action="<c:url value='/reply/replyModify' />" method="post"
							onclick="return false;">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal">×</button>
								<h4 class="modal-title">댓글수정</h4>
							</div>
							<div class="modal-body">
								<input type="hidden" name="reNo" value="">
								<textarea rows="3" name="reContent" class="form-control"></textarea>
							</div>
							<div class="modal-footer">
								<button id="btn_reply_modify" type="button"
									class="btn btn-sm btn-info">저장</button>
								<button type="button" class="btn btn-default btn-sm"
									data-dismiss="modal">닫기</button>
							</div>
						</form>
					</div>
				</div>
			</div>
			<!-- END : 댓글 수정용 Modal -->

		</div>
		<!-- reply container -->
</body>



<!-- START : 댓글 처리 스크립트-->
<!-- 
	※큰 틀 정리

	1. javascript 시작시 버튼 이벤트 등록 fn_reply_list() 실행
	2. fn_reply_list (로그인 안해도 가능)
	3. 수정, 삭제, 등록 (로그인 해야 가능)
	4. 수정, 삭제, 등록에서 ajax 실행하여 reply/** 요청 → LoginCheckInterceptor가 가로채서 처리
	5. 처리 결과에 따라 success로 갈기 error로 갈지 결정됨. 
	6. error로 오는 것은 비로그인 이므로 login 화면으로 이동 시킴 

 -->

<script type="text/javascript">

/* var params = {"curPage" : 1, "rowSizePerPage": 10 ,"reCategory": "FREE", "reParentNo" : ${moim.mNoticeNo}}; */

	// 댓글목록을 구하는 함수
function fn_reply_list() {
	
	// fn_reply_list는 반복해서 사용, AJAX에서 요청해서 DB접근 후 replyVOList를 가져와서 화면에 출력
	// 새로고침 안하고 바로바로 화면에 적용 
	
	$.ajax({
		 type		: 'POST'
		,url 		: '<c:url value="/reply/replyList" />'
		,dataType	: 'JSON'	// 서버 (Controller 메소드 리턴)에서 받을 데이터 타입
		,data 		: params			 //url 요청 시 파라미터 정보 
		,success	: function (data) {
			// 댓글 목록 영역에 list 개수 만큼 댓글 추가
			// 댓글 작성자랑 현재 로그인한 사람이 같을 때만 해당 댓글의 수정, 삭제 버튼 
			// 더보기 기능 조건 $(curPage +=1)
			
			if(data.result) {
				$div = $('#id_reply_list_area');
				$.each(data.data, function(index, element) {	//list를 반복하는데 index, element(replyVO)
					var str ='';
					str+= '<div class="row" data-re-no = '+ element.reNo + '>'	//re-no 수정, 삭제 할 때 해당 글 수정하기 위한 용도
						 +'<div class="col-sm-2 text-right">'+ element.reMemName +'</div>'
					     +'<div class="col-sm-6">'
					     +'<pre>' + element.reContent + '</pre>'
					     +'</div><div class="col-sm-2">'+ element.reRegDate + '</div>'	// 나중에 mod가 null이 아니면 mod if문 넣어야함 
						 +'<div class="col-sm-2">';
						 
							//로그인 한 사람이 댓글 작성자이면 
							if('${sessionScope.USER_INFO.userId}'==element.reMemId)	{
							str += '<button name="btn_reply_edit" type="button"'
								  +'class=" btn btn-sm btn-info">수정</button>'
							      +'<button name="btn_reply_delete" type="button"'
								  +'class="btn btn-sm btn-danger">삭제</button>';
							}
						
						str += '</div></div>'
					  
					$div.append(str)
				}); // each
				
				params.curPage+=1;		// 더보기 버튼 누를시 다음 10개 댓글 나오게 
				if(data.count <=10) {	// 더보기 버튼 사라지는 조건 
				 $('id_reply_list_more').remove();
				}
			}	// if
			data.data	// list
			
			
			data.result	// true.false
			data.count	// list.size()
		}	// success
		,error		: function (req, st, err) {
			alert(st);			
		}
	});
	
} // fn_reply_list
	
$(document).ready(
		function() {
				// 수정버튼 클릭
			$('#id_reply_list_area').on('click','button[name=btn_reply_edit]', function(e) {
				// ▷ 모달이 나타나게 할 때의 사전 작업
				// 1. 현재 버튼 댓글 div 내용을 modal에 복사 
				
				
				$btn = $(this);	// 수정 버튼
				$div = $btn.closest('div.row')	//버튼의 댓글 div
				$modal =  $('#id_reply_edit_modal')	//modal div
				// closest는 상위를 검색, find는 하위검색(자식의 자손까지), children 하위 검색(바로 자식 만)
				$pre = $div.find('pre');	// 상위 태그 중 btn이랑 가장 가까운 div 중 클래스가 row인 것을 찾고 그 다음 pre 태그(내용이 담김)을 찾음
				
				var content = $pre.html(); // html()은 innerHTML값, html(' ')은 innerHTML값 변경 
				
				$textarea = $modal.find('textarea');
				
				//$textarea의 내용을 context로 바꾸기
				$textarea.val(content);
				
				// 2. 글번호 <input name =reNo>를 modal에게 전달 (이유: modal의 저장 버튼을 눌렀을 때 DB에 수정되게 하기 위함. )
			
				// modal에서 <input> 태그 찾기 name = reNo, 찾은 후 값 셋팅
				var reNo = $div.data('re-no');
				$modal.find('input[name = reNo]').val(reNo); 								
				
				
				
				// 3. modal이 나타나게, 
				$modal.modal('show');
				
				
						}); // btn_reply_edit.click
						
						
				// 모달창의 (수정)저장버튼 btn_reply_modify 클릭
				$("#btn_reply_modify").click(function(e) {
					e.preventDefault();
					//reNo, reContent을 파라미터로 아작스 호출 
					// Controller단에서 받고, DB수정 후 success
					// success : (선택사항 : 모달 내 reContent, reNo 초기화), modal 사라짐, 
					//			 목록영역에서 업데이트 적용(목록영역 제거 후 다시 fn_reply_list)
					

					$modal =  $('#id_reply_edit_modal')	//modal div
					$btn = $(this);
					$form = $btn.closest('form[name = frm_reply_edit]');
						
					
					$.ajax({
						 type: 'POST'
						,url : '<c:url value = "/reply/replyModify" />'
						,data : $form.serialize()
						,dataType : 'JSON'
						,success : function (data) {
							
							$modal.modal('hide');
							
							$form.find('textarea[name=reContent]').val('');			// textarea영역 내용 지우기 
							
							// 댓글 목록 영역 등록된 댓글 적용 = 댓글목록 지우고 DB에서 다시 받기 
							$('#id_reply_list_area').html('');
							params.curPage=1;
							fn_reply_list();
							
						},
						error: function (req, st, err) {
							console.log(req);
						}
					})
					
					fn_reply_list();
					
				}); // btn_reply_modify.click
				
				
				// 삭제버튼 클릭
				$('#id_reply_list_area').on('click','button[name=btn_reply_delete]', function(e) {
					// 파라미터로 reNo넘기고 DB에서 삭제 
					// success 시 해당 버튼을 누르면 댓글(div.row)을 목록에서 제거  or 목록제거 후 다시 fn_reply_ist
					
					$btn = $(this)	//삭제 버튼
					$div = $btn.closest('div.row');
					
					if(confirm("댓글을 삭제하시겠습니까?")) {
						$.ajax({
							 type: 'POST'
							,url : '<c:url value = "/reply/replyDelete" />'
							,data : {'reNo' : $div.data('re-no')}
							,dataType : 'JSON'
							,success : function (data) {
								$div.remove();
								//params.curPage=1;								
							},
							error : function (req, st, err) {
								
							}
						});
					}
					
						}); // btn_reply_delete.click

				//더보기 버튼 클릭
				$('#btn_reply_list_more').click(function(e) { fn_reply_list();
				}); // #btn_reply_list_more.click
				
				
				// 등록버튼 클릭
				$("#btn_reply_regist").click(function(e) {
					// 1. 로그인이 안되어있으면 로그인 화면으로 (interCeptor와 같이)
					// 2. 등록 버튼의 상위 idv찾기, textarea 찾기 
					// 3. textarea내용, reParentNo, reCategory 파라미터로 넘기기 → 실제로 DB에 저장이 됨
					// 4. 댓글 등록 영역 내용 지우기 및 등록된 댓글 바로 적용 (바로 댓글이 뜨게 ) // 여기까지는 새로고침 해야 뜸 
					// 5. 로그인 하지 않고 등록 버튼을 누르면 로그인 화면으로 이동 → reply/replyRegist 전에 LoginCheckInterCeptor 가 가로채기 
					
					
					$btn = $(this);		// 자기 자신 (등록버튼)
					$form = $btn.closest('form[name = frm_reply]');
					e.preventDefault();
					
					var res = confirm("글 등록 하시겠습니까?")
					
						if(res){
						$.ajax({
							 type: 'POST'
							,url: '<c:url value = "/reply/replyRegist"/>'
							,data: $form.serialize() 	//form 태그 안에 reContent, reParentNo, reCategory  → {'reContent: value', 'reParentNo: value' ...}
							,dataType : 'JSON'
							,success : function (data) {
								console.log(data);
								//children이 바로 한단계 밑 자식 찾기, find는 자식의 후손들까지 찾음 
								$form.find('textarea[name=reContent]').val('');			// textarea영역 내용 지우기 
								
								// 댓글 목록 영역 등록된 댓글 적용 = 댓글목록 지우고 DB에서 다시 받기 
								$('#id_reply_list_area').html('');
								params.curPage=1;
								fn_reply_list();
							},
							error : function (req, st, err) {
								console.log(req);
								console.log(st);
								console.log(err);

								
								//401이면 인터셉터에 걸린거라고 간주, login 화면으로 이동 
								if(req.status == 401) {
									window.location.href='<c:url value = "/login/login.wow" />';
								}// 로그인 하고 나서 어떻게 하면 다시 freeView 화면으로 올지. 원래는 로그인 하면 무조건 홈 화면으로 이동함 
							}
							
						})	//ajax
						} //if
					
				}); // #btn_reply_regist.click
				
				
				// 초기화 함수 호출
				fn_reply_list();	// 처음 list 한 번 출력
			}); // ready
</script>
<!-- END : 댓글 처리 스크립트 -->

</html>


<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/inc/header.jsp"%>
<title>Teaming</title>
</head>
<style>
a {text-decoration:none;}
</style>
<body>
		<div class="container">
			<div class="page-header">
				<h3>
					총 공지 게시판 - <small>글 보기</small>
				</h3>
			</div>
			<table class="table">
				<tbody>
					<tr>
						<th scope="row">글번호</th>
						<td>${aNotice.aNoticeNo }</td>
					</tr>
					<tr>
						<th scope="row">글제목</th>
						<td>${aNotice.aNoticeTitle }</td>
					</tr>
					<tr>
						<th scope="row">작성자명</th>
						<td>${aNotice.aNoticeWriterName }</td>
					</tr>
					<tr>
						<th scope="row">내용</th>
						<td><textarea rows="10" name="aNoticeContent"
								class="form-control input-sm">${aNotice.aNoticeContent }</textarea></td>
					</tr>
					<tr>
						<th scope="row">조회수</th>
						<td>${aNotice.aNoticeHit }</td>
					</tr>
					<tr>
						<th scope="row">최근등록일자</th>
						<td><c:if test="${aNotice.aNoticeModDate eq null }">${aNotice.aNoticeRegDate }</c:if>
							${aNotice.aNoticeModDate }</td>
					</tr>
					<tr>
						<th scope="row">삭제여부</th>
						<td>${aNotice.aNoticeDelYn }</td>
					</tr>
					<tr>
						<td colspan="2">
							<div class="pull-left">
								<a href="noticeListForAdmin" class="btn btn-default btn-sm"> <span
									class="glyphicon glyphicon-list" aria-hidden="true"></span>
									&nbsp;&nbsp;목록
								</a>
							</div>
							<div class="pull-right">
								<a href="noticeEdit?aNoticeNo=${aNotice.aNoticeNo }"
									class="btn btn-success btn-sm"> <span
									class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
									&nbsp;&nbsp;수정
								</a>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- container -->
<%-- 
		<div class="container">
			<!-- reply container -->

			<!-- // START : 댓글 등록 영역  -->
			<div class="panel panel-default">
				<div class="panel-body form-horizontal">
					<form name="frm_reply"
						action="<c:url value='/reply/replyRegist' />" method="post"
						onclick="return false;">
						<input type="hidden" name="reParentNo" value="${aNotice.aNoticeNo}">
						<input type="hidden" name="reCategory" value="NTAD">
						<div class="form-group">
							<label class="col-sm-2  control-label">댓글</label>
							<div class="col-sm-8">
								<textarea rows="3" name="reContent" class="form-control"><c:if test="${sessionScope.PRECONT ne null}">${sessionScope.PRECONT }</c:if></textarea>
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
				<!-- 스크립트부분 -->
			</div>

			<div class="row text-center" id="id_reply_list_more">
				<a id="btn_reply_list_more"
					class="btn btn-sm btn-default col-sm-10 col-sm-offset-1"> <span
					class="glyphicon glyphicon-chevron-down" aria-hidden="true"></span>
					더보기
				</a>
			</div>
			<!-- // END : 댓글 목록 영역  -->

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
--%> 
</body>

<%--
<!-- START : 댓글 처리 스크립트	-->
	<!--  
		1.javascript 시작시 버튼이벤트 등록, fn_reply_list() 실행
		2.리스트보기 (로그인안해도 가능한 기능)
		3.수정, 삭제, 등록 (로그인해야 가능한 기능)
		4.수정, 삭제, 등록에서 일단 ajax를 우선적으로 실행 reply/** 요청, 로그인체크 인터셉터가 가로채서 처리
		5.처리결과에 따라 success로 갈지 error로 갈지 결정.
		6.error로 오는건 로그인이 안되어있는거니까 > login 화면으로 보내기.
	-->


<script type="text/javascript">
	//var curPage = 1;
	//var rowSizePerPage = 10;
	//var parentNo = ${board.boNum};
	//세가지 한번에
	var params={"curPage":1, "rowSizePerPage":10, "reCategory":"NTAD", "reParentNo":${aNotice.aNoticeNo}};
	
	// 댓글목록을 구하는 함수
	function fn_reply_list() {	
		//fn_reply_list는 반복해서 사용, ajax에서 요청해서 db접근 후 replyVOList를 가져와서 화면에 출력.
		//새로고침 안하고 바로바로 화면에 적용할 수 있게 반복해서 사용하는 것.(그때그때 동기화)
		$.ajax({
			type		: 'POST'
			, url		: '<c:url value="/reply/replyList" />'
			, dataType	: 'JSON' //서버(controller 메소드 리턴)에서 받을 데이터 타입
			, data 	: params 
			, success 	: function(data) {
				//console.log(data);
				//map에 담아서 가져왔기 때문에 이런식으로 출력해야함.
			 	//data.data 이게 리스트 data.count 이게 list.size
			 	
			 	//댓글 목록 영역에 list 개수만큼 댓글 추가하기
			 	//댓글 작성자랑 현재 로그인한 사람이 같을 때만 해당 댓글의 수정,삭제 버튼 활성화하기
			 	//더보기 기능은 curPage + 1 해주면 된다 < 남은 댓글이 있을 때
			 	if(data.result){ //true, false 반환
			 		$div=$('#id_reply_list_area');
			 		$.each(data.data, function(i, elt) { //list(data.data)를 반복하는데 index, element(replyVO)
			 			var str = '';
			 		//해당구간을 반복
						str+='	<div class="row" data-re-no='+ elt.reNo +'>	' //data~부분은 수정,삭제할때 사용
							+'		<div class="col-sm-2 text-right">'+ elt.reMemName +'</div> '
							+'		<div class="col-sm-6">	'
							+'		<pre>'+ elt.reContent +'</pre>	'
							+'		</div>	'
							+'		<div class="col-sm-2">'+ elt.reRegDate +'</div>	' //mod가 null이 아니면 mod
							+'		<div class="col-sm-2">	';
						if('${sessionScope.USER_INFO.userId}'==elt.reMemId){
							str+= '<button name="btn_reply_edit" type="button" class=" btn btn-sm btn-info">수정</button>'
								+ '<button name="btn_reply_delete" type="button" class="btn btn-sm btn-danger">삭제</button>'
						}; //로그인한 사람(세션에 있는) == 댓글작성자(elt)가 동일인인지 확인 후 출력해줌.
						str+='		</div>	'
							+'	</div>	';
			 			$div.append(str);
			 		})//each
					params.curPage+=1; //반복끝나면 더보기 페이지를 눌렀을때 10개를 출력해줄 수 있도록 curPage를 증가시켜준다.
					if(data.count<10){ //10개보다 조금 출력이 되면 더보기 버튼이 보이지 않게.
						$('#id_reply_list_more').remove();
					}
			 	}//if
			}//success
			, error 	: function(req, st, err) {
				alert(st);
			}//error
		});
	} // fn_reply_list
	$(document).ready(function() {
		// 수정버튼 클릭
		$('#id_reply_list_area').on('click','button[name=btn_reply_edit]', function(e) {
			// db에 저장되는건 모달의 저장버튼을 누를때.
			// 현재 버튼의 댓글div의 내용을 modal 수정칸에 복사
			// 글번호(data-re-no)를 모달의 input(name=reno)에게 전달, 그다음 모달이 보이게끔 하는거임.
			
			$btn=$(this); //수정버튼
			$div=$btn.closest('div.row');
			$modal=$('#id_reply_edit_modal'); //modal div
			
			$pre=$div.find('pre');
			var content=$pre.html(); //html == innerHTML
			$textarea=$modal.find('textarea');
			$textarea.html(content); //내용바꾸기
			var reNo=$div.data('re-no'); //data속성의 re-no
			$modal.find('input[name=reNo]').val(reNo);
			
			$modal.modal('show'); //모달 보이게
		}); // btn_reply_edit.click
		
		// 모달창의 (수정)저장버튼 btn_reply_modify 클릭
		$("#btn_reply_modify").click(function(e) {
			//reNo, reContent를 파라미터로 ajax 호출. 컨트롤러에서 받음. db수정 후 success
			//success: (모달내의 reContent, reNo 초기화), modal사라지기, 목록에 바로 적용.
			$btn=$(this);
			$modal=$('#id_reply_edit_modal');
			$form=$btn.closest('form[name=frm_reply_edit]');
			e.preventDefault();
 			$.ajax({
				type:'POST'
				,url:'<c:url value="/reply/replyModify"/>'
				,data:$form.serialize()
				,dataType:'JSON'
				,success :function(data) {
					alert('댓글이 수정되었습니다');
					$form.find('input[name=reNo]').val('');
					$form.find('textarea[name=reContent]').html('');
					$modal.modal('hide');
					$('#id_reply_list_area').html('');
					params.curPage=1; //curpage초기화
					fn_reply_list();
				}
				,error :function(req,st,err) {
					alert(st)
				}
			}); 
		}); // btn_reply_modify.click
		
		
		// 삭제버튼 클릭
		$('#id_reply_list_area').on('click','button[name=btn_reply_delete]', function(e) {
			//파라미터로 reNo넘기고 db에서 삭제
			//success 후 목록에서 해당 row 제거 혹은 목록 다시부르기
			
			$btn=$(this); //삭제버튼
			$div=$btn.closest('div.row'); //상위 div 중 클래스명이 row인걸 찾음
			if(confirm("댓글을 삭제하시겠습니까?")){
				$.ajax({
					type:'POST'
					,url:'<c:url value="/reply/replyDelete"/>'
					,data:{'reNo':$div.data('re-no')}
					,dataType:'JSON'
					,success: function(data) {
						//해당부분 목록에서 제거하는 방법
						$div.remove(); //간단!
					}
					,error: function(req,st,err) {
						alert(st)
					}
				});
			};
		}); // btn_reply_delete.click
		
		//더보기 버튼 클릭
		$('#btn_reply_list_more').click(function(e) {
			fn_reply_list();
		}); // #btn_reply_list_more.click
		
		// 등록버튼 클릭
		$("#btn_reply_regist").click(function(e) {
			//로그인이 안되어 있으면 로그인 화면으로(interCeptor와 같이).
			//reply/replyRegist 전에 interceptor가 가로채기
			
			//등록버튼의 상위 form 찾고 textarea의 내용을 찾기
			//textarea내용, reParentNo, reCategory를 넘겨줘야함. =>DB저장됨 
			//textarea내용 지우고 등록된 댓글을 바로 볼 수 있게 적용시켜주기.
			
			$btn=$(this); //자기자신(등록버튼)
			$form=$btn.closest('form[name=frm_reply]');
			e.preventDefault();
			var res = confirm("글을 등록하시겠습니까?");
			
			//버튼이 form 안에 있어서 textarea내용(reContent)과 input(reParentNo, reCategory)을 한번에 보낸다
			if(res){
				$.ajax({
					type		:	'POST'
					,url		:	'<c:url value="/reply/replyRegist"/>'
					,dataType	:	'JSON'
					,data		:	$form.serialize() //{'reContent': value,,,}<<이런 제이슨으로 만들어주는 함수
					,success	: function(data) {
						console.log(data);
						$form.find('textarea[name=reContent]').val(''); //children 자식, find 자손
						//댓글목록 영역을 지우고 다시 가져오기.
						$('#id_reply_list_area').html('');
						params.curPage=1; //curpage초기화
						fn_reply_list();
					}
					,error		: function(req,st,err) {
						if(req.status==401){
							window.location.href='<c:url value="/login/login"/>';
						};
					}
				})
			};
		}); // #btn_reply_regist.click
		
		// 초기화 함수 호출(실행하자마자 화면에 나오는부분)
		fn_reply_list();
	}); // ready
</script>
<!-- END : 댓글 처리 스크립트-->
 --%> 
</html>







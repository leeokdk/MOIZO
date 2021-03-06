<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<%request.setCharacterEncoding("UTF-8"); %>
<html>
<head>
<%@include  file="/WEB-INF/inc/header.jsp" %>
<meta charset="UTF-8">
<title>Teaming</title>
</head>
<!-- datepicker -->
 <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
 <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
 <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> 

<!-- timepicker  -->
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>

<!-- 알럿  -->
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style>
/* 하도 안먹어서 때려넣음  */
 .ui-widget-header { border: 0px solid #dddddd; background: #fff; } 

 .ui-datepicker-calendar>thead>tr>th { font-size: 14px !important; } 

 .ui-datepicker .ui-datepicker-header { position: relative; padding: 10px 0; } 

 .ui-state-default,
 .ui-widget-content .ui-state-default,
 .ui-widget-header .ui-state-default,
 .ui-button,
 html .ui-button.ui-state-disabled:hover,
 html .ui-button.ui-state-disabled:active { border: 0px solid #c5c5c5; background-color: transparent; font-weight: normal; color: #454545; text-align: center; } 

 .ui-datepicker .ui-datepicker-title { margin: 0 0em; line-height: 16px; text-align: center; font-size: 14px; padding: 0px; font-weight: bold; } 

 .ui-datepicker { display: none; background-color: #fff; border-radius: 4px; margin-top: 10px; margin-left: 0px; margin-right: 0px; padding: 20px; padding-bottom: 10px; width: 300px; box-shadow: 10px 10px 40px rgba(0, 0, 0, 0.1); } 

 .ui-widget.ui-widget-content { border: 1px solid #eee; } 

 #datepicker:focus>.ui-datepicker { display: block; } 

 .ui-datepicker-prev,
 .ui-datepicker-next { cursor: pointer; } 

 .ui-datepicker-next { float: right; } 

 .ui-state-disabled { cursor: auto; color: hsla(0, 0%, 80%, 1); } 

 .ui-datepicker-title { text-align: center; padding: 10px; font-weight: 100; font-size: 20px; } 

 .ui-datepicker-calendar { width: 100%; } 

 .ui-datepicker-calendar>thead>tr>th { padding: 5px; font-size: 20px; font-weight: 400; } 

 .ui-datepicker-calendar>tbody>tr>td>a { color: #000; font-size: 12px !important; font-weight: bold !important; text-decoration: none;}

 .ui-datepicker-calendar>tbody>tr>.ui-state-disabled:hover { cursor: auto; background-color: #fff; } 

 .ui-datepicker-calendar>tbody>tr>td { border-radius: 100%; width: 44px; height: 30px; cursor: pointer; padding: 5px; font-weight: 100; text-align: center; font-size: 12px; } 

 .ui-datepicker-calendar>tbody>tr>td:hover { background-color: transparent; opacity: 0.6; } 

 .ui-state-hover,
 .ui-widget-content .ui-state-hover,
 .ui-widget-header .ui-state-hover,
 .ui-state-focus,
 .ui-widget-content .ui-state-focus,
 .ui-widget-header .ui-state-focus,
 .ui-button:hover,
 .ui-button:focus { border: 0px solid #cccccc; background-color: transparent; font-weight: normal; color: #2b2b2b; } 

 .ui-icon-circle-triangle-e { background-position: -20px 0px; background-size: 36px; } 

 .ui-icon-circle-triangle-w { background-position: -0px -0px; background-size: 36px; } 

 .ui-datepicker-calendar>tbody>tr>td:first-child a { color: red !important; } 

 .ui-datepicker-calendar>tbody>tr>td:last-child a { color: #0099ff !important; } 

 .ui-datepicker-calendar>thead>tr>th:first-child { color: red !important; } 

 .ui-datepicker-calendar>thead>tr>th:last-child { color: #0099ff !important; } 

 .ui-state-highlight,
 .ui-widget-content .ui-state-highlight,
 .ui-widget-header .ui-state-highlight { border: 0px; background: #699bdc; color: white; border-radius: 2%; padding-top: 20%; padding-bottom: 20%;} 

 .inp { padding: 10px 10px; background-color: #f1f1f1; border-radius: 4px; border: 0px; } 

 .inp:focus { outline: none; background-color: #eee; } 
</style>
<body>
<div class="container">
<form:form action="scheduleRegist" method="post" modelAttribute="moimSchedule" id="id_save">
		
			<table class="table">
					<form:hidden path="moimCode" />	
					<form:hidden path="mScheduleNo" />	
				<tr>
					<th scope="row" id="id_date">일정 날짜</th>
					<td><form:input path="mScheduleModDate"
							cssClass="form-control input-sm"  /></td>
					<td><span id="span_tag0" style="color: red"></span></td> 
				</tr>
				<tr>
					<th scope="row">시작 시간</th>
					<td><form:input path="mScheduleStartTime"
							cssClass="form-control input-sm"/></td>
					<td><span id="span_tag1" style="color: red"></span></td> 
				</tr>
								<tr>
					<th scope="row">종료 시간</th>
					<td><form:input path="mScheduleEndTime"
							cssClass="form-control input-sm"/></td>
					<td><span id="span_tag2" style="color: red"></span></td> 
				</tr>
				<tr>
					<th scope="row">참여 인원</th>
					<td><form:input path="mScheduleEnterMax"
							cssClass="form-control input-sm" /></td>
					<td><span id="span_tag3" style="color: red"></span></td> 
				</tr>
				<tr>
					<th scope="row">장소</th>
					<td><form:input path="mSchedulePlace"
							cssClass="form-control input-sm" /></td>
					<td><span id="span_tag4" style="color: red"></span></td> 
				</tr>
				<tr>
					<td colspan="2">
						<div class="pull-left">
							<input type='button' onclick='fn_close()' value='취소' class="btn btn-sm btn-danger" id="id_close"/>
						</div>
						<div class="pull-right">
							<input type="button" value="저장" onClick="fn_save1()" class="btn btn-sm btn-primary"/>
						</div>
					</td>
				</tr>
				
			</table>
		</form:form>
</div>	<!-- Container 종료 -->

</body>
<script type="text/javascript">
/* 데이트 피커로 달력 나타내기 */
 $.datepicker.setDefaults({
  dateFormat: 'yy-mm-dd',
  prevText: '이전 달',
  nextText: '다음 달',
  monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
  monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
  dayNames: ['일', '월', '화', '수', '목', '금', '토'],
  dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
  dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
  showMonthAfterYear: true,
  yearSuffix: '년'
});
 
 
 /* 값 받아와서 비교할 수 있도록 하기  */
 function fn_click() {
	 alert($('#mScheduleStartTime').val())

}
 
 $( function() {
    $( "#mScheduleModDate" ).datepicker();
  } );
	
/* 타임피커로 시간 나타내기 */
$(document).ready(function(){
	$('#mScheduleStartTime').timepicker({
	    timeFormat: 'h:mm p',
	    interval: 30,
	    minTime: '8:00am',
	    maxTime: '11:00pm',
	    startTime: '8:00am',
	    dynamic: false,
	    dropdown: true,
	    scrollbar: true
	});
	
	$('#mScheduleEndTime').timepicker({
	    timeFormat: 'h:mm p',
	    interval: 30,
	    minTime: '8:00am',
	    maxTime: '11:00pm',
	    startTime: '8:00am',
	    dynamic: false,
	    dropdown: true,
	    scrollbar: true
	});
});

/* 취소를 누르면 창이 꺼짐*/
function fn_close(){
	self.opener = self;
	window.close();   //자기자신창을 닫습니다.
}


/* 날짜 비교를 위한 함수 선언 */
function getTimeStamp() {

    var d = new Date();
    var s =
        leadingZeros(d.getFullYear(), 4) + '-' +
        leadingZeros(d.getMonth() + 1, 2) + '-' +
        leadingZeros(d.getDate(), 2);

    return s;
}

function leadingZeros(n, digits) {

    var zero = '';
    n = n.toString();

    if (n.length < digits) {
        for (i = 0; i < digits - n.length; i++)
            zero += '0';
    }
    return zero + n;
}

/* 버튼을 누르면 글이 수정 되는 팝업 알림창 */
function fn_save1() {
	var today = getTimeStamp(); 	// 날짜 변수 생성 yyyy-mm-dd 형식임
	var s_day = $("#mScheduleModDate").val();
	

	if(today > s_day){	// true 면 실행되고 , false면 지나감 
	
		//만약 과거의 일정을 등록한다면
		 Swal.fire({
			   icon: 'error',
			   title: '저장 실패',
			   text: '과거의 일정은 등록할 수 없습니다'
			 })
			 
	} else{
	
		Swal.fire({
			  title: '저장',
			  text: "글을 저장하시겠습니까?",
			  icon: 'success',
			  showCancelButton: true,
			  confirmButtonColor: '#3085d6',
			  cancelButtonColor: '#d33',
			  confirmButtonText: 'Yes'
			}).then((result) => {
			  if (result.isConfirmed) {
				
				$.ajax({
					 type		: 'POST'
					,url 		: '<c:url value="/schedule/scheduleRegist" />'
					,data 		: {"moimCode":$("#moimCode").val(),"mScheduleNo":$("#mScheduleNo").val(),"mScheduleModDate":$("#mScheduleModDate").val(),
								   "mScheduleStartTime":$("#mScheduleStartTime").val(),"mScheduleEndTime":$("#mScheduleEndTime").val(),
								   "mScheduleEnterMax":$("#mScheduleEnterMax").val(),"mSchedulePlace":$("#mSchedulePlace").val()} 
					,dataType: "json"
					,success	: function (data) {
						//오류가 있을 때      json2
						//오류가 없을 때   {"a":"a"}
						console.log(data.a);
						
						//오류가 없으면 
						if(data.a == "a"){
							self.opener = self;
							window.close();
						// 있으면
						}else{
							
	        				//console.log("data_parse:::"+data.mScheduleModDate4);
							/*   alert("defaultMessage::::"+data);*/
							
							$("#span_tag0").text(data.mScheduleModDate0);
							$("#span_tag1").text(data.mScheduleModDate1);
							$("#span_tag2").text(data.mScheduleModDate2);
							$("#span_tag4").text(data.mScheduleModDate3);
							$("#span_tag3").text(data.mScheduleModDate4);
						}
						
						
					}, error:function(request,status,error){
				        alert("error");
				       }
			  
				})
					
			  }
			})
	
		}		
		
}	//fn_save1() 


</script>
</html>

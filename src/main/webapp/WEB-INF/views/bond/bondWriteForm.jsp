<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file="../head.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
	.input-file-button{
	 	margin-left: 10px;
	  	padding: 6px 25px;
		background-color:#FF6600;
		border-radius: 4px;
		color: white;
		cursor: pointer;
	}
	.m-info {
		cursor: pointer;
	}
	.m-info:hover {
		color : #337ab7;
	}
</style>
<script type="text/javascript">

	function getFormatDate(date){
		var stodate = new Date(date);
	    var year = stodate.getFullYear();              
	    var month = (1 + stodate.getMonth());         
	    month = month >= 10 ? month : '0' + month;  
	    var day = stodate.getDate();                   
	    day = day >= 10 ? day : '0' + day;          
	    return  year + '-' + month + '-' + day;
	}
	
	function searchS() {
		var search = $('#search').val();
		var keyword = $('#keyword').val();
		$.ajax({
			url: "${path}/bond/memberSrc",
			type: 'post',
			data: {
				'search' : search,
				'keyword' : keyword
			},
			success: function(data) {
				
				$('#searchbody').empty();
				if(data.length == 0){
					$('#searchbody').append("<tr><td colspan='6' align='center'>검색한 자료가 없습니다.</td></tr>");
				}
				if(data.length > 0) {
					for(var i=0 in data){
						var n = parseInt(i)+1;
						$('#searchbody').append(
								"<tr class='m-info' onclick=selectdata('"+data[i].m_id+"')><td align='center'>"+n+"</td>"
								+"<td align='center'>"+data[i].m_id+"</td>"
								+"<td align='center'>"+data[i].m_name+"</td>"
								+"<td align='center'>"+data[i].b_name+"</td>"
								+"<td align='center'>"+data[i].t_name+"</td>"
								+"<td align='center'>"+getFormatDate(data[i].m_hiredate)+"</td>"
								+"</tr>");
					}
				}
			}
		});
	}
	
	function selectdata(obj) {
		$('#m_id').val(obj);
		$('#info').find('td').empty();
		$.ajax({
			url : "${path}/bond/getMember",
			type : 'post',
			data : {
				'm_id' : obj
			},
			success : function (data) {
				if(data.length > 0){
						$('#id').append("<span>"+data[0].m_id+"</span>");
						$('#ssnum').append("<span>"+data[0].m_ssnum+"</span>");
						$('#name').append("<span>"+data[0].m_name+"</span>");
						$('#tel').append("<span>"+data[0].m_tel+"</span>");
						$('#email').append("<span>"+data[0].m_email+"</span>");
						$('#hiredate').append("<span>"+getFormatDate(data[0].m_hiredate)+"</span>");
						$('#branch').append("<span>"+data[0].b_name+"</span>");
						$('#team').append("<span>"+data[0].t_name+"</span>");
						$('#role').append("<span>"+data[0].r_name+"</span>");
						$('#addr').append("<span>"+"("+data[0].m_postcode+") "+data[0].m_addr
								+data[0].m_detailaddr+data[0].m_extraaddr+"</span>");
						$('#searchbody').empty();
						$('.modal-box').fadeOut();
				} 
			}
		});
	}
	
	function openBox() {
		$('#searchbody').append("<tr><td colspan='6' align='center'>검색하세요</td>	</tr>");
		$('.modal-box').fadeIn();
	}
	
	function closeBox() {
		$('#searchbody').empty();
		$('.modal-box').fadeOut();
	}
	
	function fileName() {
		var fileVal = $('#file').val().split("\\");
		var fileName = fileVal[fileVal.length-1];
		
		if(fileName == '') {
			$('#filename').text('선택된 파일이 없습니다.');
		} else {
			$('#filename').text(fileName);
		}
	}
	 function inputNumberFormat(obj) {
	     obj.value = comma(uncomma(obj.value));
	 }

	 function comma(str) {
	     str = String(str);
	     return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	 }

	 function uncomma(str) {
	     str = String(str);
	     return str.replace(/[^\d]+/g, '');
	 }
	 
	 function end() {
		var enddate = frm.bo_enddate.value;
		var startdate = frm.bo_startdate.value;
		
		if(frm.bo_startdate.value==''){
			alert('게시일을 먼저 입력해주세요');
			frm.bo_enddate.value='';
			frm.bo_startdate.focus();
		} else if(startdate > enddate){
			alert('게시일 보다 빠를수 없습니다.')
			frm.bo_enddate.value='';
			frm.bo_enddate.focus();
		}
	}
	 
	 function chk() {
		 if(frm.m_id.value == ''){
			 alert('회원검색을 통해 회원을 선택해주세요');
			 return false;
		 }
		 if(frm.bo_kinds.value == ''){
			 alert('채권 종류를 입력하세요');
			 frm.bo_kinds.focus();
			 return false;
		 }
		 if(frm.bo_startdate.value == ''){
			 alert('게시일자를 입력해주세요');
			 frm.bo_startdate.focus();
			 return false;
		 }
		 if(frm.bo_enddate.value == ''){
			 alert('만기일자를 입력해주세요');
			 frm.bo_enddate.focus();
			 return false;
		 }
		 if(frm.bo_pay.value == ''){
			 alert('채권금액을 입력해주세요');
			 frm.bo_pay.focus();
			 return false;
		 }
		 if(frm.file.value == ''){
			 alert('채권 파일을 업로드 해주세요');
			 frm.file.focus();
			 return false;
		 }
	}
</script>
</head>
<body>
	<div class="container" align="center">
		<div class="modal-box">
			<div class="modal-box-content">
				<h2 class="text-primary">회원 검색</h2>
				<div class="mt-3">
					<select class="form-control" name="search" id="search" style="display: inline-block; width: 120px; height: 40px; line-height: 40px;" >
						<c:forTokens var="sh" items="alls,m_id,m_name,b_name,t_name" delims="," varStatus="i">
							<option value="${sh }">${titles[i.index]}</option>
						</c:forTokens>
					</select>
					<input class="form-control" type="search" id="keyword" name="keyword" style="display: inline-block; width: 200px; height: 40px; line-height: 40px;">
					<input class="btn btn-default" type="button" value="검색" style="width:80px; height: 40px; line-height: 40px; padding: 0;" onclick="searchS();">
				</div>
				<table class="table table-bordered table-hover mt-3">
					<thead style="background: #e0e0e0;">
						<tr>
							<th>No.</th>
							<th>사번</th>
							<th>이름</th>
							<th>지점명</th>
							<th>팀명</th>
							<th>위촉일자</th>
						</tr>
					</thead>
					<tbody id="searchbody">
					</tbody>
				</table>
				<div class="mt-5">
					<input class="btn btn-danger btn-lg" type="button" onclick="closeBox();" value="닫기">
				</div>
			</div>
		</div>
		<h2 class="text-primary mt-3">채권 등록</h2>
		<div align="left">
			<input type="button" class="btn btn-warning btn-lg" onclick="history.go(-1)" value="뒤로">
			<input id="msearch" type="button" class="btn btn-success btn-lg" onclick="openBox()" value="회원 검색" style="float: right;">
		</div>
		<table class="table table-bordered mt-1" id="info" style="width: 100%;">
			<tr>
				<th width="100">사번</th>
				<td id="id" width="200"></td>
				<th width="100">주민번호</th>
				<td id="ssnum" width="200"></td>
			</tr>
			<tr>
				<th>이름</th>
				<td class="in" id="name"></td>
				<th>전화번호</th>
				<td class="in" id="tel"></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td class="in" id="email"></td>
				<th>위촉일자</th>
				<td class="in" id="hiredate"></td>
			</tr>
			<tr>
				<th>지점명</th>
				<td class="in" id="branch"></td>
				<th>팀명</th>
				<td class="in" id="team"></td>
			</tr>
			<tr>
				<th>직책</th>
				<td class="in" id="role"></td>
				<th>주소</th>
				<td class="in" id="addr"></td>
			</tr>
		</table>
		<form action="${path }/bond/bondWrite" method="post" enctype="multipart/form-data" name="frm" onsubmit="return chk();">
		<input type="hidden" id="m_id" name="m_id">
		<table class="table table-bordered mt-3" style="width: 100%;">
			<thead>
				<tr>
					<th>채권 종류</th>
					<th>게시 일자</th>
					<th>만기 일자</th>
					<th>채권 금액</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<input class="form-control" type="text" name="bo_kinds">
					</td>
					<td>
						<input class="form-control" type="date" name="bo_startdate" style="display: inline-block; width: 200px;">
					</td>
					<td>
						<input class="form-control" type="date" name="bo_enddate" onchange="end()" style="display: inline-block; width: 200px;">
					</td>
					<td>
						<input class="form-control" type="text" name="bo_pay" onkeyup="inputNumberFormat(this)">
					</td>
				</tr>
				<tr>
					<th style="vertical-align: middle;">채권 첨부파일</th>
					<td colspan="3" style="vertical-align: middle;">
						<label class="input-file-button" for="file">
							업로드
						</label>
						<label id="filename">
							파일이 없습니다.
						</label>
						<input type="file" name="file" id="file" onchange="fileName()" style = "display: none;">
					</td>
				</tr>
			</tbody>
		</table>
		<div>
			<input class="btn btn-primary btn-lg" type="submit" value="등록">
		</div>
		</form>
	</div>
</body>
</html>
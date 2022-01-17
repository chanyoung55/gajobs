<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file="../head.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.search-box {
		position: absolute;
		width: 100%;
		height: 100%;
		background: rgba(0,0,0,0.8);
		top:0;
		left: 0;
		z-index: 999;
		display: none;
	}
	.search-box-content {
		width:80%;
		height:60%;
  		background:#fff; 
  		border-radius:10px;
  		text-align:center;
  		box-sizing:border-box;
  		position: fixed;
  		padding : 20px;
		top: 50%;
		left: 50%;
		-webkit-transform: translate(-50%, -50%);
		-moz-transform: translate(-50%, -50%);
		-ms-transform: translate(-50%, -50%);
		-o-transform: translate(-50%, -50%);
		transform: translate(-50%, -50%);
	}
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
		 var cf = confirm("정말로 수정하시겠습니까?");
		 
		 if(cf){
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
		 }
	}
</script>
</head>
<body>
	<div class="container" align="center">
		<h2 class="text-primary mt-3">채권 수정</h2>
		<div align="left">
			<input type="button" class="btn btn-success btn-lg" onclick="history.go(-1)" value="뒤로가기">
		</div>
		<table class="table table-bordered mt-3" id="info" style="width: 100%;">
			<tr>
				<th width="100">사번</th>
				<td width="200">${bond.m_id }</td>
				<th width="100">주민번호</th>
				<td width="200">${member.m_ssnum }</td>
			</tr>
			<tr>
				<th>이름</th>
				<td>${member.m_name }</td>
				<th>전화번호</th>
				<td>${member.m_tel }</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>${member.m_email }</td>
				<th>위촉일자</th>
				<td>${member.m_hiredate }</td>
			</tr>
			<tr>
				<th>지점명</th>
				<td>${member.b_name }</td>
				<th>팀명</th>
				<td>${member.t_name }</td>
			</tr>
			<tr>
				<th>직책</th>
				<td>${member.r_name }</td>
				<th>주소</th>
				<td>(${member.m_postcode }) ${member.m_addr } ${member.m_detailaddr } ${member.m_extraaddr }</td>
			</tr>
		</table>
		<form action="${path }/bond/bondUpdate/pageNum/${pageNum}" method="post" enctype="multipart/form-data" name="frm" onsubmit="return chk();">
		<input type="hidden" name="bo_num" value="${bond.bo_num }">
		<table class="table table-bordered mt-3" style="width: 100%;">
			<thead style="background: #e0e0e0;">
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
						<input class="form-control" type="text" name="bo_kinds" value="${bond.bo_kinds }">
					</td>
					<td>
						<input class="form-control" type="date" name="bo_startdate" value="${bond.bo_startdate }" style="display: inline-block; width: 200px;">
					</td>
					<td>
						<input class="form-control" type="date" name="bo_enddate" onchange="end()" value="${bond.bo_enddate }" style="display: inline-block; width: 200px;">
					</td>
					<td>
						<input class="form-control" type="text" name="bo_pay" value="${bond.bo_pay }" onkeyup="inputNumberFormat(this)">
					</td>
				</tr>
				<tr>
					<th style="background: #e0e0e0;">기존 파일</th>
					<td colspan="3">
						<input type="hidden" name="bof_seq" value="${bondFile.bof_seq}">
						<a href="${path}/bond/FileDownload/bof_seq/${bondFile.bof_seq}">${bondFile.bof_name }.${bondFile.bof_type }</a>
					</td>
				</tr>
				<tr>
					<th colspan="4" align="center" style="color:red">새로운 파일을 업로드 하면 기존파일은 삭제 됩니다.</th>
				</tr>
				<tr>
					<th style="vertical-align: middle; background: #e0e0e0;">채권 첨부파일</th>
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
			<input class="btn btn-primary btn-lg" type="submit" value="수정하기">
		</div>
		</form>
	</div>
</body>
</html>
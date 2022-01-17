<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../head.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
 function branchChk(obj) {
	 var b_name = $('#b_name').val();
	 var special = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;
	
	 if(special.test(obj.value)){
		 $('#chkBranch').attr('class','err');
		 $('#chkBranch').html("특수문자를 사용할수 없습니다.");
		 obj.value = obj.value.replace(special,'');
	 }else if(b_name.length < 2){
		 $('#chkBranch').attr('class','err');
		 $('#chkBranch').html("지점명을 두글자 이상 입력해주세요");
	 }else {
		 $.ajax({
			url : "${path}/member/branchChk",
			type: 'post',
			data: {
				'b_name' : b_name
			},
			success: function(data) {
				if(data == '1'){
					$('#chkBranch').attr('class','success');
					$('#chkBranch').html('사용가능한 지점명 입니다.');
				} else {
					$('#chkBranch').attr('class','err');
					$('#chkBranch').html('이미 있는 지점명 입니다.');
				}
			}
		 });
	 }
}
 
 function chk() {
	var name = $('#b_name').val();
	var special = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;
	
	if(name.length < 2){
		alert("지점명을 두글자 이상 입력해야 합니다.");
		frm.b_name.focus();
		return false;
	} else if(name == "") {
		alert("지점명을 입력해주세요");
		frm.b_name.focus();
		return false;
	} else if(special.test(name)){
		alert("지점명을 확인 해주세요");
		frm.b_name.focus();
		return false;
	} else if($('#chkBranch').attr('class')=='err'){
		alert("지점명을 확인해 주세요");
		frm.b_name.focus();
		return false;
	} else {
		return true;
	}
}
</script>
</head>
<body>
	<div class="container" align="center">
		<h2 class="text-primary mt-3">지점 등록</h2>
		<form action="${path }/member/branchWrite" method="post" name="frm" onsubmit="return chk();">
		<table class="mt-5" style="width: 50%;">
			<tr>
				<th style="padding:0; height: 50px; line-height: 50px; width: 20%;">지점명</th>
				<td align="center" style="padding:0; height: 40px; line-height: 40px;">
					<input class="form-control" type="text" id="b_name" name="b_name" style="display: inline-block; width: 50%; height: 40px;" onkeyup="branchChk(this)" placeholder="지점명을 입력해주세요">
				</td>
			</tr>
			<tr>
				<td>
				</td>
				<td id="chkBranch" align="center">
				</td>
			</tr>
		</table>
		<div class="mt-5" style="width: 50%; display: flex; justify-content: space-around;">
			<input type="button" class="btn btn-warning btn-lg" onclick="history.go(-1);" value="뒤로">
			<input type="submit" class="btn btn-primary btn-lg" value="등록하기">
		</div>
		</form>
	</div>
</body>
</html>
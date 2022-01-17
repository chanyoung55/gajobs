<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../head.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
 function teamChk(obj) {
	 var t_name = $('#t_name').val();
	 var b_seq = '${team.b_seq}';
	 var special = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;
	
	 if(special.test(obj.value)){
		 $('#chkTeam').attr('class','err');
		 $('#chkTeam').html("특수문자를 사용할수 없습니다.");
		 obj.value = obj.value.replace(special,'');
	 }else if(t_name.length < 2){
		 $('#chkTeam').attr('class','err');
		 $('#chkTeam').html("팀명을 두글자 이상 입력해주세요");
	 }else {
		 $.ajax({
			url : "${path}/member/teamChk",
			type: 'post',
			data: {
				't_name' : t_name,
				'b_seq' : b_seq
			},
			success: function(data) {
				if(data == '1'){
					$('#chkTeam').attr('class','success');
					$('#chkTeam').html('사용가능한 팀명 입니다.');
				} else {
					$('#chkTeam').attr('class','err');
					$('#chkTeam').html('이미 있는 팀명 입니다.');
				}
			}
		 });
	 }
}
 
 function chk() {
	var name = $('#t_name').val();
	var special = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;
	
	if(name.length < 2){
		alert("팀명을 두글자 이상 입력해야 합니다.");
		frm.t_name.focus();
		return false;
	} else if(name == "") {
		alert("팀명을 입력해주세요");
		frm.t_name.focus();
		return false;
	} else if(special.test(name)){
		alert("팀명을 확인 해주세요");
		frm.t_name.focus();
		return false;
	} else if($('#chkTeam').attr('class')=='err'){
		alert("팀명을 확인해 주세요");
		frm.t_name.focus();
		return false;
	} else {
		return true;
	}
}
</script>
</head>
<body>
	<div class="container" align="center">
		<h2 class="text-primary mt-3">팀 수정</h2>
		<form action="${path }/member/teamUpdate" method="post" name="frm" onsubmit="return chk();">
		<input type="hidden" name="b_seq" value="${team.b_seq }">
		<input type="hidden" name="t_seq" value="${team.t_seq }">
		<table class="mt-5" style="width: 50%;">
			<tr>
				<th style="padding:0; height: 50px; line-height: 50px; width: 20%;">팀명</th>
				<td align="center" style="padding:0; height: 40px; line-height: 40px;">
					<input class="form-control" type="text" id="t_name" name="t_name" value="${team.t_name }" style="display: inline-block; width: 50%; height: 40px;" onkeyup="teamChk(this)" placeholder="팀명을 입력해주세요">
				</td>
			</tr>
			<tr>
				<td>
				</td>
				<td id="chkTeam" align="center">
				</td>
			</tr>
		</table>
		<div class="mt-5" style="width: 50%; display: flex; justify-content: space-around;">
			<input type="button" class="btn btn-warning btn-lg" onclick="history.go(-1);" value="뒤로">
			<input type="submit" class="btn btn-primary btn-lg" value="수정">
		</div>
		</form>
	</div>
</body>
</html>
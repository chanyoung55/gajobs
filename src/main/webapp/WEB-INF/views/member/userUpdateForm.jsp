<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../head.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

</style>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
function inputPhoneNumber(obj) {
    var number = obj.value.replace(/[^0-9]/g, "");
    var phone = "";

    if(number.length < 4) {
        return number;
    } else if(number.length < 7) {
        phone += number.substr(0, 3);
        phone += "-";
        phone += number.substr(3);
    } else if(number.length < 11) {
        phone += number.substr(0, 3);
        phone += "-";
        phone += number.substr(3, 3);
        phone += "-";
        phone += number.substr(6);
    } else {
        phone += number.substr(0, 3);
        phone += "-";
        phone += number.substr(3, 4);
        phone += "-";
        phone += number.substr(7);
    }
    obj.value = phone;
}

/* Daum 주소 API */
function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = '(' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('postcode').value = data.zonecode;
            document.getElementById("address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("detailAddress").focus();
        }
    }).open();
}
function chk() {
	if(frm.m_password.value != frm.m_password2.value) {
		alert("암호와 암호확인이 틀립니다.");
		frm.m_password.value="";
		frm.m_password.focus();
		return false;
	} else if(frm.m_tel.value.length < 13){
		alert("전화번호를 확인하세요");
		frm.m_tel.focus();
		return false;
	} else if(frm.m_email.value == ''){
		alert("이메일을 입력하세요");
		frm.m_email.focus();
		return false;
	} else if(frm.m_postcode.value == '' || frm.m_addr.value == '' || frm.m_detailaddr.value == ''){
		alert("주소를 확인해주세요");
		frm.m_postcode.focus();
		return false;
	}
}

function passChk() {
	var pass = $('#m_password').val();
	var pass2 = $('#m_password2').val();
	
	if(pass.length < 8) {
		$('#chkPass').attr('class','err');
		$('#chkPass').text('8자리 이상 입력해주세요');
	} else {
		$('#chkPass').attr('class','success');
		$('#chkPass').text('사용가능한 비밀번호 입니다.');
	}
	
	if(pass != pass2 ) {
		$('#chkPass2').attr('class','err');
		$('#chkPass2').text('비밀번호가 일치하지 않습니다.');
	}else{
		$('#chkPass2').text('');
	}
}

function pass2Chk() {
	var pass = $('#m_password').val();
	var pass2 = $('#m_password2').val();
	
	if(pass != pass2 ) {
		$('#chkPass2').attr('class','err');
		$('#chkPass2').text('비밀번호가 일치하지 않습니다.');
	}else{
		$('#chkPass2').text('');
	}
}
</script>
</head>
<body>
	<div class="container" align="center">
		<h2 class="text-primary mt-3">회원 정보 수정</h2>
		<form action="${path }/member/userUpdate" method="post" id="frm" onsubmit="return chk()">
		<input type="hidden" name="m_id" value="${sideNav.m_id }">
		<table class="table table-bordered mt-3">
			<tr>
				<th width="200" style="vertical-align: middle;">사번</th>
				<td width="300" style="vertical-align: middle;">${sideNav.m_id }</td>
				<th width="200" style="vertical-align: middle;">비밀번호 </th>
				<td width="300" style="vertical-align: middle;" align="center">
					<input type="password" id="m_password" class="form-control" style="width: 50%;" name="m_password" placeholder="비밀번호" onkeyup="passChk()">
					<span id="chkPass" style="font-size:1.2rem;"></span>
				</td>
			</tr>
			<tr>
				<th style="vertical-align: middle;">이름</th>
				<td style="vertical-align: middle;">${sideNav.m_name }</td>
				<th style="vertical-align: middle;">비밀번호 확인</th>
				<td style="vertical-align: middle;" align="center">
					<input type="password" id="m_password2" class="form-control" style="width: 50%;" name="m_password2" onkeyup="pass2Chk()" placeholder="비밀번호 확인">
					<span id="chkPass2" style="font-size:1.2rem;"></span>
				</td>
			</tr>
			<tr>
				<th style="vertical-align: middle;">지점명</th>
				<td style="vertical-align: middle;">${sideNav.b_name }</td>
				<th style="vertical-align: middle;">팀명</th>
				<td style="vertical-align: middle;">${sideNav.t_name }</td>
			</tr>
			<tr>
				<th style="vertical-align: middle;">전화번호</th>
				<td style="vertical-align: middle;" colspan="3">
					<input type="text" name="m_tel" onkeyup="inputPhoneNumber(this);" maxlength="13" class="form-control" style="width: 200px; height: 40px; line-height: 40px; margin-left: 10px;" value="${sideNav.m_tel }" placeholder="숫자만 입력하세요" required="required">
				</td>
			</tr>
			<tr>
				<th style="vertical-align: middle;">직책</th>
				<td style="vertical-align: middle;" colspan="3">${sideNav.r_name }</td>
			</tr>
			<tr>
				<th style="vertical-align: middle;">이메일</th>
				<td style="vertical-align: middle;" colspan="3">
					<input type="email" name="m_email" class="form-control" style="width: 200px; height: 40px; line-height: 40px; margin-left: 10px;" value="${sideNav.m_email }" required="required">
				</td>
			</tr>
			<tr>
				<th style="vertical-align: middle;" rowspan="4">주소</th>
				<td style="vertical-align: middle;" colspan="3" align="left">
					<input type="text" id="postcode" name="m_postcode" class="form-control" style="width: 200px; height: 40px; line-height: 40px; margin-left: 10px; display: inline-block; float: left;" value="${sideNav.m_postcode }" readonly="readonly" required="required">
					<input type="button" onclick="execDaumPostcode()" class="btn btn-primary btn-sm" style="width: 100px; height:40px; padding:0; line-height: 40px; float: left; margin-left: 10px;" value="주소검색">
				</td>
			</tr>
			<tr>
				<td style="vertical-align: middle;" colspan="3">
					<input type="text" id="address" name="m_addr" class="form-control" style="width: 400px; height: 40px; line-height: 40px; margin-left: 10px;" value="${sideNav.m_addr }" readonly="readonly" required="required">
				</td>
			</tr>
			<tr>
				<td style="vertical-align: middle;" colspan="3">
					<input type="text" id="detailAddress" name="m_detailaddr" class="form-control" style="width: 400px; height: 40px; line-height: 40px; margin-left: 10px;" value="${sideNav.m_detailaddr }" required="required">
				</td>
			</tr>
			<tr>
				<td style="vertical-align: middle;" colspan="3">
					<input type="text" id="extraAddress" name="m_extraaddr" class="form-control" style="width: 400px; height: 40px; line-height: 40px; margin-left: 10px;" value="${sideNav.m_extraaddr }">
				</td>
			</tr>
		</table>
			<input type="submit" class="btn btn-primary btn-lg mt-3" value="수정하기">
		</form>
	</div>
</body>
</html>
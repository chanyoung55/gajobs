<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../head.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
table {
	width: 100%;
}
table tr th {
	padding : 0;
	width : 20%;
	height: 70px;
	line-height: 70px;
	text-align: center;
}
table td {
	height: 70px;
}
.input-defualt {
	width: 80%;
	height: 40px;
	line-height: 40px;
	margin-left: 10px;
}
.input-post {
	width: 30%;
	height: 40px;
	line-height: 40px;
	margin-left: 10px;
	display:inline-block;
}
.select-box{
	width: 80%;
	height: 40px;
	line-height: 40px;
}

</style>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	function idChk(obj) {
		var m_id = $('#m_id').val();
		var special = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;
		var kor = /[ㄱ-ㅎㅏ-ㅣ가-힣]/g;
		
		if(special.test(obj.value)){
			$('#chkId').attr('class','err');
			$('#chkId').html('특수문자를 사용할수 없습니다.');
			obj.value = obj.value.replace(special,'');
		} else if(kor.test(obj.value)){
			$('#chkId').attr('class','err');
			$('#chkId').html('한글을 사용할수 없습니다.');
			obj.value = obj.value.replace(kor,'');
		} else if(m_id == '' || m_id == null){
			$('#chkId').attr('class','err');
			$('#chkId').html('아이디를 입력해주세요');
		} else if(m_id.length < 5){
			$('#chkId').attr('class','err');
			$('#chkId').html('아이디를 5자리 이상 입력해주세요');
		} else {
		$.ajax({
			url : "${path}/member/idChk",
			type: 'post',
			data: {
				'm_id' : m_id
			},
			success: function(data) {
				if(data == '1'){
					$('#chkId').attr('class','success');
					$('#chkId').html('사용가능한 아이디 입니다.');
				} else {
					$('#chkId').attr('class','err');
					$('#chkId').html('사용중인 아이디 입니다.');
				}
			}
		});
		}
	}
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
	
	function inputSSNumber(obj) {
		var number = obj.value.replace(/[^0-9]/g, "");
		var a = "";
		
		if(number.length < 6) {
			return number;
		} else {
			a += number.substr(0,6);
			a += "-";
			a += number.substr(6);
		}
		obj.value = a;
	}
	function passChk() {
		var pass = $('#m_password').val();
		
		if(pass.length < 8) {
			$('#chkPass').attr('class','err');
			$('#chkPass').html('8자리 이상 입력해주세요');
		} else {
			$('#chkPass').attr('class','success');
			$('#chkPass').html('사용가능한 비밀번호 입니다.');
		}
	}
	function pass2Chk() {
		var pass = $('#m_password').val();
		var pass2 = $('#m_password2').val();
		
		if(pass != pass2 ) {
			$('#chkPass2').attr('class','err');
			$('#chkPass2').html('비밀번호가 일치하지 않습니다.');
		}else{
			$('#chkPass2').html('');
		}
	}
	
	function branchSelect() {
		var b_seq = $('#b_seq').val();
		
		if(b_seq == '0') {
			$('#t_seq').children('option').remove();
			$('#t_seq').append($('<option>',{
				value : 0,
				text : "팀 선택"
			}));
			
		} else {
			$.ajax({
				url: "${path}/member/teamSelect",
				type: 'post',
				data: {'b_seq' : b_seq},
				success: function(data) {
					$('#t_seq').children('option').remove();
					$('#t_seq').append($('<option>',{
						value : 0,
						text : "팀 선택"
					}));
					if(data.length == 0){}
					for(var i=0 in data){
						$('#t_seq').append($('<option>',{
							value : data[i].t_seq,
							text: data[i].t_name
						}));
					}	
				}
			});
		}
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
	
	function chk() {
		var m_id = $('#m_id').val();
		var password = $('#m_password').val();
		var password2 = $('#m_password2').val();
		var b_seq = $('#b_seq').val();
		var t_seq = $('#t_seq').val();
		var r_code = $('#r_code').val();
		var special = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;
		var kor = /[ㄱ-ㅎㅏ-ㅣ가-힣]/g;
		var nh = /^((\d+)(\-?)(\d+))+$/;
		
		if(special.test(m_id) || kor.test(m_id) || m_id.length < 5){
			alert("아이디를 확인해주세요");
			frm.m_id.focus();
			return false;
		} else if($('#chkId').attr('class')=='err'){
			alert("아이디를 확인해주세요");
			frm.m_id.focus();
			return false;
		} else if(password.length < 8) {
			alert("비밀번호 확인해주세요");
			frm.m_password.focus();
			return false;
		} else if(password != password2){
			alert("비밀번호가 일치하지 않습니다.");
			frm.m_password2.focus();
			return false;
		} else if(frm.m_name.value==""){
			alert("이름을 입력해주세요");
			frm.m_name.focus();
			return false;
		} else if(frm.m_ssnum.value==""){
			alert("주민번호를 입력해주세요");
			frm.m_ssnum.focus();
			return false;
		} else if(!nh.test(frm.m_ssnum.value)){
			alert("주민번호는 숫자만 입력 가능합니다.");
			frm.m_ssnum.focus();
			return false;
		} else if(frm.m_ssnum.value.length < 14){
			alert("주민번호를 확인해주세요");
			frm.m_ssnum.focus();
			return false;
		} else if(frm.m_email.value==""){
			alert("이메일을 입력해주세요");
			frm.m_email.focus();
			return false;
		} else if(frm.m_tel.value==""){
			alert("전화번호를 입력해주세요");
			frm.m_tel.focus();
			return false;
		} else if(!nh.test(frm.m_tel.value)){
			alert("전화번호는 숫자만 입력 가능합니다.");
			frm.m_tel.focus();
			return false;
		} else if(frm.m_tel.value.length < 13){
			alert("전화번호를 확인해 주세요");
			frm.m_tel.focus();
			return false;
		}else if(frm.m_hiredate.value==""){
			alert("입사일을 입력해주세요");
			frm.m_hiredate.focus();
			return false;
		} else if(frm.m_postcode.value==""){
			alert("주소를 확인해 주세요");
			frm.m_postcode.focus();
			return false;
		} else if(frm.m_addr.value==""){
			alert("주소를 확인해 주세요");
			frm.m_addr.focus();
			return false;
		} else if(frm.m_detailaddr.value=="" ){
			alert("주소를 확인해 주세요");
			frm.m_detailaddr.focus();
			return false;
		} else if (r_code == '0' || r_code == '') {
			alert("권한을 선택해 주세요");
			frm.r_code.focus();
			return false;
		}else if (b_seq == '0' || b_seq == '') {
			alert("소속 지점 선택해 주세요");
			frm.b_seq.focus();
			return false;
		}else if (t_seq == '0' || t_seq == '') {
			alert("소속 팀을 선택해 주세요");
			frm.t_seq.focus();
			return false;
		} else {
			return true;
		}
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
	
	function mgrChk(a) {
		$('#mgr').val(a);
	}
	
	function mgrSearch() {
		var search = $('#search').val();
		var keyword = $('#keyword').val();
		
		if(keyword == '') {
			$('#mgrtbody').empty();
			$('#mgrtbody').append("<tr><td align='center' colspan='5'>검색 단어를 입력해주세요</td></tr>");
		} else {
		$.ajax({
			url : '${path}/member/mgrSearch',
			type: 'post',
			data: {
				'search' : search,
				'keyword' :keyword	
			},
			success : function(data) {
				$('#mgrtbody').empty();
				if(data.length > 0) {
					for(var i=0 in data) {
						$('#mgrtbody').append(
								"<tr><td align='center'>"+data[i].m_name+
								"</td><td align='center'>"+data[i].m_id+
								"</td><td align='center'>"+data[i].b_name+
								"</td><td align='center'>"+data[i].t_name+
								"</td><td align='center'>"
								+"<button class='btn btn-primary btn-sm'" 
								+"onclick=mgrChk('"+data[i].m_id+"') data-dismiss='modal'>선택</button>"
								+"</td></tr>");
					}
				} else {
					$('#mgrtbody').append("<tr><td align='center' colspan='5'>검색 자료가 없습니다.</td></tr>")
				}
			}
		});
		}
	}
</script>
</head>
<body>
	<div class="container" align="center">
		<h2 class="text-primary">회원 등록</h2>
		<div align="left">
			<button class="btn btn-warning btn-lg" onclick="location.href='${path}/member/memberMain'">뒤로</button>
		</div>
		<div class="modal fade" id="mgrSearch" role="dialog" aria-labelledby="introHeader" aria-hidden="true" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">도입자 검색</h4>
                    </div>
                    <div class="modal-body">
                        <div>
                        	<select name="search" id="search" class="form-control" style="display: inline-block; width: 100px;">
                        		<c:forTokens var="sh" items="m_id,m_name" delims="," varStatus="i">
                        			<option value="${sh }">${titles[i.index]}</option>
                        		</c:forTokens>
                        	</select>
                        	<input type="search" id="keyword" class="form-control" style="display: inline-block; width: 300px;" placeholder="검색할 단어를 입력해주세요">
                        	<input type="button" class="btn btn-warning" onclick="mgrSearch()" value="검색">
                        </div>
                        <table class="table-bordered table-hover mt-1">
                        	<thead>
                        	<tr style="height: 20px;">
                        		<th style="height: 20px; line-height: 20px;">이름</th>
                        		<th style="height: 20px; line-height: 20px;">사번</th>
                        		<th style="height: 20px; line-height: 20px;">지점명</th>
                        		<th style="height: 20px; line-height: 20px;">팀명</th>
                        		<th style="height: 20px; line-height: 20px;">선택</th>
                        	</tr>
                        	</thead>
                        	<tbody id="mgrtbody">
                        	</tbody>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                    </div>
                </div>
            </div>
        </div>
		<form action="${path }/member/memberWrite" method="post" enctype="multipart/form-data" name="frm" onsubmit="return chk();">
			<table class="table-bordered mt-3">
				<tr>
					<th>사번<span class="required">*</span></th>
					<td align="center">
						<input type="text" class="form-control input-defualt" name="m_id" id="m_id" onkeyup="idChk(this)"  autofocus="autofocus">
						<div id="chkId" class="err"></div>
					</td>
					<th>비밀번호<span class="required">*</span></th>
					<td align="center">
						<input type="password" class="form-control input-defualt" name="m_password" id="m_password" onkeyup="passChk(this)" >
						<div id="chkPass" class="err"></div>
					</td>
				</tr>
				<tr>
					<th>이름<span class="required">*</span></th>
					<td align="center"><input type="text" class="form-control input-defualt" name="m_name" ></td>
					<th>비밀번호 확인<span class="required">*</span></th>
					<td align="center">
						<input type="password" class="form-control input-defualt" id="m_password2" name="m_password2" onkeyup="pass2Chk(this)" >
						<div id="chkPass2" class="err"></div>
					</td>
				</tr>
				<tr>
					<th>주민번호<span class="required">*</span></th>
					<td align="center">
						<input type="text" class="form-control input-defualt" name="m_ssnum" onkeyup="inputSSNumber(this)" maxlength="14" placeholder="숫자만 입력하세요" >
					</td>
					<th>이메일<span class="required">*</span></th>
					<td align="center">
						<input type="email" class="form-control input-defualt" name="m_email" >
					</td>
				</tr>
				<tr>
					<th>전화번호<span class="required">*</span></th>
					<td align="center">
						<input type="text" class="form-control input-defualt" name="m_tel" onkeyup="inputPhoneNumber(this);" maxlength="13" placeholder="숫자만 입력하세요" >
					</td>
					<th>입사일<span class="required">*</span></th>
					<td align="center">
						<input type="date" class="form-control input-defualt" name="m_hiredate" >
					</td>
				</tr>
				<tr>
					<th rowspan="4">주소<span class="required">*</span></th>
					<td colspan="3">
						<input type="text" class="form-control input-post" name="m_postcode" id="postcode" placeholder="우편주소" >
						<input type="button" class="btn btn-primary btn-sm" onclick="execDaumPostcode()" value="주소검색">
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<input type="text" class="form-control input-defualt" name="m_addr" id="address" placeholder="주소" >
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<input type="text" class="form-control input-defualt" name="m_detailaddr" id="detailAddress" placeholder="상세주소" >
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<input type="text" class="form-control input-defualt" name="m_extraaddr" id="extraAddress" placeholder="참고항목">
					</td>
				</tr>
				<tr>
					<th>도입자</th>
					<td align="center">
						<input name="m_mgr" id="mgr" type="text" class="form-control input-defualt" style="width:60%; display: inline-block;" placeholder="도입자 아이디" readonly="readonly">
						<input type="button" class="btn btn-warning" value="찾기" data-toggle="modal" data-target="#mgrSearch" style="padding: 0; height: 40px; width: 60px; line-height: 40px;">
					</td>
					<th>권한 선택<span class="required">*</span></th>
					<td align="center">
						<select name="r_code" id="r_code" class="form-control select-box">
							<option value="0">권한 선택</option>
							<c:if test="${empty roleList }"></c:if>
							<c:if test="${not empty roleList }">
								<c:forEach var="role" items="${roleList }">
									<c:if test="${role.r_code != 'c2' }">
										<option value="${role.r_code }">${role.r_name }</option>
									</c:if>
								</c:forEach>
							</c:if>
						</select>
					</td>
				</tr>
				<tr>
					<th>지점 선택<span class="required">*</span></th>
					<td align="center">
						<select name="b_seq" id="b_seq" onchange="branchSelect()" class="form-control select-box">
							<option value="0">지점 선택</option>
						<c:if test="${empty branchList }">
						</c:if>
						<c:if test="${not empty branchList }">
							<c:forEach var="branch" items="${branchList }">
								<option value="${branch.b_seq }">${branch.b_name }</option>
							</c:forEach>
						</c:if>
						</select>
					</td>
					<th>팀 선택<span class="required">*</span></th>
					<td align="center">
						<select name="t_seq" id="t_seq" class="form-control select-box">
							<option value="0">팀 선택</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>위촉서류</th>
					<td colspan="3">
						<label class="input-file-button" for="file">
							업로드
						</label>
						<label id="filename">
							선택된 파일이 없습니다.
						</label>
						<input type="file" name="file" id="file" onchange="fileName()" style = "display: none;">
					</td>
				</tr>
			</table>
			<input type="submit" class="btn btn-primary btn-lg mt-4" value="등록">
		</form>
	</div>
</body>
</html>
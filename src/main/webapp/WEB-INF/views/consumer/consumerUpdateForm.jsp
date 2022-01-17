<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../head.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.input-post {
	width: 30%;
	height: 40px;
	line-height: 40px;
	margin-left: 10px;
	display:inline-block;
}
.input-defualt {
	width: 80%;
	height: 40px;
	line-height: 40px;
	margin-left: 10px;
}
.input-file-button{
  margin-left: 10px;
  padding: 6px 25px;
  background-color:#FF6600;
  border-radius: 4px;
  color: white;
  cursor: pointer;
}
</style>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
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
function fileName() {
	var fileVal = $('#file').val().split("\\");
	var fileName = fileVal[fileVal.length-1];
	
	if(fileName == '') {
		$('#filename').text('선택된 파일이 없습니다.');
	} else {
		$('#filename').text(fileName);
	}
}
/* 썸머노트 */
$(document).ready(function() {
	$('#summernote').summernote({
		placeholder : '내용을 입력해 주세요',
		height : 150,
		lang: "ko-KR"
	});
});

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
function chk() {
	var cf = confirm("정말로 등록하시겠습니까?");
	
	if(cf) {
		if(frm.c_name.value==''){
			alert("이름을 입력해주세요");
			frm.c_name.focus();
			return false;
		} else if(frm.c_name.value.length < 2){
			alert("이름을 두글자 이상 입력해주세요");
			frm.c_name.focus();
			return false;
		} else if(frm.c_tel.value==''){
			alert("전화번호를 입력해주세요");
			frm.c_tel.focus();
			return false;
		} else if(frm.c_tel.value.length < 12){
			alert("전화번호를 확인해주세요");
			frm.c_tel.focus();
			return false;
		} else if(frm.c_smemo.value==''){
			alert("간단 메모를 입력해주세요");
			frm.c_smemo.focus();
			return false;
		}
	}
}

function inputNumber(s) {
    str = s.value;
    s.value = str.replace(/[^\d]+/g,'');
}

function deleteFile(i) {
	var cf = confirm("파일을 정말 삭제 하시겠습니까?");
	if(cf) {
		$.ajax({
			url : "${path}/consumer/deleteFile",
			type : 'post',
			data : {'cf_seq' : i},
			success : function (data) {
				$('#file_'+i).empty();
				$('#file_'+i).append("삭제 되었습니다.");
			}
		});
	}
}

</script>
</head>
<body>
	<div class="container" align="center">
		<h2 class="text-primary">고객 등록</h2>
		<div align="left">
			<button class="btn btn-warning btn-lg" onclick="location.href='${path}/consumer/consumerRead/pageNum/${pageNum }/c_num/${c_num }'">뒤로</button>		
		</div>
		<form action="${path }/consumer/consumerUpdate/pageNum/${pageNum}" method="post" enctype="multipart/form-data" name="frm" onsubmit="return chk();">
		<input type="hidden" name="c_num" value="${consumer.c_num }">
		<table class="table table-bordered mt-1">
			<tr>
				<th width="100" style="vertical-align: middle;">이름<span class="required">*</span></th>
				<td width="200">
					<input class="form-control input-defualt" type="text" name="c_name" value="${consumer.c_name }">
				</td>
				<th width="100" style="vertical-align: middle;">관계</th>
				<td width="200">
					<input class="form-control input-defualt" type="text" name="c_relation" value="${consumer.c_relation }">
				</td>
			</tr>
			<tr>
				<th style="vertical-align: middle;">생년월일</th>
				<td>
					<input class="form-control input-defualt" type="text" name="c_ssnum" value="${consumer.c_ssnum }" onkeyup="inputNumber(this);" maxlength="6" placeholder="ex) 990101">
				</td>
				<th style="vertical-align: middle;">성별<span class="required">*</span></th>
				<td>
					<select class="form-control input-defualt" name="c_sex">
						<c:forTokens var="sex" items="1,2" delims="," varStatus="i">
							<c:if test="${sex == consumer.c_sex }">
								<option value="${sex }" selected="selected">${titles[i.index]}</option>
							</c:if>
							<c:if test="${sex != consumer.c_sex }">
								<option value="${sex }">${titles[i.index]}</option>
							</c:if>
						</c:forTokens>
					</select>
				</td>
			</tr>
			<tr>
				<th style="vertical-align: middle;">가족사항</th>
				<td>
					<input class="form-control input-defualt" type="text" name="c_family" value="${consumer.c_family }">
				</td>
				<th style="vertical-align: middle;">전화번호<span class="required">*</span></th>
				<td>
					<input class="form-control input-defualt" type="text" name="c_tel" value="${consumer.c_tel }" onkeyup="inputPhoneNumber(this);" maxlength="13" placeholder="숫자만 입력하세요">
				</td>
			</tr>
			<tr>
				<th style="vertical-align: middle;">
					설계동의서
				</th>
				<td colspan="3" style="vertical-align: middle;">
					<label class="input-file-button" for="file">
						업로드
					</label>
					<label id="filename">
						선택된 파일이 없습니다.
					</label>
					<input type="file" name="file" id="file" onchange="fileName()" style = "display: none;">
				</td>
			</tr>
			<tr>
				<th style="vertical-align: middle;">병력사항</th>
				<td colspan="3">
					<input class="form-control input-defualt" type="text" name="c_history" value="${consumer.c_history }">
				</td>
			</tr>
			<tr>
				<th rowspan="4" style="vertical-align: middle;">주소</th>
				<td colspan="3">
					<input class="form-control input-post" type="text" id="postcode" name="c_postcode" placeholder="우편번호" value="${consumer.c_postcode }">
					<input class="btn btn-defualt" type="button" onclick="execDaumPostcode()" value="주소검색">
				</td>
			</tr>
			<tr>
				<td colspan="3">
					<input class="form-control input-defualt" type="text" name="c_addr" id="address" placeholder="주소" value="${consumer.c_addr }">
				</td>
			</tr>
			<tr>
				<td colspan="3">
					<input class="form-control input-defualt" type="text" name="c_detailaddr" id="detailAddress" placeholder="상세주소" value="${consumer.c_detailaddr }">
				</td>
			</tr>
			<tr>
				<td colspan="3">
					<input class="form-control input-defualt" type="text" name="c_extraaddr" id="extraAddress" placeholder="참고항목" value="${consumer.c_extraaddr }">
				</td>
			</tr>
			<tr>
				<th style="vertical-align: middle;">고객 간단 메모<span class="required">*</span></th>
				<td colspan="3">
					<input class="form-control input-defualt" type="text" name="c_smemo" value="${consumer.c_smemo }">
				</td>
			</tr>
			<tr>
				<th colspan="4">설계동의서 첨부파일 리스트</th>
			</tr>
			<c:if test="${empty fileList }">
			<tr>
				<td align="center" colspan="4">없음</td>
			</tr>
			</c:if>
			<c:if test="${not empty fileList }">
				<c:forEach var="file" items="${fileList }">
				<tr>
					<td align="center">
						<c:set var="num" value="${num+1 }"></c:set>${num }
					</td>
					<td id="file_${file.cf_seq }" align="center" colspan="3">
						${file.cf_name }.${file.cf_type } 
						<a href="#" style="float: right; margin-right: 10px;" onclick="deleteFile('${file.cf_seq}')">삭제</a>
					</td>
				</tr>
				</c:forEach>
			</c:if>
		</table>
		<table class="table table-bordered">
			<tr>
				<th style="vertical-align: middle;">고객 상세 메모</th>
			</tr>
			<tr>
				<td>
					<textarea id="summernote" name="c_lmemo" rows="10" cols="100">${consumer.c_lmemo }</textarea>
				</td>
			</tr>
		</table>
		<input class="btn btn-primary btn-lg" type="submit" value="수정">
		</form>
	</div>
</body>
</html>
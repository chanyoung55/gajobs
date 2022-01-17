<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../head.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">

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
function add() {
	var i = $('tbody>tr:last>td:first').text();
	var html = '';
	i = Number(i) + 1;
	k = i-1;
	if(i > 30){
		alert("한번에 계약을 30건 이상 입력할수 없습니다.");
	} else {
	html += "<tr id='add_"+i+"'><td style='vertical-align: middle;' align='center'>";
	html += i+"</td>";
	html += "<td><select id='cp_seq"+i+"' class='form-control' name='consumerConlist["+k+"].cp_seq'>";
	html += "<option value='0'>선택</option>";
	html += "<c:forEach var='com' items='${comList}'>";
	html += "<option value='${com.cp_seq}'>${com.cp_name}</option>";
	html += "</c:forEach>";
	html += "</select></td>";
	html += "<td><input id='cc_kinds"+i+"' class='form-control' type='text' name='consumerConlist["+k+"].cc_kinds'>";
	html += "</td><td>";
	html += "<input id='cc_connum"+i+"' class='form-control' type='text' name='consumerConlist["+k+"].cc_connum'>"
			+"</td><td><input id='cc_condate"+i+"' class='form-control' type='date' name='consumerConlist["+k+"].cc_condate'></td>"
			+"<td><input id='cc_startdate"+i+"' class='form-control' type='date' name='consumerConlist["+k+"].cc_startdate'></td>"
			+"<td><input id='cc_enddate"+i+"' class='form-control' type='date' name='consumerConlist["+k+"].cc_enddate' onchange='end("+i+")'></td>"
			+"<td><input id='cc_pay"+i+"' class='form-control' type='text' name='consumerConlist["+k+"].cc_pay' onkeyup='inputNumberFormat(this)'></td>"
			+"<td><input id='cc_insurance"+i+"' class='form-control' type='text' name='consumerConlist["+k+"].cc_insurance'></td>"
			+"<td><input id='cc_subinsurance"+i+"' class='form-control' type='text' name='consumerConlist["+k+"].cc_subinsurance'></td>";
	html += "<td><select id='cc_state"+i+"' class='form-control' name='consumerConlist["+k+"].cc_state'>"
			+"<option value='유지'>유지</option><option value='실효'>실효</option><option value='해지'>해지</option>"
			+"<option value='철회'>철회</option><option value='취소'>취소</option></select>"
			+"<input type='hidden' name='consumerConlist["+k+"].c_num' value='${c_num}'></td></tr>";
			
	$('tbody').append(html);
	
	}
}

function del() {
	var i = $('tbody>tr:last>td:first').text();
	if(i<2){
		alert("첫행은 삭제할 수 없습니다.");
	} else {
		$('#add_'+i).remove();
	}
}

function end(i) {
		if($('#cc_startdate'+i).val()==''){
			alert('납입 시작일을 먼저 입력해주세요');
			$('#cc_enddate'+i).val('');
			$('#cc_startdate'+i).focus();
		} else if($('#cc_startdate'+i).val() > $('#cc_enddate'+i).val()){
			alert('게시일 보다 빠를수 없습니다.');
			$('#cc_enddate'+i).val('');
			$('#cc_enddate'+i).focus();
	}
}

function chk() {
	var leng = Number($('tbody>tr:last>td:first').text());
	var cf = confirm("정말로 등록 하시겠습니까?");
	if(cf){
		for(i=1; i <= leng; i++){
			if($('#cp_seq'+i).val() == 0){
				alert(i+"행 회사명을 선택해주세요");
				$('#cp_seq'+i).focus();
				return false;
			}
			if($('#cc_kinds'+i).val() == ''){
				alert(i+"행 계약종류를 선택해주세요");
				$('#cc_kinds'+i).focus();
				return false;
			}
			if($('#cc_condate'+i).val() == ''){
				alert(i+"행 계약일을 입력해주세요");
				$('#cc_condate'+i).focus();
				return false;
			}
			if($('#cc_startdate'+i).val()==''){
				alert(i+"행 납입시작일을 입력해주세요");
				$('#cc_startdate'+i).focus();
				return false;
			}
			if($('#cc_enddate'+i).val()==''){
				alert(i+"행 납입종료을 입력해주세요");
				$('#cc_enddate'+i).focus();
				return false;
			}
			if($('#cc_pay'+i).val()==''){
				alert(i+"행 보험료를 입력해주세요");
				$('#cc_pay'+i).focus();
				return false;
			}
			if($('#cc_insurance'+i).val()==''){
				alert(i+"행 계약자를 입력해주세요");
				$('#cc_insurance'+i).focus();
				return false;
			}
			if($('#cc_subinsurance'+i).val()==''){
				alert(i+"행 피보험자를 입력해주세요");
				$('#cc_subinsurance'+i).focus();
				return false;
			}
		}	
	}else{
		return false;
	}
}
</script>
</head>
<body>
	<div class="container" align="center" style="width: 95%;">
		<h2 class="text-primary mt-3">계약 등록</h2>
		<div align="right">
			<button class="btn btn-warning btn-lg" onclick="history.go(-1);" style="float: left;">뒤로</button>
			<button class="btn btn-success btn-lg" title="입력 항목을 추가합니다." onclick="add()">추가</button>
			<button class="btn btn-danger btn-lg" title="입력 항목을 삭제합니다." onclick="del()">삭제</button>
		</div>
		<form action="${path }/consumer/contractWrite/c_num/${c_num}" method="post" name="frm" onsubmit="return chk();">
		<table class="table table-bordered mt-1" style="width: 100%;">
			<thead style="background: #e0e0e0;">
				<tr>
					<th width="50" style="vertical-align: middle;">No.</th>
					<th width="200">회사명<span class="required">*</span></th>
					<th width="150">계약종류<span class="required">*</span></th>
					<th width="150">증권번호</th>
					<th width="100">계약일<span class="required">*</span></th>
					<th width="100">납입시작일<span class="required">*</span></th>
					<th width="100">납입종료일<span class="required">*</span></th>
					<th width="150">보험료<span class="required">*</span></th>
					<th width="150">계약자<span class="required">*</span></th>
					<th width="150">피보험자<span class="required">*</span></th>
					<th width="150">현재상태<span class="required">*</span></th>
				</tr>
			</thead>
			<tbody id="tbody">
				<tr id="add_1">
					<td align="center" style='vertical-align: middle;'>1</td>
					<td>
						<select class="form-control" id='cp_seq1' name="consumerConlist[0].cp_seq">
							<option value='0'>선택</option>
							<c:forEach var="com" items="${comList }">
								<option value="${com.cp_seq }">${com.cp_name }</option>
							</c:forEach>
						</select>
					</td>
					<td>
						<input id="cc_kinds1" class="form-control" type="text" name="consumerConlist[0].cc_kinds">
					</td>
					<td>
						<input id="cc_connum1" class="form-control" type="text" name="consumerConlist[0].cc_connum">
					</td>
					<td>
						<input id="cc_condate1" class="form-control" type="date" name="consumerConlist[0].cc_condate">
					</td>
					<td>
						<input id="cc_startdate1" class="form-control" type="date" name="consumerConlist[0].cc_startdate">
					</td>
					<td>
						<input id="cc_enddate1" class="form-control" type="date" name="consumerConlist[0].cc_enddate" onchange="end(1)">
					</td>
					<td>
						<input id="cc_pay1" class="form-control" type="text" name="consumerConlist[0].cc_pay" onkeyup='inputNumberFormat(this)'>
					</td>
					<td>
						<input id="cc_insurance1" class="form-control" type="text" name="consumerConlist[0].cc_insurance">
					</td>
					<td>
						<input id="cc_subinsurance1" class="form-control" type="text" name="consumerConlist[0].cc_subinsurance">
					</td>
					<td>
						<select id="cc_state1" class="form-control" name="consumerConlist[0].cc_state">
							<option value="유지">유지</option>
							<option value="실효">실효</option>
							<option value="해지">해지</option>
							<option value="철회">철회</option>
							<option value="취소">취소</option>
						</select>
						<input type="hidden" name="consumerConlist[0].c_num" value="${c_num }">
					</td>
				</tr>
			</tbody>
		</table>
		<input class="btn btn-primary btn-lg" type="submit" value="등록">
		</form>
	</div>
</body>
</html>
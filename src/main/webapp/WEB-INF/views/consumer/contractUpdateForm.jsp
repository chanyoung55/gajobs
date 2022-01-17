<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../head.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">

  $(document).ready(function() {
 	 inputNumberFormat(frm.cc_pay);
	
  });

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

function end(i) {
	if(frm.cc_startdate.value == ''){
		alert('납입 시작일을 먼저 입력해주세요');
		frm.cc_enddate.value = '';
		frm.cc_startdate.focus();
	} else if (frm.cc_startdate.value > frm.cc_enddate.value){
		alert('게시일 보다 빠를수 없습니다.');
		frm.cc_enddate.value = '';
		frm.cc_enddate.focus();
	}
}

function chk() {
	var cf = confrim("정말로 수정하시겠습니까?");
	if(cf){
		if(frm.cp_seq.value == ''){
			alert("회사명을 선택해주세요!");
			frm.cp_seq.focus();
			return false;
		} else if(frm.cc_kinds.value==''){
			alert("계약종류를 입력해주세요");
			frm.cc_kinds.focus();
			return false;
		} else if(frm.cc_condate.value == ''){
			alert("계약일을 선택해주세요");
			frm.cc_condate.focus();
			return false;
		} else if(frm.cc_startdate.value == ''){
			alert("납입 시작일을 선택해주세요");
			frm.cc_startdate.focus();
			return false;
		} else if(frm.cc_enddate.value == ''){
			alert("납입 종료일을 선택해주세요");
			frm.cc_enddate.focus();
			return false;
		} else if(frm.cc_pay.value == ''){
			alert("보험료를 입력해주세요");
			frm.cc_pay.focus();
			return false;
		} else if(frm.cc_insurance.value == ''){
			alert("계약자를 입력해주세요");
			frm.cc_insurance.focus();
			return false;
		} else if(frm.cc_subinsurance.value == ''){
			alert("피보험자를 입력해주세요");
			frm.cc_subinsurance.focus();
			return false;
		}
	}else{
		return false;
	}
}
</script>
</head>
<body>
	<div class="container" align="center" style="width: 95%;">
		<h2 class="text-primary mt-3">계약 수정</h2>
		<form action="${path }/consumer/contractUpdate/pageNum/${pageNum}" method="post" name="frm" onsubmit="return chk();">
		<table class="table table-bordered mt-3" style="width: 100%;">
			<thead style="background: #e0e0e0;">
				<tr>
					<th width="50" style="vertical-align: middle;">No.</th>
					<th width="150">회사명<span class="required">*</span></th>
					<th width="150">계약종류<span class="required">*</span></th>
					<th width="150">증권번호</th>
					<th width="150">계약일<span class="required">*</span></th>
					<th width="150">납입시작일<span class="required">*</span></th>
					<th width="150">납입종료일<span class="required">*</span></th>
					<th width="200">보험료<span class="required">*</span></th>
					<th width="200">계약자<span class="required">*</span></th>
					<th width="200">피보험자<span class="required">*</span></th>
					<th width="150">현재상태<span class="required">*</span></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td align="center" style='vertical-align: middle;'>1</td>
					<td>
						<select class="form-control" id='cp_seq1' name="cp_seq">
							<option value='0'>선택</option>
							<c:forEach var="com" items="${comList }">
								<c:if test="${com.cp_seq == contract.cp_seq }">
									<option value="${com.cp_seq }" selected="selected">${com.cp_name }</option>
								</c:if>
								<c:if test="${com.cp_seq != contract.cp_seq }">
									<option value="${com.cp_seq }">${com.cp_name }</option>
								</c:if>
							</c:forEach>
						</select>
					</td>
					<td>
						<input class="form-control" type="text" name="cc_kinds" value="${contract.cc_kinds }">
					</td>
					<td>
						<input class="form-control" type="text" name="cc_connum" value="${contract.cc_connum }">
					</td>
					<td>
						<input class="form-control" type="date" name="cc_condate" value="${contract.cc_condate }">
					</td>
					<td>
						<input class="form-control" type="date" name="cc_startdate" value="${contract.cc_startdate }">
					</td>
					<td>
						<input class="form-control" type="date" name="cc_enddate" onchange="end(1)" value="${contract.cc_enddate }">
					</td>
					<td>
						<input class="form-control" type="text" name="cc_pay" onkeyup="inputNumberFormat(this)" value="${contract.cc_pay }">
					</td>
					<td>
						<input class="form-control" type="text" name="cc_insurance" value="${contract.cc_insurance }">
					</td>
					<td>
						<input class="form-control" type="text" name="cc_subinsurance" value="${contract.cc_subinsurance }">
					</td>
					<td>
						<select class="form-control" name="cc_state">
							<c:forTokens var="state" items="유지,실효,해지,철회,취소" delims=",">
								<c:if test="${contract.cc_state == state }">
									<option value="${state }" selected="selected">${state }</option>
								</c:if>
								<c:if test="${contract.cc_state != state }">
									<option value="${state }">${state }</option>
								</c:if>
							</c:forTokens>
						</select>
						<input type="hidden" name="cc_seq" value="${contract.cc_seq }">
						<input type="hidden" name="c_num" value="${contract.c_num }">
					</td>
				</tr>
			</tbody>
			</table>
			<input class="btn btn-primary btn-lg" type="submit" value="수정">
			<input class="btn btn-danger btn-lg" type="button" value="뒤로" onclick="history.go(-1);">
		</form>
	</div>
</body>
</html>
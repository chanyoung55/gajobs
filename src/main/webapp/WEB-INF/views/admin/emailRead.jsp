<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../head.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function del() {
	var cf = confirm("정말로 삭제 하시겠습니까?");
	if(cf){
		location.href="${path}/admin/emailDelete/pageNum/${pageNum}/em_num/${em_num}";
	}
}
</script>
</head>
<body>
	<div class="container" align="center">
		<h2 class="mt-3">이메일 발송 내역</h2>
		<table class="table table-bordered mt-5">
			<tr>
				<th width="200" style="background: #e0e0e0;">발송 이메일</th>
				<td align="center">${email.em_smail }</td>
				<th width="200" style="background: #e0e0e0;">수신 이메일</th>
				<td align="center">${email.em_rmail }</td>
			</tr>
			<tr>
				<th width="200" style="background: #e0e0e0;">수신인</th>
				<td align="center">${email.em_recipient }</td>
				<th width="200" style="background: #e0e0e0;">수신인 아이디</th>
				<td align="center">${email.m_id }</td>
			</tr>
			<tr>
				<th width="200" style="background: #e0e0e0;">전송일자</th>
				<td colspan="3" align="center">${email.em_date }</td>
			</tr>
		</table>
		
		<table class="table table-bordered">
			<tr>
				<th width="200" style="background: #e0e0e0;">제목</th>
				<td align="center">${email.em_title }</td>
			</tr>
			<tr>
				<th colspan="2" width="200" style="background: #e0e0e0;">내용</th>
			</tr>
			<tr>
				<td colspan="2" height="200">
					${email.em_content }
				</td>
			</tr>
		</table>
		<div>
			<button class="btn btn-primary btn-lg" onclick="location.href='${path}/admin/mailSendMain/pageNum/${pageNum }'">목록</button>
			<button class="btn btn-danger btn-lg" onclick="del()">삭제</button>
		</div>
	</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../head.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
/* 썸머노트 */
$(document).ready(function() {
	$('#summernote').summernote({
		placeholder : '내용을 입력해 주세요',
		maxHeight : null,
		minHeight : null,
		height : 300,
		lang: "ko-KR"
	});
});
</script>
</head>
<body>
	<div class="container" align="center">
		<h2 class="text-primary">문의사항 답장</h2>
		<form action="${path }/admin/emailSend/pageNum/${pageNum}" method="post">
			<table class="table table-bordered">
				<tr>
					<th width="200" style="background:#e0e0e0; vertical-align: middle;">받는사람 이름</th>
					<td align="center">
						${help.h_writer } ${help.r_name }님
						<input type="hidden" name="em_recipient" value="${help.h_writer }">
						<input type="hidden" name="m_id" value="${help.m_id }">
					</td>
				</tr>
				<tr>
					<th width="200" style="background:#e0e0e0; vertical-align: middle;">이메일 주소</th>
					<td align="center">
						${help.h_email }
						<input type="hidden" name="em_smail" value="${sideNav.m_email }">
						<input type="hidden" name="em_rmail" value="${help.h_email }">
					</td>
				</tr>
			</table>
			<table class="table table-bordered">
				<tr>
					<th style="background: #e0e0e0; vertical-align: middle;">제목</th>
					<td>
						<input class="form-control" type="text" name="em_title" placeholder="제목을 입력하세요">
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<textarea id="summernote" name="em_content" rows="10" cols="100"></textarea>
					</td>
				</tr>
			</table>
			<input class="btn btn-primary btn-lg" type="submit" value="전송">
		</form>
	</div>
</body>
</html>
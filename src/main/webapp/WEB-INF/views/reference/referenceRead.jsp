<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "../head.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function del(i) {
		var cf = confirm("정말로 삭제하시겠습니까?");
		if(cf) {
			location.href = "${path}/reference/referenceDelete/pageNum/${pageNum}/rf_num/"+i;
		} else {
			alert("삭제가 취소되었습니다.");
			return false;
		}
	}
	
	function update(i) {
		location.href="${path}/reference/referenceUpdateForm/pageNum/${pageNum}/rf_num/"+i;
	}
</script>
</head>
<body>
	<div class="container" align="center">
		<h2 class="text-primary">글 읽기</h2>
		<h3 style="float: left;">${reference.rf_title }</h3>
		<table class="table table-bordered">
			<tr>
				<th>글쓴이</th>
				<td>
					${reference.rf_writer }
					<c:forEach var="role" items="${roleList }">
						<c:if test="${reference.r_code == role.r_code }">
							${role.r_name } 님
						</c:if>
					</c:forEach>
				</td>
			</tr>
			<tr>
				<th>업로드일</th>
				<td>${reference.rf_date }</td>
			</tr>
			<tr>
				<th>글 종류</th>
				<td>${reference.rfk_name }</td>
			</tr>
			<tr>
				<th style="vertical-align: middle;">첨부 파일 목록</th>
				<td>
					<c:if test="${empty referenceFiles }">
						첨부파일 없음
					</c:if>
					<c:if test="${not empty referenceFiles }">
						<c:forEach var="file" items="${referenceFiles}">
							<a href="${path }/reference/referenceFileDownload/rff_seq/${file.rff_seq}">${file.rff_name }.${file.rff_type }</a><br>
						</c:forEach>
					</c:if>
				</td>
			</tr>
			<tr>
				<th colspan="2">내용</th>
			</tr>
			<tr>
				<td colspan="2" height="100">
					${reference.rf_content }
				</td>
			</tr>
		</table>
		<div style="display: flex; justify-content: space-between;">
			<a class="btn btn-danger btn-lg" href="#" onclick="del('${reference.rf_num}')">삭제</a>
			<a class="btn btn-primary btn-lg" href="#" onclick="update('${reference.rf_num}')">수정</a>
		</div>
		<div>
			<a class="btn btn-success btn-lg" href="${path }/reference/referenceMain/pageNum/${pageNum}">목록</a>
		</div>
	</div>
</body>
</html>
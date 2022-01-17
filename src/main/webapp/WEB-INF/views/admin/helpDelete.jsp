<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../head.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:if test="${result > 0 }">
		<script type="text/javascript">
			alert("문의사항이 삭제 되었습니다.");
			location.href = "${path}/admin/adminMain/pageNum/${pageNum}";
		</script>
	</c:if>
	<c:if test="${result == 0 }">
		<script type="text/javascript">
			alert("문의사항이 삭제가 실패하였습니다.");
			history.go(-1);
		</script>
	</c:if>
</body>
</html>
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
			alert("채권이 등록되었습니다.");
			location.href="${path}/bond/bondMain";
		</script>
	</c:if>
	<c:if test="${result == 0 }">
		<script type="text/javascript">
			alert("채권 등록 실패! 관리자에게 문의하세요");
			history.go(-1);
		</script>
	</c:if>
	<c:if test="${result < 0 }">
		<script type="text/javascript">
			alert("파일을 찾을수 없습니다. 파일을 확인하세요");
			history.go(-1);
		</script>
	</c:if>
</body>
</html>
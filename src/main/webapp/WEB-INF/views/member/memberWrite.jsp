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
				alert("회원이 등록되었습니다.");
				location.href="${path}/member/memberMain";
			</script>
	</c:if>
	<c:if test="${result == 0 }">
			<script type="text/javascript">
				alert("회원이 실패하였습니다. 관리자에게 문의하세요");
				history.go(-1);
			</script>
	</c:if>
	<c:if test="${result == -1 }">
			<script type="text/javascript">
				alert("이미 존재하는 회원입니다.");
				history.go(-1);
			</script>
	</c:if>
</body>
</html>
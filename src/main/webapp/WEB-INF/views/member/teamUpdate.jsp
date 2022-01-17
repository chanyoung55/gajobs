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
			alert("팀명이 수정되었습니다.");
			location.href="${path}/member/teamRead/t_seq/${team.t_seq}/pageNum/1";
		</script>
	</c:if>
	<c:if test="${result == 0 }">
		<script type="text/javascript">
			alert("팀명 수정을 실패하였습니다. 관리자에게 문의하세요");
			history.go(-1);
		</script>
	</c:if>
</body>
</html>
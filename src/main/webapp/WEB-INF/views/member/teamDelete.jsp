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
			alert("삭제가 완료되었습니다.");
			location.href="${path}/member/branchRead/b_seq/${b_seq}";
		</script>
	</c:if>
	<c:if test="${result == 0 }">
		<script type="text/javascript">
			alert("삭제가 실패 하였습니다. 관리자에게 문의하세요");
			history.go(-1);
		</script>
	</c:if>
	<c:if test="${result < 0 }">
		<script type="text/javascript">
			alert("해당 팀에는 소속된 인원 및 퇴사한 인원이 있습니다.");
			history.go(-1);
		</script>
	</c:if>
</body>
</html>
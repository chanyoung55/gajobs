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
			alert("팀 생성 완료");
			location.href="${path}/member/branchRead/b_seq/${b_seq}";
		</script>
	</c:if>
	<c:if test="${result == 0 }">
		<script type="text/javascript">
			alert("팀 생성 실패! 관리자에게 문의하세요");
			history.go(-1);
		</script>
	</c:if>
	<c:if test="${result < 0 }">
		<script type="text/javascript">
			alert("중복된 팀명 입니다.확인해주세요");
			history.go(-1);
		</script>
	</c:if>
</body>
</html>
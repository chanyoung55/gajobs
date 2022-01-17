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
			alert("지점이 생성 되었습니다.");
			location.href = "${path}/member/branchMain";
		</script>	
	</c:if>
	<c:if test="${result == 0 }">
		<script type="text/javascript">
			alert("중복된 지점명입니다.");
			history.go(-1);
		</script>	
	</c:if>
	<c:if test="${result < 0 }">
		<script type="text/javascript">
			alert("지점이 생성이 실패하였습니다. 관리자에게 문의하세요");
			history.go(-1);
		</script>	
	</c:if>
</body>
</html>
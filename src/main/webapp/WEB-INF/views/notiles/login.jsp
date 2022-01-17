<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:if test="${result > 0 }">
		<script type="text/javascript">
			alert("로그인 되었습니다.");
			location.href="${path}/main/home";
		</script>
	</c:if>
	<c:if test="${result == 0 }">
		<script type="text/javascript">
			alert("로그인이 실패하였습니다. 관리자에게 문의하세요");
			history.go(-1);
		</script>
	</c:if>
	<c:if test="${result == -1 }">
		<script type="text/javascript">
			alert("아이디 또는 비밀번호가 잘못 입력 되었습니다.");
			history.go(-1);
		</script>
	</c:if>
	<c:if test="${result == -2 }">
		<script type="text/javascript">
			alert("아이디 또는 비밀번호가 잘못 입력 되었습니다.");
			history.go(-1);
		</script>
	</c:if>
	<c:if test="${update_result > 0 }">
		<script type="text/javascript">
			alert("초기화가 완료 되었습니다. 다시 로그인 해주세요~");
			history.go(-1);
		</script>
	</c:if>
	<c:if test="${update_result == 0 }">
		<script type="text/javascript">
			alert("초기화 실패!");
			history.go(-1);
		</script>
	</c:if>
</body>
</html>
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
			alert("고객 정보가 삭제되었습니다.");
			location.href="${path}/consumer/consumerMain/pageNum/${pageNum}";
		</script>
	</c:if>
	<c:if test="${result == 0 }">
		<script type="text/javascript">
			alert("고객정보를 삭제하는데 실패하였습니다. 관리자에게 문의하세요");
			history.go(-1);
		</script>
	</c:if>
	<c:if test="${result < 0 }">
		<script type="text/javascript">
			alert("고객정보을 삭제하는데 실패하였습니다[contract]. 관리자에게 문의하세요");
			history.go(-1);
		</script>
	</c:if>
</body>
</html>
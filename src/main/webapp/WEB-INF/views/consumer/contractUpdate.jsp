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
			alert("계약이 수정되었습니다.");
			location.href="${path}/consumer/contractRead/pageNum/${pageNum}/c_num/${c_num}";
		</script>
	</c:if>
	<c:if test="${result == 0 }">
		<script type="text/javascript">
			alert("계약수정이 실패하였습니다. 관리자에게 문의하세요");
			history.go(-1);
		</script>
	</c:if>
</body>
</html>
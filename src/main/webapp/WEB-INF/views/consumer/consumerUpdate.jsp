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
			alert("고객정보가 수정되었습니다.");
			location.href = "${path}/consumer/consumerRead/pageNum/${pageNum}/c_num/${c_num}";
		</script>
	</c:if>
	<c:if test="${result == 0 }">
		<script type="text/javascript">
			alert("고객정보 수정이 실패하였습니다.");
			history.go(-1);
		</script>
	</c:if>
</body>
</html>
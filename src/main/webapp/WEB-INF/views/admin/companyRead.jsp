<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../head.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function dis() {
		var cf = confirm("정말로 비활성화 하시겠습니까?");
		if(cf){
			location.href='${path}/admin/companyDelete/pageNum/${pageNum}/cp_seq/${cp_seq}';
		}
	}
	
	function active() {
		var cf = confirm("정말로 활성화 하시겠습니까?");
		if(cf){
			location.href="${path}/admin/companyActive/pageNum/${pageNum}/cp_seq/${cp_seq}";
		}
	}
</script>
</head>
<body>
	<div class="container" align="center">
		<h2 class="mt-3">보험사</h2>
		<table class="table table-bordered mt-5">
			<tr>
				<th style="background: #e0e0e0;">회사명</th>
				<td align="center">${company.cp_name }</td>
				<th style="background: #e0e0e0;">종류</th>
				<td align="center">${company.cp_kinds }</td>
			</tr>
			<tr>
				<th style="background: #e0e0e0;">생성일자</th>
				<td align="center">${company.cp_setdate }</td>
				<th style="background: #e0e0e0;">활성화여부</th>
				<td align="center">${company.cp_del }</td>
			</tr>
		</table>
		<div class="mt-3">
			<button class="btn btn-primary btn-lg" onclick="location.href='${path}/admin/companyUpdateForm/pageNum/${pageNum }/cp_seq/${cp_seq }'">수정</button>
			<c:if test="${company.cp_del == 'n' }">
				<button class="btn btn-danger btn-lg" onclick="dis()">비활성화</button>
			</c:if>
			<c:if test="${company.cp_del == 'y' }">
				<button class="btn btn-success btn-lg" onclick="active()">활성화</button>
			</c:if>
		</div>
	</div>
</body>
</html>
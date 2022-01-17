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
	<div class="container" align="center">
		<h2 class="mt-3">보험사 수정</h2>
		<form action="${path }/admin/companyUpdate/pageNum/${pageNum}" method="post">
		<input type="hidden" name="cp_seq" value="${cp_seq }">
		<table class="table table-bordered mt-5">
			<tr>
				<th style="background: #e0e0e0; vertical-align: middle;" width="200">보험사명</th>
				<td align="center" width="300">
					<input class="form-control" type="text" name="cp_name" value="${company.cp_name }">
				</td>
				<th style="background: #e0e0e0; vertical-align: middle;">종류</th>
				<td align="center">
				<select class="form-control" name="cp_kinds">
					<c:forTokens var="kinds" items="손보,생보" delims=",">
						<c:if test="${company.cp_name == kinds }">
							<option value="${kinds}" selected="selected">${kinds }</option>
						</c:if>
						<c:if test="${company.cp_name != kinds }">
							<option value="${kinds}">${kinds }</option>
						</c:if>
					</c:forTokens>
				</select>
				</td>
			</tr>
			<tr>
				<th style="background: #e0e0e0; vertical-align: middle;">생성일자</th>
				<td align="center">${company.cp_setdate }</td>
				<th style="background: #e0e0e0; vertical-align: middle;">활성화 여부</th>
				<td align="center">${company.cp_del }</td>
			</tr>
		</table>
		<input class="btn btn-primary btn-lg mt-3" type="submit" value="수정">
		</form>
	</div>
</body>
</html>
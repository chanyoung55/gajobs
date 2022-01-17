<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../head.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.trhover {
		cursor: pointer;
	}
	.trhover:hover {
		color: #337ab7;
	}
</style>
</head>
<body>
	<div class="container" align="center">
		<h2 class="mt-3">메일발송 관리</h2>
		<table class="table table-bordered table-hover mt-5">
			<thead style="background: #e0e0e0;">
				<tr>
					<th>No.</th>
					<th>제목</th>
					<th>받는사람</th>
					<th>이메일</th>
					<th>보낸일자</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty emailList }">
					<tr>
						<td colspan="5" align="center">보낸 기록이 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${not empty emailList}">
					<c:forEach var="email" items="${emailList }">
						<tr class="trhover" onclick="location.href='${path}/admin/emailRead/pageNum/${pageNum }/em_num/${email.em_num }'">
							<td align="center">${num }<c:set var="num" value="${num+1 }"></c:set></td>
							<td align="center">${email.em_title }</td>
							<td align="center">${email.em_recipient } (${email.m_id })</td>
							<td align="center">${email.em_rmail }</td>
							<td align="center">${email.em_date }</td>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
		</table>
		<div align="center">
			<ul class="pagination">
			<c:if test="${pb.startPage > pb.pagePerBlock }">
				<li>
					<a href="${path }/admin/mailSendMain/pageNum/1?keyword=${email.keyword }&search=${email.search}"><span class="glyphicon glyphicon-backward"></span></a>
				</li>
				<li>
					<a href="${path }/admin/mailSendMain/pageNum/${pb.startPage-1 }?keyword=${email.keyword }&search=${email.search}"><span class="glyphicon glyphicon-triangle-left"></span></a>
				</li>
			</c:if>
				<c:forEach var="i" begin="${pb.startPage }" end="${pb.endPage }">
					<c:if test="${pb.currentPage==i }">
						<li class="active">
							<a href="${path }/admin/mailSendMain/pageNum/${i}?keyword=${email.keyword }&search=${email.search}">${i }</a>
						</li>
					</c:if>
					<c:if test="${pb.currentPage!=i }">
						<li>
							<a href="${path }/admin/mailSendMain/pageNum/${i}?keyword=${email.keyword }&search=${email.search}">${i }</a>
						</li>
					</c:if>
				</c:forEach>
				<c:if test="${pb.endPage < pb.totalPage }">
				<li>
					<a href="${path }/admin/mailSendMain/pageNum/${pb.endPage+1 }?keyword=${email.keyword }&search=${email.search}"><span class="glyphicon glyphicon-triangle-right"></span></a>
				</li>
				<li>
					<a href="${path }/admin/mailSendMain/pageNum/${pb.totalPage}?keyword=${email.keyword }&search=${email.search}"><span class="glyphicon glyphicon-forward"></span></a>
				</li>
			</c:if>
			</ul>
		</div>
		<div class="mt-3" align="center" style="width: 100%;">
			<form action="${path }/admin/mailSendMain/pageNum/1" style="display: inline-block;">
				<select name="search" class="form-control" style="display: inline-block; width: 100px;">
				<c:forTokens var="sh" items="alls,em_title,em_content,em_rmail,m_id,em_recipient" delims="," varStatus="i">
					<c:if test="${sh==email.search }">
						<option value="${sh }" selected="selected">${titles[i.index]}</option>
					</c:if>
					<c:if test="${sh!=email.search }">
						<option value="${sh }">${titles[i.index] }</option>
					</c:if>
				</c:forTokens>
				</select>
				<input type="text" class="form-control" name="keyword" value="${email.keyword }" style="display:inline-block; width: 200px;">
				<input type="submit" class="btn btn-default" value="search" style="text-align: center; line-height: 20px;">
			</form>
		</div>
		<div align="left">
			<button style="float: left;" class="btn btn-warning btn-lg" onclick="location.href='${path}/admin/adminMain'">메인</button>
		</div>
	</div>
</body>
</html>
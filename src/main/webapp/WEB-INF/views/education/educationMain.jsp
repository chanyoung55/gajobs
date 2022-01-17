<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../head.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
td {
	text-align: center;
}
</style>
<title>Insert title here</title>
</head>
<body>
	<div class="container" align="center">
		<h2 class="text-primary">교육게시판</h2>
		<table class="table table-bordered table-hover mt-3">
			<thead>
				<tr>
					<th width="10" style="background: #e0e0e0;">No.</th>
					<th width="500" style="background: #e0e0e0;">제목</th>
					<th width="150" style="background: #e0e0e0;">글쓴이</th>
					<th width="100" style="background: #e0e0e0;">조회수</th>
					<th width="200" style="background: #e0e0e0;">업로드 일자</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty list }">
					<tr>
						<td colspan="5" align="center">게시글이 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${not empty list }">
					<c:forEach var="board" items="${list }">
					<tr>
						<td>${num}<c:set var="num" value="${num+1}"></c:set></td>
						<td>
							<a href="${path }/education/educationRead/pageNum/${pb.currentPage}/e_num/${board.e_num}">${board.e_title }</a>
						</td>
						<td>${board.e_writer }</td>
						<td>${board.e_count }</td>
						<td>${board.e_date }</td>
					</tr>
					</c:forEach>
				</c:if>
			</tbody>
		</table>
		<div align="center">
			<ul class="pagination">
			<c:if test="${pb.startPage > pb.pagePerBlock }">
				<li>
					<a href="${path }/education/educationMain/pageNum/1?keyword=${education.keyword }&search=${education.search}"><span class="glyphicon glyphicon-backward"></span></a>
				</li>
				<li>
					<a href="${path }/education/educationMain/pageNum/${pb.startPage-1 }?keyword=${education.keyword }&search=${education.search}"><span class="glyphicon glyphicon-triangle-left"></span></a>
				</li>
			</c:if>
				<c:forEach var="i" begin="${pb.startPage }" end="${pb.endPage }">
					<c:if test="${pb.currentPage==i }">
						<li class="active">
							<a href="${path }/education/educationMain/pageNum/${i}?keyword=${education.keyword }&search=${education.search}">${i }</a>
						</li>
					</c:if>
					<c:if test="${pb.currentPage!=i }">
						<li>
							<a href="${path }/education/educationMain/pageNum/${i}?keyword=${education.keyword }&search=${education.search}">${i }</a>
						</li>
					</c:if>
				</c:forEach>
				<c:if test="${pb.endPage < pb.totalPage }">
				<li>
					<a href="${path }/education/educationMain/pageNum/${pb.endPage+1 }?keyword=${education.keyword }&search=${education.search}"><span class="glyphicon glyphicon-triangle-right"></span></a>
				</li>
				<li>
					<a href="${path }/education/educationMain/pageNum/${pb.totalPage}?keyword=${education.keyword }&search=${education.search}"><span class="glyphicon glyphicon-forward"></span></a>
				</li>
			</c:if>
			</ul>
		</div>
		<form action="${path }/education/educationMain/pageNum/1">
			<select name="search" class="form-control" style="display: inline-block; width: 100px;">
			<c:forTokens var="sh" items="e_writer,e_title,e_content,sall" delims="," varStatus="i">
				<c:if test="${sh==education.search }">
					<option value="${sh }" selected="selected">${titles[i.index]}</option>
				</c:if>
				<c:if test="${sh!=education.search }">
					<option value="${sh }">${titles[i.index] }</option>
				</c:if>
			</c:forTokens>
			</select>
			<input type="text" class="form-control" name="keyword" value="${education.keyword }" style="display:inline-block; width: 200px;">
			<input type="submit" class="btn btn-default" value="search" style="text-align: center; line-height: 20px;">
		</form>
		<div align="right">
			<a href="${path }/education/educationWriteForm" class="btn btn-primary btn-lg">글등록</a>
		</div>
	</div> 
</body>
</html>
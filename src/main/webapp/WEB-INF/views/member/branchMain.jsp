<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../head.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function branchView(i) {
		location.href="${path }/member/branchRead/b_seq/"+i;
	}
</script>
</head>
<body>
<div class="container" align="center">
	<h2 class="text-primary">지점 관리</h2>
	<div class="mt-3" align="right">
	<form action="${path }/member/branchMain/pageNum/1">
		<input type="search" class="form-control" name="keyword" style="display: inline-block; width: 200px; height: 40px;" placeholder="지점명을 입력해주세요">
		<input type="submit" class="btn btn-default" value="search">
	</form>
	</div>
	<table class="table table-bordered table-hover mt-1">
		<thead style="background: #e0e0e0;">
			<tr>
				<th style="vertical-align: middle;">No.</th>
				<th style="vertical-align: middle;">지점명</th>
				<th style="vertical-align: middle;">지점 인원수</th>
				<th style="vertical-align: middle;">소속된 팀 수</th>
				<th style="vertical-align: middle;">지점 개설일</th>
			</tr>
		</thead>
		<c:if test="${empty list }">
			<tr>
				<td colspan="4" align="center" style="vertical-align: middle;">지점이 없습니다.</td>
			</tr>
		</c:if>
		<c:if test="${not empty list }">
			<c:forEach var="branch" items="${list }">
				<tr align="center">
					<td style="vertical-align: middle;">${num } <c:set var="num" value="${num+1 }"></c:set></td>
					<td style="vertical-align: middle;"><a href="#" onclick="branchView('${branch.b_seq}')">${branch.b_name }</a></td>
					<td style="vertical-align: middle;">총 ${branch.personCount } 명</td>
					<td style="vertical-align: middle;">${branch.teamCount } 팀</td>
					<td style="vertical-align: middle;">${branch.b_date }</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
	<div style="width: 100%; display: flex; justify-content: space-between;">
		<a href = "${path }/member/memberMain" class="btn btn-warning btn-lg">뒤로</a>
		<a href = "${path }/member/branchWriteForm" class="btn btn-primary btn-lg">지점 등록</a>
	</div>
	<div align="center">
		<ul class="pagination">
			<c:if test="${pb.startPage > pb.pagePerBlock }">
				<li>
					<a href="${path }/member/branchMain/pageNum/1?keyword=${branch.keyword}"><span class="glyphicon glyphicon-backward"></span></a>
				</li>
				<li>
					<a href="${path }/member/branchMain/pageNum/${pb.startPage-1 }?keyword=${branch.keyword }"><span class="glyphicon glyphicon-triangle-left"></span></a>
				</li>
			</c:if>
				<c:forEach var="i" begin="${pb.startPage }" end="${pb.endPage }">
					<c:if test="${pb.currentPage==i }">
						<li class="active">
							<a href="${path }/member/branchMain/pageNum/${i}?keyword=${branch.keyword }">${i }</a>
						</li>
					</c:if>
					<c:if test="${pb.currentPage!=i }">
						<li>
							<a href="${path }/member/branchMain/pageNum/${i}?keyword=${branch.keyword }">${i }</a>
						</li>
					</c:if>
				</c:forEach>
			<c:if test="${pb.endPage < pb.totalPage }">
				<li>
					<a href="${path }/member/branchMain/pageNum/${pb.endPage+1 }?keyword=${branch.keyword }"><span class="glyphicon glyphicon-triangle-right"></span></a>
				</li>
				<li>
					<a href="${path }/member/branchMain/pageNum/${pb.totalPage}?keyword=${branch.keyword }"><span class="glyphicon glyphicon-forward"></span></a>
				</li>
			</c:if>
		</ul>
	</div>
</div>
</body>
</html>
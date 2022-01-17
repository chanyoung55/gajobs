<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../head.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.tr-hover {
		cursor: pointer;
	}
	.tr-hover:hover{
		color : #337ab7;
	}
</style>
<script type="text/javascript">
	function consumer() {
		location.href="${path}/consumer/consumerWriteForm/pageNum/${pageNum}";
	}
</script>
</head>
<body>
	<div class="container" align="center">
		<h2 class="text-primary mt-3">고객 관리</h2>
		<div class="mt-1" align="right">
			<button class="btn btn-primary btn-lg" style="float: left;" onclick="consumer();">고객 등록</button>
			<form action="${path }/consumer/consumerMain/pageNum/1">
				<select name="search" id="search" class="form-control" style="display: inline-block; width: 100px">
					<c:forTokens var="sh" items="alls,c_name,c_relation,c_smemo" delims="," varStatus="i">
						<c:if test="${sh==consumer.search }">
							<option value="${sh }" selected="selected">${titles[i.index]}</option>
						</c:if>
						<c:if test="${sh!=consumer.search }">
							<option value="${sh }">${titles[i.index] }</option>
						</c:if>
					</c:forTokens>
				</select>
				<input class="form-control" type="search" name="keyword" style="width: 200px; height: 40px; display: inline-block;" placeholder="검색">
				<input class="btn btn-default" type="submit" value="search">
			</form>
		</div>
		<table class="table table-bordered table-hover mt-1">
			<thead style="background: #e0e0e0;">
				<tr>
					<th style="vertical-align: middle;">No.</th>
					<th style="vertical-align: middle;">이름</th>
					<th style="vertical-align: middle;">관계</th>
					<th style="vertical-align: middle;">고객 간단 메모</th>
					<th style="vertical-align: middle;">마지막 입력 일자</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty list }">
					<tr class="tr-hover">
						<td colspan="5" align="center" style="vertical-align: middle;">등록된 고객이 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${not empty list }">
					<c:forEach var="con" items="${list }">
						<tr class="tr-hover" onclick="location.href='${path}/consumer/consumerRead/pageNum/${pageNum }/c_num/${con.c_num }';">
							<td align="center" style="vertical-align: middle;">
								${num }
								<c:set var="num" value="${num+1 }"></c:set>
							</td>
							<td align="center" style="vertical-align: middle;">
								${con.c_name }
							</td>
							<td align="center" style="vertical-align: middle;">
								<c:if test="${empty con.c_relation }">
								없음
								</c:if>
								<c:if test="${not empty con.c_relation }">
								${con.c_relation}
								</c:if>
							</td>
							<td align="center" style="vertical-align: middle;">${con.c_smemo }</td>
							<td align="center" style="vertical-align: middle;">${con.c_date }</td>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
		</table>
		<div align="center">
			<ul class="pagination">
			<c:if test="${pb.startPage > pb.pagePerBlock }">
				<li>
					<a href="${path }/consumer/consumerMain/pageNum/1?keyword=${consumer.keyword }&search=${consumer.search}"><span class="glyphicon glyphicon-backward"></span></a>
				</li>
				<li>
					<a href="${path }/consumer/consumerMain/pageNum/${pb.startPage-1 }?keyword=${consumer.keyword }&search=${consumer.search}"><span class="glyphicon glyphicon-triangle-left"></span></a>
				</li>
			</c:if>
				<c:forEach var="i" begin="${pb.startPage }" end="${pb.endPage }">
					<c:if test="${pb.currentPage==i }">
						<li class="active">
							<a href="${path }/consumer/consumerMain/pageNum/${i}?keyword=${consumer.keyword }&search=${consumer.search}">${i }</a>
						</li>
					</c:if>
					<c:if test="${pb.currentPage!=i }">
						<li>
							<a href="${path }/consumer/consumerMain/pageNum/${i}?keyword=${consumer.keyword }&search=${consumer.search}">${i }</a>
						</li>
					</c:if>
				</c:forEach>
				<c:if test="${pb.endPage < pb.totalPage }">
				<li>
					<a href="${path }/consumer/consumerMain/pageNum/${pb.endPage+1 }?keyword=${consumer.keyword }&search=${consumer.search}"><span class="glyphicon glyphicon-triangle-right"></span></a>
				</li>
				<li>
					<a href="${path }/consumer/consumerMain/pageNum/${pb.totalPage}?keyword=${consumer.keyword }&search=${consumer.search}"><span class="glyphicon glyphicon-forward"></span></a>
				</li>
			</c:if>
			</ul>
		</div>
	</div>
</body>
</html>
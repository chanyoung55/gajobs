<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../head.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.trhover{
	cursor: pointer;
}
.trhover:hover {
	color: #337ab7;
}
</style>
</head>
<body>
	<div class="container" align="center">
	<h3 class="mt-3">보험사 리스트</h3>
	<table class="table table-bordered table-hover mt-5">
		<thead style="background: #e0e0e0;">
			<tr>
				<th width="50">No.</th>
				<th width="100">회사명</th>
				<th width="50">종류</th>
				<th width="50">활성화여부</th>
				<th width="100">생성일자</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${empty comList }">
				<tr>
					<td colspan="5" align="center">등록된 보험사가 없습니다.</td>
				</tr>
			</c:if>
			<c:forEach var="com" items="${comList }">
			
				<tr class="trhover" onclick="location.href='${path}/admin/companyRead/pageNum/${pageNum }/cp_seq/${com.cp_seq }'">
					<td align="center">
						${num}<c:set var="num" value="${num+1 }"></c:set>
					</td>
					<td align="center">
						${com.cp_name }
					</td>
					<td align="center">
						${com.cp_kinds }
					</td>
					<td align="center">
						${com.cp_del }
					</td>
					<td align="center">
						${com.cp_setdate }
					</td>
				</tr>
			</c:forEach>
		</tbody>
		</table>
		<div align="center">
			<ul class="pagination">
			<c:if test="${pb.startPage > pb.pagePerBlock }">
				<li>
					<a href="${path }/admin/companyMain/pageNum/1?keyword=${company.keyword }&search=${company.search}"><span class="glyphicon glyphicon-backward"></span></a>
				</li>
				<li>
					<a href="${path }/admin/companyMain/pageNum/${pb.startPage-1 }?keyword=${company.keyword }&search=${company.search}"><span class="glyphicon glyphicon-triangle-left"></span></a>
				</li>
			</c:if>
				<c:forEach var="i" begin="${pb.startPage }" end="${pb.endPage }">
					<c:if test="${pb.currentPage==i }">
						<li class="active">
							<a href="${path }/admin/companyMain/pageNum/${i}?keyword=${company.keyword }&search=${company.search}">${i }</a>
						</li>
					</c:if>
					<c:if test="${pb.currentPage!=i }">
						<li>
							<a href="${path }/admin/companyMain/pageNum/${i}?keyword=${company.keyword }&search=${company.search}">${i }</a>
						</li>
					</c:if>
				</c:forEach>
				<c:if test="${pb.endPage < pb.totalPage }">
				<li>
					<a href="${path }/admin/companyMain/pageNum/${pb.endPage+1 }?keyword=${company.keyword }&search=${company.search}"><span class="glyphicon glyphicon-triangle-right"></span></a>
				</li>
				<li>
					<a href="${path }/admin/companyMain/pageNum/${pb.totalPage}?keyword=${company.keyword }&search=${company.search}"><span class="glyphicon glyphicon-forward"></span></a>
				</li>
			</c:if>
			</ul>
		</div>
		<div class="mt-3" align="center" style="width: 100%;">
			<form action="${path }/admin/companyMain/pageNum/1" style="display: inline-block;">
				<select name="search" class="form-control" style="display: inline-block; width: 100px;">
				<c:forTokens var="sh" items="alls,cp_name,cp_kinds,cp_del" delims="," varStatus="i">
					<c:if test="${sh==company.search }">
						<option value="${sh }" selected="selected">${titles[i.index]}</option>
					</c:if>
					<c:if test="${sh!=company.search }">
						<option value="${sh }">${titles[i.index] }</option>
					</c:if>
				</c:forTokens>
				</select>
				<input type="text" class="form-control" name="keyword" value="${company.keyword }" style="display:inline-block; width: 200px;">
				<input type="submit" class="btn btn-default" value="search" style="text-align: center; line-height: 20px;">
			</form>
		</div>
		<div align="left">
			<button class="btn btn-warning btn-lg" onclick="location.href='${path}/admin/adminMain'">메인</button>
			<button style="float: right;" class="btn btn-primary btn-lg" onclick="location.href='${path}/admin/companyWriteForm/pageNum/${pageNum }'">등록</button>
		</div>
	</div>
</body>
</html>
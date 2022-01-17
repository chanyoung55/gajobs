<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../head.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.trHover {
	cursor: pointer;	
}
.trHover:hover {
	color : #337ab7;
}

</style>
</head>
<body>
	<div class="container" align="center" style="width: 95%;">
		<h3 class="mt-5">문의사항 리스트</h3>
		<table class="table table-bordered table-hover mt-3" style="width: 85%; font-size:1.5rem;">
			<thead>
				<tr>
					<th width="10" style="background: #e0e0e0; vertical-align: middle;">No.</th>
					<th width="200" style="background: #e0e0e0; vertical-align: middle;">제목</th>
					<th width="80" style="background: #e0e0e0; vertical-align: middle;">발신자</th>
					<th width="50" style="background: #e0e0e0; vertical-align: middle;">수신확인</th>
					<th width="150" style="background: #e0e0e0; vertical-align: middle;">발송일</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty helpList }">
					<tr>
						<td align="center" colspan="4">문의사항이 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${not empty helpList }">
					<c:forEach var="help" items="${helpList }">
						<tr class="trHover" onclick="location.href='${path}/admin/helpRead/pageNum/${pageNum }/h_num/${help.h_num }'">
							<td align="center" style="vertical-align: middle;">
								${num }
								<c:set var="num" value="${num+1 }"></c:set>
							</td>
							<td align="center" style="vertical-align: middle;">
								${help.h_title }
							</td>
							<td align="center" style="vertical-align: middle;">
								<c:forEach var="role" items="${roleList }">
									<c:if test="${help.r_code == role.r_code }">
										${help.h_writer } ${role.r_name }
									</c:if>
								</c:forEach>
							</td>
							<td align="center" style="vertical-align: middle;">
								<c:if test="${help.h_read == 'n' }">
									<span style="color:red;">읽지 않음</span>
								</c:if>
								<c:if test="${help.h_read == 'y' }">
									<span style="color:blue;">읽음</span>
								</c:if>
							</td>
							<td align="center" style="vertical-align: middle;">
								${help.h_date }
							</td>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
		</table>
		<div align="center">
			<ul class="pagination">
			<c:if test="${pb.startPage > pb.pagePerBlock }">
				<li>
					<a href="${path }/admin/adminMain/pageNum/1?keyword=${help.keyword }&search=${help.search}"><span class="glyphicon glyphicon-backward"></span></a>
				</li>
				<li>
					<a href="${path }/admin/adminMain/pageNum/${pb.startPage-1 }?keyword=${help.keyword }&search=${help.search}"><span class="glyphicon glyphicon-triangle-left"></span></a>
				</li>
			</c:if>
				<c:forEach var="i" begin="${pb.startPage }" end="${pb.endPage }">
					<c:if test="${pb.currentPage==i }">
						<li class="active">
							<a href="${path }/admin/adminMain/pageNum/${i}?keyword=${help.keyword }&search=${help.search}">${i }</a>
						</li>
					</c:if>
					<c:if test="${pb.currentPage!=i }">
						<li>
							<a href="${path }/admin/adminMain/pageNum/${i}?keyword=${help.keyword }&search=${help.search}">${i }</a>
						</li>
					</c:if>
				</c:forEach>
				<c:if test="${pb.endPage < pb.totalPage }">
				<li>
					<a href="${path }/admin/adminMain/pageNum/${pb.endPage+1 }?keyword=${help.keyword }&search=${help.search}"><span class="glyphicon glyphicon-triangle-right"></span></a>
				</li>
				<li>
					<a href="${path }/admin/adminMain/pageNum/${pb.totalPage}?keyword=${help.keyword }&search=${help.search}"><span class="glyphicon glyphicon-forward"></span></a>
				</li>
			</c:if>
			</ul>
		</div>
		<div class="mt-3" align="center" style="width: 85%;">
		<button style="float: left;" class="btn btn-primary btn-lg" onclick="location.href='${path}/admin/mailSendMain'">메일 발신관리</button>
		<form action="${path }/admin/adminMain/pageNum/1" style="display: inline-block;">
			<select name="search" class="form-control" style="display: inline-block; width: 100px;">
			<c:forTokens var="sh" items="alls,h_title,h_content,h_writer" delims="," varStatus="i">
				<c:if test="${sh==help.search }">
					<option value="${sh }" selected="selected">${titles[i.index]}</option>
				</c:if>
				<c:if test="${sh!=help.search }">
					<option value="${sh }">${titles[i.index] }</option>
				</c:if>
			</c:forTokens>
			</select>
			<input type="text" class="form-control" name="keyword" value="${help.keyword }" style="display:inline-block; width: 200px;">
			<input type="submit" class="btn btn-default" value="search" style="text-align: center; line-height: 20px;">
		</form>
		<button style="float: right;" class="btn btn-primary btn-lg" onclick="location.href='${path}/admin/companyMain'">보험사 관리</button>
		</div>
	</div> 
</body>
</html>
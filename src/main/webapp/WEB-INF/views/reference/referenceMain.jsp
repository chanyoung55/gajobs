<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../head.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function download(i) {
		location.href="${path}/reference/referenceFileDownload/rff_seq/"+i;
	}
</script>
</head>
<body>
	<div class="container" align="center">
		<h2 class="text-primary mt-3">서식 자료실</h2>
		<table class="table table-bordered mt-3">
			<tr>
				<th style="vertical-align: middle; background: #e0e0e0;" width="100" >No.</th>
				<th style="vertical-align: middle; background: #e0e0e0;" width="400">제목</th>
				<th style="vertical-align: middle; background: #e0e0e0;" width="100">글 종류</th>
				<th style="vertical-align: middle; background: #e0e0e0;" width="300">첨부 파일</th>
				<th style="vertical-align: middle; background: #e0e0e0;" width="100">글쓴이</th>
				<th style="vertical-align: middle; background: #e0e0e0;" width="200">업로드 일자</th>
			</tr>
			<c:if test="${empty list }">
				<tr>
					<td colspan="6" align="center">데이터가 없습니다.</td>
				</tr>
			</c:if>
			<c:if test="${not empty list }">
				<c:forEach var="reference" items="${list }">
					<tr>
						<td style="vertical-align: middle;" align="center">${num }<c:set var="num" value="${num+1 }"></c:set></td>
						<td style="vertical-align: middle;" align="center">
							<a href="${path }/reference/referenceRead/pageNum/${pageNum}/rf_num/${reference.rf_num}">${reference.rf_title }</a>
						</td>
						<td style="vertical-align: middle;" align="center">${reference.rfk_name }</td>
						<td style="vertical-align: middle;" align="center">
							<c:forEach var="file" items="${filesList }">
								<c:if test="${file.rf_num == reference.rf_num }">
									<a href="${path}/reference/referenceFileDownload/rff_seq/${file.rff_seq}">${file.rff_name }.${file.rff_type }</a><br>
								</c:if>
							</c:forEach>
						</td>
						<td style="vertical-align: middle;" align="center">${reference.rf_writer }</td>
						<td style="vertical-align: middle;" align="center">${reference.rf_date }</td>
					</tr>
				</c:forEach>
			</c:if>
		</table>
		<div align="center">
			<ul class="pagination">
			<c:if test="${pb.startPage > pb.pagePerBlock }">
				<li>
					<a href="${path }/reference/referenceMain/pageNum/1?kinds=${reference.kinds }&search=${reference.search}&keyword=${reference.keyword }"><span class="glyphicon glyphicon-backward"></span></a>
				</li>
				<li>
					<a href="${path }/reference/referenceMain/pageNum/${pb.startPage-1 }?kinds=${reference.kinds }&search=${reference.search}&keyword=${reference.keyword }"><span class="glyphicon glyphicon-triangle-left"></span></a>
				</li>
			</c:if>
				<c:forEach var="i" begin="${pb.startPage }" end="${pb.endPage }">
					<c:if test="${pb.currentPage==i }">
						<li class="active">
							<a href="${path }/reference/referenceMain/pageNum/${i}?kinds=${reference.kinds }&search=${reference.search}&keyword=${reference.keyword }">${i }</a>
						</li>
					</c:if>
					<c:if test="${pb.currentPage!=i }">
						<li>
							<a href="${path }/reference/referenceMain/pageNum/${i}?kinds=${reference.kinds }&search=${reference.search}&keyword=${reference.keyword }">${i }</a>
						</li>
					</c:if>
				</c:forEach>
				<c:if test="${pb.endPage < pb.totalPage }">
				<li>
					<a href="${path }/reference/referenceMain/pageNum/${pb.endPage+1 }?kinds=${reference.kinds }&search=${reference.search}&keyword=${reference.keyword }"><span class="glyphicon glyphicon-triangle-right"></span></a>
				</li>
				<li>
					<a href="${path }/reference/referenceMain/pageNum/${pb.totalPage}?kinds=${reference.kinds }&search=${reference.search}&keyword=${reference.keyword }"><span class="glyphicon glyphicon-forward"></span></a>
				</li>
			</c:if>
			</ul>
		</div>
			<form action="${path }/reference/referenceMain/pageNum/1">
			<select name="kinds" class="form-control" style="display: inline-block; width: 100px;">
				<option value="0">전체</option>
				<c:forEach var="kind" items="${kindslist }">
					<c:if test="${kind.rfk_seq == reference.kinds }">
						<option value="${kind.rfk_seq }" selected="selected">${kind.rfk_name }</option>
					</c:if>
					<c:if test="${kind.rfk_seq != reference.kinds }">
						<option value="${kind.rfk_seq }">${kind.rfk_name }</option>
					</c:if>
				</c:forEach>
			</select>
			<select name="search" class="form-control" style="display: inline-block; width: 100px;">
			<c:forTokens var="sh" items="rf_writer,rf_title,rf_content,sall" delims="," varStatus="i">
				<c:if test="${sh==reference.search }">
					<option value="${sh }" selected="selected">${titles[i.index]}</option>
				</c:if>
				<c:if test="${sh!=reference.search }">
					<option value="${sh }">${titles[i.index] }</option>
				</c:if>
			</c:forTokens>
			</select>
			<input type="text" class="form-control" name="keyword" value="${reference.keyword }" style="display:inline-block; width: 200px;">
			<input type="submit" class="btn btn-default" value="search" style="text-align: center; line-height: 20px;">
		</form>
		<div align="right">
			<a class="btn btn-primary btn-lg" href="${path }/reference/referenceWriteForm">글등록</a>
		</div>
	</div>
</body>
</html>
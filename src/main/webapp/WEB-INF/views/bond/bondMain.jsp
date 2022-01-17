<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file = "../head.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.binfo {
	cursor: pointer;
}
.binfo:hover {
	color : #337ab7;
}
</style>
<script type="text/javascript">
function lastDate(d) {
	var date = new Date(d);
	var year = date.getFullYear();
	var month = date.getMonth()+1;
	var day = date.getDate();
	var lastday = new Date(year,month,0).getDate();
	if(month < 10) {
		month = '0'+month;
	}
	return year + "-" + month + "-" + lastday;
}
function fomatDate(d) {
	var date = new Date(d);
	var year = date.getFullYear();
	var month = date.getMonth()+1;
	var day = date.getDate();
	if(month < 10) {
		month = '0'+month;
	}
	if(day < 10) {
		day = '0'+day;
	}
	return year + '-' + month + '-'+ day;
}

function start() {
	var startDate = fomatDate($('#startDate').val());
	var last = lastDate(startDate); 
	$('#endDate').val(last);
	var endDate = fomatDate($('#endDate').val());
}

function end() {
	var endDate = fomatDate($('#endDate').val());
	var startDate = fomatDate($('#startDate').val());
	var last = lastDate(startDate);
	if (endDate < startDate) {
		alert("종료일은 시작일 보다 빠를수 없습니다.");
		$('#endDate').val(last);
	}
}
function delDate() {
	$('#endDate').val('');
	$('#startDate').val('');
}
</script>
</head>
<body>
	<div class="container" align="center">
		<h2 class="text-primary mt-3">채권 관리</h2>
		<div class="mt-5" align="right" style="width: 100%; height: 40px;">
			<form action="${path }/bond/bondMain/pageNum/1">
				<div style="display: inline-block; float: left;">
					<span>일자 </span>
			 		<input class="form-control" type="date" onchange="start()" id="startDate" name="startDate" style="width: 200px; height: 40px; display: inline-block;" value="${bond.startDate }">
			 		<span> ~ </span>
			 		<input class="form-control" type="date" onchange="end()" id="endDate" name="endDate" style="width: 200px; height: 40px; display: inline-block;" value="${bond.endDate }">
					<button class="btn btn-danger" onclick="delDate()">시간삭제</button>
				</div>
				<select name="search" id="search" class="form-control" style="display: inline-block; width: 120px">
					<c:forTokens var="sh" items="k.m_id,m_name,bo_kinds,r_name,alls" delims="," varStatus="i">
						<c:if test="${sh==bond.search }">
							<option value="${sh }" selected="selected">${titles[i.index]}</option>
						</c:if>
						<c:if test="${sh!=bond.search }">
							<option value="${sh }">${titles[i.index] }</option>
						</c:if>
					</c:forTokens>
				</select>
				<input class="form-control" type="search" name="keyword" style="width: 200px; height: 40px; display: inline-block;" placeholder="검색">
				<input class="btn btn-default" type="submit" value="search">
			</form>
		</div>
		<table class="table table-bordered table-hover mt-3" style="width: 100%;">
			<thead style="background: #e0e0e0;">
				<tr>
					<th width="50">No.</th>
					<th width="100">사번</th>
					<th width="100">이름</th>
					<th width="100">지점명</th>
					<th width="100">팀명</th>
					<th width="100">채권종류</th>
					<th width="100">만기일자</th>
				</tr>
			</thead>
			<tbody>
			<c:if test="${empty bondList }">
				<tr>
					<td colspan="8" align="center">
						채권 등록 자료가 없습니다.
					</td>
				</tr>
			</c:if>
			<c:if test="${not empty bondList }">
				<c:forEach var="bond" items="${bondList }" >
					<tr class="binfo" onclick="location.href='${path}/bond/bondRead/pageNum/${pageNum }/bo_num/${bond.bo_num }'">
						<td align="center">${num }<c:set var="num" value="${num+1 }"></c:set></td>
						<td align="center">${bond.m_id }</td>
						<td align="center">${bond.m_name }</td>
						<td align="center">${bond.b_name }</td>
						<td align="center">${bond.t_name }</td>
						<td align="center">${bond.bo_kinds }</td>
						<td align="center">${bond.bo_enddate }</td>
					</tr>
				</c:forEach>
			</c:if>
			</tbody>
		</table>
		<div align="center">
			<ul class="pagination">
			<c:if test="${pb.startPage > pb.pagePerBlock }">
				<li>
					<a href="${path }/bond/bondMain/pageNum/1?startDate=${bond.startDate }&endDate=${bond.endDate }&search=${bond.search}&keyword=${bond.keyword }"><span class="glyphicon glyphicon-backward"></span></a>
				</li>
				<li>
					<a href="${path }/bond/bondMain/pageNum/${pb.startPage-1 }?startDate=${bond.startDate }&endDate=${bond.endDate }&search=${bond.search}&keyword=${bond.keyword }"><span class="glyphicon glyphicon-triangle-left"></span></a>
				</li>
			</c:if>
				<c:forEach var="i" begin="${pb.startPage }" end="${pb.endPage }">
					<c:if test="${pb.currentPage==i }">
						<li class="active">
							<a href="${path }/bond/bondMain/pageNum/${i}?startDate=${bond.startDate }&endDate=${bond.endDate }&search=${bond.search}&keyword=${bond.keyword }">${i }</a>
						</li>
					</c:if>
					<c:if test="${pb.currentPage!=i }">
						<li>
							<a href="${path }/bond/bondMain/pageNum/${i}?startDate=${bond.startDate }&endDate=${bond.endDate }&search=${bond.search}&keyword=${bond.keyword }">${i }</a>
						</li>
					</c:if>
				</c:forEach>
				<c:if test="${pb.endPage < pb.totalPage }">
				<li>
					<a href="${path }/bond/bondMain/pageNum/${pb.endPage+1 }?startDate=${bond.startDate }&endDate=${bond.endDate }&search=${bond.search}&keyword=${bond.keyword }"><span class="glyphicon glyphicon-triangle-right"></span></a>
				</li>
				<li>
					<a href="${path }/bond/bondMain/pageNum/${pb.totalPage}?startDate=${bond.startDate }&endDate=${bond.endDate }&search=${bond.search}&keyword=${bond.keyword }"><span class="glyphicon glyphicon-forward"></span></a>
				</li>
			</c:if>
			</ul>
		</div>
		<div align="right">
			<button class="btn btn-primary btn-lg" onclick="location.href='${path}/bond/bondWriteForm'">채권 등록</button>
		</div>
	</div>
</body>
</html>
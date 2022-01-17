<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../head.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
td {
	text-align: center;
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
	function memberView(i) {
		location.href="${path }/member/memberRead/m_id/"+i;
	}
	function branchView(i) {
		location.href="${path }/member/branchRead/b_seq/"+i;
	}
	function teamView(i) {
		location.href="${path }/member/teamRead/t_seq/"+i;
	}
	function delDate() {
		$('#endDate').val('');
		$('#startDate').val('');
	}
</script>
</head>
<body>
	<div class="container" align="center">
		<h2 class="text-primary mt-3">인사 관리</h2>
		<div class="mt-5" align="right" style="width: 100%; height: 40px;">
				<form action="${path }/member/memberMain/pageNum/1">
				<div style="display: inline-block; float: left;">
					<span>일자 </span>
			 		<input class="form-control" type="date" onchange="start()" id="startDate" name="startDate" style="width: 200px; height: 40px; display: inline-block;" value="${member.startDate }">
			 		<span> ~ </span>
			 		<input class="form-control" type="date" onchange="end()" id="endDate" name="endDate" style="width: 200px; height: 40px; display: inline-block;" value="${member.endDate }">
					<button class="btn btn-danger" onclick="delDate()">시간삭제</button>
				</div>
				<select name="search" id="search" class="form-control" style="display: inline-block; width: 100px">
					<c:forTokens var="sh" items="m_id,m_name" delims="," varStatus="i">
						<c:if test="${sh==member.search }">
							<option value="${sh }" selected="selected">${titles[i.index]}</option>
						</c:if>
						<c:if test="${sh!=member.search }">
							<option value="${sh }">${titles[i.index] }</option>
						</c:if>
					</c:forTokens>
				</select>
				<input class="form-control" type="search" name="keyword" style="width: 200px; height: 40px; display: inline-block;" placeholder="검색">
				<input class="btn btn-default" type="submit" value="search">
			</form>
		</div>
		<table class="table table-bordered mt-1">
			<thead style="background: #e0e0e0;">
				<tr>
					<th style="vertical-align: middle;">No.</th>
					<th style="vertical-align: middle;">사번</th>
					<th style="vertical-align: middle;">이름</th>
					<th style="vertical-align: middle;">지점명</th>
					<th style="vertical-align: middle;">팀명</th>
					<th style="vertical-align: middle;">도입자</th>
					<th style="vertical-align: middle;">위촉일자</th>
					<th style="vertical-align: middle;">현재 상태</th>
				</tr>
			</thead>
			<c:if test="${empty list }">
				<tr>
					<td colspan="6" align="center">데이터가 없습니다.</td>
				</tr>
			</c:if>
			<c:if test="${not empty list }">
				<c:forEach var="member" items="${list }">
					<tr>
						<td style="vertical-align: middle;">${num }<c:set var="num" value="${num+1 }"></c:set></td>
						<td style="vertical-align: middle;">${member.m_id }</td>
						<td style="vertical-align: middle;"><a href="#" onclick="memberView('${member.m_id}')">${member.m_name }</a></td>
						<td style="vertical-align: middle;"><a href="#" onclick="branchView('${member.b_seq}')">${member.b_name }</a></td>
						<td style="vertical-align: middle;"><a href="#" onclick="teamView('${member.t_seq}')">${member.t_name }</a></td>
						<c:if test="${empty member.m_mgr }">
							<td>없음</td>
						</c:if>
						<c:if test="${not empty member.m_mgr }">
							<c:forEach var="mgr" items="${mgrlist }">
								<c:if test="${member.m_mgr == mgr.m_id }">	
									<td><a href="#" onclick="memberView('${mgr.m_id}')">${mgr.m_name }</a></td>
								</c:if>
							</c:forEach>
						</c:if>
						<td style="vertical-align: middle;">${member.m_hiredate }</td>
						<c:if test="${member.m_del == 'n' }">
							<td style="color: green; vertical-align: middle;">위촉중</td>
						</c:if>
						<c:if test="${member.m_del == 'y' }">
							<td style="color: red; vertical-align: middle;">퇴사</td>
						</c:if>
					</tr>	
				</c:forEach>
			</c:if>
		</table>
		<div style="width: 100%; display: flex; justify-content: space-between;">
			<a href="${path }/member/branchMain" class="btn btn-primary btn-lg">지점관리</a>
			<a href="${path }/member/memberWriteForm" class="btn btn-primary btn-lg">회원등록</a>
		</div>
		<div align="center">
			<ul class="pagination">
			<c:if test="${pb.startPage > pb.pagePerBlock }">
				<li>
					<a href="${path }/member/memberMain/pageNum/1?startDate=${member.startDate }&endDate=${member.endDate }&search=${member.search}&keyword=${member.keyword }"><span class="glyphicon glyphicon-backward"></span></a>
				</li>
				<li>
					<a href="${path }/member/memberMain/pageNum/${pb.startPage-1 }?startDate=${member.startDate }&endDate=${member.endDate }&search=${member.search}&keyword=${member.keyword }"><span class="glyphicon glyphicon-triangle-left"></span></a>
				</li>
			</c:if>
				<c:forEach var="i" begin="${pb.startPage }" end="${pb.endPage }">
					<c:if test="${pb.currentPage==i }">
						<li class="active">
							<a href="${path }/member/memberMain/pageNum/${i}?startDate=${member.startDate }&endDate=${member.endDate }&search=${member.search}&keyword=${member.keyword }">${i }</a>
						</li>
					</c:if>
					<c:if test="${pb.currentPage!=i }">
						<li>
							<a href="${path }/member/memberMain/pageNum/${i}?startDate=${member.startDate }&endDate=${member.endDate }&search=${member.search}&keyword=${member.keyword }">${i }</a>
						</li>
					</c:if>
				</c:forEach>
				<c:if test="${pb.endPage < pb.totalPage }">
				<li>
					<a href="${path }/member/memberMain/pageNum/${pb.endPage+1 }?startDate=${member.startDate }&endDate=${member.endDate }&search=${member.search}&keyword=${member.keyword }"><span class="glyphicon glyphicon-triangle-right"></span></a>
				</li>
				<li>
					<a href="${path }/member/memberMain/pageNum/${pb.totalPage}?startDate=${member.startDate }&endDate=${member.endDate }&search=${member.search}&keyword=${member.keyword }"><span class="glyphicon glyphicon-forward"></span></a>
				</li>
			</c:if>
			</ul>
		</div>
	</div>
</body>
</html>
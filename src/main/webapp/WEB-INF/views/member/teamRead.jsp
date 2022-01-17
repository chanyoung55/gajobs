<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../head.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.tr-hover:hover {
	cursor : pointer;
	color : #337ab7;
}
</style>
<script type="text/javascript">

function memberView(i) {
	location.href="${path}/member/memberRead/m_id/"+i;
}

function teamUpdate(i) {
	location.href="${path}/member/teamUpdateForm/t_seq/"+i;
}

function teamDelete(i) {
	
	var mCount = '${mCount}';
	var leaveCount = '${leaveCount}';
	var cf = confirm("정말로 삭제 하시겠습니까?");
	
	if(cf){
		if(mCount != '0'){
			alert("팀에 소속된 회원이 있어 삭제 할 수 없습니다.");
		} else if(leaveCount != '0') {
			alert("팀에 탈퇴된 회원이 있어 삭제 할 수 없습니다.");
		} else {
			location.href="${path}/member/teamDelete/b_seq/${team.b_seq}/t_seq/"+i;
		}
	}
	
}

</script>
</head>
<body>
	<div class="container" align="center">
		<h2 class="text-primary">팀 상세 정보</h2>
		<div align="left">
			<button class="btn btn-warning btn-lg" onclick="history.go(-1);">뒤로</button>
		</div>
		<table class="table table-bordered mt-1">
			<tr>
				<th style="width: 30%;">팀명</th>
				<td align="center">${team.t_name }</td>
			</tr>
			<tr>
				<th>소속된 팀원수</th>
				<td align="center">${mCount }</td>
			</tr>
			<tr>
				<th>퇴사한 인원수</th>
				<td align="center">${leaveCount }</td>
			</tr>
			<tr>
				<th>팀 생성일</th>
				<td align="center">${team.t_date }</td>
			</tr>
		</table>
		<div class="mt-1" style="width: 100%; display: flex; justify-content: space-between;">
			<button class="btn btn-primary btn-lg" onclick="teamUpdate('${team.t_seq}')">팀 수정</button>
			<button class="btn btn-danger btn-lg" onclick="teamDelete('${team.t_seq}')">팀 삭제</button>
		</div>
		<div class="mt-5">
			<h2 class="text-primary">팀 인원 명단</h2>
			<table class="table table-bordered table-hover mt-1">
				<thead style="background: #e0e0e0;">
					<tr>
						<th style="vertical-align: middle;">No.</th>
						<th style="vertical-align: middle;">사번</th>
						<th style="vertical-align: middle;">이름</th>
						<th style="vertical-align: middle;">직책</th>
						<th style="vertical-align: middle;">현 상태</th>
					</tr>
				</thead>
					<c:if test="${empty list }">
						<tr>
							<td align="center" colspan="5">
								회원이 없습니다.
							</td>
						</tr>	
					</c:if>
					<c:if test="${not empty list }">
						<c:forEach var="member" items="${list }">
							<tr class="tr-hover" onclick="memberView('${member.m_id}')">
								<td align="center">${num }<c:set var="num" value="${num+1 }"></c:set></td>
								<td align="center">${member.m_id }</td>
								<td align="center">${member.m_name }</td>
								<td align="center">${member.r_name }</td>
								<c:if test="${member.m_del == 'y' }">
									<td align="center" style="color:red;">퇴사</td>
								</c:if>
								<c:if test="${member.m_del == 'n' }">
									<td align="center" style="color:green;">위촉중</td>
								</c:if>
							</tr>
						</c:forEach>
					</c:if>
			</table>
			<div align="center">
			<ul class="pagination">
			<c:if test="${pb.startPage > pb.pagePerBlock }">
				<li>
					<a href="${path }/member/teamRead/t_seq/${t_seq}/pageNum/1">
						<span class="glyphicon glyphicon-backward"></span>
					</a>
				</li>
				<li>
					<a href="${path }/member/teamRead/t_seq/${t_seq}/pageNum/${pb.startPage-1 }">
						<span class="glyphicon glyphicon-triangle-left"></span>
					</a>
				</li>
			</c:if>
				<c:forEach var="i" begin="${pb.startPage }" end="${pb.endPage }">
					<c:if test="${pb.currentPage==i }">
						<li class="active">
							<a href="${path }/member/teamRead/t_seq/${t_seq}/pageNum/${i}">${i}</a>
						</li>
					</c:if>
					<c:if test="${pb.currentPage!=i }">
						<li>
							<a href="${path }/member/teamRead/t_seq/${t_seq}/pageNum/${i}">${i}</a>
						</li>
					</c:if>
				</c:forEach>
				<c:if test="${pb.endPage < pb.totalPage }">
					<li>
						<a href="${path }/member/teamRead/t_seq/${t_seq}/pageNum/${pb.endPage+1 }"><span class="glyphicon glyphicon-triangle-right"></span></a>
					</li>
					<li>
						<a href="${path }/member/teamRead/t_seq/${t_seq}/pageNum/${pb.totalPage}"><span class="glyphicon glyphicon-forward"></span></a>
					</li>
				</c:if>
			</ul>
		</div>
		</div>
	</div>
</body>
</html>
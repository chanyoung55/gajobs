<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../head.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function teamView(i) {
		location.href="${path}/member/teamRead/t_seq/"+i;
	}
	
	function branchUpdate(i) {
		location.href="${path}/member/branchUpdateForm/b_seq/"+i;
	}
	
	function branchDelete(i) {
		var mcount = '${memberCount }';
		var tcount = '${teamCount }';
		var leaveCount = '${leaveCount}';
		var cf = confirm("지점을 정말로 삭제하시겠습니까?");
		
	if(cf){
		if(mcount != '0') {
			alert("소속된 회원이 존재하여 삭제할 수 없습니다.");
			return false;
		} else if (leaveCount != '0'){
			alert("퇴사한 회원이 존재하여 삭제할 수 없습니다.");
			return false;
		}
		else {
			location.href="${path}/member/branchDelete/b_seq/"+i;	
		}
	} else {
		return false;
		}
	}
	
	function teamWrite(i) {
		location.href="${path}/member/teamWriteForm/b_seq/"+i;
	}
</script>
</head>
<body>
	<div class="container" align="center">
		<h2 class="text-primary">지점정보 상세</h2>
		<table class="table table-bordered mt-3">
			<tr>
				<th style="width: 30%;">지점명</th>
				<td align="center">${branch.b_name }</td>
			</tr>
			<tr>
				<th>소속 중인 인원수</th>
				<td align="center">${memberCount } 명</td>
			</tr>
			<tr>
				<th>퇴사 인원수</th>
				<td align="center">${leaveCount } 명</td>
			</tr>
			<tr>
				<th>소속 팀수</th>
				<td align="center">${teamCount } 팀</td>
			</tr>
			<tr>
				<th>지점 개설일</th>
				<td align="center">${branch.b_date }</td>
			</tr>		
		</table>
		<div class="mt-1" style="width: 100%; display: flex; justify-content: space-between;">
			<button class="btn btn-primary btn-lg" onclick="branchUpdate('${branch.b_seq}')">지점 수정</button>
			<button class="btn btn-danger btn-lg" onclick="branchDelete('${branch.b_seq}')">지점 삭제</button>
		</div>
		<div class="mt-5">
			<h2 class="text-primary">소속팀 정보</h2>
			<div align="right">
				<button class="btn btn-default btn-lg" onclick="teamWrite('${branch.b_seq}')">팀 추가</button>
			</div>
			<table class="table table-bordered mt-1">
			<tr>
				<th>No.</th>
				<th>팀명</th>
				<th>팀 개설일</th>
			</tr>
			
				<c:if test="${empty teamList }">
				<tr>
					<td colspan="3" align="center">소속된 팀이 없습니다.</td>
				</tr>
				</c:if>
				<c:if test="${not empty teamList }">
					<c:forEach var="team" items="${teamList }">
						<tr>
							<td align="center">${n+1}<c:set var="n" value="${n+1 }"></c:set></td>
							<td align="center"><a href="#" onclick="teamView('${team.t_seq}')">${team.t_name }</a></td>
							<td align="center">${team.t_date }</td>
						</tr>
					</c:forEach>
				</c:if>
			
		</table>
		<div class="mt-4">
			<button class="btn btn-warning btn-lg" onclick="history.go(-1);">뒤로</button>
		</div>
		</div>
	</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../head.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function memberView(i) {
		location.href="${path}/member/memberRead/m_id/"+i;
	}
	function fileDownload(i) {
		location.href="${path}/member/FileDownload/af_seq/"+i
	}
	function del(i) {
		var cf = confirm("정말로 퇴사처리 하시겠습니까?");
		if(cf) {
			location.href="${path}/member/memberDelete/m_id/"+i;
		} else {
			alert("삭제가 취소 되었습니다.");
		}
	}
	function updateForm(i) {
		location.href="${path}/member/memberUpdateForm/m_id/"+i;
	}
	function reEntry(i) {
		location.href="${path}/member/reEntred/m_id/"+i;		
	}
</script>
</head>
<body>
	<div class="container" align="center">
		<h2 class="text-primary mt-3">회원 정보 상세</h2>
		<table class="table table-bordered mt-3">
			<tr>
				<th>사번</th>
				<td>${member.m_id }</td>
				<th>이름</th>
				<td>${member.m_name }</td>
			</tr>
			<tr>
				<th>주민번호</th>
				<td>${member.m_ssnum }</td>
				<th>전화번호</th>
				<td>${member.m_tel }</td>
			</tr>
			<tr>
				<th>소속지점</th>
				<td>${member.b_name }</td>
				<th>소속팀</th>
				<td>${member.t_name }</td>
			</tr>
				<tr>
				<th>직책</th>
				<td>${member.r_name }</td>
				<th>도입자</th>
				<c:if test="${empty member.m_mgr }">
					<td>없음</td>
				</c:if>
				<c:if test="${not empty member.m_mgr }">
					<td><a href="#" onclick="memberView('${member.m_mgr}')">${mgrInfo.m_name }</a></td>
				</c:if>
			</tr>
			<tr>
				<th>이메일</th>
				<td>${member.m_email }</td>
				<th>입사일</th>
				<td>${member.m_hiredate }</td>
			</tr>
			<tr>
				<th>주소</th>
				<td colspan="3">(${member.m_postcode }) ${member.m_addr } ${member.m_detailaddr } ${member.m_extraaddr }</td>
			</tr>
			<tr>
				<th>현 상태</th>
				<c:if test="${member.m_del == 'y' }">
					<td align="center" style="color:red;">퇴사</td>
					<th>퇴사일자</th>
					<td>${member.m_deldate }</td>
				</c:if>
				<c:if test="${member.m_del == 'n' }">
					<td colspan="3" align="center" style="color:green;">위촉중</td>
				</c:if>
			</tr>
			<tr>
				<th colspan="4">위촉 서류</th>
			</tr>
			<tr>
				<th>No.</th>
				<th colspan="2">파일명</th>
				<th>업로드 일자</th>
			</tr>
				<c:if test="${empty fileList }">
				<tr>
					<td colspan="4" align="center">없음</td>
				</tr>
				</c:if>
				<c:if test="${not empty fileList }">
				<c:forEach var="file" items="${fileList }">
				<tr>
					<th align="center">${fileCount }<c:set var="fileCount" value="${fileCount-1 }"></c:set></th>
					<td colspan="2" align="center">		
						<a href="#" onclick="fileDownload('${file.af_seq}')">${file.af_name }.${file.af_type }</a>
					</td>
					<td align="center">${file.af_date }</td>
				</tr>
				</c:forEach>
				</c:if>
		</table>
		
		<div class="mt-3" style="display: flex; justify-content: space-between;">
			<c:if test="${member.m_del == 'n' }">
				<a href="#" class="btn btn-danger btn-lg" onclick="del('${member.m_id}')">퇴사</a>
			</c:if>
			<c:if test="${member.m_del == 'y' }">
				<a href="#" class="btn btn-primary btn-lg" onclick="reEntry('${member.m_id}')">재입사</a>
			</c:if>
			<a href="#" class="btn btn-success btn-lg" onclick="updateForm('${member.m_id}')">수정</a>
		</div>
		<div class="mt-3">
			<a href="#" class="btn btn-warning btn-lg" onclick="history.go(-1);">뒤로</a>
		</div>
	</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../head.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function del() {
		var ch = confirm("정말 삭제하시겠습니까?");
		if(ch){
			location.href="${path}/bond/bondDelete/pageNum/${pageNum}/bo_num/${bo_num}";
		}
	}
	
	function update() {
		location.href="${path}/bond/bondUpdateForm/pageNum/${pageNum}/bo_num/${bo_num}";
	}
</script>
</head>
<body>
	<div class="container" align="center">
		<h2 class="text-primary mt-3">채권 정보 상세</h2>
		<table class="table table-bordered mt-3" style="width: 100%;">
			<tr>
				<th width="100">사번</th>
				<td width="200">${member.m_id }</td>
				<th width="100">주민번호</th>
				<td width="200">${member.m_ssnum }</td>
			</tr>
			<tr>
				<th>이름</th>
				<td>${member.m_id }</td>
				<th>전화번호</th>
				<td>${member.m_ssnum }</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>${member.m_email }</td>
				<th>위촉일자</th>
				<td>${member.m_hiredate }</td>
			</tr>
			<tr>
				<th>지점명</th>
				<td>${member.b_name }</td>
				<th>팀명</th>
				<td>${member.t_name }</td>
			</tr>
			<tr>
				<th>직책</th>
				<td>${member.r_name }</td>
				<th>주소</th>
				<td>
					(${member.m_postcode }) ${member.m_addr } ${member.m_detailaddr } ${member.m_extraaddr }
				</td>
			</tr>
		</table>
		<table class="table table-bordered mt-3" style="width: 100%">
			<thead style="background: #e0e0e0">
				<tr>
					<th>채권 종류</th>
					<th>게시 일자</th>
					<th>만기 일자</th>
					<th>채권 금액</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td align="center">${bond.bo_kinds }</td>
					<td align="center">${bond.bo_startdate }</td>
					<td align="center">${bond.bo_enddate }</td>
					<td align="center">${bond.bo_pay}</td>
				</tr>
				<tr>
					<th style="background: #e0e0e0;" colspan="2">채권 첨부 파일</th>
					<td colspan="2">
						<a href="${path }/bond/FileDownload/bof_seq/${bondFile.bof_seq}">${bondFile.bof_name }.${bondFile.bof_type }</a>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="mt-4" style="display: flex; justify-content: space-between;">
			<button class="btn btn-danger btn-lg" onclick="del()">삭제하기</button>
			<button class="btn btn-success btn-lg" onclick="update()">수정하기</button>
		</div>
		<div class="mt-1" align="center">
			<button class="btn btn-warning btn-lg" onclick="location.href='${path}/bond/bondMain/pageNum/${pageNum }'">목록으로</button>
		</div>
	</div>
</body>
</html>
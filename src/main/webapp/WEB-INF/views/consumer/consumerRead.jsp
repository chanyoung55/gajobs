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
		var cf = confirm("정말로 삭제하시겠습니까?");
		if(cf){
			location.href='${path}/consumer/consumerDelete/pageNum/${pageNum }/c_num/${c_num }';
		} else {
			return false;
		}
	}
</script>
</head>
<body>
	<div class="container" align="center">
		<h2 class="text-primary mt-3">고객 정보</h2>
		<table class="table table-bordered mt-3">
			<tr>
				<th>고객 이름</th>
				<td align="center">${consumer.c_name }</td>
				<th>고객 전화번호</th>
				<td align="center">${consumer.c_tel }</td>
			</tr>
			<tr>
				<th>고객 성별</th>
				<c:if test="${consumer.c_sex == '1' }">
					<td align="center">남</td>
				</c:if>
				<c:if test="${consumer.c_sex == '2' }">
					<td align="center">여</td>
				</c:if>
				<th>생년월일</th>
				<c:if test="${empty consumer.c_ssnum }">
					<td align="center">없음</td>
				</c:if>
				<c:if test="${not empty consumer.c_ssnum }">
					<td align="center">${consumer.c_ssnum }</td>
				</c:if>
			</tr>
			<tr>
				<th>설계동의서 여부</th>
				<c:if test="${isFile > 0 }">
					<td align="center">Y</td>
				</c:if>
				<c:if test="${isFile == 0 }">
					<td align="center">N</td>
				</c:if>
				<th>병력사항</th>
				<c:if test="${empty consumer.c_history }">
					<td align="center">없음</td>
				</c:if>
				<c:if test="${not empty consumer.c_history }">
					<td align="center">${consumer.c_history }</td>
				</c:if>
			</tr>
			<tr>
				<th>주소</th>
				<c:if test="${empty consumer.c_addr }">
					<td align="center" colspan="3">
						없음
					</td>
				</c:if>
				<c:if test="${not empty consumer.c_addr }">
					<td align="center" colspan="3">
						(${consumer.c_postcode }) ${consumer.c_addr } ${consumer.c_detailaddr } ${consumer.c_extraaddr }
					</td>
				</c:if>
			</tr>
			<tr>
				<th>고객 간단 메모</th>
				<td align="center" colspan="3">${consumer.c_smemo }</td>
			</tr>
			<tr>
				<th colspan="4">설계동의서 첨부파일 목록</th>
			</tr>
			<c:if test="${empty fileList }">
				<tr>
					<td align="center" colspan="4">없음</td>
				</tr>
			</c:if>
			<c:if test="${not empty fileList }">
				<c:forEach var="file" items="${fileList }" >
					<tr>
						<td align="center"><c:set var="num" value="${num+1 }"></c:set> ${num }</td>
						<td align="center" colspan="3">
							<a href="${path }/consumer/fileDownload/cf_seq/${file.cf_seq}">${file.cf_name }.${file.cf_type }</a>
						</td>
					</tr>
				</c:forEach>
			</c:if>	
		</table>
		<table class="table table-bordered">
			<tr>
				<th>고객 상세 메모</th>
			</tr>
			<tr>
				<c:if test="${empty consumer.c_lmemo }">
					<td height="200">없음</td>
				</c:if>
				<c:if test="${not empty consumer.c_lmemo }">
					<td height="200">${consumer.c_lmemo }</td>
				</c:if>
			</tr>
		</table>
		<div>
			<button class="btn btn-danger btn-lg" onclick="del()">삭제</button>
			<button class="btn btn-success btn-lg" onclick="location.href='${path}/consumer/consumerUpdateForm/pageNum/${pageNum }/c_num/${c_num }'">수정</button>
			<button class="btn btn-warning btn-lg" onclick="location.href='${path}/consumer/consumerMain/pageNum/${pageNum }'">목록</button>
			<button class="btn btn-primary btn-lg" onclick="location.href='${path}/consumer/contractRead/pageNum/1/c_num/${c_num }'">계약</button>
		</div>		
	</div>
</body>
</html>
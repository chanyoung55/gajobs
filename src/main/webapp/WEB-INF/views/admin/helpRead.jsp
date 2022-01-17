<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../head.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function read(i) {
		var num = '${help.h_num}';
		
		if(i == 'y'){
			if(confirm("읽음 처리하시겠습니까?")){
				$.ajax({
					url : "${path}/admin/readChk",
					type : 'post',
					data : {
						'readchk' : i,
						'h_num' : num
					},
					success : function(data) {
						location.reload();
					}
				});	
			} else {
				return false;
			}
			
		} else if(i =='n'){
			if(confirm("안읽음 처리하시겠습니까?")){
				$.ajax({
					url : "${path}/admin/readChk",
					type : 'post',
					data : {
						'readchk' : i,
						'h_num' : num
					},
					success : function(data) {
						location.reload();
					}
				});
			}
		} else {
			return false;
		}
	}
	function del() {
		var cf = confirm("삭제 하시겠습니까?");
		if(cf){
			location.href='${path}/admin/helpDelete/pageNum/${pageNum }/h_num/${help.h_num }';
		}
	}
</script>
</head>
<body>
	<div class="container" align="center">
		<h2 class="text-primary mt-3">문의사항</h2>
		<div align="right">
			<button class="btn btn-warning btn-lg" style="float: left;" onclick="location.href='${path}/admin/adminMain/pageNum/${pageNum }'">목록</button>
			<c:if test="${help.h_read == 'n' }">
				<button class="btn btn-success btn-lg" onclick="return read('y');">읽음</button>
			</c:if>
			<c:if test="${help.h_read == 'y' }">
				<button class="btn btn-danger btn-lg" onclick="return read('n');">안읽음</button>	
			</c:if>
		</div>
		<table class="table table-bordered mt-1">
			<tr>
				<th>발송인</th>
				<td>${help.h_writer }</td>
				<th>직책</th>
				<td>${help.r_name }</td>
			</tr>
			<tr>
				<th>지점명</th>
				<td>${help.b_name }</td>
				<th>팀명</th>
				<td>${help.t_name }</td>
			</tr>
			<tr>
				<th>이메일 주소</th>
				<td>${help.m_email }</td>
				<th>전화번호</th>
				<td>${help.m_tel }</td>
			</tr>
			<tr>
				<th>발송일자</th>
				<td colspan="3">${help.h_date }</td>
			</tr>
			<tr>
				<th>제목</th>
				<td colspan="3">${help.h_title }</td>
			</tr>
		</table>
		<table class="table table-bordered">
			<tr>
				<th>내용</th>
			</tr>
			<tr>
				<td height="200">
					${help.h_content }
				</td>
			</tr>
		</table>
		<table class="table table-bordered">
			<tr>
				<th>첨부파일</th>
			</tr>
			<c:if test="${empty fileList }">
				<tr>
					<td align="center">
						첨부파일이 없습니다.
					</td>
				</tr>
			</c:if>
			<c:if test="${not empty fileList }">
				<c:forEach var="file" items="${fileList }">
					<tr>
						<td align="center">
							<a href="${path }/admin/fileDwonload/hf_seq/${file.hf_seq}">
								${file.hf_name }.${file.hf_type }
							</a>
						</td>
					</tr>
				</c:forEach>
			</c:if>
		</table>
		<button class="btn btn-danger btn-lg" onclick="del()">삭제</button>
		<button class="btn btn-primary btn-lg" onclick="location.href='${path}/admin/emailSendForm/pageNum/${pageNum }/h_num/${help.h_num }'">답장</button>
	</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../head.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">
	function update() {
		var id = "${sideNav.m_id}";
		var w_id = "${education.m_id}";
		if(id == w_id) {
			location.href="${path }/education/educationUpdateForm/pageNum/${pageNum}/e_num/${education.e_num}";
		} else {
			alert("수정할수 있는 권한이 없습니다.");
		}
		
	}
	function del() {
		var role = "${sideNav.r_code}";
		var id = "${sideNav.m_id}";
		var w_id = "${education.m_id}";
		var cf = confirm("삭제하시겠습니까?");
		if(id == w_id || role == 'c1' || role == 'c2') {
		if(cf) {
			location.href="${path }/education/educationDelete/pageNum/${pageNum}/e_num/${education.e_num}";
		} else {
			alert("삭제가 취소되었습니다.");
		}
	} else {
		alert("삭제할수 있는 권한이 없습니다.");
	}
}
	function insertComment() {
		var er_content = $('#er_content').val();
		var e_num = "${education.e_num}";
		var er_writer = "${sideNav.m_name}";
		var m_id = "${sideNav.m_id}";
		
		$.ajax({
			url : "${path}/education/educationRe",
			type : 'post',
			data:{
				'er_content' : er_content,
				'er_writer' : er_writer,
				'e_num' : e_num,
				'm_id' : m_id
			},
			success : function (data) {
				location.reload();
			}
		});
	}
	
	function deleteComment(i) {
		var cf = confirm("댓글을 정말로 삭제 하시겠습니까?");
		if(cf) {
			$.ajax({
				url : "${path}/education/educationReDelete",
				type : 'post',
				data : {
					'er_seq' : i
				},
				success : function(data) {
					location.reload();
				}
			});
		}
	}
</script>
<title>Insert title here</title>
</head>
<body>
	<div class="container" align="center">
		<h2 class="text-primary">글 읽기</h2>
		<h3 class="mt-3" align="left">제목 : ${education.e_title }</h3>
		<table class="table table-bordered">
			<tr>
				<th colspan="2">글쓴이</th>
				<td colspan="2" align="center">${education.e_writer }  ${member.r_name }님</td>
			</tr>
			<tr>
				<th>글작성일</th>
				<td align="center">${education.e_date }</td>
				<th>조회수</th>
				<td>${education.e_count }</td>
			</tr>
			<tr>
				<td colspan="4" height="200">
					${education.e_content }
				</td>
			</tr>
			<tr>
				<th colspan="4">첨부파일</th>
			</tr>
			<c:if test="${empty educationFile }">
				<tr>
					<td colspan="4" align="center">
							첨부파일이 없습니다.
					</td>
				</tr>
			</c:if>
			<c:if test="${not empty educationFile }">
				<c:forEach var="file" items="${educationFile }">
					<tr>
						<td colspan="4">
							<a href="${path }/education/educationFileDownload/ef_seq/${file.ef_seq}">${file.ef_name }.${file.ef_type }</a>
						</td>
					</tr>
				</c:forEach>
			</c:if>
		</table>
		<div style="display: flex; justify-content: space-between;">
			<a class="btn btn-danger btn-lg" onclick="del()">삭제</a>
			<a class="btn btn-success btn-lg" onclick="update()">수정</a>
		</div>
		<div>
			<a href="${path }/education/educationMain/pageNum/${pageNum}" class="btn btn-warning btn-lg">목록</a>
		</div>
		<div id="comment-view-box" class="mt-3">
			<table class="table table-bordered">
					<c:if test="${empty educationRe }">
						<tr>
							<td align="center">
								댓글이 없습니다.						
							</td>
						</tr>
					</c:if>
					<c:if test="${not empty educationRe }">
						<c:forEach var="educationRe" items="${educationRe }">
							<tr>
								<td style="height: 50px;">
									<div style="width:100%; height: 10px; line-height: 10px; font-size: 1.5rem;">
										일자 : ${educationRe.er_date } / 글쓴이 : ${educationRe.er_writer }
									</div>
									<div style="width:100%; height: 40px; line-height: 40px; font-size: 2rem; font-weight: bold;">
										${educationRe.er_content }
										<c:if test="${educationRe.m_id == sideNav.m_id }">
											<a class="btn btn-danger" onclick="deleteComment('${educationRe.er_seq}')" style="float: right; font-size: 1.6rem;">삭제</a>
										</c:if>
										<c:if test="${educationRe.m_id != sideNav.m_id }">
										</c:if>
									</div>
								</td>
							</tr>
						</c:forEach>
					</c:if>
			</table>
		</div>
		<div id="comment-write-box">
			<table class="table table-bordered">
				<tr>
					<th style="height: 40px; line-height: 40px;">댓글</th>
					<td><input type="text" style="height: 40px; line-height: 40px;" class="form-control" id="er_content"></td>
					<td><button class="btn btn-primary" style="padding:0; height: 40px; width:100%; line-height: 40px;" onclick="insertComment();">전송</button></td>
				</tr>			
			</table>
		</div>
		
	</div>
</body>
</html>
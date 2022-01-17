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
		var w_id = "${notice.m_id}";
		if(id == w_id) {
			location.href="${path }/notice/noticeUpdateForm/pageNum/${pageNum}/n_num/${notice.n_num}";
		} else {
			alert("수정할수 있는 권한이 없습니다.");
		}
		
	}
	function del() {
		var role = "${sideNav.r_code}";
		var id = "${sideNav.m_id}";
		var w_id = "${notice.m_id}";
		var cf = confirm("삭제하시겠습니까?");
		if(id == w_id || role == 'c1' || role == 'c2') {
		if(cf) {
			location.href="${path }/notice/noticeDelete/pageNum/${pageNum}/n_num/${notice.n_num}";
		} else {
			alert("삭제가 취소되었습니다.");
		}
	} else {
		alert("삭제할수 있는 권한이 없습니다.");
	}
}
	function insertComment() {
		var nr_content = $('#nr_content').val();
		var n_num = "${notice.n_num}";
		var nr_writer = "${sideNav.m_name}";
		var m_id = "${sideNav.m_id}";
		
		$.ajax({
			url : "${path}/notice/noticeRe",
			type : 'post',
			data:{
				'nr_content' : nr_content,
				'nr_writer' : nr_writer,
				'n_num' : n_num,
				'm_id' : m_id
			},
			success : function (data) {
				location.reload();
			}
		});
	}
	
	function deleteComment(nr_seq) {
		var cf = confirm("댓글을 정말로 삭제 하시겠습니까?");
		if(cf) {
			$.ajax({
				url : "${path}/notice/noticeReDelete",
				type : 'post',
				data : {
					'nr_seq' : nr_seq
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
		<h3 class="mt-3" align="left">제목 : ${notice.n_title }</h3>
		<table class="table table-bordered">
			<tr>
				<th colspan="2">글쓴이</th>
				<td colspan="2" align="center">${notice.n_writer }  ${member.r_name }님</td>
			</tr>
			<tr>
				<th>글작성일</th>
				<td align="center">${notice.n_date }</td>
				<th>조회수</th>
				<td>${notice.n_count }</td>
			</tr>
			<tr>
				<td colspan="4" height="200">
					${notice.n_content }
				</td>
			</tr>
			<tr>
				<th colspan="4">첨부파일</th>
			</tr>
			<c:if test="${empty noticeFile }">
				<tr>
					<td colspan="4" align="center">
							첨부파일이 없습니다.
					</td>
				</tr>
			</c:if>
			<c:if test="${not empty noticeFile }">
				<c:forEach var="file" items="${noticeFile }">
					<tr>
						<td colspan="4">
							<a href="${path }/notice/noticeFileDownload/nf_seq/${file.nf_seq}">${file.nf_name }.${file.nf_type }</a>
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
			<a href="${path }/notice/noticeMain/pageNum/${pageNum}" class="btn btn-warning btn-lg">목록</a>
		</div>
		<div id="comment-view-box" class="mt-3">
			<table class="table table-bordered">
					<c:if test="${empty noticeRe }">
						<tr>
							<td align="center">
								댓글이 없습니다.						
							</td>
						</tr>
					</c:if>
					<c:if test="${not empty noticeRe }">
						<c:forEach var="noticeRe" items="${noticeRe }">
							<tr>
								<td style="height: 50px;">
									<div style="width:100%; height: 10px; line-height: 10px; font-size: 1.5rem;">
										일자 : ${noticeRe.nr_date } / 글쓴이 : ${noticeRe.nr_writer }
									</div>
									<div style="width:100%; height: 40px; line-height: 40px; font-size: 2rem; font-weight: bold;">
										${noticeRe.nr_content }
										<c:if test="${noticeRe.m_id == sideNav.m_id }">
											<a class="btn btn-danger" onclick="deleteComment('${noticeRe.nr_seq}')" style="float: right; font-size: 1.6rem;">삭제</a>
										</c:if>
										<c:if test="${noticeRe.m_id != sideNav.m_id }">
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
					<td><input type="text" style="height: 40px; line-height: 40px;" class="form-control" id="nr_content"></td>
					<td><button class="btn btn-primary" style="padding:0; height: 40px; width:100%; line-height: 40px;" onclick="insertComment();">전송</button></td>
				</tr>			
			</table>
		</div>
		
	</div>
</body>
</html>
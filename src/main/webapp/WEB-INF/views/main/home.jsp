<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../head.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container" align="center" style="width: 95%;">
		<h2 class="mt-3">${sideNav.m_name }님 환영합니다.</h2>
		<div style="width: 100%; height: 50%;">
			<div class="mt-5" style="width: 50%; float: left;">
				<table class="table table-bordered mt-5" style="width: 80%;">
					<tr>
						<th colspan="2"><h3>공지사항</h3></th>
					</tr>
					<tr>
						<th width="200">최근글 수</th>
						<td align="center">${countNotice }</td>
					</tr>
					<tr>
						<th style="background: #e0e0e0;">No.</th>
						<th style="background: #e0e0e0;">제목</th>
					</tr>
					<c:if test="${empty noticeList }">
						<tr>
							<td colspan="2">최근글이 없습니다.</td>
						</tr>
					</c:if>
					<c:if test="${not empty noticeList }">
						<c:forEach var="notice" items="${noticeList }">
							<tr>
								<th>
									<c:set var="noticenum" value="${noticenum+1 }"></c:set>
									${noticenum }
								</th>
								<td align="center">
									<a href="${path }/notice/noticeRead/pageNum/1/n_num/${notice.n_num}">${notice.n_title }</a>
								</td>
							</tr>
						</c:forEach>
					</c:if>
				</table>
				<div align="right" style="width: 80%;">
					<a href="#" class="btn btn-primary btn-lg" onclick="location.href='${path}/notice/noticeMain'">게시판 이동</a>
				</div>
			</div>
			<div class="mt-5" style="width: 50%; float: right;">
				<table class="table table-bordered mt-5" style="width: 80%;">
					<tr>
						<th colspan="2"><h3>교육 게시판</h3></th>
					</tr>
					<tr>
						<th width="200">최근글 수</th>
						<td align="center">${countEdu }</td>
					</tr>
					<tr>
						<th style="background: #e0e0e0;">No.</th>
						<th style="background: #e0e0e0;">제목</th>
					</tr>
					<c:if test="${empty eduList }">
						<tr>
							<td align="center" colspan="2">최근글이 없습니다.</td>
						</tr>
					</c:if>
					<c:if test="${not empty eduList }">
						<c:forEach var="edu" items="${eduList }">
							<tr>
								<th>
									<c:set var="edunum" value="${edunum+1 }"></c:set>
									${edunum }
								</th>
								<td align="center">
									<a href="${path }/education/educationRead/pageNum/1/e_num/${edu.e_num}">${edu.e_title }</a>
								</td>
							</tr>
						</c:forEach>
					</c:if>
				</table>
				<div align="right" style="width: 80%;">
					<a href="#" class="btn btn-primary btn-lg" onclick="location.href='${path}/education/educationMain'">게시판 이동</a>
				</div>
			</div>
		</div>
		<div style="width: 100%; height: 50%;">
		<div class="mt-5" style="width: 50%; float: left;">
			<table class="table table-bordered mt-3" style="width: 80%;">
				<tr>
					<th colspan="2"><h3>서식 자료실</h3></th>
				</tr>
				<tr>
					<th width="200">최근 등록 서식</th>
					<td align="center">${countReference }</td>
				</tr>
				<tr>
					<th style="background: #e0e0e0;">No.</th>
					<th style="background: #e0e0e0;">제목</th>
				</tr>
				<c:if test="${empty refList }">
					<tr>
						<td align="center" colspan="2">최근 서식글이 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${not empty refList }">
					<c:forEach var="ref" items="${refList }">
						<tr>
							<th>
								<c:set var="refnum" value="${refnum+1 }"></c:set>
								${refnum }
							</th>
							<td align="center">
								<a href="${path }/reference/referenceRead/pageNum/1/rf_num/${ref.rf_num}">${ref.rf_title }</a>
							</td>
						</tr>
					</c:forEach>
				</c:if>
			</table>
			<div align="right" style="width: 80%;">
				<a href="#" class="btn btn-primary btn-lg" onclick="location.href='${path}/reference/referenceMain'">게시판 이동</a>
			</div>
		</div>
		<div class="mt-5" style="width: 50%; float: left;">
			<table class="table table-bordered mt-3" style="width: 80%;">
				<tr>
					<th colspan="2"><h3>고객 관리</h3></th>
				</tr>
				<tr>
					<th width="200">최근 등록 인원수</th>
					<td align="center">${countConsumer }</td>
				</tr>
				<tr>
					<th style="background: #e0e0e0;">No.</th>
					<th style="background: #e0e0e0;">이름</th>
				</tr>
				<c:if test="${empty conList }">
					<tr>
						<td align="center" colspan="2">최근 등록한 고객이 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${not empty conList }">
					<c:forEach var="con" items="${conList }">
						<tr>
							<th>
								<c:set var="connum" value="${connum+1 }"></c:set>
								${connum }
							</th>
							<td align="center">
								<a href="${path }/consumer/consumerRead/pageNum/1/c_num/${con.c_num}">${con.c_name }</a>
							</td>
						</tr>
					</c:forEach>
				</c:if>
			</table>
			<div align="right" style="width: 80%;">
				<a href="#" class="btn btn-primary btn-lg" onclick="location.href='${path}/consumer/consumerMain'">게시판 이동</a>
			</div>
		</div>
		</div>
	</div>
</body>
</html>
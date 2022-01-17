<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../head.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function del(i) {
		var cf = confirm("정말로 삭제하시겠습니까?");
		if(cf){
			location.href='${path}/consumer/contractDelete/pageNum/${pageNum }/cc_seq/'+i;
		}else{
			return false;
		}
	}
	
	function update(i) {
		location.href='${path}/consumer/contractUpdateForm/pageNum/${pageNum }/cc_seq/'+i;
	}
</script>
</head>
<body>
	<div class="container" align="center" style="width: 95%;">
		<h2 class="text-primary mt-3">고객 계약 리스트</h2>
		<div class="mt-2" align="right">
			<button class="btn btn-warning btn-lg" onclick="location.href='${path}/consumer/consumerRead/pageNum/1/c_num/${c_num}'" style="float: left;">뒤로</button>
			<button class="btn btn-primary btn-lg" onclick="location.href='${path}/consumer/contractWriteForm/c_num/${c_num }'">계약 등록</button>
		</div>
		<table class="table table-bordered mt-1" style="width: 100%;">
			<thead style="background: #e0e0e0;">
				<tr>
					<td colspan="12" align="center" style="background: #fff;">
						<span style="margin-right: 10px; font-weight: bold; font-size: 2rem;">총 보험료 : ${totalpay }원</span>
					</td>
				</tr>
				<tr>
					<th>No.</th>
					<th>회사명</th>
					<th>계약종류</th>
					<th>증권번호</th>
					<th>계약일</th>
					<th>납입시작일</th>
					<th>납입종료일</th>
					<th>보험료</th>
					<th>계약자</th>
					<th>피보험자</th>
					<th>현재 상태</th>
					<th>비고</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty conList }">
					<tr>
						<td colspan="12" align="center">등록된 계약이 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${not empty conList }">
					<c:forEach var="con" items="${conList }">
						<tr>
							<td style="vertical-align: middle;" align="center">${num }<c:set var="num" value="${num+1 }"></c:set></td>
							<td style="vertical-align: middle;" align="center">${con.cp_name}</td>
							<td style="vertical-align: middle;" align="center">${con.cc_kinds }</td>
							<td style="vertical-align: middle;" align="center">${con.cc_connum }</td>
							<td style="vertical-align: middle;" align="center">${con.cc_condate }</td>
							<td style="vertical-align: middle;" align="center">${con.cc_startdate }</td>
							<td style="vertical-align: middle;" align="center">${con.cc_enddate }</td>
							<td style="vertical-align: middle;" align="center">${con.cc_pay }</td>
							<td style="vertical-align: middle;" align="center">${con.cc_insurance }</td>
							<td style="vertical-align: middle;" align="center">${con.cc_subinsurance }</td>
							<td style="vertical-align: middle;" align="center">${con.cc_state }</td>
							<td style="vertical-align: middle;" align="center">
								<button class="btn btn-danger" onclick="del('${con.cc_seq}')">삭제</button>
								<button class="btn btn-success" onclick="update('${con.cc_seq}')">수정</button>
							</td>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
		</table>
		<div align="center">
			<ul class="pagination">
				<c:if test="${pb.startPage > pb.pagePerBlock }">
					<li>
						<a href="${path }/consumer/contractRead/pageNum/1/c_num/${consumerCon.c_num}"><span class="glyphicon glyphicon-backward"></span></a>
					</li>
					<li>
						<a href="${path }/consumer/contractRead/pageNum/${pb.startPage-1 }/c_num/${consumerCon.c_num}"><span class="glyphicon glyphicon-triangle-left"></span></a>
					</li>
				</c:if>
				<c:forEach var="i" begin="${pb.startPage }" end="${pb.endPage }">
					<c:if test="${pb.currentPage==i }">
						<li class="active">
							<a href="${path }/consumer/contractRead/pageNum/${i}/c_num/${consumerCon.c_num}">${i }</a>
						</li>
					</c:if>
					<c:if test="${pb.currentPage!=i }">
						<li>
							<a href="${path }/consumer/contractRead/pageNum/${i}/c_num/${consumerCon.c_num}">${i }</a>
						</li>
					</c:if>
				</c:forEach>
				<c:if test="${pb.endPage < pb.totalPage }">
					<li>
						<a href="${path }/consumer/contractRead/pageNum/${pb.endPage+1 }/c_num/${consumerCon.c_num}"><span class="glyphicon glyphicon-triangle-right"></span></a>
					</li>
					<li>
						<a href="${path }/consumer/contractRead/pageNum/${pb.totalPage}/c_num/${consumerCon.c_num}"><span class="glyphicon glyphicon-forward"></span></a>
					</li>
				</c:if>
			</ul>
		</div>
		
	</div>
</body>
</html>
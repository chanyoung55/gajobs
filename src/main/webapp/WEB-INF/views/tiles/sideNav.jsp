<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
<div class="title-box">
	<h2><a href="${path }/main/home">GAJOBs</a></h2>
</div>
<div class="profile-box">
	<a href="${path }/member/userUpdateForm" class="user-face-box">
		<span class="material-icons user-icon">person</span>
	</a>
	<div class="user-info-box">
		<span class="user-name">${sideNav.m_name }님</span><br>
		<span class="user-role">${sideNav.r_name }</span><br>
		<span class="user-branch">${sideNav.b_name }&nbsp&nbsp${sideNav.t_name }</span>
	</div>
</div>
<ul class="side-menu">
	<li>
		<a href="${path }/notice/noticeMain">공지사항</a>
	</li>
	<c:if test="${sideNav.r_code == 'c1' || sideNav.r_code == 'c2' || sideNav.r_code == 'b4' || sideNav.r_code == 'b3' }">
		<li>
			<a href="${path }/member/memberMain">인사 관리</a>
		</li>
	</c:if>
	<li>
		<a href="${path }/consumer/consumerMain">고객 관리</a>
	</li>
	<c:if test="${sideNav.r_code == 'c1' || sideNav.r_code == 'c2' || sideNav.r_code == 'b4' || sideNav.r_code == 'b3' || sideNav.r_code == 'b2' }">
		<li>
			<a href="${path }/bond/bondMain">채권 관리</a>
		</li>
	</c:if>
	<li><a href="${path }/reference/referenceMain">서식 자료실</a></li>
	<li><a href="${path }/education/educationMain">교육 게시판</a></li>
	<c:if test="${sideNav.r_code == 'c2' }">
		<li class="admin-menu">
			<a href="${path }/admin/adminMain">관리자</a>
		</li>
	</c:if>
</ul>
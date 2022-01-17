<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
<div class="btn-box">
	<span id="navbutton" class="material-icons hambuger">menu</span>
</div>
<ul class="header-menu">
  <li><a href="${path}/notiles/logout"><i class="material-icons">logout</i><span>로그아웃</span></a></li>
  <li><a href="${path}/help/helpSend"><i class="material-icons">email</i><span>문의사항</span></a></li>
</ul>



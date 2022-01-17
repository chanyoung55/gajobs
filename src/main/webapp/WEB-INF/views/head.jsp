<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
caption {
	font-size: 30px;
}
.err {
	color : red; 
	font-weight: bold;
}
thead th {
	text-align: center;
}
th {
	text-align: center;
}
#summernote {
	text-align: right;
}
</style>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
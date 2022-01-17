<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GAJOBs</title>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/loginForm.css">
</head>
<body>
<div class="login-box">
	<div class="left-box" align="left">
		<div class="title-box">
			<h1>GA JOB's</h1>
		</div>
		<div class="image-box">
			<img src="${path }/resources/images/login.svg">
		</div>
	</div>
	<form action="login" method="post">
	<div class="right-box" align="right">
		<div class="title-box login-title">
			<h2>LOGIN</h2>		
		</div>
		<div class="input-box">
			<input type="text" name="m_id" placeholder="ID" required="required" autofocus="autofocus">
			<input type="password" name="m_password" placeholder="PASSWORD" required="required">
		</div>
		<div class="btn-box">
			<input type="submit" value="로그인">
		</div>
	</div>
	</form>
</div>
</body>
</html>
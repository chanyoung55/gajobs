<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ include file="../header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
	$(function() {
		$('#navbutton').click(function() {
			if($('#sideNav').width() == 200){
				$('#sideNav').css('width','0px');
				$('#headerNav').css('padding-left','0px');
				$('#content').css('padding-left','0px');
				$('.user-info-box').css('display','none');
				$('.side-menu').css('display','none');
			} else {
				$('#sideNav').css('width','200px');
				$('#headerNav').css('padding-left','200px');
				$('#content').css('padding-left','200px');
				$('.user-info-box').css('display','block');
				$('.side-menu').css('display','block');
			}
		});
	});
</script>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" type="text/css" href="${path }/resources/css/tilesLayout.css">
<link rel="stylesheet" type="text/css" href="${path }/resources/css/common.css">
<title>Insert title here</title>
</head>
<body>
	<div id="sideNav">
		<tiles:insertAttribute name="sideNav"/>
	</div>
	<div id="headerNav">
		<tiles:insertAttribute name="headerNav"/>
	</div>
	<div id="content">
		<tiles:insertAttribute name="content"/>
	</div>
</body>
</html> 
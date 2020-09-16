<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/healthproject/resources/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#signupbtn").on("click", function() {
			location.href="/healthproject/signup";
		});
	});
</script>
</head>
<body>
	
	<h3>로그인</h3>

	<form action="/healthproject/signin" method="post">
		ID : <input type="text" id="id"	name="id"> <br> 
		PW : <input type="password" id="password" name="password"> <br>
		<input id="signinbtn" type="submit" value="로그인">
		<input id="signupbtn" type="button" value="회원가입">
	</form>
</body>
</html>
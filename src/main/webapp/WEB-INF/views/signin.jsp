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
	
	<!--<c:choose>
    <c:when test="${sessionScope.loginCheck eq true}">
        ${sessionScope.id} 님이 로그인 되었습니다.  
        <button type="submit">로그아웃</button>
    </c:when>
    
    <c:otherwise>
        <form id="loginForm">
            <input name="id"/>
            <input name="pw"/>
            <button type="submit">로그인</button>
        </form>
    </c:otherwise>
	</c:choose>-->

	<form action="/healthproject/signin" method="post">
		ID : <input type="text" id="id"	name="id"> <br> 
		PW : <input type="password" id="password" name="password"> <br>
		<input id="signinbtn" type="submit" value="로그인">
		<input id="signupbtn" type="button" value="회원가입">
	</form>
</body>
</html>
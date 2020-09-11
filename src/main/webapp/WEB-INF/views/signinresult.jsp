<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/healthproject/resources/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#signoutbtn").on("click", function() {
			location.href="/healthproject/signout"
		});
	}) // $(document).ready(function() end
</script>
</head>
<body>
	<h1>로그인 결과</h1>
	<h3>사용자가 입력한 아이디 :${ param.id }</h3>
	<h3>사용자가 입력한 암호 :${ param.password }</h3>
	<h3>profile path :${ filepath }</h3>
	<h3>PROFILE</h3>
	<img alt="my profile" src="/img/${ filepath }">
	<input id='signoutbtn' type=button value='로그아웃'>
</body>
</html>
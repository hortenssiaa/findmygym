<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign Up Page</title>
<script src="/healthproject/resources/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#signinbtn").on("click", function() {
			location.href="/healthproject/signin/"
		});
	})
</script>
</head>
<body>
	<h3>회원가입</h3>
	
	<form action="<%=request.getContextPath() %>/signup" method="post" enctype="multipart/form-data" >
		이름 : <input type="text" name="name"> <br>
		ID : <input type="text" name="id"> <br>
		PW : <input type="password" name="password"> <br> <!-- 반드시 db? vo? 랑 같은 이름으로 할것 !! 알아보기 password -->
		email : <input type="email" name="email"> <br>
		프로필 사진 <input type="file" name="file"> <Br>
		<input type="submit" value="회원가입" >
		<button id="signinbtn" type="button" >로그인</button>
	</form>
</body>
</html>
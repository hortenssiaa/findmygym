<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/healthproject/resources/jquery-3.2.1.min.js"></script>
</head>
<body>
	<div id="signinform">
	<% 
		if(session.getAttribute("loginCheck") != null) { 
			 System.out.print("(insertmemberinfo.jsp) session connected:");
			 System.out.println(session.getAttribute("loginid"));
			 
			 String loginid = (String) session.getAttribute("loginid");
	%>
		
		<script>
		(function signinbtn() {
				$.ajax({
					url : '/healthproject/memberinfo', 
/* 					data : { 'id':'test'}, */
 					data : { 'id':'test', 'password':'test'}, 
					type : 'POST',
					error : function(){
		                alert('insertmemberinfo JSON 통신실패!!');
		            },

					dataType : 'json',
					success : function (serverdata) {
						$("#signinform").html
						(
						"<h3>" + serverdata.name + "님("
						+ serverdata.id + ") 로그인상태입니다. </h3><br>"
						+ "<img alt='my profile' src='/img/" + serverdata.filepath + "'> <br>"
						+ "<input id='signoutbtn' type=button value='로그아웃'> "
						+ "<input type='button' id='gotowriteform' value='글쓰기'>"
						); // memberinf로 mapping된 getMemberInfo()에서 리턴되는 값 : vo == serverdata
						
						$("#signoutbtn").on("click", function() {
							location.href="/healthproject/signout"
						});
						
						$("#gotowriteform").on("click", function() {
							location.href="/healthproject/writeform/"
						});
					}
				});
			})(); // function signinbtn() end
		</script>
		
	<% } else { %>
		로그인
		ID : <input type="text" id="id"	name="id"> 
		PW : <input type="password" id="password" name="password">
		<input id="signinbtn" type="button" value="로그인">
		<input id="signupbtn" type="button" value="회원가입">
		<input type="button" id="gotowriteform" value="글쓰기">
		
		<script>
			$("#gotowriteform").on("click", function() {
				alert("로그인 먼저 해주세요.");
			});
		</script>
	<% } %>
	</div>
</body>
</html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<meta charset="UTF-8">
	<title>Home</title>
<style type="text/css">
	.profile_box {
		width: 150px;
    	height: 150px; 
    	border-radius: 70%;
    	overflow: hidden;
    	/* position: absolute; */
	}
	
	.profile_pic {
		width: 100%;
   		height: 100%;
   		object-fit: cover;
   		
	}
</style>	
<script src="/healthproject/resources/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#signupbtn").on("click", function() {
			location.href="/healthproject/signup/"
		});		
		
 		$("#signinbtn").on("click", function() {
			$.ajax({
				url : '/healthproject/memberinfo', 
				data : { 'id':$('#id').val(), 'password':$('#password').val()},
				type : 'POST',
				
				
				dataType : 'json',
				success : function (serverdata) {
					$("#signinform").html
//					$("#signinstatus").html
					(
					serverdata.name + "님("
					+ serverdata.id + ") 환영합니다. <br>"
					+ "<img alt='my profile' src='/img/" + serverdata.filepath + "'> <br>"
					+ "<input id='signoutbtn' type=button value='로그아웃'>"
					); // memberinf로 mapping된 getMemberInfo()에서 리턴되는 값 : vo == serverdata
					
					$("#signoutbtn").on("click", function() {
						location.href="/healthproject/signout"
					});
				}
			}); // $.ajax 완료 
			//$("#signinform").hide();
			
		}); // $("#signinbtn").on("click", function() end 
	}) // $(document).ready(function() end
	
</script>
</head>
<body>
	<h1>
		Home
	</h1>
	
	<!-- <P>  The time on the server is ${serverTime}. </P> -->
	
	<div id="signinform">
		<jsp:include page="included_memberinfo.jsp"></jsp:include>
	</div>
	
</body>
</html>


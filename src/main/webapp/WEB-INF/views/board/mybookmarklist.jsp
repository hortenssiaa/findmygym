<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Bookmark List</title>
<style type="text/css">
	html {
		background-color: #FAFAFA;
	}
	
	h1 {
		margin-top: 60px;
		text-align: center;
	}
	
	hr {
		margin-bottom: 60px;
		max-width: 500px;
	}
	
	.board_photo {
		width: auto; height: auto;
    	max-width: 350px;
    	max-height: 350px;
    	align-content: center;
	}
	
	.board_pic {
		text-align: center;
	}
	
	table {
		width: 34%;
		border-collapse: collapse;
		border: 1px solid #D7D7D7;
		background-color: #FFFFFF;
	}
	
	th, td {
	  padding: 8px;
	  text-align: left;
	  border-bottom: 1px solid #ddd;
	}
	
	tr:hover {
		background-color: #f5f5f5;
	}
	
	#id_style {
		font-weight: bold;
	}
	
</style>
</head>
<body>
	<%
		String loginid = "";
		if(session.getAttribute("loginCheck") != null) {
			loginid = (String) session.getAttribute("loginid");
			System.out.printf("loginid: %s",loginid);
		} else
			loginid = "notsignedinnull";
	%>
	
	<h1> <%=loginid%>님의 북마크</h1>
	<hr>
	
	<div class="list_container">
		<c:set var="listsize" value="${fn:length(boardlist)}" /> <!--  역순 -->
			<c:forEach var="i" begin="1" end="${listsize}"> 
			 	<table align="center">
					<tr>
						<td> 
							<div id="id_style">
								${boardlist[listsize-i].id } 
							</div>
						</td>
					</tr>
					<tr>
						<td> ${boardlist[listsize-i].location } </td>
					</tr>
					<tr>
						<td> 
							<div class="board_pic">
								<img class="board_photo" alt="board pic" src="/img/${boardlist[listsize-i].filepath }">  
							</div>
						</td>
					</tr>
					<tr>
						<td> ${boardlist[listsize-i].caption } </td>
					</tr>
				</table>	
			<br> <br> <br>
		</c:forEach>
	</div>
</body>
</html>
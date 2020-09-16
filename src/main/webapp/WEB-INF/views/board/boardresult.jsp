<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/healthproject/resources/jquery-3.2.1.min.js"></script>
<script>
	$(document).ready(function() {
		$("#boardlist").on('click', function() {
			location.href="/healthproject/boardlist"
		});

		$("#gohome").on('click', function() {
			location.href="/healthproject/"
		});
	}
</script>
</head>
<body>
		
	<%	String loginid = (String) session.getAttribute("loginid");  %>
	
	<table border="1px" align='center'>
		<tr>
			<th> 작성자 ID </th>
			<td> java : <%=loginid %> </td>
			<td> db : ${boardvo.id } </td>
		</tr>
		<tr>
			<th> 작성 위치 </th>
			<td> ${boardvo.location } </td>
		</tr>
		<tr>
			<th> 업로드 파일 보기 </th>
			<td> <img alt="uploaded file" src="/img/boardfile/${boardvo.filepath }"> </td>
		</tr>
		<tr>
			<th> 작성 내용 </th>
			<td> ${boardvo.caption } </td>
		</tr>
	</table>
	<input id="boardlist" class="btns" type="button" value="글목록">
	<input id="gohome" class="btns" type="button" value="홈">
	
</body>
</html>
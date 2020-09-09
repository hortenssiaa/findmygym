<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table border="3px">
		<tr>
			<td> ID </td>
			<td> ${vo.name } </td>
		</tr>
		<tr>
			<td> EMAIL </td>
			<td> ${vo.email } </td>
		</tr>
		<tr>
			<td> PROFILE </td>
			<td> <img alt="my profile" 
					src="/img/${vo.file.originalFilename }"> 
			</td>
		</tr>
	</table>

	<!--  <h3>서버로 업로드한 파일은 다음과 같습니다.</h3>
	<h3>파일1 : ${vo.file.originalFilename }</h3>
	<h3>/Users/Sohnhakyung/Desktop/fileupload/ 폴더를 확인하세요.</h3>-->
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>게시물 작성하기</h3>
	<form action="">
		이름 :
		위치선택하기
		<input type="file" name="file">
		<div id="fileplace">
			이곳에 사진이 보여집니다. 
		</div>
		<textarea id="caption" rows="5" cols="25"
					placeholder="내용을 입력해주세요..." value=""></textarea>
		<input type="button" value="게시">
	</form>
</body>
</html>
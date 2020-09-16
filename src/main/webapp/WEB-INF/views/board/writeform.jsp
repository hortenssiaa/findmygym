<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewpoint" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>Board Writeform</title>

<script src="/healthproject/resources/jquery-3.2.1.min.js"></script>
<script>
	var sel_files = [];

	$(document).ready(function() {
		$("#file").on("change", showfiles);
		
		var captions = $("#caption").val();
		captions = captions.replace(/(?:\r\n|\r|\n)/g, '<br />');
		$("#caption").html(captions);
	});

	function showfiles(e) {
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);

		filesArr.forEach(function(f) {
			if (!f.type.match("image.*")) {
				alert("확장자는 이미지 확장자만 가능합니다.");
				return;
			}

			sel_files.push(f);

			var reader = new FileReader();
			reader.onload = function(e) {
				var img_html = "<img src=\"" + e.target.result + "\" />";
				$("#fileplace").append(img_html);
			};

			reader.readAsDataURL(f);
			
			$("#filepath").val($("#file").get(0).files[0].name); 
		});
	}
</script>
</head>
<body>

	<%
		if (session.getAttribute("loginCheck") != null) {
			String loginid = (String) session.getAttribute("loginid");
	%>
	
	<h3 align='center'>게시물 작성하기</h3>
	<div id="boardform" align="center">
		
		<form action="<%=request.getContextPath() %>/writeform" method="post" enctype="multipart/form-data">
			작성자 :<%=loginid%> <br> 
			위치선택하기 <input type="text" name="location"> <br> 
			올릴 사진 선택하기 
			<input id="file" type="file" name="file" multiple />
<!-- 			<input id="file" type="file" name="file" accept="image/*" multiple /> -->
			
			<input type="hidden" id="filepath" name="filepath" value="">
			
			<div id="fileplace"></div>
			
			
			<textarea id="caption" rows="5" cols="45" placeholder="내용을 입력해주세요..."
				value="" name="caption"></textarea>
			<input type="hidden" id="id" name="id" value="<%= loginid%>">
				
			<input type="submit" value="게시">
		</form>
	</div>

	<%
		} else {
	%>
	<script>
		alert("로그인을 해주세요.");
		(function() {
			location.href = "/healthproject/signin/"
		})();
	</script>
	<%
		}
	%>
</body>
</html>
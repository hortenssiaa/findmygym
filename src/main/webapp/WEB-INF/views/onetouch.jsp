<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공원, 산, 강, 화장실 정보</title>
<style type="text/css">
html {
	margin-top: 3%;
	margin-left: 10%;
	margin-right: 10%;
	font-size: 16px;
}

ul {
    list-style-type: none;
    margin: 0;
    padding: 0;
    overflow: hidden;
    background-color: #ffb300;
}

li {
    float: left;
    display: block;
    color: white;
    text-align: center;
    padding: 14px 16px;
    text-decoration: none;
}

/* Change the link color to #111 (black) on hover */
li:hover {
    background-color: #c68400;
}

#show_here {
	margin-top: 10px;
}
</style>
<script src="/healthproject/resources/jquery-3.2.1.min.js"></script>
<script type="text/javascript">

	$(document).ready(function() {
		$('#toilet').on('click', function() {
			$("#show_here").load("/healthproject/toilet");
		});

		$('#park').on('click', function() {
			$("#show_here").load("/healthproject/park");
		});
		
		$('#river').on('click', function() {
			$("#show_here").load("/healthproject/river");
		});
	});
</script>
</head>
<body>
	<ul>
		<li id='park'>공원</li>
		<li id='river'>강/탄천</li>
		<li id='toilet'>공중 화장실</li>
		<li id='fitness'>공공 운동기구</li>
		<li id='bicycle'>자전거</li>
		<li id='mount'>산</li>
	</ul>
	
	<div id="show_here">
		카테고리를 클릭하면 이곳에 결과가 보여집니다. 
	</div>
</body>
</html>
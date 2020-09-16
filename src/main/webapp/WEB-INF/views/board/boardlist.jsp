<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.board_photo {
		width: auto; height: auto;
    	max-width: 500px;
    	max-height: 500px;
    	align-content: center;
	}
	
	.board_pic {
		text-align: center;
	}
	
	table {
		width: 34%;
		border-collapse: collapse;
	}
	
	th, td {
	  padding: 8px;
	  text-align: left;
	  border-bottom: 1px solid #ddd;
	}
	
	tr:hover {
		background-color: #f5f5f5;
	}
	
	.likes_pic {
    	width: 25px;
    	height: 25px;
	}
	
	.likes_container {
		margin-left: 5px;
	}
	
</style>
<script src="/healthproject/resources/jquery-3.2.1.min.js"></script>
<script>
	$(document).ready(function() {
		var likes_arr = $(".likes_pic").get();
		
		var blackbtn = "./resources/likebtnblack.png";
		var redbtn = "./resources/likebtnred.png";
		
		for(var i=0; i < likes_arr.length; i++) {
			//alert("likes_arr["+i+"] :"+$(likes_arr[i]).attr('src'))
			var l_array = [$(likes_arr[i]).attr('src')];
			if(i>0) {
				l_array.concat([$(likes_arr[i]).attr('src')]);
			}
		}
		/* for(var i=0; i < likes_arr.length; i++) {
			alert("l_array["+i+"]: "+[$(likes_arr[i]).attr('src')]);
		} // likes_arr 배열 확인하기 */ 
		
		/* $(".board_photo").on('click', function(e) { 
			alert($(e.target).attr('src'));
		}); // board_photo event 요소 갖고오기  */
		
		$(".likes_pic").on('click', function(e) {
			//alert($(e.target).attr('src'));
			if ($(e.target).attr('src') == blackbtn) {
				$(e.target).attr('src', './resources/likebtnred.png');
			} else if ( $(e.target).attr('src') == redbtn ) {
				$(e.target).attr('src', './resources/likebtnblack.png');
			}
		}); // likes_pic event 요소 갖고오기 
		
	})
</script>
</head>
<body>
	<c:set var="listsize" value="${fn:length(boardlist)}" /> <!--  역순 -->
		<c:forEach var="i" begin="1" end="${listsize}"> 
		 	<table align="center">
				<tr>
					<td> ${boardlist[listsize-i].id } </td>
				</tr>
				<tr>
					<td> ${boardlist[listsize-i].location } </td>
				</tr>
				<tr>
					<td> 
						<p class="board_pic">
							<img class="board_photo" alt="board pic" src="/img/${boardlist[listsize-i].filepath }">  
						</p>
					</td>
				</tr>
				<tr>
					<td> 
						<div class="likes_container">
							<img class="likes_pic" alt="board pic" src="./resources/likebtnblack.png">  
							Likes : ${boardlist[listsize-i].likes } 
						</div>
					</td>
				</tr>
				<tr>
					<td> ${boardlist[listsize-i].caption } </td>
				</tr>
			</table>
	
	<!-- [0]부터 보여주기 -->	
	<%-- <c:forEach items="${boardlist }" var="vo"> --%>
<%-- 	 	<table align="center">
			<tr>
				<td> ${vo.id } </td>
			</tr>
			<tr>
				<td> ${vo.location } </td>
			</tr>
			<tr>
				<td> 
					<p class="board_pic">
						<img class="board_photo" alt="board pic" src="/img/${vo.filepath }">  
					</p>
				</td>
			</tr>
			<tr>
				<td> 
					<div class="likes_container">
						<img class="likes_pic" alt="board pic" src="./resources/likebtnblack.png">  
						Likes : ${vo.likes } 
					</div>
				</td>
			</tr>
			<tr>
				<td> ${vo.caption } </td>
			</tr>
		</table> --%>
		
		
		<br> <br> <br>
	</c:forEach>
</body>
</html>
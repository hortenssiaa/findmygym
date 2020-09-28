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

	#bookmark_pic {
    	width: 25px;
    	height: 25px;
	}
	
	#id_style {
		font-weight: bold;
	}
	
	#likes_num {
		width: 100px;
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
		
 	<%
		if(session.getAttribute("loginCheck") != null) { // 로그인 돼 있을 때 
	%> 
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
						seq:${boardlist[listsize-i].seq } 
					</td> 
				</tr>
				<tr>
					<td> 
						<div class="board_pic">
							<img class="board_photo" alt="board pic" src="/img/${boardlist[listsize-i].filepath }">  
						</div>
					</td>
				</tr>
				<tr>
					<td> 
						<div class="likes_container">
							<p>
								<img class="likes_pic" alt="board pic" src="./resources/likebtnblack.png">
							</p>
							<div class="likes_pic" id="likes_num">
								Likes:${boardlist[listsize-i].likes } 
							</div>
							<input type="hidden" class="likes_pic" id="likes_hidden" value="here">
							<input type="hidden" class="likes_pic" id="seq_hidden" value="${boardlist[listsize-i].seq }">
						</div>
						<div class="bookmark_container">
							<img id="bookmark_pic" alt="bookmark pic" src="./resources/bookmark.png">
							<input type="hidden" class="bookmark_container" id="bm_hidden" value="bmhere">
							<input type="hidden" class="bookmark_container" id="bm_seq_hidden" value="${boardlist[listsize-i].seq }">
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
 	<%
		} else { // 로그인 안돼 있을 때 
	%> 
	
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
					<td> seq:${boardlist[listsize-i].seq } </td>
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
							<img class="likes_pic" id="like_img" alt="board pic" src="./resources/likebtnblack.png">  
							<div class="likes_pic" id="likes_num">
								Likes:${boardlist[listsize-i].likes } 
							</div>
							<input type="hidden" class="likes_pic" id="likes_hidden" value="here">
							<input type="hidden" class="likes_pic" id="seq_hidden" value="${boardlist[listsize-i].seq }">
						</div>
					</td>
				</tr>
				<tr>
					<td> ${boardlist[listsize-i].caption } </td>
				</tr>
			</table>
			<br> <br> <br>
	</c:forEach>
	<%
		}
	%>
	
<script src="/healthproject/resources/jquery-3.2.1.min.js"></script>
<script>
	$(document).ready(function() {
		var likes_arr = $(".likes_pic").get();
		
		var blackbtn = "./resources/likebtnblack.png";
		var redbtn = "./resources/likebtnred.png";
		var bm_blackbtn = "./resources/bookmarkblack.png";
		var bm_btn = "./resources/bookmark.png";
		
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
		
		var loginid = '<%=loginid %>';
		var likes_status;
		var bm_status;
		var total_list = ${fn:length(boardlist)};
 
		if( !(loginid == "notsignedinnull")) { // 로그인 되어 있으면, 
			
			// 좋아요 표시했던 게시물 갖고오기 
			$.ajax({ 
				url : '/healthproject/getlikeddata', 
				type : 'POST',

				dataType : 'json',
				success : function (serverdata) {
					var k=0
			        $('p').each(function() {
			          $(this).addClass('sseq' + k);
			          k += 1;
			        }); 
					
//					for(var i=0; i<total_list; i++) {
					for(var i=0; i<serverdata.length; i++) {
						var server_seq = new Array();
						
						// 아래, hboard seq 정리시; server_seq[i] = 11 - serverdata[i].seq; 사용할 것!
						if(serverdata[i].seq < 3)
							server_seq[i] = 8 - serverdata[i].seq;
						else	
							server_seq[i] = 11 - serverdata[i].seq;
						//alert(server_seq[i]);
						//alert($('.sseq' + server_seq[i]).next().next().next().val());
						$('.sseq' + server_seq[i]).children().attr('src', './resources/likebtnred.png');
					}
				}
			}); // get liked article_ $.ajax 완료  

			// 북마크 표시했던 게시물 갖고오기 
			$.ajax({  
				url : '/healthproject/getbookmarkdata', 
				type : 'POST',

				dataType : 'json',
				success : function (serverdata) {
					var k=0
			        $('.bookmark_container img').each(function() {
			          $(this).addClass('bmseq' + k);
			          k += 1;
			        }); 
					
//					for(var i=0; i<total_list; i++) {
					for(var i=0; i<serverdata.length; i++) {
						var server_bm_seq = new Array();
						
						// 아래, hboard seq 정리시; server_seq[i] = 11 - serverdata[i].seq; 사용할 것!
						if(serverdata[i].seq < 3)
							server_bm_seq[i] = 8 - serverdata[i].seq;
						else	
							server_bm_seq[i] = 11 - serverdata[i].seq;
						$('.bmseq' + server_bm_seq[i]).attr('src', './resources/bookmarkblack.png');
					}
				}
			}); // get bookmarked article_ $.ajax 완료  
		}
		
		// #1 img.likes_pic
 		$("img.likes_pic").on('click', function(e) {
 		
			if( !(loginid == "notsignedinnull")) { // 로그인 되어 있으면
		
				//alert($(e.target).attr('src'));
				if ($(e.target).attr('src') == blackbtn) {
					
					$(e.target).attr('src', './resources/likebtnred.png');
					$(e.target).parent().next().next().val("1"); // img 아래 hidden 
					//alert("seq: "+$(e.target).next().next().next().val()); // hidden seq
					//alert( "hidden value: " + $(e.target).next().val() ); // hidden, id:likes_hidden
					//alert($('.likes_pic').next().val());
					
					likes_status = $(e.target).parent().next().next().val();
				} else if ( $(e.target).attr('src') == redbtn ) {
					$(e.target).attr('src', './resources/likebtnblack.png');
					$(e.target).parent().next().next().val("0"); // img 아래 hidden 
					
					likes_status = $(e.target).parent().next().next().val();
				}	
					
				$.ajax({
					url : '/healthproject/likesprocess', 
					data : { 'likes':likes_status, 'seq': $(e.target).parent().next().next().next().val(), 'id':loginid },
					type : 'POST',

					dataType : 'json',
					success : function (serverdata) {
						//alert("likes container:"+$(e.target).next().html());
						$(e.target).parent().next().html
//						$("#likes_num").html
						(
						"Likes : " + serverdata.likes
						); 
					}
				}); // add likes _ $.ajax 완료  
				
			} else { // 로그인 안되어 있을 때 
				alert("로그인 먼저 해주세요.");
				location.href="/healthproject/signin";
			}

		}); // likes_pic event 요소 갖고오기  ($("img.likes_pic") on('click') 완료 )

		
		// #2 img#bookmark_pic
		$("img#bookmark_pic").on('click', function(e) {
 		
			if( !(loginid == "notsignedinnull")) { // 로그인 되어 있으면
		
				//alert($(e.target).attr('src'));
				if ($(e.target).attr('src') == bm_btn) {
					
					$(e.target).attr('src', './resources/bookmarkblack.png');
					$(e.target).next().val("1"); // img 아래 hidden 
					//alert("seq: "+$(e.target).next().next().next().val()); // hidden seq
					//alert( "hidden value: " + $(e.target).next().val() ); // hidden, id:likes_hidden
					
					bm_status = $(e.target).next().val();
					//alert("bm_status:"+bm_status);
					//alert($('.likes_pic').next().val());
				} else if ( $(e.target).attr('src') == bm_blackbtn ) {
					$(e.target).attr('src', './resources/bookmark.png');
					$(e.target).next().val("0"); // img 아래 hidden 
					
					bm_status = $(e.target).next().val();
					//alert("bm_status:" + bm_status);
				}	
					
				$.ajax({
					url : '/healthproject/bookmarkprocess', 
					data : { 'bm_status':bm_status, 'seq': $(e.target).next().next().val(), 'id':loginid },
					type : 'POST',

					dataType : 'json',
					/* success : function (serverdata) {
						alert("bookmarkprocess ajax suceed!");
					} */
				}); // add likes _ $.ajax 완료  
				
			} else { // 로그인 안되어 있을 때 
				alert("로그인 먼저 해주세요.");
				location.href="/healthproject/signin";
			}

		}); // bookmark_pic event 요소 갖고오기  ($("img#bookmark_pic") on('click') 완료 )
		
	})
</script>
</body>
</html>
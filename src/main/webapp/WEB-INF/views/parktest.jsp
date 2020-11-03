<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
 <style>
 
 	body {
  font-family: "Lato", sans-serif;
}

.sidebar {
  height: 100%;
  width: 0;
  position: fixed;
  z-index: 1;
  top: 0;
  left: 0;
  background-color: #B9CFFD;
/*   background-color: #56BCB7; */
  overflow-x: hidden;
  transition: 0.5s;
  padding-top: 60px;
}

.sidebar a {
  padding: 8px 8px 8px 32px;
  text-decoration: none;
  font-size: 25px;
  color: #818181;
  display: block;
  transition: 0.3s;
}

.sidebar a:hover {
  color: #f1f1f1;
}

.sidebar .closebtn {
  position: absolute;
  top: 0;
  right: 25px;
  font-size: 36px;
  margin-left: 50px;
}

.openbtn {
  font-size: 20px;
  cursor: pointer;
  background-color: #111;
  color: white;
  padding: 10px 15px;
  border: none;
}

.openbtn:hover {
  background-color: #444;
}

#main {
  transition: margin-left .5s;
  padding: 16px;
}

/* On smaller screens, where height is less than 450px, change the style of the sidenav (less padding and a smaller font size) */
@media screen and (max-height: 450px) {
  .sidebar {padding-top: 15px;}
  .sidebar a {font-size: 18px;}
}

    .wrap {margin-left:10%; margin-bottom:3%; left: 0;bottom: 40px;width: 288px;height: 132px;text-align: left;overflow: hidden;font-size: 12px;font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;line-height: 1.5;}
/*     .wrap {position: absolute;left: 0;bottom: 40px;width: 288px;height: 132px;margin-left: -144px;text-align: left;overflow: hidden;font-size: 12px;font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;line-height: 1.5;} */
    .wrap * {padding: 0;margin: 0;}
    .wrap .info {width: 286px;height: 120px;border-radius: 6px;border-bottom: 1px solid #000000;border-left: 1px solid #000000;border-right: 1px solid #000000;overflow: hidden;background: #fff;}
/*     .wrap .info {width: 286px;height: 120px;border-radius: 1px;border-bottom: 2px solid #ccc;border-right: 1px solid #ccc;overflow: hidden;background: #fff;} */
    .wrap .info:nth-child(1) {border: 0;box-shadow: 0px 1px 1px #888;}
/*     .wrap .info:nth-child(1) {border: 0;box-shadow: 0px 1px 1px #888;} */
    .info .title {padding: 5px 0 0 10px;height: 30px;background: #716CF0;color:#fff; border-bottom: 1px solid #ddd;font-size: 18px;font-weight: bold;}
/*     .info .title {padding: 5px 0 0 10px;height: 30px;background: #fff;border-bottom: 1px solid #ddd;border-top: 1px solid #000000;border-left: 1px solid #000000;border-right: 1px solid #000000;font-size: 18px;font-weight: bold;} */
    .info .close {position: absolute;top: 18px;left: 258px;color: #888;width: 17px;height: 17px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');}
    .info .close:hover {cursor: pointer;}
    .info .body {position: relative;overflow: hidden;}
    .info .desc {position: relative;margin: 13px 0 0 90px;height: 75px;}
    .desc .ellipsis {width:180px; overflow: hidden;text-overflow: ellipsis;white-space: nowrap;}
    .desc .jibun {font-size: 11px;color: #888;margin-top: -2px;}
    .info .img {position: absolute;top: 6px;left: 5px;width: 73px;height: 71px;border: 1px solid #ddd;color: #888;overflow: hidden;}
    /* .info:after {content: '';position: absolute;margin-left: -12px;left: 50%;bottom: 0;width: 22px;height: 12px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')} */
    .info img {margin: 5px;}
    .info .link {color: #5085BB;}
</style>
<script src="/healthproject/resources/jquery-3.2.1.min.js"></script>
<script>
	$(document).ready(function() {
			
				$.ajax({
					url : '/healthproject/river/riverinfo',
					data : {'townname': '강남구'},
					type: 'post',
					
					dataType: 'json',
					success: function(details) {
						$("#div").empty();
						
						for(var i=0; i<details.length; i++) {
							var table;
							
							if(details[i].pk_addr == null)
								details[i].pk_addr = "";
							
							if(details[i].pk_tel == null)
								details[i].pk_tel = "";

							table = '<div class="wrap"> <div class="info"> '
									+ '<div class="title">' + details[i].pk_name + '</div> '
									+ '<div class="body"> <div class="img">'
									+ '<img src="./resources/bike.png" width="63" height="60"> </div> '
/* 									+ '<img src="./resources/bike.png" width="73" height="70"> </div> ' */
									+ '<div class="desc">'
									+ '<div class="ellipsis">' + details[i].pk_addr + '</div>'
									+ '<div class="jibun ellipsis">' + details[i].pk_tel + '</div>'
									+ '</div> </div> </div> </div>';
									
/* 									+ '<div> <a href="https://www.kakaocorp.com/main" target="_blank" class="link">홈페이지</a>' 
									+ '<div class="close" onclick="closeOverlay()" title="닫기">'  */
									
							$("#div").append(table);
						}
					}
				});
	});
	
</script>
</head>
<body>

		
	<div id="mySidebar" class="sidebar">
	  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">×</a>
	<div id="div"></div>
<!-- 	  <a href="#">About</a>
	  <a href="#">Services</a>
	  <a href="#">Clients</a>
	  <a href="#">Contact</a> -->
	</div>
	
	<div id="main">
	  <button class="openbtn" onclick="openNav()">☰ Open Sidebar</button>  
	  <h2>Collapsed Sidebar</h2>
	  <p>Click on the hamburger menu/bar icon to open the sidebar, and push this content to the right.</p>
	</div>
	
	<script>
	(openNav());
		
	function openNav() {
	  document.getElementById("mySidebar").style.width = "380px";
	  document.getElementById("main").style.marginLeft = "380px";
	}
	
	function closeNav() {
	  document.getElementById("mySidebar").style.width = "0";
	  document.getElementById("main").style.marginLeft= "0";
	}
	</script>

	
<!-- <script>
	$(document).ready(function() {
			
				$.ajax({
					url : '/healthproject/park/parkinfo',
					data : {'townname': '서울특별시 강남구'},
					type: 'post',
					
					dataType: 'json',
					success: function(details) {
						$("#div").empty();
						
						for(var i=0; i<details.length; i++) {
							var table;
							
							if(details[i].pk_addr == null)
								details[i].pk_addr = "";
							
							if(details[i].pk_tel == null)
								details[i].pk_tel = "";

							table = '<div class="wrap"> <div class="info"> '
									+ '<div class="title">' + details[i].pk_name + '</div> '
									+ '<div class="body"> <div class="img">'
									+ '<img src="./resources/bike.png" width="63" height="60"> </div> '
/* 									+ '<img src="./resources/bike.png" width="73" height="70"> </div> ' */
									+ '<div class="desc">'
									+ '<div class="ellipsis">' + details[i].pk_addr + '</div>'
									+ '<div class="jibun ellipsis">' + details[i].pk_tel + '</div>'
									+ '</div> </div> </div> </div>';
									
/* 									+ '<div> <a href="https://www.kakaocorp.com/main" target="_blank" class="link">홈페이지</a>' 
									+ '<div class="close" onclick="closeOverlay()" title="닫기">'  */
									
							$("#div").append(table);
						}
					}
				});
	});
	
</script>
</head>
<body>

		
	<div id="mySidebar" class="sidebar">
	  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">×</a>
	<div id="div"></div>
	  <a href="#">About</a>
	  <a href="#">Services</a>
	  <a href="#">Clients</a>
	  <a href="#">Contact</a>
	</div>
	
	<div id="main">
	  <button class="openbtn" onclick="openNav()">☰ Open Sidebar</button>  
	  <h2>Collapsed Sidebar</h2>
	  <p>Click on the hamburger menu/bar icon to open the sidebar, and push this content to the right.</p>
	</div>
	
	<script>
	(openNav());
		
	function openNav() {
	  document.getElementById("mySidebar").style.width = "380px";
	  document.getElementById("main").style.marginLeft = "380px";
	}
	
	function closeNav() {
	  document.getElementById("mySidebar").style.width = "0";
	  document.getElementById("main").style.marginLeft= "0";
	}
	</script>

	 -->
</body>
</html>
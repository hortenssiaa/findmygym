<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Map</title>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<link rel="stylesheet" href="./resources/css/maps.css" type="text/css">
<script src="/healthproject/resources/jquery-3.2.1.min.js"></script>
</head>
<body>
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2498e2ede14eaeded0134865029cedad&libraries=services"></script>

	<!-- Button -->
	<div class="page-wrapper">
		<!-- <a class="btn trigger" href="#">click me</a> -->
	</div>

	<!-- Modal -->
	<div class="modal-wrapper">
		<div class="modal">
			<div class="head">
				<a class="btn-close trigger" href="#"> 
					<i class="fa fa-times" aria-hidden="true">&#xe14c</i>
				</a>
			</div>
			<div id="map" style="width: 100%; height: 92%;"></div>

			<!-- <div class="content">
				<div class="good-job">
					<i class="fa fa-thumbs-o-up" aria-hidden="true">&#xe817</i> 
					<h1>Good Job!</h1>
				</div>
			</div> -->
		</div>
	</div>
	
	<script>
		$(document).ready(function() {
			var name, addr, lat, lng;
				
			$(".btn-close, #tab").on('click', $(".name"), function(e) {
				if($(e.target).is('.name')) {
					name = $(e.target).text();
					addr = $(e.target).next().text();
					lat = $(e.target).next().next().next().next().next().next().text();
					lng = $(e.target).next().next().next().next().next().next().next().text();
					//alert(name);
					//alert(addr);
					//alert(lat);
					//alert(lng);
		     	}  // if($(e.target).is('.name')) end  */
		     	
		     	else if($(e.target).is('.address')) {
					name = $(e.target).prev().text();
					addr = $(e.target).text();
					lat = $(e.target).next().next().next().next().next().text();
					lng = $(e.target).next().next().next().next().next().next().text();
		     	}
		
		     	$('.modal-wrapper').toggleClass('open');
				$('.page-wrapper').toggleClass('blur-it');
				
				
				var geocoder = new kakao.maps.services.Geocoder();

				var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
				    mapOption = {
				        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
				        level: 3 // 지도의 확대 레벨
				    };  
				
				var map = new kakao.maps.Map(mapContainer, mapOption);  // 지도를 생성합니다
				
				geocoder.addressSearch(addr, function(result, status) {
					
				     if (status === kakao.maps.services.Status.OK) {
				
				        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
				
				        var marker = new kakao.maps.Marker({
				            map: map,
				            position: coords
				        });
				
				        var infowindow = new kakao.maps.InfoWindow({
				            content: 
				            	'<div style="width:200px;text-align:center;padding:6px 0;">'+ name + 
				            	'<br><hr>' + addr + '</div>'
				        });
				        infowindow.open(map, marker);
				
				        map.setCenter(coords);
				    } 
				}); 
			}); 
		});	
		
		</script>
</body>
</html>
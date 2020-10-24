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
<script src="/healthproject/resources/jquery-3.2.1.min.js"></script>
<style>
@import url(https://fonts.googleapis.com/css?family=Montserrat:400,700);

#map {
	width: 100%;
	height: 100%;
}

.fa-times {
	font-family: 'Material Icons';
	font-weight: normal;
	font-style: normal;
	font-size: 30px; /* Preferred icon size */
	display: inline-block;
	line-height: 1;
	text-transform: none;
	letter-spacing: normal;
	word-wrap: normal;
	white-space: nowrap;
	direction: ltr;
	/* Support for all WebKit browsers. */
	-webkit-font-smoothing: antialiased;
	/* Support for Safari and Chrome. */
	text-rendering: optimizeLegibility;
	/* Support for Firefox. */
	-moz-osx-font-smoothing: grayscale;
	/* Support for IE. */
	font-feature-settings: 'liga';
}

.fa-thumbs-o-up {
	font-family: 'Material Icons';
	font-weight: normal;
	font-style: normal;
	font-size: 80px; /* Preferred icon size */
	display: inline-block;
	line-height: 1;
	text-transform: none;
	letter-spacing: normal;
	word-wrap: normal;
	white-space: nowrap;
	direction: ltr;
	/* Support for all WebKit browsers. */
	-webkit-font-smoothing: antialiased;
	/* Support for Safari and Chrome. */
	text-rendering: optimizeLegibility;
	/* Support for Firefox. */
	-moz-osx-font-smoothing: grayscale;
	/* Support for IE. */
	font-feature-settings: 'liga';
}

html, body {
	width: 100%;
	height: 100%;
	margin: 0;
}

.page-wrapper {
	width: 100%;
	height: 100%;
	background: url(https://goo.gl/OeVhun) center no-repeat;
	background-size: cover;
}

.blur-it {
	filter: blur(4px);
}

a.btn {
	width: 200px;
	padding: 18px 0;
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	font-family: 'Montserrat', Arial, Helvetica, sans-serif;
	font-weight: 700;
	text-align: center;
	text-decoration: none;
	text-transform: uppercase;
	color: #fff;
	border-radius: 0;
	background: #e2525c;
}

.modal-wrapper {
	width: 100%;
	height: 100%;
	position: fixed;
	top: 0;
	left: 0;
	background: rgba(41, 171, 164, 0.8);
	visibility: hidden;
	opacity: 0;
	transition: all 0.25s ease-in-out;
}

.modal-wrapper.open {
	opacity: 1;
	visibility: visible;
}

.modal {
	width: 800px;
	height: 600px;
	display: block;
	margin: 20% 0 0 -400px;
	/* 	margin: 50% 0 0 -300px; */
	position: relative;
	top: 50%; left : 50%;
	background: #fff;
	opacity: 0;
	transition: all 0.5s ease-in-out;
	left: 50%;
}

.modal-wrapper.open .modal {
	margin-top: -300px;
	opacity: 1;
}

.head {
	width: 92.5%;
	height: 32px;
	padding: 12px 30px;
	overflow: hidden;
	background: #e2525c;
}

.btn-close {
	font-size: 28px;
	display: block;
	float: right;
	color: #fff;
}

.content {
	padding: 10%;
}

.good-job {
	text-align: center;
	font-family: 'Montserrat', Arial, Helvetica, sans-serif;
	color: #e2525c;
}

.good-job h1 {
	font-size: 45px;
}
</style>
</head>
<body>
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2498e2ede14eaeded0134865029cedad&libraries=services"></script>
	<!-- 나중에 주석 풀것 !!! -->
	<!-- <p style="margin-top: -12px">
		<b>Chrome 브라우저는 https 환경에서만 geolocation을 지원합니다.</b> 참고해주세요.
	</p> -->

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
			<div id="map" style="width: 100%; height: 100%;"></div>

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
		
		     	$('.modal-wrapper').toggleClass('open');
				$('.page-wrapper').toggleClass('blur-it');
				var geocoder = new kakao.maps.services.Geocoder();
				
				var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
				    mapOption = {
				        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
				        level: 3 // 지도의 확대 레벨
				    };  
				
				var map = new kakao.maps.Map(mapContainer, mapOption); 
				
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
/* 
				var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
				mapOption = {
					center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
					level : 4
				// 지도의 확대 레벨 
				};

				var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

				// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
				if (navigator.geolocation) {

					// GeoLocation을 이용해서 접속 위치를 얻어옵니다
					navigator.geolocation
							.getCurrentPosition(function(position) {

								var lat = position.coords.latitude, // 위도
								lon = position.coords.longitude; // 경도

								var locPosition = new kakao.maps.LatLng(lat,
										lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
								message = '<div style="padding:5px;">여기에 계신가요?!</div>'; // 인포윈도우에 표시될 내용입니다

								// 마커와 인포윈도우를 표시합니다
								displayMarker(locPosition, message);

							});

				} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다

					var locPosition = new kakao.maps.LatLng(33.450701,
							126.570667), message = 'geolocation을 사용할수 없어요..'

					displayMarker(locPosition, message);
				}

				// 지도에 마커와 인포윈도우를 표시하는 함수입니다
				function displayMarker(locPosition, message) {

					// 마커를 생성합니다
					var marker = new kakao.maps.Marker({
						map : map,
						position : locPosition
					});

					var iwContent = message, // 인포윈도우에 표시할 내용
					iwRemoveable = true;

					// 인포윈도우를 생성합니다
					var infowindow = new kakao.maps.InfoWindow({
						content : iwContent,
						removable : iwRemoveable
					});

					// 인포윈도우를 마커위에 표시합니다 
					infowindow.open(map, marker);

					// 지도 중심좌표를 접속위치로 변경합니다
					map.setCenter(locPosition);
				}  */
			</script>

</body>
</html>
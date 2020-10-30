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
<style type="text/css">
	.customoverlay {position:relative;bottom:85px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;}
	.customoverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
	.customoverlay .title {display:block;text-align:center;background:#fff;margin-right:35px;padding:10px 15px;font-size:14px;font-weight:bold;}
	.customoverlay:after {content:'';position:absolute;margin-left:-12px;left:50%;bottom:-12px;width:22px;height:12px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
	.customoverlay a {
		display:block;text-decoration:none;color:#000;text-align:center;border-radius:6px;font-size:14px;font-weight:bold;overflow:hidden;
		background: #26D6DD; 
/* 		background: #34D6DD;  */
/* 		background: #FF26AF;  */
		background: #26D6DD url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;
	}	
</style>
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
					//lat = $(e.target).next().next().next().next().next().next().text();
					//lng = $(e.target).next().next().next().next().next().next().next().text();
					//alert(name);
					//alert(addr);
					//alert(lat);
					//alert(lng);
		     	}  // if($(e.target).is('.name')) end  */
		     	
		     	else if($(e.target).is('.address')) {
					name = $(e.target).prev().text();
					addr = $(e.target).text();
					//lat = $(e.target).next().next().next().next().next().text();
					//lng = $(e.target).next().next().next().next().next().next().text();
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
				    	 
				    	 lat = result[0].y;
				    	 lng = result[0].x;
				        
				        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
				        
				        var content = '<div class="customoverlay">' +
					    '  <a>' +
					    '    <span class="title">'+name+'</span>' +
					    '  </a>' +
					    '</div>';
		
						// 커스텀 오버레이를 생성합니다
						var customOverlay = new kakao.maps.CustomOverlay({
						    map: map,
						    position: coords,
						    content: content,
						    yAnchor: 1 
						});
				        
				        var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png', // 마커이미지의 주소입니다    
					    imageSize = new kakao.maps.Size(64, 69), // 마커이미지의 크기입니다
					    imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
	
						// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
						var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
						    markerPosition = new kakao.maps.LatLng(lat, lng); // 마커가 표시될 위치입니다
			
						// 마커를 생성합니다
						var marker = new kakao.maps.Marker({
						  position: markerPosition,
						  image: markerImage // 마커이미지 설정 
						});
			
						// 마커가 지도 위에 표시되도록 설정합니다
						map.setCenter(coords);
						marker.setMap(map);  
						customOverlay.setMap(map);
				
				    } 
				});  
				
			
			
			/* var geocoder = new kakao.maps.services.Geocoder();

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
			});  */
				
				
				/* // 아래와 같이 옵션을 입력하지 않아도 된다
				var zoomControl = new kakao.maps.ZoomControl();

				// 지도 오른쪽에 줌 컨트롤이 표시되도록 지도에 컨트롤을 추가한다.
				map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT); */
			}); 
		});	
		
		</script>
</body>
</html>
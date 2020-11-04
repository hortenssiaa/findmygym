<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리 별 목록 리스트</title>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<link rel="stylesheet" href="./resources/css/map_category.css" type="text/css">
<style type="text/css">
html, body { height:100%;}
.map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
.map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
.map_wrap {position:relative;width:100%;}
#menu_wrap {position:absolute;top:0;left:0;bottom:0;width:300px;margin:10px 0 30px 10px;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;}
.bg_white {background:#fff;}
#menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
#menu_wrap .option{text-align: center;}
#menu_wrap .option p {margin:10px 0;}  
#menu_wrap .option button {margin-left:5px;}
#placesList li {list-style: none;}
#placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
#placesList .item span {display: block;margin-top:4px;}
#placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
#placesList .item .info{padding:10px 0 10px 55px;}
#placesList .info .gray {color:#8a8a8a;}
#placesList .info .jibun {padding-left:26px;}
/* #placesList .info .jibun {padding-left:26px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;} */
#placesList .info .tel {color:#009900;}
#placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;}
#placesList .item .marker_1 {background-position: 0 -10px;}
#placesList .item .marker_2 {background-position: 0 -56px;}
#placesList .item .marker_3 {background-position: 0 -102px}
#placesList .item .marker_4 {background-position: 0 -148px;}
#placesList .item .marker_5 {background-position: 0 -194px;}
#placesList .item .marker_6 {background-position: 0 -240px;}
#placesList .item .marker_7 {background-position: 0 -286px;}
#placesList .item .marker_8 {background-position: 0 -332px;}
#placesList .item .marker_9 {background-position: 0 -378px;}
#placesList .item .marker_10 {background-position: 0 -423px;}
#placesList .item .marker_11 {background-position: 0 -470px;}
#placesList .item .marker_12 {background-position: 0 -516px;}
#placesList .item .marker_13 {background-position: 0 -562px;}
#placesList .item .marker_14 {background-position: 0 -608px;}
#placesList .item .marker_15 {background-position: 0 -654px;}
#pagination {margin:10px auto;text-align: center;}
#pagination a {display:inline-block;margin-right:10px;}
#pagination .on {font-weight: bold; cursor: default;color:#777;}
.customoverlay {position:relative;bottom:85px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;}
.customoverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
.customoverlay a {display:block;text-decoration:none;color:#000;text-align:center;border-radius:6px;font-size:14px;font-weight:bold;overflow:hidden;background: #00E72A;background: #7324F0 url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;}
.customoverlay .title {display:block;text-align:center;background:#fff;margin-right:35px;padding:10px 15px;font-size:14px;font-weight:bold;}
.customoverlay:after {content:'';position:absolute;margin-left:-12px;left:50%;bottom:-12px;width:22px;height:12px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
</style>
<script src="/healthproject/resources/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2498e2ede14eaeded0134865029cedad&libraries=services"></script>
</head>
<body>
<div class="map_wrap">
    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>

    <div id="menu_wrap" class="bg_white">
        <div class="option">
            <div>
                    <button id="ajaxbtn" name="ajaxbtn">검색</button>
            </div>
        </div>
        <hr>
        <ul id="placesList"></ul>
        <div id="pagination"></div>
    </div>
</div>

<script>
	//$("#ajaxbtn").on("click", function() {
	//}
	
	var datas=[],
		lat = [],
		lng = [];
	
	$.ajax({
		url : '/healthproject/river/riverinfo',
		data : {'townname': '강남구'},
		type: 'post',
		
		dataType: 'json',
		success: function(details) {
			datas = details;
			
			var markers = [];
			
			var geocoder = new kakao.maps.services.Geocoder();
			
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			    mapOption = {
			        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
			        level: 6 // 지도의 확대 레벨
			    };  
			
			var map = new kakao.maps.Map(mapContainer, mapOption); 
			
			var infowindow = new kakao.maps.InfoWindow();
			        
		    displayPlaces(datas);
			
		    displayPagination(pagination);
		    
			
			function displayPlaces(places) { // places == datas
			 			
			    var listEl = document.getElementById('placesList'), 
			    menuEl = document.getElementById('menu_wrap'),
			    fragment = document.createDocumentFragment(), 
			    bounds = new kakao.maps.LatLngBounds(), 
			    listStr = '';
				// 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체를 생성합니다
			
			    
			    removeAllChildNods(listEl);
			
			    removeMarker();

			    var count = 0;
			    var addr = [];
			    for( var i=0; i<places.length; i++ ) {
			    	addr[i] = places[i].r_addr;
			    }
			    
			    for ( var i=0; i<places.length; i++ ) {

  			    	geocoder.addressSearch(addr[i], function(result, status) {  
  			    		
					     if (status === kakao.maps.services.Status.OK) {
					    	 
					    	 lat[count] = result[0].y;
					    	 lng[count] = result[0].x;
					   		 
					        var placePosition = new kakao.maps.LatLng(lat[count], lng[count]),
					            marker = addMarker(placePosition, count), 
					            itemEl = getListItem(count, places[count]); // 검색 결과 항목 Element를 생성합니다
					            
					        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해 LatLngBounds 객체에 좌표를 추가합니다
					        bounds.extend(placePosition);
					            
					        var content = '<div class="customoverlay">' +
								    '  <a>' +
								    '    <span class="title">'+ places[count].r_name+'</span>' +
								    '  </a>' +
								    '</div>';
					        
					        var customOverlay = new kakao.maps.CustomOverlay({
							    map: map,
							    position: placePosition,
							    content: content,
							    yAnchor: 0 
							}); 
					        
					    	//console.log(count);
					        count += 1;
					        
					        console.log(itemEl);

					        fragment.appendChild(itemEl);
						    listEl.appendChild(fragment);
					        
					        map.setCenter(placePosition);
							customOverlay.setMap(map);
					     }
			    	});
 			    	
			    }
			    menuEl.scrollTop = 0;
			
			    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
			    function setBounds() {
			    	map.setBounds(bounds);
			    }
			    
			}
		 	
			function getListItem(index, places) {

				if(places.r_tel == null) 
					places.r_tel = "";
				
				var el = document.createElement('li'),
			    	itemStr = '<span class="markerbg marker_' + (index+1) + '"></span> ' +
			                '<div class="info"> ' +
			                '   <h5>' + places.r_name + '</h5> '+
							'    <span>' + places.r_addr + '</span>' +
			      			'  <span class="tel">' + places.r_tel  + '</span> </div>';
			      			
			    el.innerHTML = itemStr;
			    el.className = 'item';
			    
			    console.log((index+1));
			    console.log(places.r_name);
			    console.log(places.r_addr);
			    console.log(places.r_tel);
			    
			    return el;
			}
			
			function addMarker(position, idx, title) {
			    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
			        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기 // 24
			        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize),
			            marker = new kakao.maps.Marker({
			            position: position, // 마커의 위치
			            image: markerImage 
			        });
			    
			    marker.setMap(map); // 지도 위에 마커를 표출합니다
			    markers.push(marker);  // 배열에 생성된 마커를 추가합니다
			    
			    return marker;
			}
			
			
			function removeMarker() {
			    for ( var i = 0; i < markers.length; i++ ) {
			        markers[i].setMap(null);
			    }   
			    markers = [];
			}
			
			// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
			function displayPagination(pagination) {
			    var paginationEl = document.getElementById('pagination'),
			        fragment = document.createDocumentFragment(),
			        i; 
			
			    // 기존에 추가된 페이지번호를 삭제합니다
			    while (paginationEl.hasChildNodes()) {
			        paginationEl.removeChild (paginationEl.lastChild);
			    }
			
			    for (i=1; i<=pagination.last; i++) {
			        var el = document.createElement('a');
			        el.href = "#";
			        el.innerHTML = i;
			
			        if (i===pagination.current) {
			            el.className = 'on';
			        } else {
			            el.onclick = (function(i) {
			                return function() {
			                    pagination.gotoPage(i);
			                }
			            })(i);
			        }
			
			        fragment.appendChild(el);
			    }
			    paginationEl.appendChild(fragment);
			}
			
			function displayInfowindow(marker, title) {
				
						var content = '<div class="customoverlay">' +
						    '  <a>' +
						    '    <span class="title">'+ title+'</span>' +
						    '  </a>' +
						    '</div>';
				
			    infowindow.setContent(content);
			    infowindow.open(map, marker);
			}
			
			function removeAllChildNods(el) {   
			    while (el.hasChildNodes()) {
			        el.removeChild (el.lastChild);
			    }
			}
			 
			var mapTypeControl = new kakao.maps.MapTypeControl();

			map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

			var zoomControl = new kakao.maps.ZoomControl();
			map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
			

			// 마커와 검색결과 항목에 mouseover 했을때
	        // 해당 장소에 인포윈도우에 장소명을 표시합니다
	        // mouseout 했을 때는 인포윈도우를 닫습니다
	       // var title = places[i].pk_name;
	        /* (function(marker, title) {
	            kakao.maps.event.addListener(marker, 'mouseover', function() {
	                displayInfowindow(marker, title);
	            });
	
	            kakao.maps.event.addListener(marker, 'mouseout', function() {
	                infowindow.close();
	            });
	
	            itemEl.onmouseover =  function () {
	                displayInfowindow(marker, title);
	            };
	
	            itemEl.onmouseout =  function () {
	                infowindow.close();
	            };
	        })(marker, places[i].r_name); */
		}
	});
</script>
</body>
</html>
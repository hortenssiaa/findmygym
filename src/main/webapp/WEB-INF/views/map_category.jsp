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
/* 	.customoverlay a {display:block;text-decoration:none;color:#000;text-align:center;border-radius:6px;font-size:14px;font-weight:bold;overflow:hidden;background: #56BCB7;background: #56BCB7 url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;} */
	.customoverlay .title {display:block;text-align:center;background:#fff;margin-right:35px;padding:10px 15px;font-size:14px;font-weight:bold;}
	.customoverlay:after {content:'';position:absolute;margin-left:-12px;left:50%;bottom:-12px;width:22px;height:12px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
</style>
</head>
<body>
<div class="map_wrap">
    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>

    <div id="menu_wrap" class="bg_white">
        <div class="option">
            <div>
                <!-- <form onsubmit="searchPlaces(); return false;">
                    키워드 : <input type="text" value="이태원 맛집" id="keyword" size="15">  
                    <button type="submit">검색하기</button> -->
                    <button id="ajaxbtn" name="ajaxbtn">검색</button>
                <!-- </form> -->
            </div>
        </div>
        <hr>
        <ul id="placesList"></ul>
        <div id="pagination"></div>
    </div>
</div>

<script src="/healthproject/resources/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2498e2ede14eaeded0134865029cedad&libraries=services"></script>
<script>

	//$("#ajaxbtn").on("click", function() {
		
		
	//}
	

	
	
	
	
	
	/* 
	// 장소 검색 객체를 생성합니다
	var ps = new kakao.maps.services.Places();  
	// 키워드로 장소를 검색합니다
	searchPlaces();
	
	// 키워드 검색을 요청하는 함수입니다
	function searchPlaces() {
	    var keyword = document.getElementById('keyword').value;
	    if (!keyword.replace(/^\s+|\s+$/g, '')) {
	        alert('키워드를 입력해주세요!');
	        return false;
	    }
	    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
	    ps.keywordSearch( keyword, placesSearchCB); 
	}
	
	// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
	function placesSearchCB(data, status, pagination) {
	    if (status === kakao.maps.services.Status.OK) {
	        // 정상적으로 검색이 완료됐으면
	        // 검색 목록과 마커를 표출합니다
	        displayPlaces(data);
	        // 페이지 번호를 표출합니다
	        displayPagination(pagination);
	    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
	        alert('검색 결과가 존재하지 않습니다.');
	        return;
	    } else if (status === kakao.maps.services.Status.ERROR) {
	        alert('검색 결과 중 오류가 발생했습니다.');
	        return;
	    }
	} */
	
	
	var datas=[],
		lat = [],
		lng = [];
	
	$.ajax({
		url : '/healthproject/river/riverinfo',
		data : {'townname': '송파구'},
		type: 'post',
		
		dataType: 'json',
		success: function(details) {
			datas = details;
			
			// 마커를 담을 배열입니다
			var markers = [];
			
			var geocoder = new kakao.maps.services.Geocoder();
			
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			    mapOption = {
			        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
			        level: 5 // 지도의 확대 레벨
			    };  
			
			// 지도를 생성합니다    
			var map = new kakao.maps.Map(mapContainer, mapOption); 
			
			// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
			var infowindow = new kakao.maps.InfoWindow(
			    /* position:  new daum.maps.LatLng(position.latlng[0], position.latlng[1]),
			    content: '<span class="info-title">말풍선타이틀</span>'; // 인포윈도우 내부에 들어갈 컨텐츠 입니다. */
			);
			        
			// 검색 목록과 마커를 표출합니다
		    displayPlaces(datas);
			
		    // 페이지 번호를 표출합니다
		    displayPagination(pagination);
		    
			
		 // 검색 결과 목록과 마커를 표출하는 함수입니다
			function displayPlaces(places) { // places == datas
			 			
			    var listEl = document.getElementById('placesList'), 
			    menuEl = document.getElementById('menu_wrap'),
			    fragment = document.createDocumentFragment(), 
			    bounds = new kakao.maps.LatLngBounds(), 
			    listStr = '';
			
			// 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체를 생성합니다
			
			    
			    // 검색 결과 목록에 추가된 항목들을 제거합니다
			    removeAllChildNods(listEl);
			
			    // 지도에 표시되고 있는 마커를 제거합니다
			    removeMarker();

			    var count = 0;
			    var addr = [];
			    for( var i=0; i<places.length; i++ ) {
			    	addr[i] = places[i].r_addr;
			    }
			    
			    for ( var i=0; i<places.length; i++ ) {
			    	

  			    	geocoder.addressSearch(addr[i], function(result, status) {  
/*   			    	geocoder.addressSearch(places[count].r_addr, function(result, status) {   */
  			    		
			    	console.log("addr:"+ addr[count]+ " " + i);
/* 			    	console.log("안 addr:"+places[count].r_addr+ " " + count); */
			    	//console.log("0:" + places[0].r_addr);
			    	//console.log("1:" + places[1].r_addr);
						
					     if (status === kakao.maps.services.Status.OK) {
					    	 
					    	 lat[count] = result[0].y;
					    	 lng[count] = result[0].x;
					   	console.log(lat[count]+"      "+lng[count]);
					    	 
					        // 마커를 생성하고 지도에 표시합니다
					        var placePosition = new kakao.maps.LatLng(lat[count], lng[count]),
					            marker = addMarker(placePosition, count), 
					            itemEl = getListItem(count, places[count]); // 검색 결과 항목 Element를 생성합니다
					            
					    	 
					
					        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
					        // LatLngBounds 객체에 좌표를 추가합니다
					        bounds.extend(placePosition);
					            
					
					        // 마커와 검색결과 항목에 mouseover 했을때
					        // 해당 장소에 인포윈도우에 장소명을 표시합니다
					        // mouseout 했을 때는 인포윈도우를 닫습니다
					       // var title = places[i].pk_name;
					        
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
					    	console.log(count);
					        count += 1;
					        
					     // 마커가 지도 위에 표시되도록 설정합니다

					     
/* 					     addr[count] = places[count].r_addr; */
					        
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
					
					        fragment.appendChild(itemEl);
					        map.setCenter(placePosition);
							customOverlay.setMap(map);

					     }
			    	});
 			    	
			    }
			    // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
			    listEl.appendChild(fragment);
			    menuEl.scrollTop = 0;
			
			    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
			    function setBounds() {
			    	map.setBounds(bounds);
			    }
			}
		 
			// 검색결과 항목을 Element로 반환하는 함수입니다
			function getListItem(index, places) {

				//alert(places.r_addr);
				
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
			    
			    return el;
			}
			
			// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
			function addMarker(position, idx, title) {
			    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
			        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기 // 24
			        /* imgOptions =  {
			            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
			            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
			            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
			        }, */
			        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize),
		/* 	        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions), */
			            marker = new kakao.maps.Marker({
			            position: position, // 마커의 위치
			            image: markerImage 
			        });
			    
			    marker.setMap(map); // 지도 위에 마커를 표출합니다
			    markers.push(marker);  // 배열에 생성된 마커를 추가합니다
			    
			    return marker;
			}
			
			
			
			/* for(var a = 0 ; a < datas.length; a++)
				alert(datas[a].r_addr); */
			
			// 지도 위에 표시되고 있는 마커를 모두 제거합니다
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
			
			// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
			// 인포윈도우에 장소명을 표시합니다
			function displayInfowindow(marker, title) {
				
					 // 커스텀 오버레이에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
						var content = '<div class="customoverlay">' +
						    '  <a>' +
						    '    <span class="title">'+ title+'</span>' +
						    '  </a>' +
						    '</div>';
				
/* 			    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>'; */
			
			    infowindow.setContent(content);
			    infowindow.open(map, marker);
			}
			
			 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
			function removeAllChildNods(el) {   
			    while (el.hasChildNodes()) {
			        el.removeChild (el.lastChild);
			    }
			}
			 
			// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
			var mapTypeControl = new kakao.maps.MapTypeControl();

			// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
			// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
			map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

			// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
			var zoomControl = new kakao.maps.ZoomControl();
			map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
			
			
		}
	});
	
</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공중화장실 정보</title>
<link rel="stylesheet" href="./resources/css/toilet.css" type="text/css">
<style type="text/css">
	#toilet { /* 페이지 별로 변경! */
		background-color: #56BCB7;
	}
	
	.name {
		width: 30%;
	}
	
	.address {
		width: 30%;
	}
</style>
<script src="/healthproject/resources/jquery-3.2.1.min.js"></script>
<script>
	$(document).ready(function() {
		// sorted city 
		$('.dropdown-city').click(function(e) {
			e.preventDefault();
			e.stopPropagation();
			$(this).toggleClass('expanded');
			$('#'+$(e.target).attr('for')).prop('checked',true);
			//alert($('#'+$(e.target).attr('for')).val());
		
			var city = $(".dropdown-city").children("input:checked").val();
			//alert("city:"+city);
			
			if(city != "지역을 선택해주세요") {
				$.ajax({
					url : '/healthproject/toilet/city',
					data : {"cityname": $(".dropdown-city input:checked").val()},
					type: 'post',
					
					dataType: 'json',
					success: function(town) {
						$(".dropdown-town").empty();
						$(".dropdown-town").append
						('<input type="radio" value="지역을 선택해주세요" id="sort_town"> '
								+'<label for="sort_town">지역을 선택해주세요</label>');
						
						var townArr = new Array();
						for(var i=0; i<town.length; i++) {
							townArr[i] = town[i];
							var input = '<input type="radio" value="' + town[i] + '" id="'+i+
										'" name="sortType2" > <label for="'+i+'">'+town[i]+'</label>';
							$(".dropdown-town").append(input);
						}
						
						$('.dropdown-town').click(function(e) {
							e.preventDefault();
							e.stopPropagation();
							$(this).toggleClass('expanded');
							$('#'+$(e.target).attr('for')).prop('checked',true);
							
							//alert($('#'+$(e.target).attr('for')).val());
							//alert($('#'+$(e.target).id));
							
							//var checkedTown = $(".dropdown-town").children("input:checked").val();
							//alert("town2:"+town2);
						}); 

						$(document).click(function() { // 해당 태그 이외의 부분에 click 발생시; expanded 닫아라. 
							$('.dropdown-town').removeClass('expanded');
						});
						
					},
					error: function(request,status,error) {
						alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					}
					
				});
			}
			
			else {
				$(".dropdown-town").empty();
				$(".dropdown-town").append
				('<input type="radio" value="지역을 선택해주세요" checked="checked" id="sort_town"> '
						+'<label for="sort_town">지역을 선택해주세요</label>');
			}
		});
		
		$(document).click(function() {
			$('.dropdown-city').removeClass('expanded');
		});
		
		$("#ajaxbtn").on("click", function() {
			var city = $(".dropdown-city").children("input:checked").val();
			var town = $(".dropdown-town").children("input:checked").val();
			//alert("city:"+city);
			//alert("town:"+town);
			
			if(city != "지역을 선택해주세요" && town != "지역을 선택해주세요") {
				$.ajax({
					url : '/healthproject/toilet/toiletinfo',
					data : {'townname': $(".dropdown-town input:checked").val()},
					type: 'post',
					
					dataType: 'json',
					success: function(details) {
						$("#tab").empty();
						
						for(var i=0; i<details.length; i++) {
							var table;
							
							var handi_m = details[i].pt_m_handi1 + details[i].pt_m_handi2;
							if(handi_m == 0)
								handi_m = "X";
							else
								handi_m = "O";
							
							if(details[i].pt_f_handi.includes("0"))
								details[i].pt_f_handi = "X";
							else
								details[i].pt_f_handi = "O";
							
							if(details[i].pt_tel == null)
								details[i].pt_tel = "X";
							
							if(details[i].pt_addr1 == null) {
								details[i].pt_addr1 = "";
								
								if(details[i].pt_addr2 == null)
									details[i].pt_addr2 = "X";

								table = "<tr id=" + i +"> <td class='name'>" + details[i].pt_name 
								+ "</td><td class='address'>" + details[i].pt_addr2
								+ "</td><td>" + details[i].pt_tel 
								+ "</td><td>" + details[i].pt_time 
								+ "</td><td>" + details[i].pt_f_handi 
								+ "</td><td>" + handi_m
								+ "</td><td class='lat' hidden='hidden'>" + details[i].pt_lat
								+ "</td><td class='lng' hidden='hidden'>" + details[i].pt_lng + "</td></tr>";  
							}

							else if(details[i].pt_addr2 == null) {
								details[i].pt_addr2 = "";
								
								if(details[i].pt_addr1 == null)
									details[i].pt_addr1 = "X";
								
								table = "<tr id=" + i +"> <td class='name'>" + details[i].pt_name 
								+ "</td><td class='address'>" + details[i].pt_addr1
								+ "</td><td>" + details[i].pt_tel 
								+ "</td><td>" + details[i].pt_time 
								+ "</td><td>" + details[i].pt_f_handi 
								+ "</td><td>" + handi_m
								+ "</td><td class='lat' hidden='hidden'>" + details[i].pt_lat
								+ "</td><td class='lng' hidden='hidden'>" + details[i].pt_lng + "</td></tr>";  
							}
							
							else {
								table = "<tr id=" + i +"> <td class='name'>" + details[i].pt_name 
								+ "</td><td class='address'>" + details[i].pt_addr1
								+ "</td><td>" + details[i].pt_tel 
								+ "</td><td>" + details[i].pt_time 
								+ "</td><td>" + details[i].pt_f_handi 
								+ "</td><td>" + handi_m
								+ "</td><td class='lat' hidden='hidden'>" + details[i].pt_lat
								+ "</td><td class='lng' hidden='hidden'>" + details[i].pt_lng + "</td></tr>";  
							}
							          
							$("#tab").append(table);
						}
						
						$(".name").mouseover(function(e){
							  $(e.target).css("text-decoration", "underline");
						});
						
						$(".name").mouseleave(function(e){
							$(e.target).css("text-decoration", "none");
						});
						
						$(".address").mouseover(function(e){
							$(e.target).css("text-decoration", "underline");
						});
		
						$(".address").mouseleave(function(e){
							$(e.target).css("text-decoration", "none");
						});
					}
				});
			} else {
				alert("지역을 선택해주세요");
			}
		});	//on
		
		$(".dropdown-city").change(function() {
			//alert($('#'+$(e.target).attr('for')).val());
			
			var city = $(".dropdown-city").children("input:checked").val();
			
			if(city != "지역을 선택해주세요") {
				
				$.ajax({
					url : '/healthproject/toilet/city',
					data : {"cityname": $(".dropdown-city input:checked").val()},
					type: 'post',
					
					dataType: 'json',
					success: function(town) {
						$(".dropdown-town").empty();
						$(".dropdown-town").append
						('<input type="radio" value="지역을 선택해주세요" checked="checked" id="sort_town"> '
								+'<label for="sort_town">지역을 선택해주세요</label>');
						
						for(var i=0; i<town.length; i++) {
							var input = '<input type="radio" value="'+town[i]+'" id="'+town[i]
								+'" name="sortType2" > <label for="'+town[i]+'">'+town[i]+'</label>';
							$(".dropdown-town").append(input);
						}
					},
					error: function(request,status,error) {
						alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					}
				});
			}else{
				$(".dropdown-town").empty();
				$(".dropdown-town").append
				('<input type="radio" value="지역을 선택해주세요" checked="checked" id="sort_town"> '
						+'<label for="sort_town">지역을 선택해주세요</label>');
			}
		});//change
	});
	
</script>
</head>
<body>
	<jsp:include page="onetouch.jsp"/>
	
	화장실명, 주소를 클릭하면 지도가 보입니다.
	
	<span class="dropdown-city"> 
		<input type="radio" name="sortType" value="지역을 선택해주세요" checked="checked" id="sort_city">
		<label for="sort_city">지역을 선택해주세요</label> 
		
		<input type="radio" name="sortType" value="서울특별시" id="seoul">
		<label for="seoul">서울특별시</label> 
		
		<input type="radio" name="sortType" value="부산광역시" id="busan">
		<label for="busan">부산광역시</label> 
		
		<input type="radio" name="sortType" value="대구광역시" id="deagu">
		<label for="deagu">대구광역시</label> 
		
		<input type="radio" name="sortType" value="인천광역시" id="inchon">
		<label for="inchon">인천광역시</label> 
		
		<input type="radio" name="sortType" value="광주광역시" id="gwangju">
		<label for="gwangju">광주광역시</label>
		
		<input type="radio" name="sortType" value="울산광역시" id="ulsan">
		<label for="ulsan">울산광역시</label>
		
		<input type="radio" name="sortType" value="대전광역시" id="deajeon">
		<label for="deajeon">대전광역시</label>
		
		<input type="radio" name="sortType" value="세종특별자치시" id="sejong">
		<label for="sejong">세종특별자치시</label>
		
		<input type="radio" name="sortType" value="경기도" id="gyunggi">
		<label for="gyunggi">경기도</label>
		
		<input type="radio" name="sortType" value="강원도" id="gangwon">
		<label for="gangwon">강원도</label>
		
		<input type="radio" name="sortType" value="충청북도" id="chungbuk">
		<label for="chungbuk">충청북도</label>
		
		<input type="radio" name="sortType" value="충청남도" id="chungnam">
		<label for="chungnam">충청남도</label>
		
		<input type="radio" name="sortType" value="전라북도" id="jeonbuk">
		<label for="jeonbuk">전라북도</label>
		
		<input type="radio" name="sortType" value="전라남도" id="jeonnam">
		<label for="jeonnam">전라남도</label>
		
		<input type="radio" name="sortType" value="경상북도" id="gyungbuk">
		<label for="gyungbuk">경상북도</label>
		
		<input type="radio" name="sortType" value="경상남도" id="gyungnam">
		<label for="gyungnam">경상남도</label>
		
		<input type="radio" name="sortType" value="제주특별자치도" id="jeju">
		<label for="jeju">제주특별자치도</label>
	</span>
	
	<span class="dropdown-town"> 
		<input type="radio" name="sortType2" value="지역을 선택해주세요" checked="checked" id="sort_town">
		<label for="sort_town">지역을 선택해주세요</label> 
	</span>	
	
	<!-- <button id="ajaxbtn" name="ajaxbtn">검색</button> -->
	
<!-- 	    <span class="multi-button skin1"> -->
	      <button id="ajaxbtn" name="ajaxbtn">검색</button>
<!-- 	<div class="container">
	  <div class="group-container">
	    </div>
	</div>
 -->	
	<div>
		<table>
			<thead>
				<tr>
					<th class='name'>화장실명</th>
					<th class='address'>주소</th>
					<th>전화번호</th>
					<th>이용가능시간</th>
					<th>장애인화장실(여)</th>
					<th>장애인화장실(남)</th>
					<th id='lat' hidden='hidden'></th>
					<th id='lng' hidden='hidden'></th>
				</tr>
			</thead>
			<tbody id="tab">

			</tbody>
		</table>
	</div>
	
	<jsp:include page="maps.jsp"/>
</body>
</html>
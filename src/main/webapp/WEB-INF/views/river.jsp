<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강/탄천 정보</title>
<link rel="stylesheet" href="./resources/css/toilet.css" type="text/css">
<style type="text/css">
	#river { /* 페이지 별로 변경! */
		background-color: #56BCB7;
	}
	
	.name {
		width: 15%;
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
					url : '/healthproject/river/city',
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
			
			if(city != "지역을 선택해주세요" && town != "지역을 선택해주세요") {
				$.ajax({
					url : '/healthproject/river/riverinfo',
					data : {'townname': $(".dropdown-town input:checked").val()},
					type: 'post',
					
					dataType: 'json',
					success: function(details) {
						$("#tab").empty();
						
						for(var i=0; i<details.length; i++) {
							var table;
							
							if(details[i].r_addr == null)
								details[i].r_addr = "";

							if(details[i].r_tel == null)
								details[i].r_tel = "";

							if(details[i].r_park == null)
								details[i].r_park = "";

							if(details[i].r_baby == null)
								details[i].r_baby = "";

							if(details[i].r_baby.includes("불가"))
								details[i].r_baby = "없음";

							if(details[i].r_pet == null)
								details[i].r_pet = "";

							table = "<tr id=" + i +"> <td class='name'>" + details[i].r_name 
							+ "</td><td class='address'>" + details[i].r_addr
							+ "</td><td class='tel'>" + details[i].r_tel
							+ "</td><td>" + details[i].r_park
							+ "</td><td>" + details[i].r_baby
							+ "</td><td>" + details[i].r_pet 
							+ "</td><td class='lat' hidden='hidden'>" + details[i].r_lat
							+ "</td><td class='lng' hidden='hidden'>" + details[i].r_lng + "</td></tr>";  
							          
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
			
			var city = $(".dropdown-city").children("input:checked").val();
			
			if(city != "지역을 선택해주세요") {
				
				$.ajax({
					url : '/healthproject/river/city',
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
	
	강/탄천 명
	, 주소를 클릭하면 지도가 보입니다.
	
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
					<th class='name'>강/탄천 명</th>
					<th class='address'>주소</th>
					<th class='tel'>문의 및 안내</th>
					<th>주차가능유무</th>
					<th>유모차대여유무</th>
					<th>애완동물 동반가능유무</th>
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
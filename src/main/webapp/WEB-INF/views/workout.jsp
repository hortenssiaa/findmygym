<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>야외운동기구 정보</title>
<link rel="stylesheet" href="./resources/css/toilet.css" type="text/css">
<style type="text/css">
	#workout { /* 페이지 별로 변경! */
		background-color: #56BCB7;
	}
	
	.name {
		width: 20%;
	}
	
	.address {
		width: 30%;
	}
	
	.kind {
		width:35%;
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
					url : '/healthproject/workout/city',
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
					url : '/healthproject/workout/workoutinfo',
					data : {'townname': $(".dropdown-town input:checked").val()},
					type: 'post',
					
					dataType: 'json',
					success: function(details) {
						$("#tab").empty();
						
						for(var i=0; i<details.length; i++) {
							var table;
							
							if(details[i].wo_addr == null)
								details[i].wo_addr = "";

							if(details[i].wo_kind == null)
								details[i].wo_kind = "";

							if(details[i].wo_admin == null)
								details[i].wo_admin = "";

							table = "<tr id=" + i +"> <td class='name'>" + details[i].wo_name 
							+ "</td><td class='address'>" + details[i].wo_addr
							+ "</td><td class='kind'>" + details[i].wo_kind 
							+ "</td><td>" + details[i].wo_admin 
							+ "</td><td class='lat' hidden='hidden'>" + details[i].wo_lat
							+ "</td><td class='lng' hidden='hidden'>" + details[i].wo_lng + "</td></tr>";  
							          
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
					url : '/healthproject/workout/city',
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
	
	야외운동기구 위치명, 주소를 클릭하면 지도가 보입니다.
	
	<span class="dropdown-city"> 
		<input type="radio" name="sortType" value="지역을 선택해주세요" checked="checked" id="sort_city">
		<label for="sort_city">지역을 선택해주세요</label> 
		
		<input type="radio" name="sortType" value="서울특별시" id="seoul">
		<label for="seoul">서울특별시</label> 
		
		<input type="radio" name="sortType" value="대전광역시" id="deajeon">
		<label for="deajeon">대전광역시</label>
		
		<input type="radio" name="sortType" value="경기도" id="gyunggi">
		<label for="gyunggi">경기도</label>
		
		<input type="radio" name="sortType" value="충청남도" id="chungnam">
		<label for="chungnam">충청남도</label>
		
		<input type="radio" name="sortType" value="전라북도" id="jeonbuk">
		<label for="jeonbuk">전라북도</label>
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
					<th class='name'>야외운동기구 위치명</th>
					<th class='address'>주소</th>
					<th class='kind'>운동기구 종류</th>
					<th>관리기관</th>
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
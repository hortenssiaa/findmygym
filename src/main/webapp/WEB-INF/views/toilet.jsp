<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공중화장실 정보</title>
<style type="text/css">
@import url('https://fonts.googleapis.com/css?family=Source+Sans+Pro:400,700');
@import url(https://fonts.googleapis.com/css?family=Montserrat:400,700);
@import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap');
body {
  align-items: center;    
  text-align: center;
  background: #ebf4fb;
  min-height: 95vh;
  margin: 0;
  padding: 0;
  border-bottom: 3vh solid #3694d7;
  font-family: "Myriad Pro", "Arial", sans;
  font-family: 'Nanum Gothic', sans-serif;
  font-size: 16px;
}

#map {
	width: 100%;
	height: 100%;
}

.dropdown-city {
  margin-top: 3vh;
  min-width: 10em;
  position: relative;
  display: inline-block;
  margin-right: 1em;
  min-height: 2em;
  max-height: 2em;
  overflow: hidden;
  top: 0.5em;
  cursor: pointer;
  text-align: left;
  white-space: nowrap;
  color: #444;
  outline: none;
  border: 0.06em solid transparent;
  border-radius: 1em;
  background-color: #cde4f5;
  transition: 0.3s all ease-in-out;
}
.dropdown-city input:focus + label {
  background: #def;
}
.dropdown-city input {
  width: 1px;
  height: 1px;
  display: inline-block;
  position: absolute;
  opacity: 0.01;
}
.dropdown-city label {
  border-top: 0.06em solid #d9d9d9;
  display: block;
  height: 2em;
  line-height: 2em;
  padding-left: 1em;
  padding-right: 3em;
  cursor: pointer;
  position: relative;
  transition: 0.3s color ease-in-out;
}
.dropdown-city label:nth-child(2) {
  margin-top: 2em;
  border-top: 0.06em solid #d9d9d9;
}
.dropdown-city input:checked + label {
  display: block;
  border-top: none;
  position: absolute;
  top: 0;
  width: 100%;
}
.dropdown-city input:checked + label:nth-child(2) {
  margin-top: 0;
  position: relative;
}
.dropdown-city::after {
  content: "";
  position: absolute;
  right: 0.8em;
  top: 0.9em;
  border: 0.3em solid #3694d7;
  border-color: #3694d7 transparent transparent transparent;
  transition: 0.4s all ease-in-out;
}
.dropdown-city.expanded {
  overflow: auto;
  border: 0.06em solid #3694d7;
  background: #fff;
  border-radius: 0.25em;
  padding: 0;
  box-shadow: rgba(0, 0, 0, 0.1) 3px 3px 5px 0px;
  max-height: 15em;
}
.dropdown-city.expanded label {
  border-top: 0.06em solid #d9d9d9;
}
.dropdown-city.expanded label:hover {
  color: #3694d7;
}
.dropdown-city.expanded input:checked + label {
  color: #3694d7;
}
.dropdown-city.expanded::after {
  transform: rotate(-180deg);
  top: 0.55em;
}

.dropdown-town {
  margin-top: 3vh;
  min-width: 10em;
  position: relative;
  display: inline-block;
  margin-right: 1em;
  min-height: 2em;
  max-height: 2em;
  overflow: hidden;
  top: 0.5em;
  cursor: pointer;
  text-align: left;
  white-space: nowrap;
  color: #444;
  outline: none;
  border: 0.06em solid transparent;
  border-radius: 1em;
  background-color: #cde4f5;
  transition: 0.3s all ease-in-out;
}
.dropdown-town input:focus + label {
  background: #def;
}
.dropdown-town input {
  width: 1px;
  height: 1px;
  display: inline-block;
  position: absolute;
  opacity: 0.01;
}
.dropdown-town label {
  border-top: 0.06em solid #d9d9d9;
  display: block;
  height: 2em;
  line-height: 2em;
  padding-left: 1em;
  padding-right: 3em;
  cursor: pointer;
  position: relative;
  transition: 0.3s color ease-in-out;
}
.dropdown-town label:nth-child(2) {
  margin-top: 2em;
  border-top: 0.06em solid #d9d9d9;
}
.dropdown-town input:checked + label {
  display: block;
  border-top: none;
  position: absolute;
  top: 0;
  width: 100%;
}
.dropdown-town input:checked + label:nth-child(2) {
  margin-top: 0;
  position: relative;
}
.dropdown-town::after {
  content: "";
  position: absolute;
  right: 0.8em;
  top: 0.9em;
  border: 0.3em solid #3694d7;
  border-color: #3694d7 transparent transparent transparent;
  transition: 0.4s all ease-in-out;
}
.dropdown-town.expanded {
  overflow: auto;
  border: 0.06em solid #3694d7;
  background: #fff;
  border-radius: 0.25em;
  padding: 0;
  box-shadow: rgba(0, 0, 0, 0.1) 3px 3px 5px 0px;
  max-height: 15em;
}
.dropdown-town.expanded label {
  border-top: 0.06em solid #d9d9d9;
}
.dropdown-town.expanded label:hover {
  color: #3694d7;
}
.dropdown-town.expanded input:checked + label {
  color: #3694d7;
}
.dropdown-town.expanded::after {
  transform: rotate(-180deg);
  top: 0.55em;
}

table ,tr td, tr th{
	margin-top: 5px;
    border:1px solid $color-form-highlight;
    border-collapse:separate; 
    border-spacing: 0 0.5em;
}
tbody {
    display:block;
    height:500px;
    overflow:auto;
}

thead, tbody tr {
    display:table;
    width:100%;
    table-layout:fixed;
    /* even columns width , fix width of table too */
}


thead {
    width: calc( 100% - 1em );
    /* scrollbar is average 1em/16px width, remove it from thead width */
    background:#56BCB7;
    color: white;
} 

table {
    width:100%;
} 

.name {
	width:30%;
}
.address {
	width:30%;
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
			}
		});	//on
		
		$(".dropdown-city").change(function() {
			//alert($('#'+$(e.target).attr('for')).val());
			alert("change1");
			
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
	장소 이름, 주소를 클릭하면 지도가 보입니다.
	<br>
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
	
	<button id="ajaxbtn" name="ajaxbtn">검색</button>
	
	<div>
		<table>
			<thead>
				<tr>
					<th class='name'>장소명</th>
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
	<!-- <div id="mapresult" style="width: 100%; height: 100%;"></div> -->
	
</body>
</html>
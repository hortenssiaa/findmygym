<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">

	$(document).ready(function() {
		
		var city= $("#city").children("option:selected").val();
		var town= $("#town").children("option:selected").val();
		
			if(town == "지역을 선택해주세요"){
				
				$.ajax({
					url : '/healthproject/river/city',
					data : {'cityname': city},
					type: 'post',
					
					dataType: 'json',
					success: function(town) {
						
						$("#town").empty();
						$("#town").append("<option value=\"지역을 선택해주세요\" selected=\"selected\">지역을 선택해주세요</option>");
						
						for(var i=0; i<town.length; i++){
							var option = "<option value=\""+town[i]+"\">"+town[i]+"</option>"
							$("#town").append(option);
						}
						
					},
					error: function(request,status,error) {
						alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					}
				});
				
			} else {
				$("#town").empty();
				$("#town").append("<option value=\"지역을 선택해주세요\" selected=\"selected\">지역을 선택해주세요</option>");
			}
		
		$("#city").change(function() {
			
			$("#town").empty();
			$("#town").append("<option value=\"지역을 선택해주세요\" selected=\"selected\">지역을 선택해주세요</option>");
			
			var city= $("#city").children("option:selected").val();
			
				$.ajax({
					url : '/healthproject/river/city',
					data : {'cityname': city},
					type: 'post',
					
					dataType: 'json',
					success: function(town) {
						
						$("#town").empty();
						$("#town").append("<option value=\"지역을 선택해주세요\" selected=\"selected\">지역을 선택해주세요</option>");
						
						for(var i=0; i<town.length; i++){
							var option = "<option value=\""+town[i]+"\">"+town[i]+"</option>"
							$("#town").append(option);
						}
						
					},
					error: function(request,status,error) {
						alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					}
				});
		});//change
		
	});
</script>
</head>
<body>
	<!-- <form action="/action_page.php"> -->
		<label for="city">지역을 선택해주세요</label> 
		<br> 
		<select name="city" id="city">
			<option value="서울특별시" id="seoul" selected="selected">서울특별시</option>
			<option value="부산광역시" id="busan">부산광역시</option>
			<option value="대구광역시" id="deagu">대구광역시</option>
			<option value="인천광역시" id="inchon">인천광역시</option>
			<option value="광주광역시" id="gwangju">광주광역시</option>
			<option value="울산광역시" id="ulsan">울산광역시</option>
			<option value="대전광역시" id="deajeon">대전광역시</option>
			<option value="경기도" id="gyunggi">경기도</option>
			<option value="강원도" id="gangwon">강원도</option>
			<option value="충청북도" id="chungbuk">충청북도</option>
			<option value="충청남도" id="chungnam">충청남도</option>
			<option value="전라북도" id="jeonbuk">전라북도</option>
			<option value="전라남도" id="jeonnam">전라남도</option>
			<option value="경상북도" id="gyungbuk">경상북도</option>
			<option value="경상남도" id="gyungnam">경상남도</option>
			<option value="제주특별자치도" id="jeju">제주특별자치도</option>
		</select> 
		<select name="town" id="town">
			<option value="지역을 선택해주세요" selected="selected">지역을 선택해주세요</option>
		</select> 
		<button id="ajaxbtn" name="ajaxbtn">검색</button>
	<!-- </form> -->
</body>
</html>
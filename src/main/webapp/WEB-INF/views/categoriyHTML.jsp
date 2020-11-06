<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#category {list-style-type: none; position:absolute;top:10px;left:340px;border-radius: 15px; border:1px solid #909090;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.4);background: #fff;overflow: hidden;z-index: 2;}
#category li {height: 20px;float:left;position: relative;list-style: none;width:75px;px;border-right:1px solid #acacac;padding:6px 0;text-align: center; cursor: pointer;}
#category li.on {background: #eee;}
#category li:hover {background: #EDE1FD;border-left:1px solid #acacac;margin-left: -1px;}
#category li:last-child{margin-right:0;border-right:0;}
#category li span {display: block;margin:0 auto 3px;width:20px;height: 1px;align-content: center;}
#category li label {ext-align: center; align-content: left;}
#category li .category_bg {}
#category li .workout {background-position: -10px 0;}
#category li .park {background-position: -10px -36px;}
#category li .river {background-position: -10px -72px;}
#category li .toilet {background-position: -10px -108px;}
#category li .mount {background-position: -10px -144px;}
#category li .bike {background-position: -10px -180px;}
#category li.on .category_bg {background-position-x:-46px;}
#category input[type="radio"] {	display:none; z-index: 100; }
</style>
</head>
<body>
	<ul id="category" >
        <li id="workout" data-order="0"> 
            <span class="category_bg workout"></span>
            <input type="radio" id="inp_workout" name="categories" value="야외운동기구" checked="checked"/>
		    <label for="inp_workout">야외운동기구</label>
            
        </li>       
        <li id="park" data-order="1"> 
            <span class="category_bg park"></span>
            <input type="radio" id="inp_park" value="공원" name="categories"/>
		    <label for="inp_park">공원</label>
        </li>  
        <li id="river" data-order="2"> 
            <span class="category_bg river"></span>
            <input type="radio" id="inp_river" value="강/탄천" name="categories"/>
		    <label for="inp_river">강/탄천</label>
        </li>  
        <li id="toilet" data-order="3"> 
            <span class="category_bg toilet"></span>
            <input type="radio" id="inp_toilet" value="공중 화장실" name="categories"/>
		    <label for="inp_toilet">공중 화장실</label>
        </li>  
        <li id="mount" data-order="4"> 
            <span class="category_bg mount"></span>
            <input type="radio" id="inp_mount" value="산" name="categories"/>
		    <label for="inp_mount">산</label>
        </li>  
        <li id="bike" data-order="5"> 
            <span class="category_bg bike"></span>
            <input type="radio" id="inp_bike" value="자전거" name="categories"/>
		    <label for="inp_bike">자전거</label>
        </li>      
    </ul>
    
    
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/com/libs.jsp" %>  
<!DOCTYPE HTML>
<html>
<head>
<title>后台登录</title>
<link href="login/css/style.css" rel="stylesheet" type="text/css" media="all"/>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="Transparent Login Form Responsive Widget,Login form widgets, Sign up Web forms , Login signup Responsive web form,Flat Pricing table,Flat Drop downs,Registration Forms,News letter Forms,Elements" />
<!--web-fonts--> 
<!--web-fonts-->
<script src="css_js/js/jquery-1.11.1.min.js"></script>
</head>

<body>
<!--header-->
	<div class="header-w3l">
		<h1> 后台登录</h1>
	</div>
<!--//header-->

<!--main-->
<div class="main-content-agile">
	<div class="sub-main-w3">	
		 <form method="post" id="loginform"  action="j_spring_security_check">
			<input placeholder="账号" name="j_username" class="user" type="text" required=""><br>
			<input  placeholder="密码" name="j_password" class="pass" type="password" required=""><br> 
		</form>
		<input type="submit" value="" onclick="login()">
	</div>
</div>
<!--//main-->

<!--footer--> 
</body>
<script>
function login(){
	  document.getElementById('loginform').submit();
	} 
function keydown(e)   
{ var currKey=0,e=e||event;  
	   if(e.keyCode==13){
	     if($("#j_username").val()==''||$("#j_password").val()==''){
	     return;
	     }
	   document.getElementById('loginform').submit();  
	   }
	 }  
document.onkeydown=keydown; 
</script>
</html>
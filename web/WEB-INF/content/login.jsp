<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/com/libs.jsp" %>  
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>后台登录</title>
  <meta name="description" content="particles.js is a lightweight JavaScript library for creating particles.">
  <meta name="author" content="Vincent Garreau" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <link rel="stylesheet" media="screen" href="login2/css/style.css">
  <link rel="stylesheet" type="text/css" href="login2/css/reset.css"/>
  <script src="css_js/js/jquery-1.11.1.min.js"></script>
</head>
<body>

<div id="particles-js">
     <form method="post" id="loginform"  action="j_spring_security_check">
		<div class="login">
			<div class="login-top">
				登录
			</div>
			<div class="login-center clearfix">
				<div class="login-center-img"><img src="login2/img/name.png"/></div>
				<div class="login-center-input">
					<input type="text" name="j_username" value="" placeholder="请输入您的用户名" onfocus="this.placeholder=''" onblur="this.placeholder='请输入您的用户名'"/>
					<div class="login-center-input-text">用户名</div>
				</div>
			</div>
			<div class="login-center clearfix">
				<div class="login-center-img"><img src="login2/img/password.png"/></div>
				<div class="login-center-input">
					<input type="password" name="j_password" value="" placeholder="请输入您的密码" onfocus="this.placeholder=''" onblur="this.placeholder='请输入您的密码'"/>
					<div class="login-center-input-text">密码</div>
				</div>
			</div>
			<div class="login-button" onclick="login()">
				登陆
			</div>
		</div>
		</form>
		<div class="sk-rotating-plane"></div>
</div>

<!-- scripts -->
<script src="login2/js/particles.min.js"></script>
<script src="login2/js/app.js"></script>
<script type="text/javascript">
	function hasClass(elem, cls) {
	  cls = cls || '';
	  if (cls.replace(/\s/g, '').length == 0) return false; //当cls没有参数时，返回false
	  return new RegExp(' ' + cls + ' ').test(' ' + elem.className + ' ');
	}
	 
	function addClass(ele, cls) {
	  if (!hasClass(ele, cls)) {
	    ele.className = ele.className == '' ? cls : ele.className + ' ' + cls;
	  }
	}
	 
	function removeClass(ele, cls) {
	  if (hasClass(ele, cls)) {
	    var newClass = ' ' + ele.className.replace(/[\t\r\n]/g, '') + ' ';
	    while (newClass.indexOf(' ' + cls + ' ') >= 0) {
	      newClass = newClass.replace(' ' + cls + ' ', ' ');
	    }
	    ele.className = newClass.replace(/^\s+|\s+$/g, '');
	  }
	}
		document.querySelector(".login-button").onclick = function(){
				addClass(document.querySelector(".login"), "active")
				setTimeout(function(){
					addClass(document.querySelector(".sk-rotating-plane"), "active")
					document.querySelector(".login").style.display = "none"
				},800)
				setTimeout(function(){
					removeClass(document.querySelector(".login"), "active")
					removeClass(document.querySelector(".sk-rotating-plane"), "active")
					document.querySelector(".login").style.display = "block"
					document.getElementById('loginform').submit();
					
				},5000)
		} 
function keydown(e)   
	{ var currKey=0,e=e||event;  
			   if(e.keyCode==13){
			     if($("#j_username").val()==''||$("#j_password").val()==''){
			     return;
			     }
			     addClass(document.querySelector(".login"), "active")
					setTimeout(function(){
						addClass(document.querySelector(".sk-rotating-plane"), "active")
						document.querySelector(".login").style.display = "none"
					},800)
					setTimeout(function(){
						removeClass(document.querySelector(".login"), "active")
						removeClass(document.querySelector(".sk-rotating-plane"), "active")
						document.querySelector(".login").style.display = "block"
						document.getElementById('loginform').submit();
						
					},5000)
			   }
			 }  
document.onkeydown=keydown; 		
</script>
</body>
</html>
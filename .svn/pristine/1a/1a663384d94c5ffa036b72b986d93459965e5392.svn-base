<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/com/libs.jsp" %> 
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">
  <link rel="shortcut icon" href="images/favicon.png" type="image/png">

  <title>登 录</title>

  <link href="css_js/css/style.default.css" rel="stylesheet">

  <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!--[if lt IE 9]>
  <script src="js/html5shiv.js"></script>
  <script src="js/respond.min.js"></script>
  <![endif]-->
</head>

<body class="signin">
 
<section>
  
    <div class="signinpanel">
        
        <div class="row">
            
            <div class="col-md-7">
                
                <div class="signin-info">
                    <div class="logopanel">
                        <h1><span>[</span> 锦福源家居商城 <span>]</span></h1>
                    </div><!-- logopanel -->
                
                    <div class="mb20"></div>
                
                    <h5><strong>欢迎来到锦福源！</strong></h5>
                    <ul>
                        <li><i class="fa fa-arrow-circle-o-right mr5"></i>家电、家具、壁纸、净水、灯具、卫浴、浴霸、地板、集成吊顶、水暖、壁纸、太阳能、安防、集成吊顶、室内净化、室内绿化、车内净化等15大行业。</li>
                        <li><i class="fa fa-arrow-circle-o-right mr5"></i>
                        1.互联网电商的线下配送、安装、维修问题；
                        2.居民家电、家具等的清洗、保养、安装、维修、搬家的问题；
                        3.各地域的家电、家具、卫浴等经销商的配送、安装、维修问题。</li>
                       
                    </ul>
                    <div class="mb20"></div>
                    <strong>没有账号? <a href="${ctx}/signup.action">注 册</a></strong>
                </div><!-- signin0-info -->
            
            </div><!-- col-sm-7 -->
            
            <div class="col-md-5"> 
                    <h4 class="nomargin">登 录</h4> 
                    <form method="post" id="loginform"  action="j_spring_security_check">
                    
                    <input type="text" id="j_username" name="j_username" value="${sessionScope['SPRING_SECURITY_LAST_USERNAME']}" class="form-control uname" placeholder="账号" />
                    <input type="password" id="j_password" name="j_password" class="form-control pword" placeholder="密码" /> 
                    </form>  
                    <button class="btn btn-success btn-block" onclick="login()">登 录</button> 
            </div><!-- col-sm-5 -->
            
        </div><!-- row -->
        
        <div class="signup-footer">
            <div class="pull-left">
                &copy; 2017. 锦福源家居有限责任公司
            </div>
            
        </div>
        
    </div><!-- signin -->
  
</section>


<script src="css_js/js/jquery-1.11.1.min.js"></script>
<script src="css_js/js/jquery-migrate-1.2.1.min.js"></script>
<script src="css_js/js/bootstrap.min.js"></script>
<script src="css_js/js/modernizr.min.js"></script>
<script src="css_js/js/jquery.sparkline.min.js"></script>
<script src="css_js/js/jquery.cookies.js"></script>

<script src="css_js/js/toggles.min.js"></script>
<script src="css_js/js/retina.min.js"></script>

<script src="css_js/js/custom.js"></script>
<script>
    jQuery(document).ready(function(){
        
        // Please do not use the code below
        // This is for demo purposes only
        var c = jQuery.cookie('change-skin');
        if (c && c == 'greyjoy') {
            jQuery('.btn-success').addClass('btn-orange').removeClass('btn-success');
        } else if(c && c == 'dodgerblue') {
            jQuery('.btn-success').addClass('btn-primary').removeClass('btn-success');
        } else if (c && c == 'katniss') {
            jQuery('.btn-success').addClass('btn-primary').removeClass('btn-success');
        }
    });
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

</body>
</html>

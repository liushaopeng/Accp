<%@ page contentType="text/html;charset=UTF-8"%> 
<%@ include file="/com/libs.jsp" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta charset="utf-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0"/>
  <meta name="description" content=""/>
  <meta name="author" content=""/>
  <link rel="shortcut icon" href="images/favicon.png" type="image/png"/>

  <title>注册</title>

  <link href="html/css/style.default.css" rel="stylesheet"/>

  <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!--[if lt IE 9]>
  <script src="js/html5shiv.js"></script>
  <script src="js/respond.min.js"></script>
  <![endif]-->
</head>

<body class="signin">
 

<section>
  
    <div class="signuppanel">
        
        <div class="row">
            
            <div class="col-md-6">
                
                <div class="signup-info">
                    <div class="logopanel">
                        <h1><span>[</span>  锦福源家居商城  <span>]</span></h1>
                    </div><!-- logopanel -->
                
                    <div class="mb20"></div>
                
                    <h5><strong>Bootstrap 3 Admin Template!</strong></h5>
                    <p>Bracket is a theme that is perfect if you want to create your own content management, monitoring or any other system for your project.</p>
                    <p>Below are some of the benefits you can have when purchasing this template.</p>
                    <div class="mb20"></div>
                    
                    <div class="feat-list">
                        <i class="fa fa-wrench"></i>
                        <h4 class="text-success">Easy to Customize</h4>
                        <p>Bracket is made using Bootstrap 3 so you can easily customize any element of this template following the structure of Bootstrap 3.</p>
                    </div>
                    
                    <div class="feat-list">
                        <i class="fa fa-compress"></i>
                        <h4 class="text-success">Fully Responsive Layout</h4>
                        <p>Bracket is design to fit on all browser widths and all resolutions on all mobile devices. Try to scale your browser and see the results.</p>
                    </div>
                    
                    <div class="feat-list mb20">
                        <i class="fa fa-search-plus"></i>
                        <h4 class="text-success">Retina Ready</h4>
                        <p>When a user load a page, a script checks each image on the page to see if there's a high-res version of that image. If a high-res exists, the script will swap that image in place.</p>
                    </div>
                    
                    <h4 class="mb20">and much more...</h4>
                
                </div><!-- signup-info -->
            
            </div><!-- col-sm-6 -->
            
            <div class="col-md-6">
                
                <form method="post" action="index.html">
                    
                    <h3 class="nomargin">注 册</h3>
                    <p class="mt5 mb20">如果你有账号可以直接登录? <a href="${ctx}/login.action"><strong>登 录</strong></a></p>
                 
                    <div class="mb10">
                        <label class="control-label">账号</label>
                        <input type="text" class="form-control" />
                    </div>
                    
                    <div class="mb10">
                        <label class="control-label">密码</label>
                        <input type="password" class="form-control" />
                    </div>
                    
                    <div class="mb10">
                        <label class="control-label">再次输入密码</label>
                        <input type="password" class="form-control" />
                    </div>
                    <div class="mb10">
                        <label class="control-label">电话</label>
                        <input type="text" class="form-control" />
                    </div>
                    <label class="control-label">身份</label>
                    <div class="row mb10">
                        <div class="col-sm-5">
                            <select class="select2" data-placeholder="身份">
                                <option value=""></option>
                                <option value="1">厂家</option>
                                <option value="2">供应商</option>
                                <option value="3">分销商</option>
                                <option value="4">普通用户</option>
                               
                            </select>
                        </div>
                     
                    </div>  
                    <div class="mb10">
                        <label class="control-label">区域</label>
                        <select class="select2-2" data-placeholder="Choose a Country...">
                          <option value=""></option>
                          <option value="United States">陕西 西安</option>
                          <option value="United Kingdom">甘肃 兰州</option> 
                        </select>
                    </div>
                    <br />
                    
                    <button class="btn btn-success btn-block">注 册</button>     
                </form>
            </div><!-- col-sm-6 -->
            
        </div><!-- row -->
        
        <div class="signup-footer">
            <div class="pull-left">
                &copy; 2014. All Rights Reserved. Bracket Bootstrap 3 Admin Template
            </div>
            <div class="pull-right">
                Created By: <a href="http://themepixels.com/" target="_blank">ThemePixels</a>
            </div>
        </div>
        
    </div><!-- signuppanel -->
  
</section>


<script src="html/js/jquery-1.11.1.min.js"></script>
<script src="html/js/jquery-migrate-1.2.1.min.js"></script>
<script src="html/js/bootstrap.min.js"></script>
<script src="html/js/modernizr.min.js"></script>
<script src="html/js/jquery.sparkline.min.js"></script>
<script src="html/js/jquery.cookies.js"></script>

<script src="html/js/toggles.min.js"></script>
<script src="html/js/retina.min.js"></script>

<script src="html/js/select2.min.js"></script>

<script src="html/js/custom.js"></script>
<script>
    jQuery(document).ready(function(){
        
        jQuery(".select2").select2({
            width: '100%',
            minimumResultsForSearch: -1
        });
        
        jQuery(".select2-2").select2({
            width: '100%'
        });
        
        
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
</script>

</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/com/libs.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="/com/js_css.jsp" %>    
    <script type="text/javascript" src="${ctx}/ckeditor/ckeditor.js"></script>  
    <link href="${ctx}/html/css/font-awesome.min.css" rel="stylesheet">
    <script type="text/javascript">
     
    </script>
    <style type="text/css">

        .fa-spin1 {
            -webkit-animation: fa-spin 1s infinite linear;
            animation: fa-spin 1s infinite linear
        }

        .img-60 {
            width: 60px;
            height: 60px;
        }

    </style>
</head>

<body>

<section>

    <%@include file="/com/header.jsp" %> 
    <div class="mainpanel">
        <%@include file="/com/headerbar.jsp" %>
       <div class="pageheader" style="font-size: 16px">
                <i class="fa fa-home"></i>设置&nbsp;&nbsp;/<span style="font-size: 14px;color:#000;">&nbsp;&nbsp;微信公众号参数设置</span> 
        </div>
        <div class="row">
            <div class="col-md-12">
                               <form id="inscxForm" action="${ctx}/wenxin/wxpay!save.action?"
                      class="form-horizontal" method="post" onsubmit="chk()">
                    <input type="hidden" id="_id" name="_id"/>
         <div class="div-group-10 overflow-hidden">
           <div class="overflow-hidden">
                <div class=" div-group-10 pb-25 bg-bai border-radius5 overflow-hidden">
                  <div class=" div-group-10 pb-25 bg-bai border-radius5 overflow-hidden">
                   <div class="pt-15 pl-15 pr-15 overflow-auto" >
                         <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">原始ID</label>
                                <input type="text" id="toUser" name="toUser" value="${toUser}"
                                       class="form-control" placeholder="请输入" readonly="readonly"/>
                            </div>
                        </div> 
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">开发者ID
(AppID)</label>
                               <input type="text" id="appid" name="appid" value="${entity.appid}"
                                       class="form-control" placeholder="请输入" required="required"/>
                            </div>
                        </div> 
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">开发者密钥
(AppSecret)
</label>
                                <input type="text" id="appsecret" name="appsecret" value="${entity.secret}"
                                       class="form-control" placeholder="请输入" required="required"/>
                            </div>
                        </div> 
                       
                    </div> 
                      <div class="div-group-1 " style="padding-left: 40px; padding-right: 40px;">
                        <button class="btn btn-danger width-10 maring-a clear weight500 hang40">提 交
                        </button>
                    </div> 
                    </div>
                    </div>
                  </div>  
                  </div> 
                </form>
            </div>
            </div> 
       </div> 
    <!-- mainpanel -->
</section>   
      
<script type="text/javascript">
  
    jQuery(".select2").select2({
        width: '100%'
    });
    $('#typeid').change(function(){ 
    	var id=$("#typeid").val();
    	if(isNaN(id)||id==null){
    		
    	}else{ 
    		getchild(id); 	
    	}
    	
    	
    });
    $("#typeid").val("${entity.typeid}").trigger("change");
    
    //实例化编辑器
    //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
  
   var editor=CKEDITOR.replace('content');

    function checksubmit() {
        $("#content").val(editor.getData());
        $('#custinfoForm').submit();
    }
  
</script>
<div class="confirm-mask">
<div class="confirm-mask-content">
		<div class="confirm-content">
			
		</div>
		<div class="confirm-btns">
			<span class="confirm-cancel" style="background: #f00;border-radius: 0 0 0 10px;">取消</span>
			<span class="confirm-sure" style="background: #007FF5;border-radius: 0 0 10px 0;">确定</span>
		</div>
	</div>
</div>
<div class="tip-mask"></div> 
</body>
</html>
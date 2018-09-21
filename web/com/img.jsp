<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/com/libs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> 
<style>
.line-height10{
line-height: 10px;
}
</style>
<!--弹出页面色值图标选择-->
<div class="fullscreen bg-hei-8 display-none" style="height: 100%;z-index: 9999" id="img_tanchu">
    <div style="padding-top:2%;padding-left: 20%">
        <div class="div-group-15 maring-a position-r"style="width: 100%;max-width: 80%;min-width: 320px;margin: 0px auto;right: 0px;">

           <div class="col-8" style="height: 25px;text-align: center;">
                 <label class="control-label">信使图库</label>
           </div>
            <div class=" bg-bai border-radius3">
              <div class="pt-5 pb-5 pr-5 pl-5 overflow-hidden bg-hui-qj">
                    <div class="overflow-hidden border-radius5 bg-hui-qj line-lu"> 
                        <div class="col-10 bg-bai" style="height: 25px;">
                            <input class=" width-10 txt-c zi-hui" style="background-color: transparent;line-height: 23px;"
                                   type="text"
                                   id="sel"  value="搜索" onfocus="if(value=='搜索'){value=''}"
                                   onblur="if (value ==''){value='搜索'}">
                        </div> 
                        <div class="col-2 txt-c bg-bai" style="height: 25px;" onclick="sel_img()">
                                <i class="fa fa-search zi-hui" style="line-height: 23px;"></i>
                        </div> 
                    </div>
                </div>
                
                <div class="row pl-20 pt-10 pb-10 overflow-hidden pt-10 width-10  overflow-auto"style="height: 500px;" id="ajax_ioc">
                    
                     
                </div>
            </div>

            <a href="javascript:img_hide()">
                <div class="position-a" style="right:13px;top:10px;">
                    <div class="img-wh20 border-radius50 bg-hui-tx txt-c line-height20">
                        <font size="2">
                            <i class="fa fa-remove zi-green line-height20"></i>
                        </font>
                    </div>
                </div>
            </a>


        </div>

    </div>


</div>

<!--弹出页面色值图标选择-->
<div class="fullscreen bg-hei-8 display-none"  style="height: 100%; width:350px; z-index: 99999999" id="selimg_tanchu">
    <div style="padding-top:1%">
        <div class="div-group-15 maring-a position-r"style="width: 100%;max-width: 400px;min-width: 320px;margin: 0px auto;right: 0px;">

            <div class=" bg-bai border-radius3">
               
                
                <div class="row pl-20 pt-10 pb-10 overflow-hidden pt-10 width-10  overflow-auto">
                    <img  id="selimgs"   src="" width="100%">  
                </div>
            </div>

            <a href="javascript:selimg_hide()">
                <div class="position-a" style="right:13px;top:10px;">
                    <div class="img-wh20 border-radius50 bg-hui-tx txt-c line-height20">
                        <font size="2">
                            <i class="fa fa-remove zi-green line-height20"></i>
                        </font>
                    </div>
                </div>
            </a>


        </div>

    </div>


</div>
<script>
var vg='';
var obj='';
function img_hide(){
 $("#img_tanchu").hide();
 $("#"+obj).show();
}
function img_show(){
 $("#img_tanchu").show();
}
function set_img(v,g,w,h){
 $("#"+v).val(g);
 $("#"+v).attr("imgW",w);
 $("#"+v).attr("imgH",h);
 img_hide();
}

function sel_img(){
	init_img(vg,obj);
}
function  init_img(fg,gf){
   vg=fg;
   obj=gf;
   $("#"+obj).hide();
  var submitData = {
        sel:$("#sel").val().replace("搜索","") 
		};
		$.post('${ctx}/suc/image!ajaxWeb.action', submitData, function(json) {
			  if (json.state == 0) {
			  var  html='';
			  var  list=json.list;
			   for (var i = 0; i < list.length; i++) {
				   html+='<div class="pb-15 col-sm-1">'
			          +'<img height="50px" onclick="set_img(\''+fg+'\',\''+list[i].picurl+'\','+list[i].width+','+list[i].height+')" onmouseout="selimg_hide()" onmouseover="initSelimg(\'${filehttp}/'+list[i].picurl+'\')" src="${filehttp}/'+list[i].picurl+'"class="border-radius3 width-10 bg-hei-8">'
			          +'<div class="txt-c zi-hei-tq sl size10">'+list[i].title
			          +'</div><div onclick="ajaxDel('+list[i]._id+')" class="position-a" style="right:7px;top:-5px;">'
			          +'<div class="img-wh10 border-radius50 bg-hui-tx txt-c line-height10">'
			          +'<font size="1"><i class="fa fa-remove zi-green line-height10"></i>'
			          +'</font> </div>'
			          +'</div></div>'; 
	                   
                 
              
			   }
			   $("#ajax_ioc").html(html);
			  
			  }

		}, "json")
		img_show();
} 

function  selimgshow(){
	$("#selimg_tanchu").show();
}
function  selimg_hide(){
	$("#selimg_tanchu").hide();
} 
function  initSelimg(v){
	$("#selimgs").attr("src",v);
	selimgshow();
}
function   ajaxDel(v){
	 if (confirm('确实要删除吗?')) {
		 var submitData = {
			        id:v,
			        sel:$("#sel").val().replace("搜索","") 
					};
					$.post('${ctx}/suc/image!ajaxDel.action', submitData, function(json) {
						  if (json.state == 0) { 
							  var  html='';
							  var  list=json.list;
							   for (var i = 0; i < list.length; i++) {
								   html+='<div class="pb-15 col-sm-1">'
							          +'<img height="50px" onclick="set_img(\''+vg+'\',\''+list[i].picurl+'\')" onmouseout="selimg_hide()" onmouseover="initSelimg(\'${filehttp}/'+list[i].picurl+'\')" src="${filehttp}/'+list[i].picurl+'"class="border-radius3 width-10 bg-hei-8">'
							          +'<div class="txt-c zi-hei-tq sl size10">'+list[i].title
							          +'</div><div onclick="ajaxDel('+list[i]._id+')" class="position-a" style="right:7px;top:-5px;">'
							          +'<div class="img-wh10 border-radius50 bg-hui-tx txt-c line-height10">'
							          +'<font size="1"><i class="fa fa-remove zi-green line-height10"></i>'
							          +'</font> </div>'
							          +'</div></div>';  
							   }
							   $("#ajax_ioc").html(html);
						  } 
					}, "json")
	 }
	
}
</script>
 
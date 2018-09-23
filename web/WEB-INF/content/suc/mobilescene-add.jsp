<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/com/libs.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en"> 
<%@include file="/com/js_css.jsp" %>  
<style type="text/css">
.dialog-590{
 width: 590px;
 margin: 10% auto;
}
.dialog-750{
 width: 750px;
 margin: 7% auto;
}
.dialog-500{
 width: 500px;
 margin: 5% 1% 1% 50%;
}

textarea{ resize:none; width:200px; height:200px;} 
</style>
<script type="text/javascript"src="${ctx}/color/jscolor.js"></script>
<script type="text/javascript"> 
var  styletype;
var  scid;
var  styleid;
var  animaid;
var  animatype;
var  scsort=0;
 
function share(url) {
	window.open("${contextPath}/weixin/share.action?method="+ encodeURIComponent(url));
}
 
function footpic(index,value){
	$('#footpic'+index).val(value);
}

function addfunc(){
	$('#funcid').val('');
	$('#funcname').val('');
	$('#key').val('');	
	$('#type').val('');	
	$('#url').val('');	
	$('#mb').val('');	
	$('#picurl').val('');	
	$('#summary').val('');	
	$('#sort').val('');	
	
	$('#insfunc').modal({ 
	    show:true
	});
}
function updfunc(id){
	var submitData = {
			_id:id
	};
	$.post('${ctx}/wx/wxfunc!upd.action', submitData,
		function(json) {
		$('#funcid').val(json._id);
		$('#funcname').val(json.name);
		$('#key').val(json.key);	
		$('#type').val(json.type);	
		$('#url').val(json.url);	
		$('#mb').val(json.mb);	
		$('#uploadresultTwo').val(json.picurl);	
		$('#summary').val(json.summary);	
		$('#sort').val(json.sort);	
		$('#adminurl').val(json.adminurl);	
		$('#xs').val(json.xs);	
		changeurl(json.type);
				
	},"json")
	
	$('#insfunc').modal({ 
	    show:true
	});
}
function addadv(){
	$('#advid').val('');
	$('#advtitle').val('');
	$('#advurl').val('');	
	
	$('#uploadresult').val('');	
	$('#advsort').val('');	
	
	$('#insadv').modal({ 
	    show:true
	});
}

function updadv(id,title,url,picurl,sort){
	$('#advid').val(id);
	$('#advtitle').val(title);
	$('#advurl').val(url);	
	
	$('#uploadresult').val(picurl);	
	$('#advsort').val(sort);	
	
	$('#insadv').modal({ 
	    show:true
	});
}
function addroll(){
   if(!checkid(2)){
    return;
    };
	$('#rollid').val('');
	$('#rolltitle').val('');
	$('#rollurl').val('');	
	$('#rollsort').val('');	
	
	$('#insroll').modal({ 
	    show:true
	});
}
function addnavi(){
   if(!checkid(3)){
    return;
    };
	$('#naviid').val('');
	$('#navititle').val('');
	$('#naviurl').val('');	
	$('#navisort').val('');	
	
	$('#insnavi').modal({ 
	    show:true
	});
}
function addScene(){
    
	$('#sceneid').val('');
	$('#scenetitle').val('');
	$('#sceneurl').val('');	
	$('#scenebj').val('');

	$('#scenesort').val(0);	
	
	$('#insScene').modal({ 
	    show:true
	});
}
function addwxpay(){
	var submitData = {};
	$.post('${ctx}/wx/wxtouser!updpay.action?_id=${entity.toUser}', submitData,
			function(json) {
				$('#partner').val(json.partner);
				$('#partner_key').val(json.partner_key);	
				$('#appkey').val(json.appkey);	
				
	},"json")
	$('#inspay').modal({ 
		    show:true
	});
}

function delfunc(id,tab) {
	if(confirm('确实要删除吗?')) {
		location.href = "${ctx}/wx/wxtouser!delfunc.action?funcid="+ id+"&tab="+tab;
	}		
}
function deladv(id,tab) {
	if(confirm('确实要删除吗?')) {
		location.href = "${ctx}/wx/wxtouser!deladv.action?_id="+ id+"&tab="+tab;
	}		
}
function delroll(id,tab) {
	if(confirm('确实要删除吗?')) {
		location.href = "${ctx}/wx/wxtouser!delroll.action?_id="+ id+"&tab="+tab;
	}		
}
function changeurl(value) {
	if(value=="link"){
		$("#urlcontrol").show();
	}else{
		$("#urlcontrol").hide();
	}
	
}
function getpic(xsvalue) {
	$('#xsvalue').val(xsvalue);
    $('#tubiao').show();
}
function seltb(key){
	var a=$('#xsvalue').val();
	$('#'+a).val(key);
	$('#tubiao').hide();
}
function xzsb() {
    $('#sbtb').show();
}
function close_box(){
	$('#sbtb').hide();
}
function selsb(key,value){
	$('#css').val(key);
	$('#sbtb').hide();
}
function addmb(){

$('#insmb').modal({ 
	    show:true
	});
}

function  changemb(id){ 
  var  subdata={
    mb:id,
    webid:$("#webid").val(),
    comid:'${comid}',
    toUser:'${toUser}'
  
  }; 
  $.post("${ctx}/website/website!ajaxsaveMb.action",subdata,function(json){
     if(json.state==0){ 
     $("#webid").val(json.webid);
     $("#slidewebid").val(json.webid);
     $("#rollwebid").val(json.webid);
     $("#naviwebid").val(json.webid);
     alert("设置成功");
     }else{
     alert("设置失败");
     }
     location.reload();
   },"json");

}
function checkid(v){
  if($('#webid').val()==""){
      alert("请先设置模板");
      $('#li_'+v).removeClass("active");
      $('#tab'+v).removeClass("active");
      $('#li_0').addClass("active");
      $('#tab0').addClass("active");
      return false;
    }
  return true;
}
function checkweb(){
 
    return;
 
}
function delScene(id){

    var submitdata={
    id:id,
    msid:'${msid}'
   };
   $.post("${ctx}/suc/mobilescene!delScene.action?custid=${custid}",submitdata,function(json){ 
   
      var  html=""; 
      var  list=json.list;
       html+='<table class="table table-striped table-success mb30"><thead>'
           +'<tr><th>序号</th><th>名称</th><th>背景图</th><th>操作</th></tr>'
           +'</thead><tbody>'; 
      if(json.state==0){ 
       for ( var v = 0; v<list.length; v++) {
        
		  html+='<tr><td>'+list[v].sort+'</td>'
		      +'<td>'+list[v].title+'</td>'
		      +'<td><img src="${filehttp}'+list[v].picurl+'" alt="" style="height: 25px;"></td>'
		      +'<td class="table-action"><div class="btn-group1 position-r"><a data-toggle="dropdown" class="dropdown-toggle">'
		      +'<i class="fa fa-cog"></i></a>'
		      +'<ul role="menu" class="dropdown-menu pull-right">'
		      +'<li><a href="javascript:updScene('+list[v]._id+')">'
		      +'<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a></li>'
		      +'<li><a href="javascript:getSpirit('+list[v]._id+')">'
		      +'<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;管理精灵</a></li>'
		      +' <li><a href="javascript:delScene('+list[v]._id+');"><i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>'
		      +'</ul></div></td></tr>';
		            
	      }
	    } 
	     
	    html+='</tbody></table><span class="btn btn-darkblue btn-block" id="btnScene" onclick="addScene();"><li class="fa fa-plus"></li>&nbsp;&nbsp;添加图层</span>';
	    $('#scene').html('');
	    $('#scene').html(html);
	    $('#li_1 a strong').html('图层管理');
	    refresh();
    
   
   },"json");
 

}
function gobackScene(){
   var submitdata={
    id:'${msid}'
   };
   $.post("${ctx}/suc/mobilescene!getScene.action?custid=${custid}",submitdata,function(json){ 
   
      var  html=""; 
      var  list=json.list;
       html+='<table class="table table-striped table-success mb30"><thead>'
           +'<tr><th>序号</th><th>名称</th><th>背景图</th><th>操作</th></tr>'
           +'</thead><tbody>'; 
      if(json.state==0){ 
       for ( var v = 0; v<list.length; v++) {
        
		  html+='<tr><td>'+list[v].sort+'</td>'
		      +'<td>'+list[v].title+'</td>'
		      +'<td><img src="${filehttp}'+list[v].picurl+'" alt="" style="height: 25px;"></td>'
		      +'<td class="table-action"><div class="btn-group1 position-r"><a data-toggle="dropdown" class="dropdown-toggle">'
		      +'<i class="fa fa-cog"></i></a>'
		      +'<ul role="menu" class="dropdown-menu pull-right">'
		      +'<li><a href="javascript:updScene('+list[v]._id+')">'
		      +'<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a></li>'
		      +'<li><a href="javascript:getSpirit('+list[v]._id+','+list[v].sort+')">'
		      +'<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;管理精灵</a></li>'
		      +' <li><a href="javascript:delScene('+list[v]._id+');"><i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>'
		      +'</ul></div></td></tr>';
		            
	      }
	    } 
	     
	    html+='</tbody></table><span class="btn btn-darkblue btn-block" id="btnScene" onclick="addScene();"><li class="fa fa-plus"></li>&nbsp;&nbsp;添加图层</span>';
	    $('#scene').html('');
	    $('#scene').html(html);
	    $('#li_1 a strong').html('图层管理');
    
   
   },"json");
 
}
function delSpirit(id){ 
   var submitdata={
    id:id,
    custid:'custid',
    scid:scid
   };
   $.post("${ctx}/suc/mobilescene!deleteSpirit.action",submitdata,function(json){ 
     
      var  html=""; 
      var  list=json.list;
       html+='<table class="table table-striped table-success mb30"><thead>'
           +'<tr><th>序号</th><th>名称</th><th>背景图</th><th>操作</th></tr>'
           +'</thead><tbody>'; 
      if(json.state==0){ 
       for ( var v = 0; v<list.length; v++) {
		  html+='<tr><td>'+list[v].sort+'</td>'
		      +'<td style="width:380px;display:block;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;">'+list[v].title+'</td>'
		      +'<td><img src="${filehttp}'+list[v].picurl+'" alt="" style="height: 25px;"></td>' 
		      +'<td class="table-action"><div class="btn-group1 position-r"><a data-toggle="dropdown" class="dropdown-toggle">'
		      +'<i class="fa fa-cog"></i></a>'
		      +'<ul role="menu" class="dropdown-menu pull-right">'
		      +'<li><a href="javascript:updSpirit('+list[v]._id+')">'
		      +'<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a></li>' 
		      +'<li><a href="javascript:delSpirit('+list[v]._id+');"><i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>'
		      +'<li><a href="javascript:updSpiritStyle('+list[v]._id+');"><i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;样式</a></li>'
		       +'<li><a href="javascript:updSpiritAnimation('+list[v]._id+');"><i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;动画</a></li>'
		      +'</ul></div></td></tr>';
		           
	      }
	    } 
	    html+='</tbody></table><span class="btn btn-darkblue btn-block" id="btSpirit" onclick="addSpirit();"><li class="fa fa-plus"></li>&nbsp;&nbsp;添加精灵</span>'
	    +'<span class="btn btn-darkblue btn-block" id="btSpirit" onclick="gobackScene();"><li class="fa fa-plus"></li>&nbsp;&nbsp;返回父层</span>'; 
	    $('#scene').html('');
	    $('#scene').html(html);
	    $('#li_1 a strong').html('精灵管理');
	    refresh();
   
   },"json");
} 

function getSpirit(id,t){ 
  scsort=t; 
  scid=id;
 var submitdata={
    id:id
   };
   $.post("${ctx}/suc/mobilescene!getSpirits.action",submitdata,function(json){ 
   
      var  html=""; 
      var  list=json.list;
       html+='<table class="table table-striped table-success mb30"><thead>'
           +'<tr><th>序号</th><th>名称</th><th>背景图</th><th>操作</th></tr>'
           +'</thead><tbody>'; 
      if(json.state==0){ 
       for ( var v = 0; v<list.length; v++) {
		  html+='<tr><td>'+list[v].sort+'</td>'
		      +'<td style="width:380px;display:block;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;">'+list[v].title+'</td>'
		      +'<td><img src="${filehttp}'+list[v].picurl+'" alt="" style="height: 25px;"></td>' 
		      +'<td class="table-action"><div class="btn-group1 position-r"><a data-toggle="dropdown" class="dropdown-toggle">'
		      +'<i class="fa fa-cog"></i></a>'
		      +'<ul role="menu" class="dropdown-menu pull-right">'
		      +'<li><a href="javascript:updSpirit('+list[v]._id+')">'
		      +'<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a></li>' 
		      +'<li><a href="javascript:delSpirit('+list[v]._id+');"><i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>'
		      +'<li><a href="javascript:updSpiritStyle('+list[v]._id+');"><i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;样式</a></li>'
		       +'<li><a href="javascript:updSpiritAnimation('+list[v]._id+');"><i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;动画</a></li>'
		      +'</ul></div></td></tr>';
		           
	      }
	    } 
	    html+='</tbody></table><span class="btn btn-darkblue btn-block" id="btSpirit" onclick="addSpirit();"><li class="fa fa-plus"></li>&nbsp;&nbsp;添加精灵</span>'
	    +'<span class="btn btn-darkblue btn-block" id="btSpirit" onclick="gobackScene();"><li class="fa fa-plus"></li>&nbsp;&nbsp;返回父层</span>'; 
	    $('#scene').html('');
	    $('#scene').html(html);
	    $('#li_1 a strong').html('精灵管理');
	    refresh();
  
   
   },"json");
}
function updSpirit(id){
 
  var submitData = {
			id:id,
		 	
	};
	$.post('${ctx}/suc/mobilescene!updateSpirit.action', submitData,
		function(json) { 
		    $('#spiritid').val(json._id); 
			$('#spirittitle').val(json.title);
			$('#spiriturl').val(json.url);
			$('#spirittype').val(json.type);
			$('#spiritsort').val(json.sort);
			$('#spiritpicurl').val(json.picurl);
			 
		   
	},"json");


  $('#insSpririt').modal({ 
	    show:true
 	});
}
function addSpirit(){  
	$('#spiritid').val(''), 
	$('#spiriturl').val(''),
	$('#spirittitle').val(''),
	$('#spiritpicurl').val(''),
	$('spiritsummary').val(''),
	$('#spiritsort').val(0),  
	$('#spirittype').val(0),
    $('#insSpririt').modal({ 
	    show:true
 	});
}
function AdSpirit(){ 
   var submitData = {
			id:$('#spiritid').val(),
			scid:scid,
			url:$('#spiriturl').val(),
			title:$('#spirittitle').val(),
			picurl:$('#spiritpicurl').val(),
			summary:$('spiritsummary').val(),
			sort:$('#spiritsort').val(),  
			type:$('#spirittype').val(),
			width:80,
			height:(80*$('#spiritpicurl').attr('imgH'))/$('#spiritpicurl').attr('imgW'),
			
	};
	$.post('${ctx}/suc/mobilescene!updSpirit.action?custid=${custid}', submitData,
		function(json) {   
		  var  html=""; 
          var  list=json.list;
       html+='<table class="table table-striped table-success mb30"><thead>'
           +'<tr><th>序号</th><th>名称</th><th>图片</th><th>操作</th></tr>'
           +'</thead><tbody>'; 
      if(json.state==0){ 
    	  refresh();
       for ( var v = 0; v<list.length; v++) {
		  html+='<tr><td>'+list[v].sort+'</td>'
		      +'<td style="width:380px;display:block;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;">'+list[v].title+'</td>'
		      +'<td><img src="${filehttp}'+list[v].picurl+'" alt="" style="height: 25px;"></td>' 
		      +'<td class="table-action"><div class="btn-group1 position-r"><a data-toggle="dropdown" class="dropdown-toggle">'
		      +'<i class="fa fa-cog"></i></a>'
		      +'<ul role="menu" class="dropdown-menu pull-right">'
		      +'<li><a href="javascript:updSpirit('+list[v]._id+')">'
		      +'<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a></li>' 
		      +' <li><a href="javascript:delSpirit('+list[v]._id+',1);"><i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>'
		      +'<li><a href="javascript:updSpiritStyle('+list[v]._id+');"><i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;样式</a></li>'
		      +'<li><a href="javascript:updSpiritAnimation('+list[v]._id+');"><i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;动画</a></li>'
		      +'</ul></div></td></tr>';
		            
	      }
	    } 
	    html+='</tbody></table><span class="btn btn-darkblue btn-block" id="btSpirit" onclick="addSpirit();"><li class="fa fa-plus"></li>&nbsp;&nbsp;添加精灵</span>'
	    +'<span class="btn btn-darkblue btn-block" id="btSpirit" onclick="gobackScene();"><li class="fa fa-plus"></li>&nbsp;&nbsp;返回父层</span>'; 
	    $('#scene').html('');
	    $('#scene').html(html);
	    $('#li_1 a strong').html('精灵管理'); 
	   
	    
  
		  
		  
	},"json");
 	
   
}
 
function  updScene(id){

var submitData = {
			id:id
	};
	$.post('${ctx}/suc/mobilescene!updateSceneById.action', submitData,
		function(json) {
		$('#sceneid').val(json._id);
		$('#scenetitle').val(json.title);
		$('#sceneurl').val(json.url);
		$('#scenesort').val(json.sort);
		$('#uploadresult').val(json.picurl);
		$('#scenesort').val(json.sort);
		 		
	},"json");
	
	$('#insScene').modal({ 
	    show:true
 	});
}
 
function  updSpiritStyle(id){
  styletype='scene';
  styleid=scid+'-'+id;  
  var submitData = {
			id:'${custid}'+'-'+styletype+'-'+styleid,
		 	
	};
	$.post('${ctx}/suc/mobilescene!updStyle.action', submitData,
		function(json) {   
			$('#fl').html(json.marginleft),
			$('#ft').html(json.margintop),
			$('#styleh').val(json.height),
			$('#stylew').val(json.width),
			$('#stylecolor').val(json.color),
			$('#border-radius').html(json.radius)
			styleh=json.height;
			stylew=json.width;
			 // Basic Slider滑动监听
		    jQuery('#slider-float-left').slider({
		      range: "min",
		      max: 1000,
		      value:json.marginleft*10,
		      slide: function(event, ui ) {
		        $("#fl").html(ui.value/10);
		        updStyle(); 
		      }
		    });
			  $("#slider-float-top").slider({
			      range: "min",
			      max: 1000,
			      value:parseFloat(json.margintop)+500,
			      slide: function(event, ui ) { 
			       $("#ft").html(ui.value-500);
			       updStyle();
			        
			      }
			    });
			    $("#slider-border-radius").slider({
			     range:"min",
			     max:1000,
			     value:json.radius,
			     slide:function(event,ui){
			      $("#border-radius").html(ui.value);
			      updStyle();
			     }
			    
			    });
		   
		   
	},"json");
  
  $('#insStyle').modal({ 
	    show:true
	});
}
function updSpiritAnimation(id){
animaid=scid+'-'+id;
animatype='scene';
var submitData = {
			id:'${custid}'+'-'+animatype+'-'+animaid,
		 	
	}; 
	$.post('${ctx}/suc/mobilescene!updAnima.action', submitData,
		function(json) {  
			$('#animaValue').val(json.value);
			$('#animaiterate').val(json.iterate);
			$('#animaduration').val(json.duration);
			$('#animakeep').val(json.keep);
			 
		   
	},"json");
  


 $('#insAnima').modal({ 
	    show:true
	});
}

function  updMp3(type){
styletype=type;
styleid='${styleid}';
 var submitData = {
			id:'${custid}'+'-'+styletype+'-'+styleid,
		 	
	}; 
	$.post('${ctx}/suc/mobilescene!updStyle.action', submitData,
		function(json) {  
			$('#fl').html(json.marginleft),
			$('#ft').html(json.margintop/bheight*100),
			$('#styleh').val(json.height),
			$('#stylew').val(json.width),
			$('#stylecolor').val(json.color),
			$('#border-radius').html(json.radius);
			
			 // Basic Slider滑动监听
    jQuery('#slider-float-left').slider({
      range: "min",
      max: 1000,
      value:json.marginleft*10,
      slide: function(event, ui ) {
        $("#fl").html(ui.value/10);
        updStyle(); 
      }
    });
    $("#slider-float-top").slider({
      range: "min",
      max: 1000,
      value:json.margintop+500,
      slide: function(event, ui ) { 
       $("#ft").html(ui.value-500);
       updStyle();
        
      }
    });
    $("#slider-border-radius").slider({
     range:"min",
     max:1000,
     value:json.radius,
     slide:function(event,ui){
      $("#border-radius").html(ui.value);
      updStyle();
     }
    
    });
			
			
		   
	},"json");
  

$('#insStyle').modal({ 
	    show:true
	});
 
}
var  styleh;
var  stylew;
function updStyle(){  
var submitData = {
			id:styleid,
			type:styletype,
			ml:$('#fl').html(),
			mt:$('#ft').html(),
			h:$('#styleh').val(),
			w:$('#stylew').val(),
			color:$('#stylecolor').val(),
			radius:$('#border-radius').html(),
			
	}; 
	$.post('${ctx}/suc/mobilescene!updateStyle.action?custid=${custid}', submitData,
		function(json) { 
		refresh(); 
	},"json");
 	

}
function updAnima(){  
var submitData = {
			id:animaid,
			type:animatype,
			value:$('#animaValue').val(),
			iterate:$('#animaiterate').val(),
			duration:$('#animaduration').val(),
			keep:$('#animakeep').val()
	}; 
	$.post('${ctx}/suc/mobilescene!updateAnima.action?custid=${custid}', submitData,
		function(json) { 
		  document.getElementById('leftmenu').contentWindow.location.reload(true); 
	},"json");
 	

}

function gb(){
    	$('#tubiao').hide();
    	$('#jqpic').hide();
    	$('#clipArea').html('');
    	
    }
function changestyle(v){
	if($("#checkbox4").attr("checked")=="checked"){
		 if($(v).attr("id")=="styleh"){
		    	//
		    	var st=$(v).val()/parseFloat(styleh);
		    	$("#stylew").val($("#stylew").val()*st);
		    	 
		    }else if($(v).attr("id")=="stylew"){
		    	var st=$(v).val()/parseFloat(stylew);
		    	$("#styleh").val($("#styleh").val()*st);
		    }	
	} 
    styleh=$("#styleh").val();
	stylew=$("#stylew").val();
	updStyle();
}
</script>
<style>
  .iphone5s{
        width: 450px;
        height:750px;
        margin:-60px auto;
        background-color: #2e2e2e;
        border:10px solid #3b3b3b;
        border-radius: 55px;
        position: relative;
        box-shadow: 3px 5px 5px  rgba(0,0,0,0.5);
    }
    .iphone5s:before
    {   content: "";
        position: absolute;
        width: 66px;
        height: 6px;
        background-color: #2e2e2e;
        right:60px;
        top:-16px;
        border-radius: 3px 3px 0 0;
    }
    .iphone5s:after{
        content: "";
        position: absolute;
        height: 45px;
        width: 6px;
        background-color: #2e2e2e;
        left:-16px;
        top:100px;
    }
    .listen{
        width: 6px;
        height:6px;
        background-color: #1a1a1a;
        border:3px solid #4a4a4a;
        position: absolute;
        top:30px;
        left:50%;
        margin-left:-8px;
        border-radius: 50%;
        box-shadow: 2px 2px 2px  rgba(0,0,0,0.5);
 
    }
    .speaker{
        width: 60px;
        height:5px;
        border:5px solid #4a4a4a;
        background-color: #1a1a1a;
        position: absolute;
        left:50%;
        margin-left:-35px;
        top:50px;
        border-radius: 10px;
        box-shadow: 2px 2px 2px  rgba(0,0,0,0.5);
 
    }
    .content{
        width: 375px;
        height: 590px;
        background-color: #0a0a0a;
        margin:80px auto 0;
        font:35px/590px "微软雅黑";
        text-align: center;
        color:white;
        border:4px solid #1a1a1a;
        position: relative;
 
    }
    .content:before{
        content: "";
        width: 375px;
        height: 590px;
        position: absolute;
        top:0;
        left:0;
        background: -webkit-linear-gradient(top left,rgba(255,255,255,0.3),rgba(255,255,255,0) 80%)
    }
    .home{
        width: 50px;
        height: 50px;
        background-color: #1a1a1a;
        border-radius: 50%;
        margin:5px auto 0;
        position: relative;
        box-shadow: 2px 2px 2px  rgba(0,0,0,0.2) inset;
    }
    .home:before{
        content: "";
        width: 20px;
        height: 20px;
        border:2px solid rgba(255,255,255,0.7);
        position:absolute;
        top:13px;
        left:15px;
        border-radius: 3px;
 
    }
    </style>
    <script type="text/javascript">
    function ckOnchange(v){
    	if($("#checkbox"+v).attr('checked')=="checked"){
    		var ht=$("#imgup"+v).attr("onclick"); 
        	ht=ht.replace("\'0\'","\'1\'");
        	$("#imgup"+v).attr("onclick",ht);
    	}else{
    		var ht=$("#imgup"+v).attr("onclick"); 
        	ht=ht.replace("\'1\'","\'0\'");
        	$("#imgup"+v).attr("onclick",ht);
    	}
    	
    	
    	
    }
    </script>
</head>

<body>

<section>

  <%@include file="/com/header.jsp"%>
<input type="hidden" id="xsvalue" value="0" 	name="xsvalue" />
<div class="mainpanel">
	<%@include file="/com/headerbar.jsp"%>
   
    <div class="pageheader">
      
      <h2><i class="fa fa-eye"></i>微场景 <span>场景添加</span></h2>
      <div class="breadcrumb-wrapper1">
        <div class="form-group pull-right btn-group">
        	<button type="button" class="btn btn-darkblue dropdown-toggle" data-toggle="dropdown">
                      	菜单 <span class="caret"></span>
            </button>
            <ul class="dropdown-menu pull-right" role="menu"> 
            	<li><a href="javascript:qrcode('http://www.wbaishui.com/Acc_Manage/suc/mobilescene!web.action?custid=${custid}&msid=${msid}')" target="_blank"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;预览</a></li>
            	 
            </ul>
         </div>
      </div>
    </div>
	<div class="contentpanel" style="margin-top: 50px">
    
                           
	<div class="row" id="hswe">
    	<div class="col-md-5">  
            	<div class="shouji"></div>
            	<div class="shouji_di"></div>
            	<div class="iphone5s">
                <div class="listen"></div>
                <div class="speaker"></div>
            
                <div class="content">
               
                     <iframe name="leftmenu" id="leftmenu"  marginwidth=1 marginheight=10 frameborder=no  width="375px"  height=590px id="myiframe"
                	src='${ctx}/suc/mobilescene!yl.action?custid=${entity.custid}&msid=${entity._id}'scrolling="auto" ></iframe>
                </div>
                <div class="home"></div> 
                </div>  
    	</div><!-- col-md-5 -->
    	   
		<div class="col-md-7">
		  <div class="btn btn-danger  hang40" onclick="previouspage()">上一页
          </div> 
           <div class="btn btn-danger  hang40" onclick="nextpage()">下一页
          </div> 
           <div class="btn btn-danger  hang40" onclick="refresh()">刷新
          </div> 
			<ul class="nav nav-tabs nav-justified" id="tabs">
          		<li id="li_0" <c:if test='${tab==0}'>class="active"</c:if>><a href="#tab0" data-toggle="tab"><strong>基础设置</strong></a></li>
          		<li id="li_1" <c:if test='${tab==1}'>class="active"</c:if>><a href="#tab1" data-toggle="tab"><strong>图层管理</strong></a></li>
          		
        	</ul>
			<div class="tab-content" id="tabs-body" >
          		<div class="tab-pane <c:if test='${tab==0}'>active</c:if> " id="tab0">
            	  
            		<div class="panel panel-default">
                
                <div class="panel-body">
                    <form id="websiteForm" action="${ctx}/suc/mobilescene!save.action" class="form-horizontal"  method="post">
                	 
                	<input type="hidden" id="tab" name="tab" value="0"/>
                	<input type="hidden" id="_id" value="${msid}" name="_id"/>

                    <div class="panel panel-default">
                        <div class="panel-body">
                        	<div class="form-group">
                                <label class="col-sm-2 control-label">标题: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text"  name="title" value="${entity.title }" class="form-control" placeholder="请输入" />
                                  
                                </div>
                                
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">背景音乐: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text"  name="mp3" value="${entity.mp3 }" class="form-control" placeholder="请输入" />
                                  
                                </div>
                                 <div class="col-sm-5">
                                 <a class="btn btn-primary" href="javascript:updMp3('mp3')">样式</a>
                               
                                </div>
                                
                            </div>
                             
                            <div class="form-group">
                                <label class="col-sm-2 control-label">LOGO: <span class="asterisk">*</span></label>
                                <div class="col-sm-3">
                                   
                                   <input type="text" name="logo" value="${entity.logo}" id="mslogo" class="form-control" placeholder="图片建议尺寸450*450." />
                                </div>
                                <div class="col-sm-2">  
                                 <div class="btn btn-danger  hang40" style="margin-left: 0px" id="imgup1" onclick="pz('mslogo','100','100',false,null,'1')">上传
                                 </div> 
                                </div>
                                 <div class="col-sm-2">  
                                 <div class="btn btn-danger  hang40"  onclick="init_img('mslogo',null)">图库
                                 </div> 
                                </div>
                                 <div class="col-sm-3">
                                 <div class="ckbox ckbox-success hang40" style="top:8px">
                                        <input type="checkbox" id="checkbox1" onchange="ckOnchange(1)" checked="checked">
                                        <label for="checkbox1">同步图片到库</label>
                                 </div> 
                                </div>
                                
                                
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">封面: <span class="asterisk">*</span></label>
                                <div class="col-sm-3"> 
                                   <input type="text" name="picurl" value="${entity.picurl}" id="mspicurl" class="form-control" placeholder="图片建议尺寸500*450." />
                                </div>
                                <div class="col-sm-2">  
                                 <div class="btn btn-danger  hang40" style="margin-left: 0px" id="imgup2" onclick="pz('mspicurl','375','590',false,null,'1')">上传
                                 </div> 
                                </div>
                                <div class="col-sm-2">  
                                 <div class="btn btn-danger  hang40" style="margin-left: 0px" onclick="init_img('mspicurl',null)">图库
                                 </div> 
                                </div>
                                <div class="col-sm-3">
                                 <div class="ckbox ckbox-success" style="top:8px">
                                        <input type="checkbox" id="checkbox2" onchange="ckOnchange(2)" checked="checked">
                                        <label for="checkbox2">同步图片到库</label>
                                 </div> 
                                </div>
                            </div>
                             <div class="form-group">
                                <label class="col-sm-2 control-label">描述: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                               
                            <textarea   name="summary" class="form-control" rows="5" placeholder="字数控制在100以内..." >${entity.summary}</textarea>
                                </div>
                            	
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">下标: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" name="foot" value="${entity.foot}" class="form-control" placeholder="请输入" />
                                </div>
                            	
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">序号: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" name="sort" value="${entity.sort}" class="form-control" placeholder="请输入" />
                                </div>
                            	
                            </div>
                            
                        </div>
                        <!-- panel-body -->

                        

                    </div>
                    <!-- panel -->
                    
                       <div class="panel-footer">
                            <div class="row">
                                <div class="col-sm-9 col-sm-offset-3">
                                    <button class="btn btn-black btn-block">提&nbsp;&nbsp;交</button>
                                </div>
                            </div>
                      </div>
                </form>
             
                   
                </div><!-- panel-body -->
 

    		</div><!-- panel -->
    </form>
    </div>
    <div class="tab-pane <c:if test='${tab==1}'>active</c:if> " id="tab1">   
        	<div class="table-responsive" id="scene">
             <c:if test="${not empty scenelist }">
            	<table class="table table-striped table-success mb30" >
                	<thead>
                      			<tr>
                      				<th>序号</th>
                        			<th>名称</th> 
									<th>背景图</th>
									<th>背景色</th>
									<th>操作</th>
						
                      			</tr>
                   	</thead>
                    <tbody>
                    <c:forEach items="${scenelist}" var="bean">
						<tr >
												<td>${bean.sort}</td>
												<td>${bean.title}</td> 
												<td><img src="${filehttp}${bean.picurl}" alt="" style="height: 25px;"></td>
												<td>${bean.bg}</td> 
							<td class="table-action">
                              
                              <div class="btn-group1 position-r">
                                  <a data-toggle="dropdown" class="dropdown-toggle">
                                      <i class="fa fa-cog"></i>
                                  </a>
                                  <ul role="menu" class="dropdown-menu pull-right">
                                      <li><a href="javascript:updScene('${bean._id}')">
                                      		<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a></li>
                                      		<li><a href="javascript:getSpirit('${bean._id}','${bean.sort}')">
                                      		<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;管理精灵</a></li>
                                      <li><a href="javascript:delScene(${bean._id});"><i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>
                                      
                                  </ul>
                              </div>
                          </td>
						</tr>
					    </c:forEach>		
                    </tbody>
                     
 
                </table>
                </c:if>
           <span class="btn btn-darkblue btn-block" id="btnScene" onclick="addScene();"><li class="fa fa-plus"></li>&nbsp;&nbsp;添加图层</span>
		</div>
		
		 
		   
		
		
	 
    </div><!-- panel -->
   
  
    
    </div>
        
   </div>
  
	
  </div>
 </div>
</div>
</section>

<div id="insScene" class="modal fade bs-example-modal-static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     data-backdrop="static" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close" type="button">&times;</button>
                <h4 class="modal-title"><i class="fa  "></i> 添加图层</h4>
            </div>
            <div class="modal-body">
                <form id="inscxForm" action="${ctx }/suc/mobilescene!saveScene.action" class="form-horizontal"  method="post" >
                	<input type="hidden" id="sceneid" name="id" />
                	<input type="hidden" value="${msid}" name="msid" />
                	<input type="hidden" id="tab" name="tab" value="1"/>

                    <div class="panel panel-default">
                        <div class="panel-body">
                        	<div class="form-group">
                                <label class="col-sm-2 control-label">标题: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" id="scenetitle" name="title" class="form-control" placeholder="请输入" />
                                </div>
                            	
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">图片: <span class="asterisk">*</span></label>
                                <div class="col-sm-3">
                                   
                                   <input type="text" name="picurl" id="uploadresult" class="form-control" placeholder="图片建议尺寸375*590." />
                                </div>
                                 <div class="col-sm-2">
                                   <div  class="button  btn-lu " id="imgup3" onclick="pz('uploadresult','250','450',false,null,'1')">
                    						<div class="an-normal ">上传</div>
                    						
                				  </div> 
                                </div>
                                <div class="col-sm-2">
                                   <div  class="button btn-danger btn-lu " onclick="init_img('uploadresult','insScene')">
                    						<div class="an-normal ">图库</div>
                    						
                				  </div> 
                                </div>
                                <div class="col-sm-2">
                                 <div class="ckbox ckbox-success" style="top:8px">
                                        <input type="checkbox" id="checkbox3" onchange="ckOnchange(3)" checked="checked">
                                        <label for="checkbox3">同步图片到库</label>
                                 </div> 
                                </div>
                                 
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">描述: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" id="scenesummary" name="summary" class="form-control" placeholder="请输入" />
                                </div>
                            	
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">序号: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" id="scenesort" name="sort" class="form-control" placeholder="请输入" />
                                </div>
                      	     
                               	<!--222-->
                            </div>
                            
                        </div>
                        <!-- panel-body -->

                        <div class="panel-footer">
                            <div class="row">
                                <div class="col-sm-9 col-sm-offset-1">
                                    <button class="btn btn-success btn-block">提&nbsp;&nbsp;交</button>
                                </div>
                            </div>
                        </div>

                    </div>
                    <!-- panel -->
                </form>


            </div>
            <!-- row -->
        </div>
    </div>
</div>
<div id="insSpririt" class="modal fade bs-example-modal-static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     data-backdrop="static" aria-hidden="true">
    <div class="dialog-500 modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close" type="button">&times;</button>
                <h4 class="modal-title"><i class="fa"></i>添加精灵</h4>
            </div>
            <div class="modal-body"> 
                	<input type="hidden" id="spiritid" name="id" />
                	<input type="hidden" name="tab" value="1"/>

                    <div class="panel panel-default">
                        <div class="panel-body">
                        	<div class="form-group">
                                <label class="col-sm-3 control-label">标题: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" id="spirittitle" name="spirittitle" class="form-control" placeholder="请输入" />
                                </div>
                            	
                            </div>
                            <div class="form-group">
                            <label class="col-sm-3 control-label">缩略图: <span class="asterisk">*</span></label>
                                <div class="col-sm-3">
                                	<input type="text" id="spiritpicurl"  name="spiritpicurl"  class=" form-control" /> 
                                </div>
                                
                                <div class="col-sm-3">
                                 <div class="btn btn-success btn-block">直接传</div>
                            		<div style="position: absolute;width: 120px;height: 40px;top:0px;opacity: 0"> 
                            		<input type="file"  class="spiritpicurl" style="width: 120px;height: 40px" /> 
									</div>
                                </div>
                                <div class="col-sm-2">
                                   <div  class="button btn-lu " onclick="init_img('spiritpicurl','insSpririt')">
                    						<div class="an-normal ">图库</div>
                    						
                				  </div> 
                                </div>
                            </div>
                            <div class="form-group">
									<label class="col-sm-3 control-label">类型 <span
										class="asterisk">*</span>
									</label>
									 <div class="col-sm-4">
                                     <select class="form-control col-sm-2" id="spirittype" name="spirittype" onchange="">
										<option value="0">普通模板</option>
										<option value="-1">一排一个</option>
										<option value="1">一排两个</option>
										<option value="2">一排三个</option>
										<option value="3">一排四 个</option>
									  	
								     </select>
                              </div>
							</div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">链接地址: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" id="spiriturl" name="spiriturl" class="form-control" placeholder="请输入" />
                                </div>
                            	
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">描述: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" id="spiritsummary" name="spiritsummary" class="form-control" placeholder="请输入" />
                                </div>
                            	
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">序号: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                   
                                   <input type="text" id="spiritsort" name="spiritsort" class="form-control" placeholder="请输入" />
                                </div>
                            	
                            </div>
                            
                        </div>
                        <!-- panel-body -->

                     
                    </div>
                    <!-- panel -->
                </form>
                  <div class="panel-footer">
                            <div class="row">
                                <div class="col-sm-9 col-sm-offset-3">
                                     <button aria-hidden="true" data-dismiss="modal" class="btn btn-primary btn-block" onclick="AdSpirit()">确&nbsp;&nbsp;定</button>
                              
                                </div>
                            </div>
                  </div>
                       

            </div>
            <!-- row -->
        </div>
    </div>
</div>



 


<div id="insStyle" class="modal fade bs-example-modal-static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     data-backdrop="static" aria-hidden="true">
    <div class="dialog-500 modal-lg"style="margin-top: 1%">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close" type="button">&times;</button>
                <h4 class="modal-title"><i class="fa  "></i> 编辑样式</h4>
            </div>
            <div class="modal-body"> 
                	<input type="hidden" id="styleid" name="id" />  

                    <div class="panel panel-default">
                        <div class="panel-body">
                        	<div class="form-group">
                                <label class="col-sm-3 control-label">左边距: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                <div id="slider-float-left" class="slider-primary mb20"></div>
                                </div>
                                <div class="col-sm-2">
                            	<span id="fl">0px</span>
                            	</div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">上边距: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                <div id="slider-float-top" class="slider-primary mb20"></div>
                                </div>
                                <div class="col-sm-2">
                            	<span id="ft">0px</span>
                            	</div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">颜色: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                 <input type="text" name="stylecolor" id="stylecolor" class="form-control color"  value="#" />
                            	</div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">高度: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                 <input type="text" name="styleh" id="styleh" onchange="changestyle(this)" class="form-control"  value="0px" />
                            	</div>
                            	 
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">宽度: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                 <input type="text" name="stylew" id="stylew" onchange="changestyle(this)"class="form-control"  value="0px" />
                            	</div>
                            	    <div class="col-sm-4">
                                 <div class="ckbox ckbox-success" style="top:8px">
                                        <input type="checkbox" id="checkbox4" checked="checked">
                                        <label for="checkbox4">同比例宽高</label>
                                 </div> 
                                </div>
                            </div>
                           
                             <div class="form-group">
                                <label class="col-sm-3 control-label">圆角: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                <div id="slider-border-radius" class="slider-primary mb20"></div>
                                </div>
                                <div class="col-sm-2">
                            	<span id="border-radius">0</span>
                            	</div>
                            </div>
                             <div class="form-group">
                                <label class="col-sm-3 control-label">背景颜色: <span class="asterisk">*</span></label>
                                <div class="col-sm-5">
                                 <input type="text" name="stylecolor" id="stylebackgroundcolor" class="form-control color"  value="#" />
                            	</div>
                            </div>
                            
                        </div>
                        <!-- panel-body -->

                         <div class="panel-footer">
                            <div class="row">
                                <div class="col-sm-9 col-sm-offset-3">
                                 <button aria-hidden="true" data-dismiss="modal" class="btn btn-primary btn-block" onclick="updStyle()">确&nbsp;&nbsp;定</button>
                                </div>
                            </div>
                        </div>

                    </div>
                 
                   

            </div>
            <!-- row -->
        </div>
    </div>
</div>
 
 
 
 
 <div id="insAnima" class="modal fade bs-example-modal-static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     data-backdrop="static" aria-hidden="true">
    <div class="dialog-500 modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close" type="button">&times;</button>
                <h4 class="modal-title"><i class="fa"></i> 添加动画</h4>
            </div>
            <div class="modal-body"> 
                	<input type="hidden" id="styleid" name="id" />  

                    <div class="panel panel-default">
                        <div class="panel-body">
                           <div class="form-group">
                              <label class="col-sm-3 control-label">动画样式: <span class="asterisk">*</span></label>
                        	  <div class="col-sm-3">
                                     <select class="form-control col-sm-2" id="animaValue" name="animaValue" onchange="onChange(this.value)">
										<option value="tada">抖动</option>
										<option value="bounceInLeft">左闪入</option>
										<option value="bounceInRight">右闪入</option>
										<option value="spinner">旋转</option>
										<option value="fadeOutLeft">左飞出</option>
										<option value="fadeOutRight">右飞出</option>
										<option value="fadeOutUp">上飞出</option>
										<option value="fadeOutDown">下飞出</option>
										<option value="fadeInLeft">左飞入</option>
										<option value="fadeInRight">右飞入</option>
										<option value="fadeInUp">上飞入</option>
										<option value="fadeInDown">下飞入</option>
										<option value="flipOutX">上下翻转</option>
										<option value="flipOutY">左右翻转</option>
									 	
								     </select>
                              </div>
                              <label class="col-sm-3 control-label">持续时间: <span class="asterisk">*</span></label>
                        	  <div class="col-sm-2">
                                 <input type="text" name="animaduration" id="animaduration" class="form-control"  value="0" />    
                              </div>
                             </div>
                             <div class="form-group">
                               <label class="col-sm-3 control-label">保持状态: <span class="asterisk">*</span></label>
                        	  <div class="col-sm-3">
                                     <select class="form-control col-sm-2" id="animakeep" name="animakeep" >
										<option value="0">显示</option>
										<option value="1">不显示</option>
										 
								     </select>
                              </div>
                              <label class="col-sm-3 control-label">迭代次数: <span class="asterisk">*</span></label>
                        	  <div class="col-sm-2">
                                 <input type="text" name="animaiterate" id="animaiterate" class="form-control"  value="0" />       
                              </div>
                             
                             </div>
                             
                            
                            
                        </div>
                        <!-- panel-body -->

                         <div class="panel-footer">
                            <div class="row">
                                <div class="col-sm-9 col-sm-offset-3">
                                 <button aria-hidden="true" data-dismiss="modal" class="btn btn-primary btn-block" onclick="updAnima()">确&nbsp;&nbsp;定</button>
                                </div>
                            </div>
                        </div>

                    </div>
                 
                   

            </div>
            <!-- row -->
        </div>
    </div>
</div> 
 <%@include file="/com/cut-img.jsp" %>
 <%@include file="/com/img.jsp" %>
 <%@include file="/com/preview.jsp" %> 

<script>
jQuery(document).ready(function() {
 
    "use strict";
    
    // Basic Slider滑动监听
    jQuery('#slider-float-left').slider({
      range: "min",
      max: 1000,
      value:0,
      slide: function(event, ui ) {
        $("#fl").html(ui.value/10);
        updStyle(); 
      }
    });
    $("#slider-float-top").slider({
      range: "min",
      max: 1000,
      value:0,
      slide: function(event, ui ) { 
       $("#ft").html(ui.value-500);
       updStyle();
        
      }
    });
    $("#slider-border-radius").slider({
     range:"min",
     max:1000,
     value:0,
     slide:function(event,ui){
      $("#border-radius").html(ui.value);
      updStyle();
     }
    
    });
   
});		
</script>
<script type="text/javascript" src="${ctx}/css_js/js/fileUp_no.js"></script>
<script type="text/javascript"> 
fileInput("spiritpicurl","11","spiritpicurl","1");
function previouspage(){
	if(scsort>0){
		scsort--;
	}
	window.frames['leftmenu'].previouspage();
}
function nextpage(){
	scsort++;
	window.frames['leftmenu'].nextpage();
}
function  refresh(){
	window.frames['leftmenu'].refresh();
}
</script>
</body>
</html>
 
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/com/libs.jsp"%>
<%@page import="com.mongodb.DBObject"%>
<%@page
	import="com.lsp.sys.security.CustomerUser,com.lsp.pub.util.SpringSecurityUtils,com.lsp.pub.entity.CacheResource
,com.lsp.pub.entity.FuncInfo,java.util.List"%>
<%@page import="org.springframework.web.filter.RequestContextFilter"%>

<%
    String custName = "";
    String custid=""; 
    CustomerUser cust =(CustomerUser)SpringSecurityUtils.getCurrentUser();
	if(cust!=null){
	custName=cust.getCustname(); 
	custid=cust.getCustid(); 
	} 
	 
%>
<div class="leftpanel">

	<div class="logopanel"
		style="height: 50px; overflow: hidden; line-height: 50px; font-weight: font-weight:bold;">
		<h4>
			<span>&nbsp;</span>
		</h4>
	</div>
	<!-- logopanel -->

	<div class="leftpanelinner">

		<h5 class="sidebartitle"></h5>

		<ul class="nav nav-pills nav-stacked nav-bracket">


		</ul>

	</div>
	<!-- leftpanelinner -->
</div>
<!-- leftpanel -->
<script>
  function getAllfunc() {
      var submitData = {  
      };
      $.post('${ctx}/pub/role!getfunclistAuth.action', submitData,
              function (json) { 
    	            var html='';
    	          var  list=json;
	             for(var i=0;i<list.length;i++){
	            	 html+='<li  class="nav-parent" id="cate_'+list[i].id+'"><a href=""><i class="fa '+list[i].ioc+'"></i> <span>'+list[i].name+'</span></a>'; 
	            	 if(list[i].children!=null&&list[i].children.length>0){
	            		 html+='<ul class="children">';
	            		 var child=list[i].children;
	            		 for(var j=0;j<child.length;j++){
	            			  if(child[j].url!=null&&child[j].url.replace("**","").indexOf("?")>0){
	            				 html+='<li id="cate_'+child[j].id+'"><a href="${ctx}'+child[j].url.replace("**","")+'&cate_id='+child[j].id+'"><i class="fa fa-caret-right"style="color: #666"></i>'+child[j].name+'</a>'; 
	            			  }else{
	            				  html+='<li id="cate_'+child[j].id+'"><a href="${ctx}'+child[j].url.replace("**","")+'?cate_id='+child[j].id+'"><i class="fa fa-caret-right"style="color: #666"></i>'+child[j].name+'</a>'; 
	            			  }
	            			 if(child[j].children!=null&&child[j].children.length>0){
	            				 html+='<ul class="children" style="display:block">';
	            				 var child1=child[j].children;
	            				 for(var k=0;k<child1.length;k++){
	            					  if(child1[k].url!=null&&child1[k].url.replace("**","").indexOf("?")>0){
	     	            				 html+='<li id="cate_'+child1[k].id+'"><a href="${ctx}'+child1[k].url.replace("**","")+'&cate_id='+child1[k].id+'"><i class="fa fa-caret-right"style="color: #666"></i>'+child1[k].name+'</a>'; 
	     	            			  }else{
	     	            				  html+='<li id="cate_'+child1[k].id+'"><a href="${ctx}'+child1[k].url.replace("**","")+'?cate_id='+child1[k].id+'"><i class="fa fa-caret-right"style="color: #666"></i>'+child1[k].name+'</a>'; 
	     	            			  }
	            					  
	            					 if(child1[k].children!=null&&child1[k].children.length>0){
	            						 html+='<ul class="children" style="display:block">';
	            						 var child2=child1[k].children;
	            						for(var l=0;l<child2.length;l++){
	            							  if(child2[l].url!=null&&child2[l].url.replace("**","").indexOf("?")>0){
	     	     	            				 html+='<li id="cate_'+child2[l].id+'"><a href="${ctx}'+child2[l].url.replace("**","")+'&cate_id='+child2[l].id+'"><i class="fa fa-caret-right"style="color: #666"></i>'+child2[l].name+'</a></li>'; 
	     	     	            			  }else{
	     	     	            				 html+='<li id="cate_'+child2[l].id+'"><a href="${ctx}'+child2[l].url.replace("**","")+'?cate_id='+child2[l].id+'"><i class="fa fa-caret-right"style="color: #666"></i>'+child2[l].name+'</a></li>'; 
	     	     	            			  } 
	            						} 
	            						html+="</ul>";
	            					 }
	            					 html+="</li>";
	            				 }
	            				 html+="</ul>";
	            			 }
	            			 html+="</li>";
	            		 }
	            		 html+="</ul>";
	            		 
	            	 }
	            	 html+="</li>";
	             }
	             
	           $('.nav-pills').html(html);  
	           
	             
              }, "json")
     
  }
  getAllfunc(); 
</script>


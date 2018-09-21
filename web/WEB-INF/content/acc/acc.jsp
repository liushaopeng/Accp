<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/com/libs.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en"> 
<script src="${ctx}/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<head> 
    <%@include file="/com/js_css.jsp" %> 
    <script type="text/javascript">
        function del(id) {
            if (confirm('确实要删除吗?')) {
                location.href = "${ctx}/acc/acc!delete.action?_id=" + id;
            }
        }
        
        function add() {
            $('#_id').val('');
            $('#count').val(0); 
            $('#pcount').val(0);
            $('#paidin').val(0); 
            $('#other').val(0);
            ps_show('inszc');
        }
        function printALL(id) {
            var submitData = {
                _id: id
            };
            $.post('${ctx}/acc/dutyman!upd.action', submitData,
                    function (json) {
                        
                       
                    }, "json")
            $('#inszcp').modal({
                show: true
            });
        }
        function zf(id) {
        	  $('#zfid').val(id);
        	  $('#invalids').val('');
        	  $('#inszf').modal({
                  show: true
              }); 
        }
        function invalids() {
            var submitData = {
                id: $('#zfid').val(),
                invalids: $('#invalids').val(),
                state:1
            };
            $.post('${ctx}/acc/acc!setState.action', submitData,
                    function (json) {  
                        if(json.state==0){
                        	alert('作废成功！');
                        	window.location.reload();
                        }
                       
                    }, "json")
           
        }
        
        function page_submit(num) {
            if (num == -1) {
                $("#fypage").val(0);
            } else if (num == -2) {
                $("#fypage").val($("#fypage").val() - 1);
            } else {
                $("#fypage").val(num);
            }
            $("#custdangerForm").submit();
        } 
      var gdthe=0;
      function createGids(){ 
    	  gdthe++; 
    	  var html=$('#gis').html();
    	  var liDiv = document.createElement('div');
    	      liDiv.className="li";
    	  var col4Div1 = document.createElement('div');
    	      col4Div1.className="col-sm-4";
    	  var mb20Div1=document.createElement('div');
    	      mb20Div1.className="mb-20";
    	  var glabel1=document.createElement('label'); 
    	      glabel1.className="control-label";
    	      glabel1.innerHTML="商品"+gdthe;
    	  var gselect=document.createElement("select");
    	      gselect.id ="gid"+gdthe;
    	      gselect.name ="gid"+gdthe;
    	      gselect.className ="width-10 select"+gdthe;
    	      gselect.options.add(new Option("请选择","")); 
    	      <c:forEach items="${goodslist}" var="item" varStatus="status" >  
    	      gselect.options.add(new Option("${item.title}","${item._id}"));
    	      </c:forEach>  
    	 var col4Div2 = document.createElement('div');
    	     col4Div2.className="col-sm-4";
    	 var mb20Div2=document.createElement('div');
    	     mb20Div2.className="mb-20";
	     var glabel2=document.createElement('label'); 
   	         glabel2.className="control-label";
   	         glabel2.innerHTML="单价";
   	     var input1=document.createElement('input'); 
   	         input1.className="form-control";
   	         input1.value=0;
   	         input1.type="text";
   	         input1.id="price"+gdthe;
   	         input1.name="price"+gdthe;
   	         input1.readOnly="false";
   	         
   	      var col4Div3 = document.createElement('div');
 	          col4Div3.className="col-sm-4";
 	      var mb20Div3=document.createElement('div');
 	          mb20Div3.className="mb-20";
	      var glabel3=document.createElement('label'); 
	          glabel3.className="control-label";
	          glabel3.innerHTML="数量";
	      var input2=document.createElement('input'); 
	          input2.className="form-control";
	          input2.value=0;
	          input2.type="text";
	          input2.id="count"+gdthe;
	          input2.name="count"+gdthe;  
	          input2.onchange=ontotal;
	      var input3=document.createElement('input');  
	          input3.type="hidden";
	          input3.id="title"+gdthe;
	          input3.name="title"+gdthe; 
	          
	          mb20Div1.appendChild(glabel1); 
	          mb20Div1.appendChild(gselect);
	          col4Div1.appendChild(mb20Div1);
	          
	          mb20Div2.appendChild(glabel2); 
	          mb20Div2.appendChild(input1);
	          col4Div2.appendChild(mb20Div2);
	          
	          mb20Div3.appendChild(glabel3); 
	          mb20Div3.appendChild(input2);
	          mb20Div3.appendChild(input3);
	          col4Div3.appendChild(mb20Div3);
	          liDiv.appendChild(col4Div1);
	          liDiv.appendChild(col4Div2);
	          liDiv.appendChild(col4Div3);
	          document.getElementById('gis').appendChild(liDiv);  
    	      $('#gids').val(gdthe); 
    	      jQuery(".select"+gdthe).select2({
    	    	     width: '100%'
    	    	 });
    	      $('#gid'+gdthe).change(function(){ 
    	    		toPrice(gdthe);  
    	    	 });
      }
      function ontotal(){ 
          var t=0; 
    	  for(var i=0;i<=gdthe;i++){
    		  var price=parseInt($('#price'+i).val()); 
    		  var count=parseFloat($('#count'+i).val());
    		  var total=price*count; 
    		  t+=total; 
    	  } 
    	  if(parseFloat($('#other').val())){
    		t+=parseFloat($('#other').val()); 
    	  }
    	  $('#total').val(t);
    	  $('#paidin').val(t);
    		  
      }
      function toPrice(v){ 
    	  var submitData = {
                  id: $('#gid'+v).val()
              };
              $.post('${ctx}/acc/acc!getPrice.action', submitData,
                      function (json) { 
            	           if(json.state==0){
            		         $('#price'+v).val(json.price);
            		         $('#title'+v).val(json.title);
            	           } 
            	           ontotal();
                      }, "json")
              
      }
      var ids='';
      function  total(thr,zj,sf){
    	  var zjhj=parseFloat($("#zjhj").html());
		  var sfhj=parseFloat($("#sfhj").html());
    	  if($(thr).is(':checked')){  
    		  ids+=$(thr).attr('id')+",";
    		  $("#zjhj").html(zj+zjhj);
    		  $("#sfhj").html(sf+sfhj);  
    	  }else{
    		  $("#zjhj").html(zjhj-zj);
    		  $("#sfhj").html(sfhj-sf); 
    		  ids=ids.replace($(thr).attr('id')+",","");
    	  }
    	  $("#hj").show(); 
    	  if($("#zjhj").html()==0&&$("#sfhj").html()==0){
    		  $("#hj").hide();   
    	  }
      } 
      function qx(tx){ 
    	 $('.acc').each(function(){
    		 if($(tx).prop('checked')){
    			 $(this).prop('checked', true);
    			 ids+=$(this).attr('id')+",";
    			 var zj=0;
    			 var sf=0;
    			 <c:forEach items="${list}" var="item" varStatus="status" >  
       	         zj+=parseFloat('${item.total}');
       	         sf+=parseFloat('${item.paidin}');
       	         </c:forEach> 
       	         $("#zjhj").html(zj);
    		     $("#sfhj").html(sf);
    		     $("#hj").show();
    		 }else{
    			 
    		     $(this).prop('checked', false);
    			 $("#zjhj").html(0);
    		     $("#sfhj").html(0);
    		     ids='';
    		     $("#hj").hide(); 
    		 }
    		
    	 }); 
      } 
      function showZF(st){ 
    	  $('#zfsm').val(st);
    	  $('#inszzfsm').modal({
              show: true
          }); 
      }
      function accFC(st){
    	  $('#accFC').html(st);
    	  $('#accFC').show();
      }
      function accFCs(){
    	  $('#accFC').hide(); 
      }
      function print(id){
    	var url= "${ctx}/acc/acc!print.action?id=" + id+",";  
    	window.open(url);
      }
      function printall(){
    	if(ids.replace(',','')==''){
    		  alert("请选择要打印的订单");
    		  return;
    	  }
      	var url= "${ctx}/acc/acc!print.action?id=" + ids;  
      	window.open(url);
      }
    </script>
    
    <script type="text/javascript">
	function doPrint(how) {

		//打印文档对象9
		var myDoc = {
			settings : {
				paperWidth : 800,
				paperHeight : "auto" // 小票打印，高度自动					
			},
			marginIgnored : true,
			documents : document,
			copyrights : '杰创软件拥有版权  www.jatools.com'
		};
		var jatoolsPrinter = getJatoolsPrinter();

		// 调用打印方法
		if (how == '打印预览...')
			jatoolsPrinter.printPreview(myDoc); // 打印预览

		else if (how == '打印...')
			jatoolsPrinter.print(myDoc, true); // 打印前弹出打印设置对话框

		else
			jatoolsPrinter.print(myDoc, false); // 不弹出对话框打印
	}
</script>
    <style>
        .form-group-20 {
            margin-bottom: 20px;
        } 
        .select2-container .select2-choice {
            line-height: 28px  !important;
        } 
        .pr-10 {
            padding-right: 10px;
        } 
        .pl-10 {
            padding-left: 10px;
        } 
        .gx-xz {
            width: 18px;
            height: 18px;
            line-height: 18px;
            text-align: center;
            color: white;
            border: 1px solid #bbb;
            border-radius: 3px;
        } 
        .gx-xz-dj {
            border: 1px solid #428BCA;
            background-color: #428BCA
        }
    </style>
</head>
<body>
<section>
    <%@include file="/com/header.jsp" %>
    <div class="mainpanel">
        <%@include file="/com/headerbar.jsp" %>
        <form id="custdangerForm" name="custdangerForm" method="post"
              action="${ctx}/acc/acc.action?">
            <div class="pageheader" style="font-size: 16px"> 
                    <i class="fa fa-user"></i>后台管理 <span style="font-size: 12px"><i class="fa fa-angle-double-right" style="font-size: 16px;margin:0;padding: 0"></i>账单管理</span> 
            </div>
           
            <div class="panelss">
                <div class="panelss-body">
                   <div class="form-group pull-right btn-group"> 
                         <button type="button" class="btn btn-danger dropdown-toggle form-group pull-right" data-toggle="dropdown">
                                                                                    菜单 <i  class="fa fa-list"></i>
                         </button>
                         <ul class="dropdown-menu pull-right" role="menu">
                            <li><a href="javascript:add()"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;出单</a>

                            </li>  
                            <li><a href="javascript:printall()"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;批量打印</a>

                            </li>  
                             <li><a href="${ctx}/acc/acc!statistics.action?state=0"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;订单统计</a>

                            </li>  
                        </ul> 
                    </div> 
                    <div class="row-pad-5">
                        <div class="form-group col-sm-1"> 
                             <select id="gid" name="gid" class="width-10 select0"> 
                                       <option value="">请选择</option>
                                       <c:forEach items="${goodslist}" var="bean">
                                       <option value="${bean._id}">${bean.title}</option>
                                       </c:forEach>      
                              </select>
                        </div> 
                         <div class="form-group col-sm-1"> 
                             <select id="did" name="did" class="width-10 select0"> 
                                       <option value="">请选择</option>
                                       <c:forEach items="${manlist}" var="bean">
                                       <option value="${bean._id}">${bean.name}</option>
                                       </c:forEach>      
                              </select>
                        </div> 
                        <div class="form-group col-sm-1"> 
                             <select id="paystate" name="paystate" class="width-10 select0"> 
                                       <option value="">请选择</option>
                                       <option value="3">结算</option>  
                                       <option value="1">挂账</option>   
                                       <option value="2">请客</option>
                                          
                              </select>
                        </div> 
                        <div class="form-group col-sm-1"> 
                             <select id="state" name="state" class="width-10 select0"> 
                                       <option value="">请选择</option> 
                                       <option value="1">正常</option>
                                       <option value="2">作废</option>   
                              </select>
                        </div> 
                        <div class="form-group col-sm-1"> 
                             <select id="paytype" name="paytype" class="width-10 select0"> 
                                       <option value="">请选择</option> 
                                       <option value="5">现金</option> 
                                       <option value="1">刷卡</option>
                                       <option value="2">微信</option>
                                       <option value="3">支付宝</option>
                                       <option value="4">其他</option>
                                        
                              </select>
                        </div> 
                        <div class="form-group col-sm-2">
                            <input type="text" id="sel_insdate" name="sel_insdate" value="${sel_insdate}" placeholder="开始日期"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" class="form-control" />
                        </div>
                        <div class="form-group col-sm-2">
                            <input type="text" id="sel_enddate" name="sel_enddate" value="${sel_enddate}" placeholder="结束日期"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" class="form-control" />
                         </div>
                        <a href="javascript:page_submit(-1);" class="btn btn-danger">搜&nbsp;&nbsp;索</a>
                    </div>
                </div>
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="table-responsive">
                            <table class="table table-striped table-danger mb30">
                                <thead>
                                <tr> 
                                    <th class="th5">全选<input type="checkbox" onclick="qx(this)"/></th>
                                    <th class="th5">单号</th>
                                    <th class="th8">商品</th> 
                                    <th class="th8">总价</th>  
                                    <th class="th8">实付</th>
                                    <th class="th8">值班人</th> 
                                    <th class="th8">时间</th>
                                    <th class="th8">支付方式</th> 
                                    <th class="th8">状态</th> 
                                    <th class="th8">操作</th> 
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${list}" var="bean">
                                    <tr>
                                        <td><input class="acc" type="checkbox" id="${bean._id}" onclick="total(this,${bean.total},${bean.paidin})"></td> 
                                        <td>${bean._id}</td>
                                        <td>
                                        <c:forEach items="${bean.lsRecords}" var="gods">
                                        ${gods.title}/${gods.count}<br/>
                                        </c:forEach>
                                        </td> 
                                        <td>${bean.total}</td> 
                                        <td>${bean.paidin}</td> 
                                        <td>${bean.mansname}</td>
                                        <td><fmt:formatDate pattern='yyyy-MM-dd HH:mm'
                                                            value='${bean.createdate}'/></td>
                                        <td><c:if test="${bean.paytype==0}">现金</c:if><c:if test="${bean.paytype==1}">刷卡</c:if><c:if test="${bean.paytype==2}">微信</c:if><c:if test="${bean.paytype==3}">支付宝</c:if><c:if test="${bean.paytype==4}">其他</c:if></td>
                                        <td><c:if test="${bean.state==0}">正常</c:if><c:if test="${bean.state==1}"><i onclick="showZF('${bean.invalids}')" onmouseover="accFC('${bean.invalids}')" onmouseout="accFCs()">作废</i></c:if></td> 
                                        <td class="table-action">
                                            <div class="btn-group1  position-r">
                                                <a data-toggle="dropdown" class="dropdown-toggle"> <i
                                                        class="fa fa-cog"></i> </a> 
                                                    <ul role="menu" class="dropdown-menu pull-right">
                                                        
                                                        <li><a href="javascript:del('${bean._id}');"><i
                                                                class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a>
                                                        </li>
                                                        <li><a href="javascript:zf('${bean._id}');"><i
                                                                class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;作废</a>
                                                        </li>
                                                        <li><a href="javascript:print('${bean._id}');"><i
                                                                class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;打印</a>
                                                        </li>
                                                    </ul> 
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <tr id="hj" style="display: none"> 
                                <td> 
                                合计:
                                </td>
                                <td> 
                                </td>
                                <td>
                                
                                </td>
                                <td id="zjhj">
                                0
                                </td>
                                <td id="sfhj">
                                0
                                </td>
                                <td> 
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td> 
                                </td> 
                             
                                </tr>
                            </table>
                            <%@include file="/com/page.jsp" %>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</section>
<%--弹出层新--%>
<div class="fullscreen bg-hei-8 display-none" id="inszc" style="height: 100%;">
    <div style="padding-top:2%">
        <div class="pl-10 pr-10 maring-a cmp500"
             style="width: 100%;max-width: 500px;min-width: 320px;margin: 0px auto;right: 0px;">
            <div class=" bg-bai border-radius3 overflow-hidden">
                <div class="overflow-hidden line-height40 bg-bai line-bottom">
                    <div class="hang50 pull-left zi-hui-tq">
                        <i class="weight500 size14 pl-10 line-height50">出单</i>
                    </div>
                    <a href="javascript:ps_hide('inszc')">
                        <div class="hang40 pull-right zi-hui-tq">
                            <i class="weight500 size14 pl-10 pr-10 fa-1dx fa fa-remove" style="line-height: 50px;"></i>
                        </div>
                    </a>
                </div>
                <form id="inscxForm" action="${ctx}/acc/acc!save.action?fypage=${fypage}"
                      class="form-horizontal"  method="post">
                    <input type="hidden" id="_id" name="_id"/>
                    <input type="hidden" id="gids" name="gids" value="0"/>
                    <%--row--%>

                    <div class="pt-15 pl-15 pr-15 overflow-auto" style="height:490px;">
                        
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">值班人</label>
                                 <select id="did" name="did" class="width-10 select0"> 
                                       <c:forEach items="${manlist}" var="bean">
                                       <option value="${bean._id}">${bean.name}</option>
                                       </c:forEach>      
                                </select>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">挂账</label>
                                 <select id="paystate" name="paystate" class="width-10 select0">  
                                       <option value="0">结算</option>
                                       <option value="1">挂账</option> 
                                       <option value="2">请客</option> 
                                </select>
                            </div>
                        </div>
                         <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">结算</label>
                                 <select id="paytype" name="paytype" class="width-10 select0">  
                                       <option value="0">现金</option>
                                       <option value="1">刷卡</option>
                                       <option value="2">微信</option>
                                       <option value="3">支付宝</option>
                                       <option value="4">其他</option> 
                                </select>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">人数</label>
                                 <input type="text" id="count" name="count"
                                       class="form-control" placeholder="请输入"/>
                            </div>
                        </div>
                        <div id="gis">
                         <div class="li">
                          <div class="col-sm-4">
                            <div class="mb-20">
                                <label class="control-label">商品0</label>
                                 <select id="gid0" name="gid0" class="width-10 select0"> 
                                       <option  value="">请选择</option> 
                                       <c:forEach items="${goodslist}" var="bean">
                                       <option value="${bean._id}">${bean.title}</option>
                                       </c:forEach> 
                                </select>
                             </div> 
                          </div>
                          <div class="col-sm-4">
                             <div class="mb-20">
                                <label class="control-label">单价</label>
                                 <input type="text" id="price0" name="price0" value="0"
                                       class="form-control"  readonly="readonly"/>
                            </div>
                          </div>
                          <div class="col-sm-4">
                             <div class="mb-20">
                                <label class="control-label">数量</label>
                                 <input type="text" id="count0" name="count0" value="0"
                                       class="form-control" placeholder="请输入" onchange="ontotal()"/>
                                 <input type="hidden" id="title0" name="title0"
                                       class="form-control" placeholder="请输入"/>
                            </div>
                          </div>
                         </div>  
                        </div>
                        <div class="col-sm-12" align="center"> 
                               <label class="control-label" ><a href="javascript:createGids()" style="color: red;text-decoration: none;">+添加商品</a></label> 
                        </div>
                        
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">座次：</label>
                                <input type="text" id="ramadhin" name="ramadhin"
                                       class="form-control" placeholder="请输入"/>
                            </div>
                        </div> 
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">其他：</label>
                                <input type="text" id="other" name="other"
                                       class="form-control" placeholder="请输入" onchange="ontotal()"/>
                            </div>
                        </div> 
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">总计：</label>
                                <input type="text" id="total" name="total" value="0"
                                       class="form-control" placeholder="请输入" readonly="readonly"/>
                            </div>
                        </div>   
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">实付金额：</label>
                                <input type="text" id="paidin" name="paidin"
                                       class="form-control" placeholder="请输入"/>
                            </div>
                        </div>
                        
                    </div>
                    <div class="div-group-10 line-top" style="padding-left: 40px; padding-right: 40px;">
                        <button class="btn btn-danger width-10 maring-a clear weight500 hang40">出单
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
 </div> 
 
 <%--弹出层新--%>
<div class="fullscreen bg-hei-8 display-none" id="inszf" style="height: 100%;">
    <div style="padding-top:2%">
        <div class="pl-10 pr-10 maring-a cmp500"
             style="width: 100%;max-width: 500px;min-width: 320px;margin: 0px auto;right: 0px;">
            <div class=" bg-bai border-radius3 overflow-hidden">
                <div class="overflow-hidden line-height40 bg-bai line-bottom">
                    <div class="hang50 pull-left zi-hui-tq">
                        <i class="weight500 size14 pl-10 line-height50">出单</i>
                    </div>
                    <a href="javascript:ps_hide('inszf')">
                        <div class="hang40 pull-right zi-hui-tq">
                            <i class="weight500 size14 pl-10 pr-10 fa-1dx fa fa-remove" style="line-height: 50px;"></i>
                        </div>
                    </a>
                </div> 
                    <input type="hidden" id="zfid"/> 
                    <%--row--%>

                    <div class="pt-15 pl-15 pr-15 overflow-auto" style="height:490px;">
                        
                        
                        <div class="col-sm-12">
                            <div class="mb-20">
                                <label class="control-label">作废说明：</label>
                                <textarea type="text" id="invalids"
                                       class="form-control" style="height: 200px" placeholder="请输入"></textarea>
                            </div>
                        </div>
                        
                    </div>
                    <div class="div-group-10 line-top" style="padding-left: 40px; padding-right: 40px;">
                        <button onclick="invalids()" class="btn btn-danger width-10 maring-a clear weight500 hang40">出单
                        </button>
                    </div> 
            </div>
        </div>
    </div>
 </div> 
  
 
<%--弹出层新--%>
<div class="fullscreen bg-hei-8 display-none" id="inszzfsm" style="height: 100%;">
    <div style="padding-top:10%">
        <div class="pl-10 pr-10 maring-a cmp500"
             style="width: 100%;max-width: 250px;min-width: 120px;margin: 0px auto;right: 0px;">
            <div class=" bg-bai border-radius3 overflow-hidden">
                <div class="overflow-hidden line-height40 bg-bai line-bottom">
                    <div class="hang50 pull-left zi-hui-tq">
                        <i class="weight500 size14 pl-10 line-height50">作废说明</i>
                    </div>
                    <a href="javascript:ps_hide('inszzfsm')">
                        <div class="hang40 pull-right zi-hui-tq">
                            <i class="weight500 size14 pl-10 pr-10 fa-1dx fa fa-remove" style="line-height: 50px;"></i>
                        </div>
                    </a>
                </div>
                
                 <div class="col-sm-12">
                            <div class="mb-20">
                               <textarea  cols="12" rows="6" id="zfsm" style="text-align: center;"></textarea>
                            </div>
                 </div>
                
                
            </div>
        </div>
    </div>
 </div>
 <div  style="background-color: white;display:none;width: 300px;height: 350px;z-index: 999;position: absolute;right: 500px;top: 220px;padding: 10px;" id="accFC">sdgggggg</div>  
 <script type="text/javascript">
 jQuery(".select0").select2({
     width: '100%'
 }); 
 $('#gid0').change(function(){  
	toPrice(0);  
 });
 $("#gid").val("${gid}").trigger("change");
 $("#did").val("${did}").trigger("change");
 $("#state").val("${state}").trigger("change"); 
 $("#paystate").val("${paystate}").trigger("change");
 $("#paytype").val("${paytype}").trigger("change");
 </script>
</body>
</html>

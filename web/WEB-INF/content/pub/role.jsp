<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/com/libs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="/com/js_css.jsp"%>  
<script type="text/javascript" src="${ctx}/zTree/js/jquery.ztree.core-3.5.min.js"></script>  
<script type="text/javascript" src="${ctx}/zTree/js/jquery.ztree.excheck-3.5.min.js"></script>  
<script type="text/javascript" src="${ctx}/zTree/js/jquery.ztree.exedit-3.5.min.js"></script>  
<link rel="stylesheet" href="${ctx}/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css"> 
<script type="text/javascript">
	function del(id) {
		if (confirm('确实要删除吗?')) {

			location.href = "${ctx}/pub/role!delete.action?_id=" + id;

		}
	}
	 
	function add() {
		$('#_id').val('');
		$('#rolename').val(''); 
		//初始化节点为未选中状态
		zTreeObj.checkAllNodes(false);
		$('#inszc').modal({
			show : true
		});
	}
	function upd(id, rolename,funcList) {
		$('#_id').val(id);
		$('#rolename').val(rolename);
		 //初始化节点为选中状态
		$.each(funcList,function(n,value) {   
          zTreeObj.checkNode(zTreeObj.getNodeByParam("id",value, null));   
        
        });  
		$('#inszc').modal({
			show : true
		});

	}
	function page_submit(num) {

		if (num == -1) {
			$("#fypage").val(0);
		} else if (num == -2) {
			$("#fypage").val($("#fypage").val() - 1);
		} else {
			$("#fypage").val(num);
		}

		$("#custinfoForm").submit();
	}
	function check(){
	var nodes = zTreeObj.getCheckedNodes();
	                    var s = '';//选中节点ids
	                    //遍历选中的节点，为s赋值
	                    for(var i=0; i<nodes.length; i++){
 	                        if (s != '') s += ',';
	                        s += nodes[i].id;
	                    }
    if(s==""){
        return false;
    }else{
    
    $("#funclist").val(s);
        return true;//不写此返回值也行，此时就直接提交了

    }
  }
</script>
<SCRIPT type="text/javascript">
 	        <!--
	        var setting = {
	            async: {
	                enable: true,//异步处理
	 
	                //contentType: "application/json",//提交参数方式，这里 JSON 格式，默认form格式
	                 
	                url: '${ctx}/pub/role!getfunclist.action',//异步获取json格式数据的路径
	 
	                autoParam: ["id","name"]//异步加载时需要提交的参数，多个用逗号分隔
	                             
	            },
	            callback: {//回调函数，在这里可做一些回调处理
	                //beforeAsync: zTreeBeforeAsync
	            },
	            check: {//设置 zTree 的节点上是否显示 checkbox / radio ,默认为false
	                enable: true
	            },
	            data: {
	                simpleData: {
	                    /**
 	                    如果设置为 true，请务必设置 setting.data.simpleData 内的其他参数: idKey / pIdKey / rootPId
	                    并且让数据满足父子关系。*/                 
	                    enable: true,//true / false 分别表示 使用 / 不使用 简单数据模式
	                    idKey: "id",
	                    pIdKey: "pId",
	                    rootPId: 0                         
	                }
	            }
	        };
	 
	        var zNodes =[];//树节点，json格式，异步加载可设置为null或[]
	        var zTreeObj;//树对象
	      
	        $(document).ready(function(){
	             
	            zTreeObj = $.fn.zTree.init($("#permission_tree"), setting, zNodes);//实例化后直接返回树对象
	 
	            //异步提交表单
 	            $('#permissionform').form({
	                url: '${root}/sys/PermissionManagerole.action',
	                onSubmit: function() {
	                    //获取树对象中选中的节点
 	                    var nodes = zTreeObj.getCheckedNodes();
	                    var s = '';//选中节点ids
	                    //遍历选中的节点，为s赋值
	                    for(var i=0; i<nodes.length; i++){
 	                        if (s != '') s += ',';
	                        s += nodes[i].id;
	                    }
	                    document.all("roledto.permissionIds").value = s;
	                },
	                success: function(data) {
	                    //操作成功，返回信息
	                    var data = jQuery.parseJSON(data);
	                    if(data.success == false){
	                        alert(data.msg);
	                    }
	                    m_close(); 
	                }
	            });
	             
	        });
	 
 	        //-->
	    </SCRIPT>
</head>

<body>

	<section>

		<%@include file="/com/header.jsp"%>

		<div class="mainpanel">
			<%@include file="/com/headerbar.jsp"%>

			<form id="custinfoForm" name="custinfoForm" method="post"
				action="${contextPath}/pub/role.action?">

				<div class="pageheader"> 
						<i class="fa fa-user"></i>权限管理 <span style="font-size: 12px"><i class="fa fa-angle-double-right" style="font-size: 16px;margin:0;padding: 0"></i>角色管理</span>  
				</div>
				<div class="panelss ">
					<div class="panelss-body">
					   <div class="form-group pull-right btn-group"> 
                         <button type="button" class="btn btn-danger dropdown-toggle form-group pull-right" data-toggle="dropdown">
                                                                                    菜单 <i  class="fa fa-list"></i>
                         </button>
                         <ul class="dropdown-menu pull-right" role="menu">
                            <li><a href="javascript:add()"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;新增</a>

                            </li>  
                        </ul> 
                       </div> 
						<div class="row-pad-5"> 
							<div class="form-group col-sm-2">
								<input type="text" name="title" value="${title}"
									placeholder="标题" class="form-control" />
							</div>

							<a href="javascript:page_submit(-1);" class="btn btn-danger">搜&nbsp;&nbsp;索</a>

						</div>
					</div>
					<!-- panel-body -->
				</div>
				<!-- panel -->

				<div class="panel-body">
					<div class="row">
						<div class="col-md-12">
							<div class="table-responsive">
								<table class="table table-striped table-danger mb30">
									<thead>
										<tr>
										    <th class="th5">ID</th>
											<th class="th5">名称</th> 
											<th class="th5">创建者</th> 
											<th class="th5">操作</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${roleList}" var="bean">
											<tr>

                                                <td>${bean._id}</td>
												<td>${bean.rolename}</td> 
                                                <td>${bean.custid}</td> 

												<td class="table-action">
													<div class="btn-group1 position-r">
														<a data-toggle="dropdown" class="dropdown-toggle"> <i
															class="fa fa-cog"></i> </a>
														<ul role="menu" class="dropdown-menu pull-right">
															<li><a
																href="javascript:upd('${bean._id}','${bean.rolename}',${bean.funcList});">
																	<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a>
															</li>
															<li><a href="javascript:del(${bean._id});"><i
																	class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>

														</ul>
													</div>
												</td>
											</tr>
										</c:forEach>
								</table>
								<%@include file="/com/page.jsp"%>

							</div>
						</div>
					</div>

				</div>
				<!-- contentpanel -->
			</form>
		</div>
		<!-- mainpanel -->
	</section>
 
<div class="fullscreen bg-hei-8 display-none" id="inszc" style="height: 100%;">
    <div style="padding-top:2%">
        <div class="pl-10 pr-10 maring-a cmp500"
             style="width: 100%;max-width: 500px;min-width: 320px;margin: 0px auto;right: 0px;">
            <div class=" bg-bai border-radius3 overflow-hidden">
                <div class="overflow-hidden line-height40 bg-bai line-bottom">
                    <div class="hang50 pull-left zi-hui-tq">
                        <i class="weight500 size14 pl-10 line-height50">角色添加</i>
                    </div>
                    <a href="javascript:ps_hide('inszc')">
                        <div class="hang40 pull-right zi-hui-tq">
                            <i class="weight500 size14 pl-10 pr-10 fa-1dx fa fa-remove" style="line-height: 50px;"></i>
                        </div>
                    </a>
                </div>
                <form id="inscxForm" action="${ctx}/pub/role!save.action?fypage=${fypage}"
                      class="form-horizontal" onsubmit="return check()" method="post">
                    <input type="hidden" id="_id" name="_id"/>
                    <input type="hidden" id="funclist" name="funclist" /> 

                    <div class="pt-15 pl-15 pr-15 overflow-auto" style="height:490px;">
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">角色名称：</label>
                                <input type="text" id="rolename" name="rolename"
                                       class="form-control" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">资源列表：</label>
                                 <ul id="permission_tree" class="ztree" style="border: 0px; background-color: #f7f7f7;"></ul>
                            </div>
                        </div>
                         
                    </div>
                    <div class="div-group-10 line-top" style="padding-left: 40px; padding-right: 40px;">
                        <button class="btn btn-danger width-10 maring-a clear weight500 hang40">提 交
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
 </div> 
</body>
</html>

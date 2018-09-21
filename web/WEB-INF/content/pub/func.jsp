<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/com/libs.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head> 
    <%@include file="/com/js_css.jsp" %> 
    <script type="text/javascript">
        function del(id) {
            if (confirm('确实要删除吗?')) {
                location.href = "${ctx}/pub/func!delete.action?_id=" + id+"&parentid=${parentid}&fypage=${fypage}";
            }
        }
        function find(id) { 
                location.href = "${ctx}/pub/func.action?parentid="+id+"&fypage=${fypage}"; 
        }
        function add() {
            $('#_id').val('');
            $('#name').val('');
            $('#url').val('#');
            $('#ioc').val(''); 
            $('#sort').val(0); 
            ps_show('inszc');
        }
        function upd(id) {
            var submitData = {
                _id: id
            };
            $.post('${ctx}/pub/func!upd.action', submitData,
                    function (json) {
                        $('#_id').val(json._id);
                        $('#name').val(json.name);
                        $('#url').val(json.url);
                        $('#ioc').val(json.ioc);
                        $('#nickname').val(json.nickname);
                        $('#sort').val(json.sort); 
                       
                    }, "json")
            $('#inszc').modal({
                show: true
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
            $("#custdangerForm").submit();
        }
      
    </script>
  
</head>
<body>
<section>
    <%@include file="/com/header.jsp" %>
    <div class="mainpanel">
        <%@include file="/com/headerbar.jsp" %>
        <form id="custdangerForm" name="custdangerForm" method="post"
              action="${ctx}/pub/func.action?parentid=${parentid}">
            <div class="pageheader" style="font-size: 16px"> 
                    <i class="fa fa-user"></i>系统管理<span style="font-size: 12px"><i class="fa fa-angle-double-right" style="font-size: 16px;margin:0;padding: 0"></i>资源管理</span> 
            </div> 
            <div class="panelss">
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
                            <input type="text" name="name" value="${name}"
                                   placeholder="资源名称" class="form-control"/>
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
                                    <th class="th5">id</th>
                                    <th class="th5">名称</th> 
                                    <th class="th5">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${list}" var="bean">
                                    <tr>
                                        <td>${bean._id}</td>
                                        <td>${bean.name}</td>  
                                        <td class="table-action">
                                            <div class="btn-group1 position-r">
                                                <a data-toggle="dropdown" class="dropdown-toggle"> <i
                                                        class="fa fa-cog"></i> </a> 
                                                    <ul role="menu" class="dropdown-menu pull-right">
                                                        <li><a
                                                                href="javascript:upd('${bean._id}');">
                                                            <i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a>
                                                        </li>
                                                        <li><a
                                                                href="javascript:find('${bean._id}');">
                                                            <i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;管理子资源</a>
                                                        </li>
                                                        <li><a href="javascript:del('${bean._id}');"><i
                                                                class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a>
                                                        </li>
                                                    </ul> 
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
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
                        <i class="weight500 size14 pl-10 line-height50">资源添加</i>
                    </div>
                    <a href="javascript:ps_hide('inszc')">
                        <div class="hang40 pull-right zi-hui-tq">
                            <i class="weight500 size14 pl-10 pr-10 fa-1dx fa fa-remove" style="line-height: 50px;"></i>
                        </div>
                    </a>
                </div>
                <form id="inscxForm" action="${ctx}/pub/func!save.action?fypage=${fypage}"
                      class="form-horizontal" method="post">
                    <input type="hidden" id="_id" name="_id"/>
                    <%--row--%>

                    <div class="pt-15 pl-15 pr-15 overflow-auto" style="height:490px;">
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">名称：</label>
                                <input type="text" id="name" name="name"
                                       class="form-control" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">链接：</label>
                                <input type="text" id="url" name="url"
                                       class="form-control" placeholder="请输入"/>
                            </div>
                        </div> 
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">图标：</label>
                                <input type="text" id="ioc" name="ioc"
                                       class="form-control" placeholder="请输入"/>
                            </div>
                        </div> 
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">父资源：</label> 
                                <input type="text" id="parentid" name="parentid"
                                       class="form-control" value="${parentid}" readonly="readonly"/>
                            </div>
                        </div> 
                        <div class="col-sm-12">
                            <div class="mb-20">
                                <label class="control-label">序号：</label>
                                <input type="text" id="sort" name="sort"
                                       class="form-control" placeholder="请输入"/>
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
 <script type="text/javascript">
 jQuery(".select2").select2({
     width: '100%'
 });
 </script>
</body>
</html>

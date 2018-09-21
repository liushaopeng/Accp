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
                location.href = "${ctx}/user/user!delete.action?_id=" + id;
            }
        }
        function add() {
            $('#_id').val('');
            $('#account').val('');
            $('#password').val('');
            $('#nickname').val('');
            $('#toUser').val('');
            $('#tel').val('');
            ps_show('inszc');
        }
        function upd(id) {
            var submitData = {
                _id: id
            };
            $.post('${ctx}/user/user!upd.action', submitData,
                    function (json) {
                        $('#_id').val(json._id);
                        $('#account').val(json.account);
                        $('#password').val(json.password); 
                        $('#nickname').val(json.nickname);  
                        $('#tel').val(json.tel); 
                        $('#toUser').val(json.toUser);
                        $('#roleid').val(json.roleid); 
                       
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
        function check(){
        	if($("#password").val()==$("#repassword").val()&&$("#password").val().length>0){
        		var regu = /^[1][0-9]{10}$/;
                var re = new RegExp(regu);
                if (!re.test($("#tel").val())) {
                  alert("请输入正确手机号码");
                  return false;
                }  
        		return true; 
        	}else{
        		alert("两次输入密码不一致！");
        		return false; 
        	}
        
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
              action="${ctx}/user/user.action?">
            <div class="pageheader" style="font-size: 16px"> 
                    <i class="fa fa-user"></i>权限管理 <span style="font-size: 12px"><i class="fa fa-angle-double-right" style="font-size: 16px;margin:0;padding: 0"></i>用户管理</span> 
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
                            <input type="text" name="title" value="${title}"
                                   placeholder="登陆名称" class="form-control"/>
                        </div>
                        <div class="form-group col-sm-2">
                            <input type="text" name="wxname" value="${name}"
                                   placeholder="昵称" class="form-control"/>
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
                                    <th class="th5">名称</th>
                                    <th class="th8">密码</th>
                                    <th class="th8">创建时间</th>  
                                    <th class="th8">创建者</th>
                                    <th class="th5">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${list}" var="bean">
                                    <tr> 
                                        <td>${bean.account}</td>
                                        <td>${bean.password}</td>
                                        <td><fmt:formatDate pattern='yyyy-MM-dd HH:mm'
                                                            value='${bean.createdate}'/></td> 
                                        <td>${bean.custid}</td>
                                        <td class="table-action">
                                            <div class="btn-group1  position-r">
                                                <a data-toggle="dropdown" class="dropdown-toggle"> <i
                                                        class="fa fa-cog"></i> </a> 
                                                    <ul role="menu" class="dropdown-menu pull-right">
                                                        <li><a
                                                                href="javascript:upd('${bean._id}');">
                                                            <i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a>
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
                        <i class="weight500 size14 pl-10 line-height50">用户添加</i>
                    </div>
                    <a href="javascript:ps_hide('inszc')">
                        <div class="hang40 pull-right zi-hui-tq">
                            <i class="weight500 size14 pl-10 pr-10 fa-1dx fa fa-remove" style="line-height: 50px;"></i>
                        </div>
                    </a>
                </div>
                <form id="inscxForm" onsubmit="return check()" action="${ctx}/user/user!save.action?fypage=${fypage}"
                      class="form-horizontal"  method="post">
                    <input type="hidden" id="_id" name="_id"/>
                    <%--row--%>

                    <div class="pt-15 pl-15 pr-15 overflow-auto" style="height:490px;">
                        
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">账号：</label>
                                <input type="text" id="account" name="account"
                                       class="form-control" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="mb-20">
                                <label class="control-label">图片</label>
                                <input type="text" id="picurl" name="picurl"
                                       class="form-control" placeholder="请输入"/>
                                 
                            </div>
                        </div>
                        <div class="col-sm-2"> 
                            <label class="control-label">&nbsp;&nbsp;&nbsp;</label>
                              <div class="btn btn-danger  hang40" style="margin-left: 0px" onclick="pz('picurl','450','200',false)">上传
                              </div> 
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">昵称：</label>
                                <input type="text" id="nickname" name="nickname"
                                       class="form-control" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">密码：</label>
                                <input type="password" id="password" name="password"
                                       class="form-control" placeholder="请输入"/>
                            </div>
                        </div> 
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">重复密码：</label>
                                <input type="password" id="repassword" name="repassword"
                                       class="form-control" placeholder="请输入"/>
                            </div>
                        </div> 
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">电话：</label>
                                <input type="text" id="tel" name="tel"
                                       class="form-control" placeholder="请输入"/>
                            </div>
                        </div> 
                       <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">微信ID：</label>
                                <input type="text" id="toUser" name="toUser"
                                       class="form-control" placeholder="请输入"/>
                            </div>
                        </div> 
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">角色：</label>
                                <select id="roleid" name="roleid" class="width-10 select2"> 
                                       <c:forEach items="${roleList}" var="bean">
                                       <option value="${bean._id}">${bean.rolename}</option>
                                       </c:forEach>      
                                </select>
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
<%@include file="/com/cut-img2.jsp" %>
 <script type="text/javascript">
 jQuery(".select2").select2({
     width: '100%'
 }); 
 
 </script>
</body>
</html>

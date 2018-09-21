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
            $('#area').val('');
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
                        $('#toUser').val(json.toUser);
                        $('#nickname').val(json.nickname);
                        $('#roleid').val(json.roleid);
                        $('#type').val(json.type); 
                        $('#province').val(json.province);
                        $('#city').val(json.city);
                        var funcs = json.funclist;
                        $('.ch_type').each(function () {
                            $(this).removeClass("gx-xz-dj");
                        });
                        for (var l = 0; l < funcs.length; l++) {
                            $("#func-" + funcs[l]._id).addClass("gx-xz-dj");
                        }
                        cke();
                        $('#mb').val(json.mb);
                    }, "json")
            $('#inszc').modal({
                show: true
            });
        }
        function submint() {
            var submitData = {
                id: $('#_id').val(),
                funcs: $('#funcs').val(),
                account: $('#account').val(),
                password: $('#password').val(),
                toUser: $('#toUser').val(),
                roleid: $('#roleid').val(),
                type: $('#type').val(),
                province: $('#province').val(),
                city: $('#city').val(),
                nickname: $('#nickname').val(),
                mb: $('#mb').val(),
            };
            $.post('${ctx}/user/user!ajaxsave.action', submitData,
                    function (json) {
                        if (json.state == 0) {
                            alert("添加成功！");
                            window.location.reload();
                        }
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
        function cke(v) {
            if ($(v).hasClass('gx-xz-dj')) {
                $(v).removeClass("gx-xz-dj");
            } else {
                $(v).addClass("gx-xz-dj");
            }
            var str = "";
            $('.ch_type').each(function () {
                        if ($(this).is('.gx-xz-dj')) {
                            str += $(this).find('input').val() + ",";
                        }
                    }
            );
            $("#funcs").val(str);
        }
        function selGoods(v){
        	alert("你选择了"+v);
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
                    <i class="fa fa-user"></i>eeee <span style="font-size: 12px"><i class="fa fa-angle-double-right" style="font-size: 16px;margin:0;padding: 0"></i>用户管理</span> 
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
                                    <th class="th5">id</th>
                                    <th class="th5">名称</th>
                                    <th class="th8">密码</th>
                                    <th class="th8">创建时间</th>
                                    <th class="th8">角色</th>
                                    <th class="th8">创建者</th>
                                    <th class="th5">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${list}" var="bean">
                                    <tr>
                                        <td>${bean._id}</td>
                                        <td>${bean.account}</td>
                                        <td>${bean.password}</td>
                                        <td><fmt:formatDate pattern='yyyy-MM-dd HH:mm'
                                                            value='${bean.createdate}'/></td>
                                        <td>${bean.roleid}</td>
                                        <td>${bean.custid}</td>
                                        <td class="table-action">
                                            <div class="btn-group1">
                                                <a data-toggle="dropdown" class="dropdown-toggle"> <i
                                                        class="fa fa-cog"></i> </a>
                                                <c:if test="${bean.custid==custid}">
                                                    <ul role="menu" class="dropdown-menu pull-right">
                                                        <li><a
                                                                href="javascript:upd('${bean._id}');">
                                                            <i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a>
                                                        </li>
                                                        <li><a href="javascript:del('${bean._id}');"><i
                                                                class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a>
                                                        </li>
                                                    </ul>
                                                </c:if>
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
                        <i class="weight500 size14 pl-10 line-height50">商品选择</i>
                    </div>
                    <a href="javascript:ps_hide('inszc')">
                        <div class="hang40 pull-right zi-hui-tq">
                            <i class="weight500 size14 pl-10 pr-10 fa-1dx fa fa-remove" style="line-height: 50px;"></i>
                        </div>
                    </a>
                </div>
           <div class="row filemanager" style="padding: 10px;background-color:#e6e8ea">
            
            <div class="col-xs-6 col-sm-4 col-md-3 document">
              <div class="thmb">
                <div class="ckbox ckbox-default">
                  <input type="checkbox" id="check1" value="1" />
                  <label for="check1"></label>
                </div> 
                <div class="thmb-prev">
                  <img src="${ctx}/img/2.jpg" class="img-responsive" alt="" />
                </div>
                <h5 class="fm-title"><a href="javascript:selGoods('1');">MyDocuments.doc</a></h5> 
              </div><!-- thmb -->
            </div><!-- col-xs-6 -->
            
            <div class="col-xs-6 col-sm-4 col-md-3 document">
              <div class="thmb">
                <div class="ckbox ckbox-default">
                  <input type="checkbox" id="check2" value="1" />
                  <label for="check2"></label>
                </div> 
                <div class="thmb-prev">
                  <a href="images/photos/media1.jpg" data-rel="prettyPhoto">
                    <img src="${ctx}/img/2.jpg" class="img-responsive" alt="" />
                  </a>
                </div>
                <h5 class="fm-title"><a href="">Vegetarian.png</a></h5> 
              </div><!-- thmb -->
            </div><!-- col-xs-6 -->
            
            <div class="col-xs-6 col-sm-4 col-md-3 document">
              <div class="thmb">
                <div class="ckbox ckbox-default">
                  <input type="checkbox" id="check3" value="1" />
                  <label for="check3"></label>
                </div> 
                <div class="thmb-prev">
                  <img src="${ctx}/img/2.jpg" class="img-responsive" alt="" />
                </div>
                <h5 class="fm-title"><a href="">DogAnimation.mp4</a></h5> 
              </div><!-- thmb -->
            </div><!-- col-xs-6 -->
            
            <div class="col-xs-6 col-sm-4 col-md-3 document">
              <div class="thmb">
                <div class="ckbox ckbox-default">
                  <input type="checkbox" id="check7" value="1" />
                  <label for="check7"></label>
                </div> 
                <div class="thmb-prev">
                  <img src="${ctx}/img/2.jpg" class="img-responsive" alt="" />
                </div>
                <h5 class="fm-title"><a href="">WreckingBall.mp3</a></h5> 
              </div><!-- thmb -->
            </div><!-- col-xs-6 -->
            
            <div class="col-xs-6 col-sm-4 col-md-3 document">
              <div class="thmb">
                <div class="ckbox ckbox-default">
                  <input type="checkbox" id="check4" value="1" />
                  <label for="check4"></label>
                </div> 
                <div class="thmb-prev">
                  <a href="images/photos/media3.png" data-rel="prettyPhoto">
                    <img src="${ctx}/img/2.jpg" class="img-responsive" alt="" />
                  </a>
                </div>
                <h5 class="fm-title"><a href="">MyFirstArt.png</a></h5> 
              </div><!-- thmb -->
            </div><!-- col-xs-6 -->
            
            <div class="col-xs-6 col-sm-4 col-md-3 document">
              <div class="thmb">
                <div class="ckbox ckbox-default">
                  <input type="checkbox" id="check5" value="1" />
                  <label for="check5"></label>
                </div> 
                <div class="thmb-prev">
                  <img src="${ctx}/img/2.jpg" class="img-responsive" alt="" />
                </div>
                <h5 class="fm-title"><a href="">MyResume.docx</a></h5> 
              </div><!-- thmb -->
            </div><!-- col-xs-6 --> 
          </div><!-- row -->
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

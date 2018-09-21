<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/com/libs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="/com/js_css.jsp" %>  
<script type="text/javascript" src="${ctx}/ckeditor/ckeditor.js"></script>
 
<script type="text/javascript">

var editor=CKEDITOR.replace('context');
	$(document).ready(
			function() {
				var validator = $("#inscxForm").validate(
						{
							rules : {
								title : {
									required : true
								},
								sort : {
									digits : true,
									required : true
								}

							},
							messages : {},
							highlight : function(element) {
								jQuery(element).closest('.form-group')
										.removeClass('has-success').addClass(
												'has-error');
							},
							success : function(element) {
								jQuery(element).closest('.form-group')
										.removeClass('has-error');
							}
						});
			});
	function del(id) {
		if (confirm('确实要删除吗?')) {
			location.href = "${ctx}/suc/roll!delete.action?type=${type}&fypage=${fypage}&_id="
					+ id;
		}
	}
	function add() {
		$('#_id').val('');
		$('#title').val('');
		$('#url').val('');
		$('#sort').val(0);
		ps_show('inszc'); 
		//location.href = "${ctx}/suc/roll!addroll.action?type=${type}&fypage=${fypage}";
	}
	function upd(id) {
		var submitData = {
			_id : id
		};
		$.post('${ctx}/suc/roll!upd.action', submitData, function(json) {
			
			var content  = json.content  ;
			$('#_id').val(json._id);
			$('#title').val(json.title);
			$('#type').val(json.type);
			$('#url').val(json.url);
			$('#context').val(content);
			//CKEDITOR.instances.content.setData(content); 
			   //var editor=CKEDITOR.replace("context");
			 
			editor.setData(content);
			
			$('#sort').val(json.sort);

		}, "json")
		ps_show('inszc');
	}
	function getpic() {
		$('#tubiao').show();
	}
	function close_box() {
		$('#tubiao').hide();
	}
	function seltb(key) {
		$('#picurl').val(key);
		$('#tubiao').hide();
	}
	function share(url) {
		window.open("${contextPath}/weixin/share.action?method="
				+ encodeURIComponent(url));
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
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	jQuery(".select2").select2({
		width : '100%'
	});
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
		  <%@include file="/com/header.jsp"%>
		<div class="mainpanel">
				<%@include file="/com/headerbar.jsp"%>
			<form id="custinfoForm" name="custinfoForm" method="post"
				action="${contextPath}/Acc_Manage/suc/roll.action?type=${type}">
				<div class="pageheader">
					<h2>
						<i class="fa fa-user"></i> 微官网 <span>滚动管理</span>
					</h2>

				</div>
			   <div class="panelss">
                <div class="panelss-body">
                   <div class="form-group pull-right btn-group row-pad-5"> 
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
                                   placeholder="标题" class="form-control"/>
                        </div>
                        <a href="javascript:page_submit(-1);" class="btn btn-danger">搜&nbsp;&nbsp;索</a>
                    </div>
                </div>
            </div>
				<div class="panel-body">
					<div class="row">
						<div class="col-md-12">
							<div class="table-responsive">
								<table
									class="table table-striped table-action table-primary mb30">
									<thead>
										<tr>
											<th class="table-action">序号</th>
											<th class="table-action">名称</th>
											<th class="table-action">地址</th>
											<th class="table-action">操作</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${rollList}" var="bean">
											<tr>
												<td>${bean.sort}</td>
												<td>${bean.title}</td>
												<td><div class="th10 sl">${bean.url}</div></td>
												<td class="table-action">
													<div class="btn-group1 position-r">
														<a data-toggle="dropdown" class="dropdown-toggle"> <i
															class="fa fa-cog"></i>
														</a>
														<ul role="menu" class="dropdown-menu pull-right"> 
																<li><a href="javascript:upd('${bean._id}');"> <i
																		class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改
																</a></li> 
																<li><a href="javascript:del('${bean._id}');"><i
																		class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a>
																</li> 
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
			</form>
		</div>
	</section>

	<%--弹出层新--%>
	<div class="fullscreen bg-hei-8 display-none" id="inszc"
		style="height: 100%;">
		<div style="padding-top: 2%">
			<div class="pl-10 pr-10 maring-a cmp500"
				style="width: 100%; max-width: 500px; min-width: 320px; margin: 0px auto; right: 0px;">
				<div class=" bg-bai border-radius3 overflow-hidden">
					<div class="overflow-hidden line-height40 bg-bai line-bottom">
						<div class="hang50 pull-left zi-hui-tq">
							<i class="weight500 size14 pl-10 line-height50">内容管理</i>
						</div>
						<a href="javascript:ps_hide('inszc')">
							<div class="hang40 pull-right zi-hui-tq">
								<i class="weight500 size14 pl-10 pr-10 fa-1dx fa fa-remove"
									style="line-height: 50px;"></i>
							</div>
						</a>
					</div>
					<form id="inscxForm"
						action="${ctx}/suc/roll!save.action?fypage=${fypage}"
						class="form-horizontal" method="post">
						<input type="hidden" id="_id" name="_id" /> <input type="hidden"
							id="type" name="type" value="${type}" />
						<%--row--%>

						<div class="pt-15 pl-15 pr-15 overflow-auto"
							style="height: 490px;">

							<div class="col-sm-6">
								<div class="mb-20">
									<label class="control-label">名称：</label> <input type="text"
										id="title" name="title" class="form-control" placeholder="请输入" />
								</div>
							</div>
							<!--  
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">链接：</label>
                                <input type="text" id="url" name="url"
                                       class="form-control" placeholder="请输入"/>
                            </div>
                        </div> 
                        -->
							<div class="col-sm-12">
								<div class="mb-20">
									<label class="control-label">序号：</label> <input type="text"
										id="sort" name="sort" class="form-control" placeholder="请输入" />
								</div>
							</div>


							<!--下部编辑器-->
							<div class="pt-10 clear">
								<div class="div-group-10 border-radius5 bg-bai">
									<textarea name="context" id="context" class="ckeditor"
										rows="10" cols="38"> </textarea>
									<script id="editor" type="text/plain"
										style="width: 100%; height: 300px;"> </script>
								</div>

							</div>

						</div>
						<div class="div-group-10 line-top"
							style="padding-left: 40px; padding-right: 40px;">
							<button
								class="btn btn-primary width-10 maring-a clear weight500 hang40">提
								交</button>
						</div>
					</form>
				</div>
			</div>
		</div>
		<%@include file="/com/cut-img.jsp"%>
		<script type="text/javascript">
			 
		    var editor=CKEDITOR.replace('context');
		 
			function checksubmit() {
				$("#context").val(editor.getData());
			}
			

		</script>
	</div>


</body>
</html>

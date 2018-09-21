<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/com/libs.jsp"%>
<%@page import="com.mongodb.DBObject"%>
<%@page
	import="com.lsp.sys.security.CustomerUser,com.lsp.pub.util.SpringSecurityUtils,com.lsp.pub.entity.CacheResource
,com.lsp.pub.entity.FuncInfo,java.util.List"%>
<%@page import="org.springframework.web.filter.RequestContextFilter"%>

<%
	String custName = "";
	String custid = "";
	CustomerUser cust = (CustomerUser) SpringSecurityUtils.getCurrentUser();
	if (cust != null) {
		custName = cust.getCustname();
		custid = cust.getCustid();
	}
	List<FuncInfo> modules = CacheResource.getGetAllFunc();
%>
<div class="leftpanel" style="width: 28%">

	<div class="logopanel"
		style="height: 50px; overflow: hidden; line-height: 50px; font-weight: font-weight:bold;">
		<h4>
			<span>&nbsp;</span>
		</h4>
	</div>
	<!-- logopanel -->

	<div class="leftpanelinner">

		<h5 class="sidebartitle"></h5>

		<ul class="nav nav-tabs nav-justified" id="lefttabs">
			<li id="leftli_0" class="active" mbdata="0"><a href="#lefttab0"
				data-toggle="tab"><strong>模板中心</strong></a></li>
			<li id="leftli_1" mbdata="1"><a href="#lefttab1" data-toggle="tab"><strong>我的模板</strong></a></li>
		</ul>
		<div class="tab-content" id="jltabs-body">
			<div class="tab-pane active" id="lefttab0">

				<div class="panel panel-default">

					<div class="row">
						<div class="col-sm-12" style="height: 500px;overflow: scroll;">
							<div class="row filemanager" id="mb_all" > 
							</div>
							<!-- row -->
						</div>
						<!-- col-sm-9 -->

					</div>
				</div>
				<!-- panel -->
			</div>


			<div class="tab-pane" id="lefttab1">

				<div class="panel panel-default">

					<div class="row">
						<div class="col-sm-12" style="height: 500px;overflow: scroll;">
							<div class="row filemanager" id="mb_my">
  
							</div>
							<!-- row -->
						</div>
						<!-- col-sm-9 -->

					</div>
				</div>
				<!-- panel -->
			</div>
		</div>

	</div>
	<!-- leftpanelinner -->
</div>
<!-- leftpanel -->
<script>
	$(function() {
		var cate_id = "${cate_id }";
		$("#cate_" + cate_id).addClass("active");
		$("#cate_" + cate_id).parent().css("display", "block");

		$("#cate_" + cate_id.substring(0, 2)).addClass("active");
	});
</script>


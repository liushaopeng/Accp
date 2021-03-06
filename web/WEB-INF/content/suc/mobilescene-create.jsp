<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/com/libs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<%@include file="/com/js_css.jsp"%>

<head>
<link rel="stylesheet" type="text/css"
	href="${ctx}/iphone/css/style.css">
<script type="text/javascript"
	src="${ctx}/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<link href="${ctx}/css_js/css/an.css" rel="stylesheet" />
<script type="text/javascript" src="${ctx}/transformjs/transform.js"></script>
<script type="text/javascript" src="${ctx}/transformjs/asset/tick.js"></script>
<script type="text/javascript" src="${ctx}/transformjs/asset/to.js"></script>
<script type="text/javascript"
	src="${ctx}/transformjs/asset/alloy_flow.js"></script>
<script type="text/javascript" src="${ctx}/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${ctx}/css_js/Tdrag/js/Tdrag.js"></script>
<style type="text/css">
*, *:after, *:before {
	box-sizing: border-box;
}

body {
	overflow: hidden;
}

.iphone {
	margin-top: 90px;
	box-shadow: inset 0 0 3px 0 rgba(0, 0, 0, 0.2), 0 0 0 1px #999, 0 0 30px
		0px rgba(0, 0, 0, 0.7);
	border: 5px solid #d9dbdc;
	background: #f8f8f8;
	padding: 5px;
	width: 350px;
	border-radius: 20px;
	top: -80px;
	position: relative;
	-webkit-transform: scale(1);
	transform: scale(1);
}

.iphone-screen {
	background: black;
	border: 1px solid #fff;
	height: 486px;
	width: 320px;
	margin: 0 auto;
	border: 1px solid rgba(0, 0, 0, 0.9);
	border-radius: 3px;
	overflow: hidden;
}

.childdiv {
	width: 100px;
	height: 100px;
	background-color: red;
}

.layers {
	width: 100%;
	height: 100%;
	background-color: white;
	background-size: cover;
}

.elves {
	background-size: 100%;
}

.bg_color {
	background-color: #e8ad58 !important;
}

.div_text {
	width: 100%;
	border: 1px solid #1593ff;
	min-height: 30px;
	top: 50%;
	color: black;
	position: relative;
	line-height: 31px;
	text-align: center;
	cursor: default;
}

.div_move {
	width: 100%;
	min-height: 30px;
	top: 50%;
	color: black;
	position: relative;
	line-height: 31px;
	text-align: center;
	cursor: default;
}

.div_slide {
	width: 100%;
	height: 300px;
	background-color: blue;
	position: absolute !important;
	-webkit-transform: scale(1);
	transform: scale(1);
}

.div_roll {
	width: 100%;
	min-height: 30px;
	color: red;
	position: absolute !important;
	border: 1px solid #1593ff;
	position: relative;
}
</style>
<script type="text/javascript">
	var layerid;//当前层
	var elveid;//当前精灵
</script>
</head>
<body>

	<section>
		<%@include file="/com/header1.jsp"%>
		<div class="mainpanel" style="margin-left: 28%; min-height: 600px">
			<%@include file="/com/headerbar1.jsp"%>
			<div class="contentpanel">
				<div class="row" id="hswe" style="width: 50%; float: left;">
					<div class="iphone">
						<div class="iphone-screen"></div>

					</div>
				</div>
				<input type="button" class="disable" value="禁止/启用拖拽">
				<div class="row" id="hswe" style="width: 50%; float: right;">
					<ul class="nav nav-tabs nav-justified" id="tabs">
						<li id="li_2"><a href="#tab2" data-toggle="tab"><strong>精灵管理</strong></a></li>
						<li id="li_3"><a href="#tab3" data-toggle="tab"><strong>图层管理</strong></a></li>

						<div class="tab-content" id="tabs-body">
							<div class="tab-pane  top-pane active" id="tab4">

								<div class="panel panel-default">

									<div class="modal-header">
										<h4 class="modal-title">
											<i class="fa"></i>精灵设置
										</h4>
									</div>
									<ul class="nav nav-tabs nav-justified" id="jltabs">
										<li id="jlli_1" class="active"><a href="#jltab1"
											data-toggle="tab"><strong>样式</strong></a></li>
										<li id="jlli_2"><a href="#jltab2" data-toggle="tab"><strong>动画</strong></a></li>

									</ul>

									<div class="tab-content" id="jltabs-body">
										<div class="tab-pane active" id="jltab1">
											<div class="panel-body"
												style="height: 400px; overflow: scroll;">

												<div class="panel panel-default">
													<input type="hidden" id="elve_id" />
													<div class="form-group">
														<label class="col-sm-3 control-label">精灵标题: <span
															class="asterisk">*</span></label>
														<div class="col-sm-5">
															<input type="text" id="elve_title"
																onchange="elveChange()" class="form-control"
																placeholder="请输入" />
														</div>
														<div class="col-sm-2">
															<div id="elve_yl"
																style="height: 40px; width: 40px; background-size: 100% 100%"></div>
														</div>

													</div>
													<div class="form-group">
														<label class="col-sm-3 control-label">标题颜色: <span
															class="asterisk">*</span></label>
														<div class="col-sm-5">
															<input type="text" id="elve_title_color"
																class="form-control color" onchange="bg_onchange(this)"
																readonly="readonly" />
														</div>
													</div>
													<div class="form-group">
														<label class="col-sm-3 control-label">背景图片: <span
															class="asterisk">*</span></label>
														<div class="col-sm-5">

															<input type="text" id="elve_picurl"
																onchange="picurl_change()"
																class="elve_picurl form-control" />
														</div>
														<div class="col-sm-2"
															style="height: 30px; line-height: 30px; margin-top: 3px">
															<div class="button  btn-warning-alt "
																style="text-align: center;">上传</div>
															<div
																style="position: absolute; width: 60px; height: 20px; top: 0px; opacity: 0">
																<input type="file" class="elvepicurl"
																	style="width: 60px; height: 20px" />
															</div>
														</div>

														<div class="col-sm-2"
															style="height: 30px; line-height: 30px; margin-top: 3px">
															<div class="button  btn-warning-alt "
																style="text-align: center;"
																onclick="init_img('elve_picurl','insScene','elve_picurl_change')">图库</div>
														</div>

													</div>
													<div class="form-group">
														<label class="col-sm-3 control-label">背景颜色: <span
															class="asterisk">*</span></label>
														<div class="col-sm-5">

															<input type="text" id="elve_bgcolor"
																class="form-control color" onchange="bg_onchange(this)"
																readonly="readonly" />
														</div>

													</div>
													<div class="form-group">
														<label class="col-sm-3 control-label">透明度: <span
															class="asterisk">*</span></label>
														<div class="col-sm-5">
															<div id="slider-elve-transparent"
																class="slider-primary mb20"></div>
														</div>
														<div class="col-sm-3">
															<input type="text" id="elve_transparent"
																class="form-control" placeholder="1" value="1" />
														</div>


														<!--222-->
													</div>
													<div class="form-group">
														<label class="col-sm-3 control-label">点击跳转: <span
															class="asterisk">*</span></label>
														<div class="col-sm-5">

															<input type="text" id="elve_url" class="form-control"
																placeholder="请输入" onchange="elveChange()" />
														</div>

														<!--222-->
													</div>
													<div class="form-group">
														<label class="col-sm-3 control-label">精灵序号: <span
															class="asterisk">*</span></label>
														<div class="col-sm-5">

															<input type="text" id="elve_sort" class="form-control"
																placeholder="请输入" onchange="elveChange()" />
														</div>

														<!--222-->
													</div>


													<div class="panel-group" id="accordion">
														<div class="panel panel-default">
															<div class="panel-heading">
																<h4 class="panel-title">
																	<a data-toggle="collapse" data-parent="#accordion"
																		href="#collapseOne" class="collapsed">边框 </a>
																</h4>
															</div>
															<div id="collapseOne" class="panel-collapse collapse"
																style="height: 0px;">
																<div class="panel-body">
																	<div class="form-group">
																		<label class="col-sm-3 control-label">边框样式: <span
																			class="asterisk">*</span></label>
																		<div class="col-sm-4">
																			<select class="form-control col-sm-2" id="elve_bk_ys"
																				onchange="bk_ys_change()">
																				<option value="none">无边框</option>
																				<option value="dotted">点状</option>
																				<option value="dashed">虚线</option>
																				<option value="solid">实线</option>
																				<option value="double">双线</option>
																				<option value="groove">3D凹槽</option>
																				<option value="ridge">3D垄状</option>
																				<option value="inset">3Dinset</option>
																				<option value="outset">3Doutset</option>

																			</select>
																		</div>

																		<!--222-->
																	</div>
																	<div class="form-group">
																		<label class="col-sm-3 control-label">边框颜色: <span
																			class="asterisk">*</span></label>
																		<div class="col-sm-5">
																			<input type="text" id="elve_bk_color"
																				class="form-control color" readonly="readonly" />
																		</div>

																		<!--222-->
																	</div>
																	<div class="form-group">
																		<label class="col-sm-3 control-label">边框尺寸: <span
																			class="asterisk">*</span></label>
																		<div class="col-sm-5">
																			<div id="slider-bk-cc" class="slider-primary mb20"></div>
																		</div>
																		<div class="col-sm-3">
																			<input type="text" id="elve_bk_cc" name="sort"
																				class="form-control" placeholder="0" value="0" />
																		</div>

																		<!--222-->
																	</div>
																	<div class="form-group">
																		<label class="col-sm-3 control-label">边框弧度: <span
																			class="asterisk">*</span></label>
																		<div class="col-sm-5">
																			<div id="slider-bk-hd" class="slider-primary mb20"></div>
																		</div>
																		<div class="col-sm-3">
																			<input type="text" id="elve_bk_hd"
																				class="form-control" placeholder="0" value="0" />
																		</div>

																		<!--222-->
																	</div>

																</div>
															</div>
														</div>
														<div class="panel panel-default">
															<div class="panel-heading">
																<h4 class="panel-title">
																	<a data-toggle="collapse" class="collapsed"
																		data-parent="#accordion" href="#collapseTwo"> 阴影 </a>
																</h4>
															</div>
															<div id="collapseTwo" class="panel-collapse collapse"
																style="height: 0px;">
																<div class="panel-body">
																	<div class="form-group">
																		<label class="col-sm-3 control-label">阴影颜色: <span
																			class="asterisk">*</span></label>
																		<div class="col-sm-5">

																			<input type="text" id="elve_yy_color" name="sort"
																				class="form-control color" value="#FFFFFF"
																				readonly="readonly" />
																		</div>

																		<!--222-->
																	</div>
																	<div class="form-group">
																		<label class="col-sm-3 control-label">阴影大小: <span
																			class="asterisk">*</span></label>
																		<div class="col-sm-5">
																			<div id="slider-yy-dx" class="slider-primary mb20"></div>
																		</div>
																		<div class="col-sm-3">
																			<input type="text" id="elve_yy_dx" name="sort"
																				class="form-control" placeholder="0" value="0" />
																		</div>
																		<!--222-->
																	</div>
																	<div class="form-group">
																		<label class="col-sm-3 control-label">阴影方向: <span
																			class="asterisk">*</span></label>
																		<div class="col-sm-5">
																			<div id="slider-yy-fx" class="slider-primary mb20"></div>
																		</div>
																		<div class="col-sm-3">
																			<input type="text" id="elve_yy_fx" name="sort"
																				class="form-control" placeholder="0" value="0" />
																		</div>

																		<!--222-->
																	</div>
																	<div class="form-group">
																		<label class="col-sm-3 control-label">阴影模糊: <span
																			class="asterisk">*</span></label>
																		<div class="col-sm-5">
																			<div id="slider-yy-mh" class="slider-primary mb20"></div>
																		</div>
																		<div class="col-sm-3">
																			<input type="text" id="elve_yy_mh" name="sort"
																				class="form-control" placeholder="0" value="0" />
																		</div>

																		<!--222-->
																	</div>
																</div>
															</div>
														</div>
														<div class="panel panel-default">
															<div class="panel-heading">
																<h4 class="panel-title">
																	<a data-toggle="collapse" class="collapsed"
																		data-parent="#accordion" href="#collapseThree">
																		尺寸与位置 </a>
																</h4>
															</div>
															<div id="collapseThree" class="panel-collapse collapse"
																style="height: 0px;">
																<div class="panel-body">
																	<div class="form-group">
																		<label class="col-sm-3 control-label">宽度: <span
																			class="asterisk">*</span></label>
																		<div class="col-sm-5">

																			<input type="text" id="elve_wz_width" name="sort"
																				class="form-control" placeholder="请输入" />
																		</div>

																		<!--222-->
																	</div>
																	<div class="form-group">
																		<label class="col-sm-3 control-label">长度: <span
																			class="asterisk">*</span></label>
																		<div class="col-sm-5">

																			<input type="text" id="elve_wz_height" name="sort"
																				class="form-control" placeholder="请输入" />
																		</div>

																		<!--222-->
																	</div>
																	<div class="form-group">
																		<label class="col-sm-3 control-label">左边距: <span
																			class="asterisk">*</span></label>
																		<div class="col-sm-5">
																			<div id="slider-wz-left" class="slider-primary mb20"></div>
																		</div>
																		<div class="col-sm-3">
																			<input type="text" id="elve_wz_left" name="sort"
																				class="form-control" placeholder="0" value="0" />
																		</div>

																		<!--222-->
																	</div>
																	<div class="form-group">
																		<label class="col-sm-3 control-label">上边距: <span
																			class="asterisk">*</span></label>
																		<div class="col-sm-5">
																			<div id="slider-wz-top" class="slider-primary mb20"></div>
																		</div>
																		<div class="col-sm-3">
																			<input type="text" id="elve_wz_top" name="sort"
																				class="form-control" placeholder="0" value="0" />
																		</div>

																		<!--222-->
																	</div>
																	<div class="form-group">
																		<label class="col-sm-3 control-label">旋转: <span
																			class="asterisk">*</span></label>
																		<div class="col-sm-5">
																			<div id="slider-wz-xz" class="slider-primary mb20"></div>
																		</div>
																		<div class="col-sm-3">
																			<input type="text" id="elve_wz_xz" name="sort"
																				class="form-control" placeholder="0" value="0" />
																		</div>

																		<!--222-->
																	</div>
																</div>
															</div>
														</div>
													</div>

												</div>
												<!-- panel -->


											</div>
										</div>
										<div class="tab-pane" id="jltab2">

											<div class="panel-body" 
												style="height: 400px; overflow: scroll;">
												<div class="form-group">
												<div class="col-sm-6">
												  <div class="btn btn-lightblue btn-block"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;添加动画</div>
												</div>
												<div class="col-sm-6"> 
												 <div class="btn btn-white btn-block"><i class="fa fa-play"></i>&nbsp;&nbsp;&nbsp;&nbsp;预览动画</div>
												</div>
												</div>  
												<div class="panel-group" id="spiritlist">
													<div class="panel panel-default">
														<div class="panel-heading">
															<h4 class="panel-title">
																
																	<div style="background-color: #f7f7f7;color: #666;border-bottom: 1px solid #ddd;padding:15px 18px 40px 15px;display: block;">
																	
												                      <div class="col-sm-3">
												                          <div>动画1</div>
												                      </div>
												                      <div class="col-sm-6"> 
												                          <div>向右移入</div>
												                      </div>
												                      <div class="col-sm-3"> 
												                         <div class="col-sm-4"><i class="fa fa-play"></i></div>
												                         <div class="col-sm-4"><i class="fa fa-trash-o"></i></div> 
												                         <div class="col-sm-4"> 
																	    <i   data-toggle="collapse" data-parent="#spiritlist"
																	href="#sprit_One"  class="fa fa-reorder"></i></div>   
												                      </div>
												                    </div>   
															</h4>
														</div>
														<div id="sprit_One" class="panel-collapse collapse in"
															  >
															<div class="panel-body">
																<div class="form-group">
																	<label class="col-sm-3 control-label">动画样式: <span
																		class="asterisk">*</span></label>
																	<div class="col-sm-4">
																		<select class="form-control col-sm-3" id="anima_value"
																			name="anima_value" onchange="animation()">
																			<option value="">请选择</option>
																			<option value="fadeIn">淡入</option>
																			<option value="fadeInLeft">向右移入</option>
																			<option value="fadeInRight">向左移入</option>
																			<option value="fadeInUp">向上移入</option>
																			<option value="fadeInDown">向下移入</option>
																			<option value="flipInY">翻转进入</option>
																			<option value="bounceInLeft">向右弹入</option>
																			<option value="bounceInRight">向左弹入</option>
																			<option value="bounceInUp">向上弹入</option>
																			<option value="bounceInDown">向下弹入</option>
																			<option value="flipInX">翻开进入</option>
																			<option value="rollInRight">向右翻滚</option>
																			<option value="rollInLeft">向左翻滚</option>
																			<option value="rollInUp">向上翻滚</option>
																			<option value="rollInDown">向下翻滚</option>
																			<option value="bounceIn">中心弹入</option>
																			<option value="lightSpeedInRight">光速向右</option>
																			<option value="lightSpeedInLeft">光速向左</option>
																			<option value="lightSpeedInUp">光速向上</option>
																			<option value="lightSpeedInDown">光速向下</option>
																			<option value="zoomIn">中心放大</option>
																			<option value="twisterInDownRight">魔幻向右</option>
																			<option value="twisterInDownLeft">魔幻向左</option>
																			<option value="twisterInDownUp">魔幻向上</option>
																			<option value="twisterInDownDown">魔幻向下</option>
																			<option value="puffIn">缩小进入</option>
																			<option value="twisterInUpLeft">向左旋转</option>
																			<option value="twisterInUpRight">向右旋转</option>
																			<option value="twisterInUpUp">向上旋转</option>
																			<option value="twisterInUpDown">向下旋转</option>
																			<option value="rotateIn">旋转</option>

																		</select>
																	</div>
																	<div class="col-sm-4">
																		<div class="btn btn-white btn-block" id="anima_yl"><i class="fa fa-play"></i>&nbsp;预览</div>
																	</div>
																</div>

																<div class="form-group">
																	<label class="col-sm-3 control-label">时间: <span
																		class="asterisk">*</span></label>
																	<div class="col-sm-3">
																		<input type="text" id="anima_duration" name="sort"
																			class="form-control" onchange="animation()"
																			placeholder="0" value="0" />
																	</div>
																	<label class="col-sm-3 control-label">延时: <span
																		class="asterisk">*</span></label>
																	<div class="col-sm-3">
																		<input type="text" id="anima_timeDelay" name="sort"
																			class="form-control" onchange="animation()"
																			placeholder="0" value="0" />
																	</div>
																</div>
																<div class="form-group">
																	<label class="col-sm-3 control-label">次数: <span
																		class="asterisk">*</span></label>
																	<div class="col-sm-3">
																		<input type="text" id="anima_iterate" name="sort"
																			class="form-control" onchange="animation()"
																			placeholder="0" value="0" />
																	</div>
																	<label class="col-sm-3 control-label">是否循环: <span
																		class="asterisk">*</span></label>
																	<div class="col-sm-3">
																		<input type="checkbox" id="anima_infinite" name="sort"
																			class="form-control" onchange="animation()"
																			placeholder="0" value="0" />
																	</div>

																</div>
															</div>
														</div>
													</div>
													<div class="panel panel-default">
														<div class="panel-heading">
															<h4 class="panel-title">
																		<div style="background-color: #f7f7f7;color: #666;border-bottom: 1px solid #ddd;padding:15px 18px 40px 15px;display: block;">
																	
												                      <div class="col-sm-3">
												                          <div>动画1</div>
												                      </div>
												                      <div class="col-sm-6"> 
												                          <div>向右移入</div>
												                      </div>
												                      <div class="col-sm-3"> 
												                         <div class="col-sm-4"><i class="fa fa-play"></i></div>
												                         <div class="col-sm-4"><i class="fa fa-trash-o"></i></div> 
												                         <div class="col-sm-4"> 
																	    <i   data-toggle="collapse" data-parent="#spiritlist"
																	href="#sprit_Two"  class="fa fa-reorder"></i></div>   
												                      </div>
												                    </div>  
															</h4>
														</div>
														<div id="sprit_Two" class="panel-collapse collapse"
															style="height: 0px;">
															<div class="panel-body">
																<div class="form-group">
																	<label class="col-sm-3 control-label">动画样式: <span
																		class="asterisk">*</span></label>
																	<div class="col-sm-4">
																		<select class="form-control col-sm-3" id="anima_value"
																			name="anima_value" onchange="animation()">
																			<option value="">请选择</option>
																			<option value="fadeIn">淡入</option>
																			<option value="fadeInLeft">向右移入</option>
																			<option value="fadeInRight">向左移入</option>
																			<option value="fadeInUp">向上移入</option>
																			<option value="fadeInDown">向下移入</option>
																			<option value="flipInY">翻转进入</option>
																			<option value="bounceInLeft">向右弹入</option>
																			<option value="bounceInRight">向左弹入</option>
																			<option value="bounceInUp">向上弹入</option>
																			<option value="bounceInDown">向下弹入</option>
																			<option value="flipInX">翻开进入</option>
																			<option value="rollInRight">向右翻滚</option>
																			<option value="rollInLeft">向左翻滚</option>
																			<option value="rollInUp">向上翻滚</option>
																			<option value="rollInDown">向下翻滚</option>
																			<option value="bounceIn">中心弹入</option>
																			<option value="lightSpeedInRight">光速向右</option>
																			<option value="lightSpeedInLeft">光速向左</option>
																			<option value="lightSpeedInUp">光速向上</option>
																			<option value="lightSpeedInDown">光速向下</option>
																			<option value="zoomIn">中心放大</option>
																			<option value="twisterInDownRight">魔幻向右</option>
																			<option value="twisterInDownLeft">魔幻向左</option>
																			<option value="twisterInDownUp">魔幻向上</option>
																			<option value="twisterInDownDown">魔幻向下</option>
																			<option value="puffIn">缩小进入</option>
																			<option value="twisterInUpLeft">向左旋转</option>
																			<option value="twisterInUpRight">向右旋转</option>
																			<option value="twisterInUpUp">向上旋转</option>
																			<option value="twisterInUpDown">向下旋转</option>
																			<option value="rotateIn">旋转</option>

																		</select>
																	</div>
																	<div class="col-sm-4">
																		<div class="btn btn-darkblue btn-block" id="anima_yl">预览</div>
																	</div>
																</div>

																<div class="form-group">
																	<label class="col-sm-3 control-label">时间: <span
																		class="asterisk">*</span></label>
																	<div class="col-sm-3">
																		<input type="text" id="anima_duration" name="sort"
																			class="form-control" onchange="animation()"
																			placeholder="0" value="0" />
																	</div>
																	<label class="col-sm-3 control-label">延时: <span
																		class="asterisk">*</span></label>
																	<div class="col-sm-3">
																		<input type="text" id="anima_timeDelay" name="sort"
																			class="form-control" onchange="animation()"
																			placeholder="0" value="0" />
																	</div>
																</div>
																<div class="form-group">
																	<label class="col-sm-3 control-label">次数: <span
																		class="asterisk">*</span></label>
																	<div class="col-sm-3">
																		<input type="text" id="anima_iterate" name="sort"
																			class="form-control" onchange="animation()"
																			placeholder="0" value="0" />
																	</div>
																	<label class="col-sm-3 control-label">是否循环: <span
																		class="asterisk">*</span></label>
																	<div class="col-sm-3">
																		<input type="checkbox" id="anima_infinite" name="sort"
																			class="form-control" onchange="animation()"
																			placeholder="0" value="0" />
																	</div>

																</div>
															</div>
														</div>
													</div>
													<div class="panel panel-default">
														<div class="panel-heading">
															<h4 class="panel-title">
																		<div style="background-color: #f7f7f7;color: #666;border-bottom: 1px solid #ddd;padding:15px 18px 40px 15px;display: block;">
																	
												                      <div class="col-sm-3">
												                          <div>动画1</div>
												                      </div>
												                      <div class="col-sm-6"> 
												                          <div>向右移入</div>
												                      </div>
												                      <div class="col-sm-3"> 
												                         <div class="col-sm-4"><i class="fa fa-play"></i></div>
												                         <div class="col-sm-4"><i class="fa fa-trash-o"></i></div> 
												                         <div class="col-sm-4"> 
																	    <i   data-toggle="collapse" data-parent="#spiritlist"
																	href="#sprit_Three"  class="fa fa-reorder"></i></div>   
												                      </div>
												                    </div>  
															</h4>
														</div>
														<div id="sprit_Three" class="panel-collapse collapse"
															style="height: 0px;">
															<div class="panel-body">
																<div class="form-group">
																	<label class="col-sm-3 control-label">动画样式: <span
																		class="asterisk">*</span></label>
																	<div class="col-sm-4">
																		<select class="form-control col-sm-3" id="anima_value"
																			name="anima_value" onchange="animation()">
																			<option value="">请选择</option>
																			<option value="fadeIn">淡入</option>
																			<option value="fadeInLeft">向右移入</option>
																			<option value="fadeInRight">向左移入</option>
																			<option value="fadeInUp">向上移入</option>
																			<option value="fadeInDown">向下移入</option>
																			<option value="flipInY">翻转进入</option>
																			<option value="bounceInLeft">向右弹入</option>
																			<option value="bounceInRight">向左弹入</option>
																			<option value="bounceInUp">向上弹入</option>
																			<option value="bounceInDown">向下弹入</option>
																			<option value="flipInX">翻开进入</option>
																			<option value="rollInRight">向右翻滚</option>
																			<option value="rollInLeft">向左翻滚</option>
																			<option value="rollInUp">向上翻滚</option>
																			<option value="rollInDown">向下翻滚</option>
																			<option value="bounceIn">中心弹入</option>
																			<option value="lightSpeedInRight">光速向右</option>
																			<option value="lightSpeedInLeft">光速向左</option>
																			<option value="lightSpeedInUp">光速向上</option>
																			<option value="lightSpeedInDown">光速向下</option>
																			<option value="zoomIn">中心放大</option>
																			<option value="twisterInDownRight">魔幻向右</option>
																			<option value="twisterInDownLeft">魔幻向左</option>
																			<option value="twisterInDownUp">魔幻向上</option>
																			<option value="twisterInDownDown">魔幻向下</option>
																			<option value="puffIn">缩小进入</option>
																			<option value="twisterInUpLeft">向左旋转</option>
																			<option value="twisterInUpRight">向右旋转</option>
																			<option value="twisterInUpUp">向上旋转</option>
																			<option value="twisterInUpDown">向下旋转</option>
																			<option value="rotateIn">旋转</option>

																		</select>
																	</div>
																	<div class="col-sm-4">
																		<div class="btn btn-darkblue btn-block" id="anima_yl">预览</div>
																	</div>
																</div>

																<div class="form-group">
																	<label class="col-sm-3 control-label">时间: <span
																		class="asterisk">*</span></label>
																	<div class="col-sm-3">
																		<input type="text" id="anima_duration" name="sort"
																			class="form-control" onchange="animation()"
																			placeholder="0" value="0" />
																	</div>
																	<label class="col-sm-3 control-label">延时: <span
																		class="asterisk">*</span></label>
																	<div class="col-sm-3">
																		<input type="text" id="anima_timeDelay" name="sort"
																			class="form-control" onchange="animation()"
																			placeholder="0" value="0" />
																	</div>
																</div>
																<div class="form-group">
																	<label class="col-sm-3 control-label">次数: <span
																		class="asterisk">*</span></label>
																	<div class="col-sm-3">
																		<input type="text" id="anima_iterate" name="sort"
																			class="form-control" onchange="animation()"
																			placeholder="0" value="0" />
																	</div>
																	<label class="col-sm-3 control-label">是否循环: <span
																		class="asterisk">*</span></label>
																	<div class="col-sm-3">
																		<input type="checkbox" id="anima_infinite" name="sort"
																			class="form-control" onchange="animation()"
																			placeholder="0" value="0" />
																	</div>

																</div>

															</div>
														</div>
													</div>
												</div>





											</div>






										</div>
									</div>

									<!-- panel-body -->
								</div>
								<!-- panel -->
							</div>
							<div class="tab-pane top-pane" id="tab10">

								<div class="panel panel-default">

									<div class="modal-header">
										<h4 class="modal-title">
											<i class="fa"></i>音乐设置
										</h4>
									</div>
									<div class="panel-body">

										<div class="panel panel-default">
											<div class="form-group">
												<label class="col-sm-3 control-label">音乐链接: <span
													class="asterisk">*</span></label>
												<div class="col-sm-5">

													<input type="text" id="music_url" class="form-control"
														placeholder="请输入" value="${entity.music_url}" />
												</div>

											</div>
											<div class="form-group">
												<label class="col-sm-3 control-label">音乐图标: <span
													class="asterisk">*</span></label>
												<div class="col-sm-5">

													<input type="text" id="music_picurl" class="form-control"
														placeholder="尺寸375*667" value="${entity.music_picurl}" />
												</div>
												<div class="col-sm-2"
													style="height: 30px; line-height: 30px; margin-top: 3px">
													<div class="button  btn-warning-alt "
														style="text-align: center;">上传</div>
													<div
														style="position: absolute; width: 60px; height: 20px; top: 0px; opacity: 0">
														<input type="file" class="musicpicurl"
															style="width: 60px; height: 20px" />
													</div>
												</div>

												<div class="col-sm-2"
													style="height: 30px; line-height: 30px; margin-top: 3px">
													<div class="button  btn-warning-alt "
														style="text-align: center;"
														onclick="init_img('music_picurl','insScene','')">图库</div>
												</div>

											</div>
											<div class="form-group">
												<label class="col-sm-3 control-label">图标颜色: <span
													class="asterisk">*</span></label>
												<div class="col-sm-5">

													<input type="text" id="music_color"
														class="form-control color" readonly="readonly"
														onchange="bg_onchange(this)" placeholder="请输入"
														value="${entity.music_color}" />
												</div>

											</div>
											<div class="form-group">
												<label class="col-sm-3 control-label">透明度: <span
													class="asterisk">*</span></label>
												<div class="col-sm-5">
													<div id="slider-music-transparent"
														class="slider-primary mb20"></div>
												</div>
												<div class="col-sm-3">
													<input type="text" id="music_transparent"
														class="form-control" placeholder="1"
														value="${entity.music_transparent}" />
												</div>

												<!--222-->
											</div>
											<span style="margin-bottom: 0px"
												class="btn btn-darkblue btn-block" id="btnScene"
												onclick="save_music();"><li class="fa fa-plus"></li>&nbsp;&nbsp;提交</span>

										</div>
										<!-- panel -->


									</div>
									<!-- panel-body -->
								</div>
								<!-- panel -->
							</div>
							<div class="tab-pane top-pane" id="tab1">

								<div class="panel panel-default">

									<div class="modal-header">
										<h4 class="modal-title">
											<i class="fa"></i>图层设置
										</h4>
									</div>
									<div class="panel-body">

										<div class="panel panel-default">
											<div class="form-group">
												<label class="col-sm-3 control-label">图层标题: <span
													class="asterisk">*</span></label>
												<div class="col-sm-5">

													<input type="text" id="layer_title" class="form-control"
														placeholder="请输入" />
												</div>

											</div>
											<div class="form-group">
												<label class="col-sm-3 control-label">背景图片: <span
													class="asterisk">*</span></label>
												<div class="col-sm-5">

													<input type="text" id="layer_picurl"
														class="layer_picurl form-control" placeholder="尺寸375*667"
														onchange="picurl_change()" />
												</div>
												<div class="col-sm-2"
													style="height: 30px; line-height: 30px; margin-top: 3px">
													<div class="button  btn-warning-alt "
														style="text-align: center;">上传</div>
													<div
														style="position: absolute; width: 60px; height: 20px; top: 0px; opacity: 0">
														<input type="file" class="layerpicurl"
															style="width: 60px; height: 20px" />
													</div>
												</div>

												<div class="col-sm-2"
													style="height: 30px; line-height: 30px; margin-top: 3px">
													<div class="button  btn-warning-alt "
														style="text-align: center;"
														onclick="init_img('layer_picurl','insScene','picurl_change')">图库</div>
												</div>


											</div>
											<div class="form-group">
												<label class="col-sm-3 control-label">背景颜色: <span
													class="asterisk">*</span></label>
												<div class="col-sm-5">

													<input type="text" id="layer_bgcolor"
														class="form-control color" readonly="readonly"
														onchange="bg_onchange(this)" placeholder="请输入" />
												</div>

											</div>
											<div class="form-group">
												<label class="col-sm-3 control-label">图层序号: <span
													class="asterisk">*</span></label>
												<div class="col-sm-5">
													<input type="text" id="layer_sort" class="form-control"
														placeholder="请输入" />
												</div>

											</div>
											<div class="form-group">
												<label class="col-sm-3 control-label">透明度: <span
													class="asterisk">*</span></label>
												<div class="col-sm-5">
													<div id="slider-layer-transparent"
														class="slider-primary mb20"></div>
												</div>
												<div class="col-sm-3">
													<input type="text" id="layer_transparent"
														class="form-control" placeholder="1" value="1" />
												</div>

												<!--222-->
											</div>

										</div>
										<!-- panel -->


									</div>
									<!-- panel-body -->
								</div>
								<!-- panel -->
							</div>

							<div class="tab-pane top-pane" id="tab11">

								<div class="panel panel-default">

									<div class="modal-header">
										<h4 class="modal-title">
											<i class="fa"></i>分享设置
										</h4>
									</div>
									<div class="panel-body">

										<div class="panel panel-default">
											<div class="form-group">
												<label class="col-sm-3 control-label">分享标题: <span
													class="asterisk">*</span></label>
												<div class="col-sm-5">

													<input type="text" id="share_title" value="${entity.title}"
														class="form-control" placeholder="请输入" />
												</div>

											</div>
											<div class="form-group">
												<label class="col-sm-3 control-label">分享图片: <span
													class="asterisk">*</span></label>
												<div class="col-sm-5">

													<input type="text" id="share_picurl"
														value="${entity.picurl}" class="share_picurl form-control" />
												</div>
												<div class="col-sm-2"
													style="height: 30px; line-height: 30px; margin-top: 3px">
													<div class="button  btn-warning-alt "
														style="text-align: center;">上传</div>
													<div
														style="position: absolute; width: 60px; height: 20px; top: 0px; opacity: 0">
														<input type="file" class="sharepicurl"
															style="width: 60px; height: 20px" />
													</div>
												</div>

												<div class="col-sm-2"
													style="height: 30px; line-height: 30px; margin-top: 3px">
													<div class="button  btn-warning-alt "
														style="text-align: center;"
														onclick="init_img('share_picurl','insScene')">图库</div>
												</div>


											</div>
											<div class="form-group">
												<label class="col-sm-3 control-label">分享说明: <span
													class="asterisk">*</span></label>
												<div class="col-sm-5">

													<input type="text" id="share_summary"
														value="${entity.summary}" class="form-control"
														placeholder="请输入" />
												</div>

											</div>

											<span style="margin-bottom: 0px"
												class="btn btn-darkblue btn-block" id="btnScene"
												onclick="save_share();"><li class="fa fa-plus"></li>&nbsp;&nbsp;提交</span>

										</div>
										<!-- panel -->


									</div>
									<!-- panel-body -->
								</div>
								<!-- panel -->
							</div>
							<div class="tab-pane top-pane" id="tab2">
								<div class="table-responsive"
									style="height: 450px; overflow: scroll;">

									<table class="table table-striped table-success mb30">
										<thead>
											<tr>
												<th>序号</th>
												<th>名称</th>
												<th>预览</th>
												<th>操作</th>

											</tr>
										</thead>
										<tbody id="elves" style="height: 300px; overflow: scroll;">

										</tbody>
									</table>

								</div>
								<span style="margin-left:" class="btn btn-darkblue btn-block"
									id="btnScene" onclick="create_elve();"><li
									class="fa fa-plus"></li>&nbsp;&nbsp;添加精灵</span>
								<!-- panel -->
							</div>
							<div class="tab-pane top-pane" id="tab3">
								<div class="table-responsive"
									style="height: 450px; overflow: scroll;">
									<table class="table table-striped table-success mb30">
										<thead>
											<tr>
												<th>序号</th>
												<th>名称</th>
												<th>预览</th>
												<th>操作</th>

											</tr>
										</thead>
										<tbody id="layers" style="height: 300px; overflow: scroll;">

										</tbody>
									</table>

								</div>
								<span style="margin-bottom: 0px"
									class="btn btn-darkblue btn-block" id="btnScene"
									onclick="create_layer();"><li class="fa fa-plus"></li>&nbsp;&nbsp;添加图层</span>
							</div>

							<div class="tab-pane top-pane" id="tab8">

								<ul class="nav nav-tabs nav-justified" id="slidetabs">
									<li id="slideli_0" class="active" mbdata="0"><a
										href="#slidetab0" data-toggle="tab"><strong>幻灯片管理</strong></a></li>
									<li id="slideli_1" mbdata="1"><a href="#slidetab1"
										data-toggle="tab"><strong>幻灯片设置</strong></a></li>
								</ul>
								<div class="tab-content" id="slidetabs-body">
									<div class="tab-pane active" id="slidetab0">

										<div class="table-responsive"
											style="height: 380px; overflow: scroll;">
											<table class="table table-striped table-success mb30">
												<thead>
													<tr>
														<th>序号</th>
														<th>名称</th>
														<th>图片</th>
														<th>操作</th>

													</tr>
												</thead>
												<tbody id="slides" style="height: 300px; overflow: scroll;">

												</tbody>
											</table>

										</div>
										<span style="margin-bottom: 0px"
											class="btn btn-darkblue btn-block" id="btnScene"
											onclick="add_slide();"><li class="fa fa-plus"></li>&nbsp;&nbsp;添加幻灯片</span>

									</div>
									<div class="tab-pane" id="slidetab1">
										<div class="panel-body">

											<div class="panel panel-default">
												<div class="form-group">
													<label class="col-sm-3 control-label">上边距: <span
														class="asterisk">*</span></label>
													<div class="col-sm-5">

														<input type="text" id="slide_top"
															value="${slidestyle.margintop}" class="form-control"
															placeholder="请输入" />
													</div>

												</div>
												<div class="form-group">
													<label class="col-sm-3 control-label">左边距: <span
														class="asterisk">*</span></label>
													<div class="col-sm-5">

														<input type="text" id="slide_left" class="form-control"
															placeholder="请输入" value="${slidestyle.marginleft}" />
													</div>

												</div>
												<div class="form-group" style="display: none;">
													<label class="col-sm-3 control-label">宽度: <span
														class="asterisk">*</span></label>
													<div class="col-sm-5">

														<input type="text" id="slide_width"
															value="${slidestyle.width}" class="form-control"
															placeholder="请输入" />
													</div>

												</div>
												<div class="form-group">
													<label class="col-sm-3 control-label">高度: <span
														class="asterisk">*</span></label>
													<div class="col-sm-5">

														<input type="text" id="slide_height"
															value="${slidestyle.height}" class="form-control"
															placeholder="请输入" />
													</div>

												</div>

											</div>
											<!-- panel -->


										</div>

									</div>


								</div>

							</div>
							<div class="tab-pane top-pane" id="tab9">
								<ul class="nav nav-tabs nav-justified" id="rolltabs">
									<li id="rollli_0" class="active" mbdata="0"><a
										href="#rolltab0" data-toggle="tab"><strong>滚动字幕管理</strong></a></li>
									<li id="rollli_1" mbdata="1"><a href="#rolltab1"
										data-toggle="tab"><strong>滚动字幕设置</strong></a></li>
								</ul>
								<div class="tab-content" id="rolltabs-body">
									<div class="tab-pane active" id="rolltab0">

										<div class="table-responsive"
											style="height: 380px; overflow: scroll;">
											<table class="table table-striped table-success mb30">
												<thead>
													<tr>
														<th>序号</th>
														<th>名称</th>
														<th>操作</th>

													</tr>
												</thead>
												<tbody id="rolls" style="height: 300px; overflow: scroll;">

												</tbody>
											</table>

										</div>
										<span style="margin-bottom: 0px"
											class="btn btn-darkblue btn-block" id="btnScene"
											onclick="add_roll();"><li class="fa fa-plus"></li>&nbsp;&nbsp;添加滚动字</span>
									</div>
									<div class="tab-pane" id="rolltab1">

										<div class="panel-body">

											<div class="panel panel-default">
												<div class="form-group">
													<label class="col-sm-3 control-label">上边距: <span
														class="asterisk">*</span></label>
													<div class="col-sm-5">

														<input type="text" id="roll_top" class="form-control"
															placeholder="请输入" value="${rollstyle.margintop}" />
													</div>

												</div>
												<div class="form-group">
													<label class="col-sm-3 control-label">左边距: <span
														class="asterisk">*</span></label>
													<div class="col-sm-5">

														<input type="text" id="roll_left"
															value="${rollstyle.marginleft}" class="form-control"
															placeholder="请输入" />
													</div>

												</div>
												<div class="form-group">
													<label class="col-sm-3 control-label">字体颜色: <span
														class="asterisk">*</span></label>
													<div class="col-sm-5">

														<input type="text" id="roll_color"
															class="form-control color" placeholder="请输入"
															readonly="readonly" value="${rollstyle.color}" />
													</div>

												</div>
												<div class="form-group">
													<label class="col-sm-3 control-label">背景色: <span
														class="asterisk">*</span></label>
													<div class="col-sm-5">

														<input type="text" id="roll_bj_color"
															value="${rollstyle.backgroundcolor}"
															class="form-control color" placeholder="请输入"
															readonly="readonly" />
													</div>

												</div>
												<div class="form-group" style="display: none;">
													<label class="col-sm-3 control-label">长度: <span
														class="asterisk">*</span></label>
													<div class="col-sm-5">

														<input type="text" id="roll_width"
															value="${rollstyle.width}" class="form-control"
															placeholder="请输入" />
													</div>

												</div>
												<div class="form-group" style="display: none;">
													<label class="col-sm-3 control-label">宽度: <span
														class="asterisk">*</span></label>
													<div class="col-sm-5">

														<input type="text" id="roll_height"
															value="${rollstyle.height}" class="form-control"
															placeholder="请输入" />
													</div>

												</div>

											</div>
											<!-- panel -->


										</div>
									</div>
								</div>


							</div>
							<div class="tab-pane top-pane" id="tab12">
								<ul class="nav nav-tabs nav-justified" id="rolltabs">
									<li id="curtaini_0" class="active" mbdata="0"><a
										href="#rolltab0" data-toggle="tab"><strong>幕布管理</strong></a></li>
									<li id="curtaini_1" mbdata="1"><a href="#rolltab1"
										data-toggle="tab"><strong>幕布设置</strong></a></li>
								</ul>
								<div class="tab-content" id="rolltabs-body">
									<div class="tab-pane active" id="curtaintab0">

										<div class="table-responsive"
											style="height: 380px; overflow: scroll;">
											<table class="table table-striped table-success mb30">
												<thead>
													<tr>
														<th>序号</th>
														<th>名称</th>
														<th>操作</th>

													</tr>
												</thead>
												<tbody id="curtains"
													style="height: 300px; overflow: scroll;">

												</tbody>
											</table>

										</div>
										<span style="margin-bottom: 0px"
											class="btn btn-darkblue btn-block" id="btnScene"
											onclick="add_curtain();"><li class="fa fa-plus"></li>&nbsp;&nbsp;添加幕布</span>
									</div>
									<div class="tab-pane" id="curtaintab1">

										<div class="panel-body">

											<div class="panel panel-default"></div>
											<!-- panel -->
										</div>
									</div>
								</div>


							</div>
							<div class="tab-pane top-pane" id="tab6">
								<div class="table-responsive"
									style="height: 450px; overflow: scroll;">
									<table class="table table-striped table-success mb30">
										<thead>
											<tr>
												<th>序号</th>
												<th>名称</th>
												<th>操作</th>

											</tr>
										</thead>
										<tbody id="txts" style="height: 300px; overflow: scroll;">

										</tbody>
									</table>

								</div>
								<span style="margin-bottom: 0px"
									class="btn btn-darkblue btn-block" id="btnScene"
									onclick="createText();"><li class="fa fa-plus"></li>&nbsp;&nbsp;添加文本</span>
							</div>
							<!-- panel -->
						</div>
				</div>
			</div>

		</div>
	</section>





	<%--弹出层新--%>
	<div class="fullscreen bg-hei-8 display-none" id="inszc_roll"
		style="height: 100%;">
		<div style="padding-top: 2%">
			<div class="pl-10 pr-10 maring-a cmp500"
				style="width: 100%; max-width: 500px; min-width: 320px; margin: 0px auto; right: 0px;">
				<div class=" bg-bai border-radius3 overflow-hidden">
					<div class="overflow-hidden line-height40 bg-bai line-bottom">
						<div class="hang50 pull-left zi-hui-tq">
							<i class="weight500 size14 pl-10 line-height50">内容管理</i>
						</div>
						<a href="javascript:ps_hide('inszc_roll')">
							<div class="hang40 pull-right zi-hui-tq">
								<i class="weight500 size14 pl-10 pr-10 fa-1dx fa fa-remove"
									style="line-height: 50px;"></i>
							</div>
						</a>
					</div>
					<input type="hidden" id="roll_id" />
					<div class="pt-15 pl-15 pr-15 overflow-auto" style="height: 490px;">

						<div class="col-sm-6">
							<div class="mb-20">
								<label class="control-label">标题：</label> <input type="text"
									id="roll_title" name="title" class="form-control"
									placeholder="请输入" />
							</div>
						</div>
						<div class="col-sm-6">
							<div class="mb-20">
								<label class="control-label">链接：</label> <input type="text"
									id="roll_url" name="url" class="form-control" placeholder="请输入" />
							</div>
						</div>
						<div class="col-sm-12">
							<div class="mb-20">
								<label class="control-label">序号：</label> <input type="text"
									id="roll_sort" name="sort" class="form-control"
									placeholder="请输入" />
							</div>
						</div>


						<!--下部编辑器-->
						<div class="pt-10 clear">

							<div class="div-group-10 border-radius5 bg-bai">
								<label class="control-label">内容：</label>
								<textarea name="roll_context" id="roll_context" class="ckeditor"
									rows="10" cols="38"> </textarea>
								<script id="editor" type="text/plain"
									style="width: 100%; height: 300px;"> </script>
							</div>

						</div>

					</div>
					<div onclick="save_roll()" class="div-group-10 line-top"
						style="padding-left: 40px; padding-right: 40px;">
						<button
							class="btn btn-primary width-10 maring-a clear weight500 hang40">提
							交</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%--弹出层新--%>
	<div class="fullscreen bg-hei-8 display-none" id="inszc_slide"
		style="height: 100%;">
		<div style="padding-top: 2%">
			<div class="pl-10 pr-10 maring-a"
				style="width: 100%; max-width: 500px; min-width: 320px; margin: 0px auto; right: 0px;">
				<div class=" bg-bai border-radius3 overflow-hidden">
					<div class="overflow-hidden line-height40 bg-bai line-bottom">
						<div class="hang50 pull-left zi-hui-tq">
							<i class="weight500 size14 pl-10 line-height50">幻灯片添加</i>
						</div>
						<a href="javascript:ps_hide('inszc_slide')">
							<div class="hang40 pull-right zi-hui-tq">
								<i class="weight500 size14 pl-10 pr-10 fa-1dx fa fa-remove"
									style="line-height: 50px;"></i>
							</div>
						</a>
					</div>
					<input type="hidden" id="slide_id" name="_id" />
					<%--row--%>
					<div class="pt-15 pl-15 pr-15 overflow-auto" style="height: 490px;">

						<div class="col-sm-6">
							<div class="mb-20">
								<label class="control-label">名称：</label> <input type="text"
									id="slide_title" name="title" class="form-control"
									placeholder="请输入" />
							</div>
						</div>
						<div class="col-sm-6">
							<div class="mb-20">
								<label class="control-label">链接：</label> <input type="text"
									id="slide_url" name="url" class="form-control"
									placeholder="请输入" />
							</div>
						</div>
						<div class="col-sm-3">
							<div class="mb-20">
								<label class="control-label">排序：</label> <input type="text"
									id="slide_sort" name="sort" class="form-control"
									placeholder="请输入" />
							</div>
						</div>
						<div class="col-sm-9">
							<label class="control-label">图片(375*200)：</label>
							<div>
								<div class="col-sm-5">
									<input class="form-control" id="slide_picurl" />
								</div>
								<div class="col-sm-2"
									style="height: 30px; line-height: 30px; margin-top: 3px">
									<div class="button  btn-warning-alt "
										style="text-align: center;">上传</div>
									<div
										style="position: absolute; width: 60px; height: 20px; top: 0px; opacity: 0">
										<input type="file" class="slide_picurl"
											style="width: 60px; height: 20px" />
									</div>
								</div>

								<div class="col-sm-2"
									style="height: 30px; line-height: 30px; margin-top: 3px">
									<div class="button  btn-warning-alt "
										style="text-align: center;"
										onclick="init_img('slide_picurl','insScene')">图库</div>
								</div>
							</div>
						</div>


					</div>
					<div onclick="save_slide()" class="div-group-10 line-top"
						style="padding-left: 40px; padding-right: 40px;">
						<button
							class="btn btn-primary width-10 maring-a clear weight500 hang40">提
							交</button>
					</div>

				</div>
			</div>

		</div>
	</div>

	<%--弹出层新--%>
	<div class="fullscreen bg-hei-8 display-none" id="inszc_curtain"
		style="height: 100%;">
		<div style="padding-top: 2%">
			<div class="pl-10 pr-10 maring-a"
				style="width: 100%; max-width: 500px; min-width: 320px; margin: 0px auto; right: 0px;">
				<div class=" bg-bai border-radius3 overflow-hidden">
					<div class="overflow-hidden line-height40 bg-bai line-bottom">
						<div class="hang50 pull-left zi-hui-tq">
							<i class="weight500 size14 pl-10 line-height50">幕布添加</i>
						</div>
						<a href="javascript:ps_hide('inszc_curtain')">
							<div class="hang40 pull-right zi-hui-tq">
								<i class="weight500 size14 pl-10 pr-10 fa-1dx fa fa-remove"
									style="line-height: 50px;"></i>
							</div>
						</a>
					</div>
					<input type="hidden" id="curtain_id" name="_id" />
					<%--row--%>
					<div class="pt-15 pl-15 pr-15 overflow-auto" style="height: 490px;">

						<div class="col-sm-6">
							<div class="mb-20">
								<label class="control-label">名称：</label> <input type="text"
									id="curtain_title" name="title" class="form-control"
									placeholder="请输入" />
							</div>
						</div>
						<div class="col-sm-6">
							<div class="mb-20">
								<label class="control-label">链接：</label> <input type="text"
									id="curtain_url" name="url" class="form-control"
									placeholder="请输入" />
							</div>
						</div>
						<div class="col-sm-3">
							<div class="mb-20">
								<label class="control-label">排序：</label> <input type="text"
									id="curtain_sort" name="sort" class="form-control"
									placeholder="请输入" />
							</div>
						</div>
						<div class="col-sm-9">
							<label class="control-label">图片(375*200)：</label>
							<div>
								<div class="col-sm-5">
									<input class="form-control" id="slide_picurl" />
								</div>
								<div class="col-sm-2"
									style="height: 30px; line-height: 30px; margin-top: 3px">
									<div class="button  btn-warning-alt "
										style="text-align: center;">上传</div>
									<div
										style="position: absolute; width: 60px; height: 20px; top: 0px; opacity: 0">
										<input type="file" class="curtain_picurl"
											style="width: 60px; height: 20px" />
									</div>
								</div>

								<div class="col-sm-2"
									style="height: 30px; line-height: 30px; margin-top: 3px">
									<div class="button  btn-warning-alt "
										style="text-align: center;"
										onclick="init_img('curtain_picurl','insScene')">图库</div>
								</div>
							</div>
						</div>


					</div>
					<div onclick="save_curtain()" class="div-group-10 line-top"
						style="padding-left: 40px; padding-right: 40px;">
						<button
							class="btn btn-primary width-10 maring-a clear weight500 hang40">提
							交</button>
					</div>

				</div>
			</div>

		</div>
	</div>
	<script type="text/javascript">
		function elveChange() {
			console.log("#elve_" + elveid);
			$("#elve_" + elveid).attr("url_value", $('#elve_url').val());
			$("#elve_" + elveid).attr("title", $('#elve_title').val());
			$("#elve_" + elveid).attr("sort", $('#elve_sort').val());
		}
		function updateStyle(v) {
			var left = $(v).css("left");
			var top = $(v).css("top");
			var width = $(v).css("width");
			var height = $(v).css("height");
			$("#wz-top").val(top.replace("px", ""));
			$("#wz-left").val(left.replace("px", ""));
			$("#wz-width").val(width.replace("px", ""));
			$("#wz-height").val(height.replace("px", ""));

		}
		//阴影：v为dom对象，t、g为左边距和上边距.k为阴影大小，l为模糊度，u为背景颜色
		function upd_box_shadow(v, t, g, k, l, u) {
			if (t >= 0 && t <= 90) {

				var gl = g / 90;
				g = -k * gl;
				t = -k * gl;

			}
			if (t >= 90 && t <= 180) {
				var gl = g / 180;
				g = k * gl;
				t = -k * gl;

			}
			if (t >= 180 && t <= 270) {
				var gl = g / 270;
				g = -k * gl;
				t = k * gl;

			}
			if (t >= 270 && t <= 360) {

				var gl = g / 360;
				g = k * gl;
				t = k * gl;

			}
			var lm = "";
			if (t != "") {
				lm = lm + t + "px ";
			}
			if (g != "") {
				lm = lm + g + "px ";
			}
			if (l != "") {
				lm = lm + l + "px ";
			}
			if (k != "") {
				lm = lm + k + "px ";
			}

			if (u != "") {
				lm = lm + u;
			} else {
				lm = lm + "black";
			}
			$(v).css("-moz-box-shadow", lm);
			$(v).css("box-shadow", lm);

		}
		function border_create(v, t, g, c) {
			var obj = t + "px" + " " + g + " " + c;
			$(v).css("border", obj);
		}
		function getproportion(v, g) {
			var w = v.replace("px", "");
			var h = g.replace("px", "");
			return parseFloat(w) / parseFloat(h);
		}
		function createElves(v) {
			var div = $('<div></div>');
			div.attr('id', v);
			div.addClass('childdiv');
			$(".iphone-screen").append(div);
			div.draggable({
				containment : ".iphone-screen",
				scroll : false,
				stack : "#" + v,
				drag : function(event, ui) {
					//updateStyle("#" +v);
					updateStyle(ui.helper);
				},
			});
			div.resizable({
				//aspectRatio: getproportion(div.css("width"),div.css("height"))
				resize : function(event, ui) {
					updateStyle(ui.element);
				}
			});
		}

		$(".color").colorpicker(
				{
					fillcolor : true,
					success : function(v) {
						if ($(v).attr("id") == "elve_bgcolor") {
							$("#elve_" + elveid).css("background-color",
									$(v).val());
						}
						if ($(v).attr("id") == "layer_bgcolor") {
							$("#layer_" + layerid).css("background-color",
									$(v).val());
						}
						if ($(v).attr("id") == "elve_title_color") {
							$("#elve_" + elveid)
									.attr("title_color", $(v).val());
						}
						if ($(v).attr("id") == "elve_bk_color") {
							border_create("#elve_" + elveid, $("#elve_bk_cc")
									.val(), $("#elve_bk_ys").val(), $(
									"#elve_bk_color").val());
						}
					},
					reset : function(v) {
						console.log($(v).attr("id"));
						if ($(v).attr("id") == "elve_bgcolor") {
							$(v).val('');
							$("#elve_" + elveid).css("background-color",
									$(v).val());
							$(v).removeClass("childdiv");
						}
					}
				});
		function bk_ys_change() {
			border_create("#elve_" + elveid, $("#elve_bk_cc").val(), $(
					"#elve_bk_ys").val(), $("#elve_bk_color").val());
		}
		function picurl_change() {
			console.log("#elve_" + elveid);
			$("#layer_" + layerid).css("background-image",
					'url(${filehttp}' + $("#layer_picurl").val() + ")");
			$("#layer_" + layerid).attr("backgroundimage",
					$("#layer_picurl").val());
		}
		function elve_picurl_change() {
			$("#elve_" + elveid).css("background-image",
					"url(${filehttp}" + $("#elve_picurl").val() + ")");
			var width = 80;
			var heigth = (80 * $('#elve_picurl').attr('imgH'))
					/ $('#elve_picurl').attr('imgW');
			$("#elve_" + elveid).css("width", width);
			$("#elve_" + elveid).css("background-color",
					$("#elve_bgcolor").val());
			$("#elve_" + elveid).css("height", heigth);
			$("#elve_" + elveid).attr("backgroundimage",
					$("#elve_picurl").val());
			$("#elve_" + elveid).removeClass('childdiv');

		}
		jQuery(document).ready(
				function() {

					"use strict";

					// Basic Slider滑动监听
					jQuery('#slider-bk-cc').slider(
							{
								range : "min",
								max : 20,
								value : 0,
								slide : function(event, ui) {
									$("#elve_bk_cc").val(ui.value);
									border_create("#elve_" + elveid, $(
											"#elve_bk_cc").val(), $(
											"#elve_bk_ys").val(), $(
											"#elve_bk_color").val());

								}
							});
					jQuery('#slider-bk-hd').slider(
							{
								range : "min",
								max : 50,
								value : 0,
								slide : function(event, ui) {
									$("#elve_bk_hd").val(ui.value);
									$("#elve_" + elveid).css("border-radius",
											ui.value);

								}
							});

					jQuery('#slider-yy-dx').slider(
							{
								range : "min",
								max : 20,
								value : 0,
								slide : function(event, ui) {
									$("#elve_yy_dx").val(ui.value);
									upd_box_shadow("#elve_" + elveid, $(
											"#elve_yy_fx").val(), $(
											"#elve_yy_fx").val(), $(
											"#elve_yy_dx").val(), $(
											"#elve_yy_mh").val(), $(
											"#elve_yy_color").val());

								}
							});
					jQuery('#slider-yy-mh').slider(
							{
								range : "min",
								max : 20,
								value : 0,
								slide : function(event, ui) {
									$("#elve_yy_mh").val(ui.value);
									upd_box_shadow("#elve_" + elveid, $(
											"#elve_yy_fx").val(), $(
											"#elve_yy_fx").val(), $(
											"#elve_yy_dx").val(), $(
											"#elve_yy_mh").val(), $(
											"#elve_yy_color").val());

								}
							});
					jQuery('#slider-yy-fx').slider(
							{
								range : "min",
								max : 360,
								value : 0,
								slide : function(event, ui) {
									$("#elve_yy_fx").val(ui.value);
									upd_box_shadow("#elve_" + elveid, $(
											"#elve_yy_fx").val(), $(
											"#elve_yy_fx").val(), $(
											"#elve_yy_dx").val(), $(
											"#elve_yy_mh").val(), $(
											"#elve_yy_color").val());

								}
							});
					jQuery('#slider-wz-xz').slider({
						range : "min",
						max : 360,
						value : 0,
						slide : function(event, ui) {
							$("#elve_wz_xz").val(ui.value);
							rotate("#elve_" + elveid, ui.value);

						}
					});
					jQuery('#slider-wz-top').slider({
						range : "min",
						max : 800,
						value : 0,
						slide : function(event, ui) {
							$("#elve_wz_top").val(ui.value);

						}
					});
					jQuery('#slider-wz-left').slider({
						range : "min",
						max : 300,
						value : 0,
						slide : function(event, ui) {
							$("#elve_wz_left").val(ui.value);

						}
					});
					jQuery('#slider-dh-time').slider({
						range : "min",
						max : 200,
						value : 0,
						slide : function(event, ui) {
							$("#anima_duration").val(ui.value);

						}
					});

					jQuery('#slider-elve-transparent').slider(
							{
								range : "min",
								max : 10,
								value : 10,
								slide : function(event, ui) {
									$("#elve_transparent").val(
											parseFloat(ui.value) / 10);
									$("#elve_" + elveid).css("opacity",
											parseFloat(ui.value) / 10);

								}
							});
					jQuery('#slider-layer-transparent').slider(
							{
								range : "min",
								max : 10,
								value : 10,
								slide : function(event, ui) {
									$("#layer_transparent").val(
											parseFloat(ui.value) / 10);
									$("#layer_" + elveid).css("opacity",
											parseFloat(ui.value) / 10);

								}
							});
					jQuery('#slider-music-transparent').slider(
							{
								range : "min",
								max : 10,
								value : 10,
								slide : function(event, ui) {
									$("#music_transparent").val(
											parseFloat(ui.value) / 10);

								}
							});

				});
		//旋转
		function rotate(v, t) {
			$(v).attr("rotate", t)
			$(v).css("transform", "rotate(" + t + "deg)");
			$(v).css("-ms-transform", "rotate(" + t + "deg)");
			$(v).css("-moz-transform", "rotate(" + t + "deg)");
			$(v).css("-webkit-transform", "rotate(" + t + "deg)");
			$(v).css("-o-transform", "rotate(" + t + "deg)");
		}

		//精灵点击
		function elve_click(v) {
			//清空
			//$(v).parent().find("td").removeClass('bg_color');
			//$(v).find("td").addClass('bg_color');
			init_elve($(v).attr("elveid"));
			show_evle();

		}
		function elves_click(v) {
			init_elve($(v).attr("id").replace("elve_", ""));
		}
		//层点击
		function layer_click(v) {
			show_scence();
			saveLayer();
			//清空
			$(v).parent().find("td").removeClass('bg_color');
			$(v).find("td").addClass('bg_color');
			init_layer($(v).attr('layerid'));

		}
		//创建图层
		function create_layer() {
			var submitData = {
				sid : '${msid}'
			};
			$.post('${ctx}/suc/mobilescene!create_layer.action', submitData,
					function(json) {
						if (json.state == 0) {
							alert("创建成功");
							get_layer();
						} else {
							alert("创建失败");
						}
					}, "json")
		}
		//创建精灵
		function create_elve() {
			var submitData = {
				cid : layerid
			};
			$.post('${ctx}/suc/mobilescene!create_elve.action', submitData,
					function(json) {
						if (json.state == 0) {
							alert("创建精灵成功");
							get_elve();
							init_layer(layerid);
						} else {
							alert("创建失败");
						}
					}, "json")
		}
		function get_layer() {
			var submitData = {
				sid : '${msid}'
			};
			$
					.post(
							'${ctx}/suc/mobilescene!get_layer.action',
							submitData,
							function(json) {
								if (json.state == 0) {
									var html = "";
									var list = json.list;
									if (json.state == 0) {
										for (var v = 0; v < list.length; v++) {

											html += '<tr><td>'
													+ list[v].sort
													+ '</td>'
													+ '<td  onclick="layer_click(this)" layerid="'
													+ list[v]._id
													+ '">'
													+ list[v].title
													+ '</td>'
													+ '<td onclick="layer_click(this)" layerid="'
													+ list[v]._id
													+ '"><img src="${filehttp}/'
													+ list[v].picurl+'"'
													+ 'height="35px"  /></td>'
													+ '<td class="table-action"><div class="btn-group1 position-r"><a data-toggle="dropdown" class="dropdown-toggle">'
													+ '<i class="fa fa-cog"></i></a>'
													+ '<ul role="menu" class="dropdown-menu pull-right">'
													+ ' <li><a href="javascript:delScene('
													+ list[v]._id
													+ ');"><i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>'
													+ '</ul></div></td></tr>';

										}
									}
									$('#layers').html('');
									$('#layers').html(html);
									$("[layerid='" + layerid + "']").find("td")
											.addClass("bg_color");
								}
							}, "json")
		}
		function get_elve() {

			var submitData = {
				cid : layerid
			};
			$
					.post(
							'${ctx}/suc/mobilescene!get_elve.action',
							submitData,
							function(json) {
								if (json.state == 0) {
									var html = "";
									var list = json.list;
									if (json.state == 0) {
										for (var v = 0; v < list.length; v++) {
											html += '<tr id="'
												+ list[v]._id 
												+ '"><td>'
													+ list[v].sort
													+ '</td>'
													+ '<td  class="elves_context" onclick="elve_click(this)" elveid="'
													+ list[v]._id
													+ '" id="'
													+ list[v]._id
													+ '">'
													+ list[v].title
													+ '</td>'
													+ '<td onclick="elve_click(this)" elveid="'
													+ list[v]._id
													+ '"><img src="${filehttp}/'
													+ list[v].picurl+'"'
													+ 'height="35px"  /></td>'
													+ '<td class="table-action"><div class="btn-group1 position-r"><a data-toggle="dropdown" class="dropdown-toggle">'
													+ '<i class="fa fa-cog"></i></a>'
													+ '<ul role="menu" class="dropdown-menu pull-right">'
													+ '<li><a href="javascript:delSpirit('
													+ list[v]._id
													+ ');"><i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>'
													+ '<li></tr>';

										}
									}
									$('#elves').html('');
									$('#elves').html(html);
									initContext2();
									$("[elveid='" + elveid + "']").find("td")
											.addClass("bg_color");

								} else {
									$('#elves').html('');
								}

							}, "json")
		}
		var tdrag = false;
		//初始化当前层数据
		function init_layer(id) {
			layerid = id;
			var submitData = {
				id : id
			};
			$
					.post(
							'${ctx}/suc/mobilescene!get_layer_ById.action',
							submitData,
							function(json) {
								if (json.state == 0) {
									//初始化数据到iphone-screen
									var obj = json.obj
									var div = $('<div style="position: relative;"></div>');
									div.attr('id', 'layer_' + obj._id);
									div.addClass('layers');
									if (obj.backgroundcolor != null) {
										div.css('background-color',
												obj.backgroundcolor);
									}
									if (obj.picurl != null) {
										div.css('background-image',
												'url(${filehttp}/' + obj.picurl
														+ ")");
										div.attr('backgroundimage', obj.picurl);
									}
									//初始化精灵属性
									var list = json.list;
									if (list != null && list.length > 0) {
										for (var i = 0; i < list.length; i++) {
											var elve = $('<div style="position: absolute;" onclick="elve_click(this)" elveid="'
													+ list[i]._id + '"></div>');
											elve.attr('id', 'elve_'
													+ list[i]._id);
											var style = list[i].style;
											elve.addClass('elves');
											elve.attr('title', list[i].title);
											elve.attr('title_color',
													list[i].title_color);
											elve.attr('url_value', list[i].url);
											elve.attr('sort', list[i].sort);

											if (style == null) {
												elve.addClass('childdiv');
												elve.attr('z_index', 1);
											} else {
												if (style.height != null) {
													elve.css('height',
															style.height);
												} else {
													elve.css('height', "100px");
												}
												if (style.width != null) {
													elve.css('width',
															style.width);
												} else {
													elve.css('width', "100px");
												}
												if (style.color != null) {
													elve.css('color',
															style.color);
												} else {
													elve.css('color',
															style.color);
												}
												elve.css('left',
														style.marginleft);
												elve
														.css('top',
																style.margintop);
												elve.css('padding',
														style.padding);
												elve.css('border-radius',
														style.radius);
												elve.css('z-index',
														style.z_index);
												elve.attr('z_index',
														style.z_index);

												if (style.backgroundcolor != null) {
													elve
															.css(
																	'background-color',
																	style.backgroundcolor);
												} else {
													elve.css(
															'background-color',
															"black");
												}
												elve.css('box-shadow',
														style.shadow);
												elve
														.css('border',
																style.border);
												elve.attr('rotate',
														style.rotate);
												elve.css('opacity',
														style.opacity);
												rotate(elve, style.rotate);
												if (style.backgroundimage != null) {
													elve
															.css(
																	'background-image',
																	"url(${filehttp}/"
																			+ style.backgroundimage
																			+ ")");
													elve
															.attr(
																	'backgroundimage',
																	style.backgroundimage);
												} else {
													elve
															.css(
																	'background-image',
																	"url(${filehttp}/"
																			+ elve.picurl
																			+ ")");
													elve.attr(
															'backgroundimage',
															elve.picurl);
												}

												var animo = list[i].anima;
												if (animo != null) {
													elve.attr('anima_type',
															animo.type);
													elve.attr('anima_value',
															animo.value);
													elve.attr('anima_duration',
															animo.duration);
													elve.attr('anima_iterate',
															animo.iterate);
													elve.attr('anima_keep',
															animo.keep);
													elve.attr(
															'anima_timeDelay',
															animo.timeDelay);
												}

											}

											var elve_title = $('<div  style="position: absolute;bottom: -20px;font-size: 16px;width: 100%;text-align: center;color:'
													+ list[i].title_color
													+ '">'
													+ list[i].title
													+ '</div>');
											elve.append(elve_title);
											elve.bind("click", function() {
												elves_click(this);
											});
											/**elve.draggable({
												//containment : "#" + 'layer_'
														//+ obj._id,
												scroll : false,
												stack : "#" + 'elve_'
														+ list[i]._id,
												drag : function(event, ui) {
													//updateStyle("#" +v);
													updateStyle(ui.helper);
												},
												start : function(event, ui) {
													init_elve($(ui.helper)
															.attr("id")
															.replace("elve_",
																	""));
													show_evle();
												},
												stop:function(event,ui){
													$(ui.helper).css("z-index",$(ui.helper).attr('sort'))
												}
											});*/

											elve.resizable({
												//aspectRatio: getproportion(div.css("width"),div.css("height"))
												resize : function(event, ui) {
													updateStyle(ui.element);

												},
												start : function(event, ui) {

													if (!tdrag) {
														$(".disable").trigger(
																"click");
														console.log("开始"
																+ tdrag);
														tdrag = true;
													}
													init_elve($(ui.element)
															.attr("id")
															.replace("elve_",
																	""));

													//$(ui.element).disable_open();
												},
												stop : function(event, ui) {

													if (tdrag) {
														$(".disable").trigger(
																"click");
														console.log("结束"
																+ tdrag);
														tdrag = false;
													}

													//$(ui.element).disable_open();
												}
											});
											$(elve)
													.Tdrag(
															{
																cbStart : function(
																		e, v) {
																	init_elve($(
																			e)
																			.attr(
																					"id")
																			.replace(
																					"elve_",
																					""));
																	show_evle();
																},//移动前的回调函数
																cbMove : function(
																		e, v) {
																	updateStyle(e);
																},//移动中的回调函数
																cbEnd : function(
																		e, v) {
																	$(e)
																			.css(
																					"z-index",
																					$(
																							e)
																							.attr(
																									'z_index'))
																}//移动结束时候的回调函数
																,
																disableInput : ".disable"

															});
											div.append(elve);

										}
									}
									//初始化文本属性
									var text = json.text;

									if (text != null && text.length > 0) {
										for (var i = 0; i < text.length; i++) {
											var txt = $('<div onblur="onTextonblur(this)" onclick="getCursortPosition(event,this)">'
													+ list[i].content
													+ '</div>');
											txt
													.attr('id', 'txt_'
															+ list[i]._id);
											txt.addClass('div_text');
											if (list[i].width != null) {
												txt.css('width', list[i].width);
											}
											if (list[i].min_height != null) {
												txt.css('min-height',
														list[i].min_height);
											}
											if (list[i].top != null) {
												txt.css('top', list[i].top);
											}
											if (list[i].color != null) {
												txt.css('color', list[i].color);
											}
											if (list[i].line_height != null) {
												txt.css('line-height',
														list[i].line_height);
											}
											if (list[i].text_align != null) {
												txt.css('text-align',
														list[i].text_align);
											}
											if (list[i].left != null) {
												txt.css('font-size',
														list[i].font - size);
											}

											txt.attr("contenteditable", true);

											var animo = list[i].anima;
											if (animo != null) {
												txt.attr('anima_type',
														animo.type);
												txt.attr('anima_value',
														animo.value);
												txt.attr('anima_duration',
														animo.duration);
												txt.attr('anima_iterate',
														animo.iterate);
												txt.attr('anima_keep',
														animo.keep);
											}

											var divt = $('<div class="div_move"></div>');
											divt.append(txt);
											divt.draggable({
												scroll : false,
												drag : function(event, ui) {
													//updateStyle("#" +v);

												},
												start : function(event, ui) {

												}
											});

											div.append(divt);

										}
									}

									$(".iphone-screen").html("");
									$(".iphone-screen").append(div);
									$("#layer_title").val(obj.title);
									$("#layer_picurl").val(obj.picurl);
									$("#layer_summary").val(obj.summary);
									$("#layer_sort").val(obj.sort);
									$("#layer_transparent")
											.val(obj.transparent);
									$("#layer_bgcolor")
											.val(obj.backgroundcolor);
									get_elve();
									initContext();

								} else {
									alert("创建失败");
								}
							}, "json")
		}
		function init_elve(id) {
			elveid = id;
			var submitData = {
				id : id
			};
			$
					.post(
							'${ctx}/suc/mobilescene!get_elve_ById.action',
							submitData,
							function(json) {
								if (json.state == 0) {
									var obj = json.data;
									var style = obj.style;
									$("#elve_title").val(obj.title);
									$("#elve_picurl").val(obj.picurl);
									$("#elve_url").val(obj.url);
									$("#elve_sort").val(obj.sort);
									$("#elve_title_color").val(obj.title_color);
									$("#elve_yl").css(
											'background-image',
											'url(${filehttp}/' + obj.picurl
													+ ')');
									if (style != null) {
										if (style.backgroundcolor != null) {
											$("#elve_bgcolor").val(
													style.backgroundcolor);
											$("#elve_yl").css(
													'background-color',
													style.backgroundcolor);
										} else {
											$("#elve_yl").css(
													'background-color', 'red');
										}
										if (style.width != null) {
											$("#elve_wz_width")
													.val(style.width);
										}
										if (style.height != null) {
											$("#elve_wz_height").val(
													style.height);
										}
										if (style.marginleft != null) {
											$("#elve_wz_left").val(
													style.marginleft.replace(
															"px", ""));
											jQuery('#slider-wz-left')
													.slider(
															{
																range : "min",
																max : 300,
																value : $(
																		"#elve_wz_left")
																		.val(),
																slide : function(
																		event,
																		ui) {
																	$(
																			"#elve_wz_left")
																			.val(
																					ui.value);
																	$(
																			'#elve_'
																					+ elveid)
																			.css(
																					'left',
																					ui.value);

																}
															});
										}
										if (style.margintop != null) {
											$("#elve_wz_top").val(
													style.margintop.replace(
															"px", ""));
											jQuery('#slider-wz-top')
													.slider(
															{
																range : "min",
																max : 800,
																value : $(
																		"#elve_wz_top")
																		.val(),
																slide : function(
																		event,
																		ui) {
																	$(
																			"#elve_wz_top")
																			.val(
																					ui.value);
																	$(
																			'#elve_'
																					+ elveid)
																			.css(
																					'top',
																					ui.value);

																}
															});
										}
										if (style.rotate != null) {
											$("#elve_wz_xz").val(style.rotate);
											jQuery('#slider-wz-xz')
													.slider(
															{
																range : "min",
																max : 360,
																value : style.rotate,
																slide : function(
																		event,
																		ui) {
																	$(
																			"#elve_wz_xz")
																			.val(
																					ui.value);
																	rotate(
																			"#elve_"
																					+ elveid,
																			ui.value);

																}
															});
										}

									}
									var anima = obj.anima;
									if (anima != null) {
										console.log(anima);
										if (anima.value != null) {
											$('#anima_value').val(anima.value);
										} else {
											$('#anima_value').val('');
										}
										if (anima.duration != null) {
											$('#anima_duration').val(
													anima.duration);
										} else {
											$('#anima_duration').val(0);
										}
										if (anima.iterate != null) {
											if (anima.iterate == 'infinite') {
												$('#anima_infinite').prop(
														"checked", true);
												$('#anima_iterate').val(0);
											} else {
												$('#anima_iterate').val(
														anima.iterate);
												$('#anima_infinite').prop(
														"checked", false);
											}

										}
										if (anima.keep != null) {
											$('#anima_keep').val(anima.keep);
										}
										if (anima.type != null) {
											$('#anima_type').val(anima.type);
										}
										if (anima.timeDelay != null) {
											$('#anima_timeDelay').val(
													anima.timeDelay);
										}

									}

								} else {

								}
							}, "json")
		}
		//保存层以及层下级精灵的数据
		function saveLayer() {
			//检索当前层
			var layer = $("#layer_" + layerid);
			if (layer.length > 0) {
				//层存在组装层数据
				var data = {};
				var layer = {};
				layer.title = $("#layer_title").val();
				layer.id = layerid;
				layer.picurl = $("#layer_picurl").val();
				layer.sort = $("#layer_sort").val();
				layer.color = $("#layer_color").val();
				layer.backgroundcolor = $("#layer_bgcolor").val();
				layer.opacity = $("#layer_transparent").val();

				//组装精灵数据
				var elvels = new Array();
				$(".elves").each(function() {
					var elvel = {};
					elvel.id = $(this).attr("id").replace("elve_", "");
					elvel.title = $(this).attr("title");
					elvel.sort = $(this).attr("sort");
					elvel.title_color = $(this).attr("title_color");
					elvel.width = $(this).css("width");
					elvel.height = $(this).css("height");
					elvel.left = $(this).css("left");
					elvel.picurl = $(this).attr("backgroundimage");
					elvel.top = $(this).css("top");
					elvel.color = $(this).css("color");
					elvel.backgroundcolor = $(this).css("background-color");
					elvel.backgroundimage = $(this).attr("backgroundimage");
					elvel.transform = $(this).attr("rotate");
					elvel.border = $(this).css("border");
					elvel.radius = $(this).css("border-radius");
					elvel.box_shadow = $(this).css("box-shadow");
					elvel.opacity = $(this).css("opacity");
					elvel.url = $(this).attr("url_value");
					elvel.z_index = $(this).attr("z_index");
					//组装精灵动画
					elvel.anima_value = $(this).attr("anima_value");
					elvel.anima_duration = $(this).attr("anima_duration");
					elvel.anima_iterate = $(this).attr("anima_iterate");
					elvel.anima_keep = $(this).attr("anima_keep");
					elvel.anima_type = $(this).attr("anima_type");
					elvel.anima_timeDelay = $(this).attr("anima_timeDelay");

					elvels.push(elvel);

				});
				layer.elvels = elvels;
				//组装文本数据
				var texts = new Array();
				$(".div_text")
						.each(
								function() {
									var txt = {};
									txt.id = $(this).attr("id").replace("txt_",
											"");
									txt.title = $(this).attr("title");
									txt.width = $(this).css("width");
									txt.height = $(this).css("height");
									txt.left = $(this).css("left");
									txt.picurl = $(this)
											.css("background-image").replace(
													"none", "");
									txt.top = $(this).css("top");
									txt.color = $(this).css("color");
									txt.backgroundcolor = $(this).css(
											"background-color");
									txt.backgroundimage = $(this).attr(
											"backgroundimage");
									txt.transform = $(this).attr("rotate");
									txt.border = $(this).css("border");
									txt.radius = $(this).css("border-radius");
									txt.box_shadow = $(this).css("box-shadow");
									txt.opacity = $(this).css("opacity");
									txt.url = $(this).attr("url");
									txt.z_index = $(this).css("z-index");

									//组装文本动画
									txt.anima_value = $(this).attr(
											"anima_value");
									txt.anima_duration = $(this).attr(
											"anima_duration");
									txt.anima_iterate = $(this).attr(
											"anima_iterate");
									txt.anima_keep = $(this).attr("anima_keep");
									txt.anima_type = $(this).attr("anima_type");

									texts.push(txt);
								});
				layer.texts = texts;
				//组装幻灯片数据
				var slide = {};
				slide.width = $('#slide_width').val();
				slide.height = $('#slide_height').val();
				slide.left = $('#slide_left').val();
				slide.top = $('#slide_top').val();

				layer.slide = slide;
				//组装滚动字幕数据
				var roll = {};
				roll.width = $('#roll_width').val();
				roll.height = $('#roll_height').val();
				roll.left = $('#roll_left').val();
				roll.top = $('#roll_top').val();
				roll.bjcolor = $('#roll_bj_color').val();
				roll.color = $('#roll_color').val();
				layer.roll = roll;

				data.layer = JSON.stringify(layer);
				data.id = '${msid}';
				$.post('${ctx}/suc/mobilescene!save_layer.action', data,
						function(json) {
							if (json.state == 0) {

							} else {
							}
							//window.location.reload();
						}, "json")
			}

		}

		var obj = {};
		var globalID;
		var ybobj = null;
		function animation1() {

			//绑定数据到dom对象
			console.log("#elve_" + elveid);
			console.log($('#anima_value').val());
			console.log($("#elve_" + elveid).attr("anima_value"));
			$("#elve_" + elveid).attr("anima_value", $('#anima_value').val());
			$("#elve_" + elveid).attr("anima_duration",
					$('#anima_duration').val());
			$("#elve_" + elveid).attr("anima_keep", $('#anima_keep').val());
			$("#elve_" + elveid).attr("anima_type", $('#anima_type').val());

			var element = document.querySelector("#elve_" + elveid);

			Transform(element);
			tickArr.splice(0, 1);
			To.stopAll();
			To.List.splice(0);
			console.log(To.List);
			if (ybobj != null) {
				ybobj.stop();

			}
			//translateX, translateY, translateZ, scaleX, scaleY, scaleZ, rotateX, rotateY, rotateZ, skewX, skewY, originX, originY, originZ
			//初始化
			if (typeof (obj.translateX) == "undefined"
					|| obj.id != "#elve_" + elveid) {
				obj.translateX = element.translateX;
				obj.id = "#elve_" + elveid;
				obj.translateY = element.translateY;
				obj.translateZ = element.translateZ;
				obj.scaleX = element.scaleX;
				obj.scaleY = element.scaleY;
				obj.scaleZ = element.scaleZ;
				obj.rotateX = element.rotateX;
				obj.rotateY = element.rotateY;
				obj.rotateZ = element.rotateZ;
				obj.skewX = element.skewX;
				obj.skewY = element.skewY;
				obj.originX = element.originX;
				obj.originY = element.originY;
				obj.originZ = element.originZ;
			} else {
				element.translateX = obj.translateX;
				obj.id = "#elve_" + elveid;
				element.translateY = obj.translateY;
				element.translateZ = obj.translateZ;
				element.scaleX = obj.scaleX;
				element.scaleY = obj.scaleY;
				element.scaleZ = obj.scaleZ;
				element.rotateX = obj.rotateX;
				element.rotateY = obj.rotateY;
				element.rotateZ = obj.rotateZ;
				element.skewX = obj.skewX;
				element.skewY = obj.skewY;
				element.originX = obj.originX;
				element.originY = obj.originY;
				element.originZ = obj.originZ;
			}

			//旋转
			if ($('#anima_value').val() == "spinner") {
				tick(function() {
					if ($('#anima_duration').val() > 0) {
						element.rotateZ = element.rotateZ
								+ parseFloat($('#anima_duration').val() * 0.1);
					} else {
						element.rotateZ = element.rotateZ + 0.1;
					}
				});

			}
			//上下翻转
			if ($('#anima_value').val() == "flipOutX") {
				tick(function() {
					if ($('#anima_duration').val() > 0) {
						element.rotateX = element.rotateX
								+ parseFloat($('#anima_duration').val() * 0.1);
					} else {
						element.rotateX = element.rotateX + 0.1;
					}
				});

			}
			//左右翻转
			if ($('#anima_value').val() == "flipOutY") {
				tick(function() {
					if ($('#anima_duration').val() > 0) {
						element.rotateY = element.rotateY
								+ parseFloat($('#anima_duration').val() * 0.1);
					} else {
						element.rotateY = element.rotateY + 0.1;
					}
				});

			}
			//左飞入
			if ($('#anima_value').val() == "fadeInLeft") {
				var qs = element.translateX;
				element.translateX = -300;
				tick(function() {
					if ($('#anima_duration').val() > 0
							&& element.translateX < qs) {
						element.translateX = element.translateX
								+ parseFloat($('#anima_duration').val() * 0.1);
					} else if (element.translateX < qs) {
						element.translateX = element.translateX + 0.1;
					}

				});
			}
			//右飞入
			if ($('#anima_value').val() == "fadeInRight") {
				var qs = element.translateX;
				element.translateX = 300;
				tick(function() {
					if ($('#anima_duration').val() > 0
							&& element.translateX > qs) {
						element.translateX = element.translateX
								- parseFloat($('#anima_duration').val() * 0.1);
					} else if (element.translateX > qs) {
						element.translateX = element.translateX - 0.1;
					}

				});
			}
			//上飞入
			if ($('#anima_value').val() == "fadeInUp") {
				var qs = element.translateY;
				element.translateY = -600;
				tick(function() {
					if ($('#anima_duration').val() > 0
							&& element.translateY < qs) {
						element.translateY = element.translateY
								+ parseFloat($('#anima_duration').val() * 0.1);
					} else if (element.translateY < qs) {
						element.translateY = element.translateY + 0.1;
					}

				});
			}
			//下飞入
			if ($('#anima_value').val() == "fadeInDown") {
				var qs = element.translateY;
				element.translateY = 600;
				tick(function() {
					if ($('#anima_duration').val() > 0
							&& element.translateY > qs) {
						element.translateY = element.translateY
								- parseFloat($('#anima_duration').val() * 0.1);
					} else if (element.translateY > qs) {
						element.translateY = element.translateY - 0.1;
					}

				});
			}
			//放大
			if ($('#anima_value').val() == "fadeBig") {
				var qs = element.translateZ;
				element.translateZ = -300;
				tick(function() {
					if ($('#anima_duration').val() > 0
							&& element.translateZ < qs) {
						element.translateZ = element.translateZ
								+ parseFloat($('#anima_duration').val() * 0.1);
					} else if (element.translateZ < qs) {
						element.translateZ = element.translateZ + 0.1;
					}

				});
			}
			//缩小
			if ($('#anima_value').val() == "fadeSmall") {
				var qs = element.translateZ;
				element.translateZ = 300;
				tick(function() {
					if ($('#anima_duration').val() > 0
							&& element.translateZ > qs) {
						element.translateZ = element.translateZ
								- parseFloat($('#anima_duration').val() * 0.1);
					} else if (element.translateZ > qs) {
						element.translateZ = element.translateZ - 0.1;
					}

				});
			}
			//左右摇摆
			if ($('#anima_value').val() == "swing") {
				var step = 0.01, xStep = 3, skewStep = 1;
				Transform(element);
				element.originY = 100;
				element.skewX = -20;

				function sineInOut(a) {
					return 0.5 * (1 - Math.cos(Math.PI * a));
				}
				var alloyFlow = new AlloyFlow({
					workflow : [ {
						work : function() {
							To.go(element, "scaleY", .8, 450, sineInOut);
							To.go(element, "skewX", 20, 900, sineInOut)
						},
						start : 0
					}, {
						work : function() {
							To.go(element, "scaleY", 1, 450, sineInOut)
						},
						start : 450
					}, {
						work : function() {
							To.go(element, "scaleY", .8, 450, sineInOut);
							To.go(element, "skewX", -20, 900, sineInOut)
						},
						start : 900
					}, {
						work : function() {
							To.go(element, "scaleY", 1, 450, sineInOut);
						},
						start : 1350
					}, {
						work : function() {
							this.start();
						},
						start : 1800
					} ]
				})
				ybobj = alloyFlow;
				ybobj.start();

			}

			if ($('#anima_value').val() == "left_right") {
				var step = 0.02, xStep = 3, skewStep = 1;
				animateX();
			}
			if ($('#anima_value').val() == "up_down") {
				var step = 0.02, xStep = 3, skewStep = 1;
				animateY();
			}

			function animateY() {
				cancelAnimationFrame(globalID);
				element.translateY < -300 && (xStep *= -1);
				element.translateY > 300 && (xStep *= -1);
				element.translateY += xStep;
				globalID = requestAnimationFrame(animateY);
			}
			function animateX() {
				cancelAnimationFrame(globalID);
				element.translateX < -150 && (xStep *= -1);
				element.translateX > 150 && (xStep *= -1);
				element.translateX += xStep;
				globalID = requestAnimationFrame(animateX);
			}

		}
		//css动画
		function animation() {
			console.log($("#elve_" + elveid).css("animation"));
			$("#elve_" + elveid).css("animation", '');
			console.log($("#elve_" + elveid).css("animation"));
			//绑定动画到当前精灵上
			var anima = '';
			anima += $('#anima_value').val() + ' ';
			anima += $('#anima_duration').val() + 's ';
			anima += 'ease ' + $('#anima_timeDelay').val() + 's ';
			if ($('#anima_infinite').is(':checked')) {
				anima += "infinite normal both running";
				$("#elve_" + elveid).attr("anima_iterate", "infinite");
			} else {
				anima += $('#anima_iterate').val() + " normal both running";
				$("#elve_" + elveid).attr("anima_iterate",
						$('#anima_iterate').val());
			}

			$("#elve_" + elveid).css("animation", anima);
			//绑定动画数据到精灵上
			$("#elve_" + elveid).attr("anima_value", $('#anima_value').val());
			$("#elve_" + elveid).attr("anima_duration",
					$('#anima_duration').val());
			$("#elve_" + elveid).attr("anima_timeDelay",
					$('#anima_timeDelay').val());
			console.log($("#elve_" + elveid).attr("anima_timeDelay"));

		}
		$('#anima_yl').click(function() {
			animation();
		});
		//创建文本框
		function createText() {
			var div = $('<div onblur="onTextonblur(this)" onclick="getCursortPosition(event,this)" >双击编辑文字</div>');
			$(div).addClass("div_text");
			$(div).attr("contenteditable", true);

			var divt = $('<div class="div_move"></div>');
			divt.append(div);
			divt.draggable({
				scroll : false,
				drag : function(event, ui) {
					//updateStyle("#" +v);

				},
				start : function(event, ui) {

				}
			});
			$("#layer_" + layerid).append(divt);
		}

		//创建幻灯片
		function createSlide() {
			if ($(".iphone-screen").find('.div_slide').length == 0) {
				$(".iphone-screen").html("");
				init_slide_roll();
			}

		}

		//创建滚动字幕
		function createRoll() {
			if ($(".iphone-screen").find('.div_roll').length == 0) {

				$(".iphone-screen").html("");
				init_slide_roll();
			}

		}

		function onTextonfoucs(v) {
			$(v).html($(v).html().replace("双击编辑文字", ""));

		}
		//文本框失焦
		function onTextonblur(v) {
			console.log($(v).html());
			if ($(v).html().trim() == "") {
				$(v).html("双击编辑文字");
			}
			var divt = $('<div class="div_move"></div>');
			$(divt).css('left', $(v).css('left'));
			$(divt).css('top', $(v).css('top'));
			$(v).css('left', 0);
			$(v).css('top', 0);
			divt.append(v);
			divt.draggable({
				scroll : false,
				drag : function(event, ui) {
					//updateStyle("#" +v);

				},
				start : function(event, ui) {

				}
			});
			$("#layer_" + layerid).append(divt);

		}

		function getCursortPosition(e, t) {
			if ($("#layer_" + layerid).find('.div_move').length > 0) {
				$(t).css('left', $(t).parent('.div_move').css('left'));
				$(t).css('top', $(t).parent('.div_move').css('top'))
				$(t).parent('.div_move').remove();

				$("#layer_" + layerid).append(t);
			}
			if (e.target.nodeName == "DIV") {
				pos = getDivPosition(e.target);
			}
		}

		//可编辑div获取坐标
		const getDivPosition = function(element) {
			var caretOffset = 0;
			var doc = element.ownerDocument || element.document;
			var win = doc.defaultView || doc.parentWindow;
			var sel;
			if (typeof win.getSelection != "undefined") {//谷歌、火狐
				sel = win.getSelection();
				if (sel.rangeCount > 0) {//选中的区域
					console.log(sel.rangeCount);
					var range = win.getSelection().getRangeAt(0);
					var preCaretRange = range.cloneRange();//克隆一个选中区域 
					preCaretRange.selectNodeContents(element);//设置选中区域的节点内容为当前节点 
					preCaretRange.setEnd(range.endContainer, range.endOffset); //重置选中区域的结束位置
					caretOffset = preCaretRange.toString().length;
				}
			} else if ((sel = doc.selection) && sel.type != "Control") {//IE
				var textRange = sel.createRange();
				var preCaretTextRange = doc.body.createTextRange();
				preCaretTextRange.moveToElementText(element);
				preCaretTextRange.setEndPoint("EndToEnd", textRange);
				caretOffset = preCaretTextRange.text.length;
			}
			return caretOffset;
		}

		//获取模板数据
		var mbfypage_my = 0;
		var isappend_my = true;
		var mbfypage_all = 0;
		var isappend_all = true;
		function init_mb(mb, v) {
			var fypage;
			if (mb == 1) {
				if (isappend_my) {
					isappend_my = false;
				} else {
					return;
				}
				fypage = mbfypage_my;
			} else {
				if (isappend_all) {
					isappend_all = false;
				} else {
					return;
				}
				fypage = mbfypage_all;
			}
			var submitData = {
				my : mb
			}
			$
					.post(
							'${ctx}/suc/mobilescene!get_mb.action?fypage='
									+ fypage,
							submitData,
							function(json) {
								if (json.state == 0) {
									var list = json.list;
									var html = $(v).html();
									for (var i = 0; i < list.length; i++) {
										html += '<div class="col-xs-6 document">'
												+ '<div class="thmb">'
												+ '<div class="ckbox ckbox-default" style="display: none;">'
												+ '<input type="checkbox" id="check1" value="1"> <label for="check1"></label>'
												+ '</div>'
												+ '<div class="btn-group fm-group" style="display: none;">'
												+ '<button type="button" class="btn btn-default dropdown-toggle fm-toggle" data-toggle="dropdown"> <span class="caret"></span> </button>'
												+ '<ul class="dropdown-menu fm-menu" role="menu">'
												+ '<li><a href="#"><i class="fa fa-share"></i> Share</a></li>'
												+ '<li><a href="#"><i class="fa fa-envelope-o"></i>Email</a></li>'
												+ '	</ul></div>'
												+ '<div class="thmb-prev"> <img src="${filehttp}/'+list[i].picurl+'" class="img-responsive" alt=""> </div>'
												+ '<h5 class="fm-title">'
												+ '<a href="">'
												+ list[i].title
												+ '</a>' + '</h5>'

												+ '</div>' + '</div>'
									}
									if (mb == 1) {
										mbfypage_my++;
									} else {
										mbfypage_all++;
									}
									$(v).html(html);
								} else {

								}
								if (mb == 1) {
									isappend_my = true;
								} else {
									isappend_all = true;
								}
							}, "json")
		}

		//初始化数据
		init_mb(0, $("#mb_all"));
		init_mb(1, $("#mb_my"));
		//滑动监听

		$("#mb_all")
				.parent('.col-sm-12')
				.scroll(
						function() {
							console.log('加载滑动');
							if ($("#mb_all").parent('.col-sm-12').scrollTop() > $(
									'#mb_all').height()
									- $("#mb_all").parent('.col-sm-12')
											.height() - 200) {

								init_mb(0, $("#mb_all"));
							}

						});
		//滑动监听
		$("#mb_my").parent('.col-sm-12').scroll(
				function() {
					if ($("#mb_my").parent('.col-sm-12').scrollTop() > $(
							'#mb_my').height()
							- $("#mb_my").parent('.col-sm-12').height() - 200) {
						init_mb(1, $("#mb_my"));
					}

				});

		var remove = $("#li_1");
		//显示幻灯片数据
		function show_slide() {
			var idvi = $('<li id="li_8" style="display: none"><a href="#tab8" data-toggle="tab"><strong>幻灯片管理</strong></a></li>');
			$('#tabs').append(idvi);

			$('#tabs').find('li').removeClass('active');
			$('#tabs-body').find('.top-pane').removeClass('active')
			//$("#tabs").children('li').eq(icount).hide();
			remove.remove();
			$('#li_8').addClass('active');
			$('#li_8').show();
			$('#tab8').addClass('active');
			$('#li_2').after($('#li_8'));
			remove = $('#li_8');
			createSlide();
			getSlide();

		}
		//显示幻滚动字幕
		function show_roll() {

			var idvi = $('<li id="li_9" style="display: none"><a href="#tab9" data-toggle="tab"><strong>滚动字管理</strong></a></li>');
			$('#tabs').append(idvi);
			$('#tabs').find('li').removeClass('active');
			$('#tabs-body').find('.top-pane').removeClass('active')
			remove.remove();
			$('#li_9').addClass('active');
			$('#li_9').show();
			$('#tab9').addClass('active');
			$('#li_2').after($('#li_9'));
			remove = $('#li_9');
			createRoll();
			getRoll();
		}
		//显示文本数据
		function show_txt() {
			var idvi = $('<li id="li_6" style="display: none"><a href="#tab6" data-toggle="tab"><strong>文本管理</strong></a></li>');
			$('#tabs').append(idvi);
			$('#tabs').find('li').removeClass('active');
			$('#tabs-body').find('.top-pane').removeClass('active')
			remove.remove();
			$('#li_6').addClass('active');
			$('#li_6').show();
			$('#tab6').addClass('active');
			$('#li_2').after($('#li_6'));
			remove = $('#li_6');
			createText();

		}
		//显示图层属性
		function show_scence() {
			if (remove.attr('id') != '#li_1') {
				var idvi = $('<li id="li_1" style="display: none"><a href="#tab6" data-toggle="tab"><strong>图层属性</strong></a></li>');
				$('#tabs').append(idvi);
				$('#tabs').find('li').removeClass('active');
				$('#tabs-body').find('.top-pane').removeClass('active')
				remove.remove();
				$('#li_1').addClass('active');
				$('#li_1').show();
				$('#tab1').addClass('active');
				$('#li_2').after($('#li_1'));
				remove = $('#li_1');
			}

		}
		//显示音乐数据
		function show_music() {
			var idvi = $('<li id="li_10" style="display: none"><a href="#tab10" data-toggle="tab"><strong>音乐设置</strong></a></li>');
			$('#tabs').append(idvi);
			$('#tabs').find('li').removeClass('active');
			$('#tabs-body').find('.top-pane').removeClass('active')
			remove.remove();
			$('#li_10').addClass('active');
			$('#li_10').show();
			$('#tab10').addClass('active');
			$('#li_2').after($('#li_10'));
			remove = $('#li_10');

		}
		//显示分享数据
		function show_share() {
			var idvi = $('<li id="li_11" style="display: none"><a href="#tab11" data-toggle="tab"><strong>分享设置</strong></a></li>');
			$('#tabs').append(idvi);
			$('#tabs').find('li').removeClass('active');
			$('#tabs-body').find('.top-pane').removeClass('active')
			remove.remove();
			$('#li_11').addClass('active');
			$('#li_11').show();
			$('#tab11').addClass('active');
			$('#li_2').after($('#li_11'));
			remove = $('#li_11');

		}
		//显示精灵属性
		function show_evle() {
			var idvi = $('<li id="li_4" style="display: none"><a href="#tab4" data-toggle="tab"><strong>精灵属性</strong></a></li>');
			$('#tabs').append(idvi);
			$('#tabs').find('li').removeClass('active');
			$('#tabs-body').find('.top-pane').removeClass('active')
			remove.remove();
			$('#li_4').addClass('active');
			$('#li_4').show();
			$('#tab4').addClass('active');
			$('#li_2').after($('#li_4'));
			remove = $('#li_4');

		}
	</script>
	<script type="text/javascript" src="${ctx}/css_js/js/fileUp_no.js">
		
	</script>
	<script type="text/javascript">
		//图片上传
		fileInput("layerpicurl", "11", "layer_picurl", "1", function(e) {
			picurl_change();
		});
		fileInput("elvepicurl", "11", "elve_picurl", "1", function(e) {
			elve_picurl_change();
		});
		fileInput("sharepicurl", "11", "share_picurl", "1", function(e) {

		});

		fileInput("slide_picurl", "11", "slide_picurl", "1", function(e) {

		});
		fileInput("curtain_picurl", "11", "curtain_picurl", "1", function(e) {

		});
		fileInput("musicpicurl", "11", "music_picurl", "1", function(e) {

		});
	</script>
	<script type="text/javascript">
		var editor = CKEDITOR.replace('roll_context');
		//添加滚动字幕
		function add_roll() {
			$('#roll_id').val('');
			$('#roll_title').val('');
			$('#roll_url').val('');
			$('#roll_sort').val(0);
			ps_show('inszc_roll');
		}
		//添加幻灯片
		function add_slide() {
			$('#slide_id').val('');
			$('#slide_title').val('');
			$('#slide_url').val('');
			$('#slide_sort').val(0);
			ps_show('inszc_slide');
		}
		//添加幕布
		function add_curtain() {
			$('#curtain_id').val('');
			$('#curtain_title').val('');
			$('#curtain_url').val('');
			$('#curtain_sort').val(0);
			ps_show('inszc_curtain');
		}
		//保存滚动字幕
		function save_roll() {
			var submitData = {
				title : $('#roll_title').val(),
				sort : $('#roll_sort').val(),
				id : $('#roll_id').val(),
				url : $('#roll_url').val(),
				content : editor.getData(),
				type : 'scene${msid}'
			};
			$.post('${ctx}/suc/mobilescene!save_Roll.action', submitData,
					function(json) {
						if (json.state == 0) {
							ps_hide('inszc_roll');
							getRoll();
						}

					}, "json")

		}
		//保存幻灯片
		function save_slide() {
			var submitData = {
				title : $('#slide_title').val(),
				sort : $('#slide_sort').val(),
				id : $('#slide_id').val(),
				url : $('#slide_url').val(),
				picurl : $('#slide_picurl').val(),
				type : 'scene${msid}'
			};
			$.post('${ctx}/suc/mobilescene!save_Slide.action', submitData,
					function(json) {
						if (json.state == 0) {
							ps_hide('inszc_slide');
							getSlide();
						}

					}, "json")
		}
		//保存幕布
		function save_curtain() {
			var submitData = {
				title : $('#curtain_title').val(),
				sort : $('#curtain_sort').val(),
				id : $('#curtain_id').val(),
				url : $('#curtain_url').val(),
				picurl : $('#curtain_picurl').val(),
				type : 'scene${msid}'
			};
			$.post('${ctx}/suc/mobilescene!save_Curtain.action', submitData,
					function(json) {
						if (json.state == 0) {
							ps_hide('inszc_curtain');
							getSlide();
						}

					}, "json")
		}
		//保存分享信息
		function save_share() {
			var submitData = {
				title : $('#share_title').val(),
				summary : $('#share_summary').val(),
				id : $('#share_id').val(),
				picurl : $('#share_picurl').val(),
				id : "${msid}"
			};
			$.post('${ctx}/suc/mobilescene!saveShare.action', submitData,
					function(json) {
						if (json.state == 0) {
							alert("保存成功！");
						}

					}, "json")
		}
		//保存音乐
		function save_music() {
			var submitData = {
				music_url : $('#music_url').val(),
				music_picurl : $('#music_picurl').val(),
				music_color : $('#music_color').val(),
				id : '${msid}',
				music_transparent : $('#music_transparent').val(),

			};
			$.post('${ctx}/suc/mobilescene!saveMp3.action', submitData,
					function(json) {
						if (json.state == 0) {
							alert("保存成功！")
						}

					}, "json")
		}
		//修改滚动字幕
		function upd_roll(id) {
			var submitData = {
				_id : id
			};
			$.post('${ctx}/suc/roll!upd.action', submitData, function(json) {
				$('#roll_id').val(json._id);
				$('#roll_title').val(json.title);
				$('#roll_picurl').val(json.picurl);
				$('#roll_url').val(json.url);
				$('#roll_sort').val(json.sort);
				$('#roll_context').val(json.content);
				editor.setData(json.content)

			}, "json")

			ps_show('inszc_roll');
		}
		//删除滚动字幕
		function del_roll(id) {
			var submitData = {
				id : id
			};
			$.post('${ctx}/suc/mobilescene!delRoll.action', submitData,
					function(json) {
						if (json.state == 0) {

						}
						alert("删除成功！");
						getRoll();

					}, "json")

		}
		//删除幻灯片
		function del_slide(id) {
			var submitData = {
				id : id
			};
			$.post('${ctx}/suc/mobilescene!delSlide.action', submitData,
					function(json) {
						if (json.state == 0) {

						}
						alert("删除成功！");
						getSlide();

					}, "json")

		}
		//删除幕布
		function del_curtain(id) {
			var submitData = {
				id : id
			};
			$.post('${ctx}/suc/mobilescene!delCurtain.action', submitData,
					function(json) {
						if (json.state == 0) {

						}
						alert("删除成功！");
						getCurtain();

					}, "json")

		}
		//修改幻灯片
		function upd_slide(id) {
			var submitData = {
				_id : id
			};
			$.post('${ctx}/suc/slide!upd.action', submitData, function(json) {
				$('#slide_id').val(json._id);
				$('#slide_title').val(json.title);
				$('#slide_picurl').val(json.picurl);
				$('#slide_url').val(json.url);
				$('#slide_sort').val(json.sort);

			}, "json")

			ps_show('inszc_slide');
		}
		//修改幕布
		function upd_curtain(id) {
			var submitData = {
				_id : id
			};
			$.post('${ctx}/suc/slide!upd.action', submitData, function(json) {
				$('#curtain_id').val(json._id);
				$('#curtain_title').val(json.title);
				$('#curtain_picurl').val(json.picurl);
				$('#curtain_url').val(json.url);
				$('#curtain_sort').val(json.sort);

			}, "json")

			ps_show('inszc_curtain');
		}
		//获取滚动字幕
		function getRoll() {
			var submitData = {
				msid : '${msid}'
			}
			$
					.post(
							'${ctx}/suc/mobilescene!getRoll.action',
							submitData,
							function(json) {
								if (json.state == 0) {
									var html = "";
									var list = json.list;
									if (json.state == 0) {
										for (var v = 0; v < list.length; v++) {

											html += '<tr><td>'
													+ list[v].sort
													+ '</td>'
													+ '<td>'
													+ list[v].title
													+ '</td>'
													+ '<td class="table-action"><div class="btn-group1 position-r"><a data-toggle="dropdown" class="dropdown-toggle">'
													+ '<i class="fa fa-cog"></i></a>'
													+ '<ul role="menu" class="dropdown-menu pull-right">'
													+ '<li><a href="javascript:upd_roll('
													+ list[v]._id
													+ ')">'
													+ '<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a></li>'
													+ ' <li><a href="javascript:del_roll('
													+ list[v]._id
													+ ');"><i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>'
													+ '</ul></div></td></tr>';

										}
									}
									$('#rolls').html('');
									$('#rolls').html(html);
								}

							}, "json")
		}
		//获取幻灯片
		function getSlide() {
			var submitData = {
				msid : '${msid}'
			}
			$
					.post(
							'${ctx}/suc/mobilescene!getSlide.action',
							submitData,
							function(json) {

								var html = "";
								var list = json.list;
								if (json.state == 0) {
									for (var v = 0; v < list.length; v++) {

										html += '<tr><td>'
												+ list[v].sort
												+ '</td>'
												+ '<td>'
												+ list[v].title
												+ '</td>'
												+ '<td><img src="${filehttp}'
												+ list[v].picurl
												+ '" style="height:25px"/></td>'
												+ '<td class="table-action"><div class="btn-group1 position-r"><a data-toggle="dropdown" class="dropdown-toggle">'
												+ '<i class="fa fa-cog"></i></a>'
												+ '<ul role="menu" class="dropdown-menu pull-right">'
												+ '<li><a href="javascript:upd_slide('
												+ list[v]._id
												+ ')">'
												+ '<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a></li>'
												+ ' <li><a href="javascript:del_slide('
												+ list[v]._id
												+ ');"><i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>'
												+ '</ul></div></td></tr>';

									}
								}
								$('#slides').html('');
								$('#slides').html(html);

							}, "json")
		}
		//获取幕布
		function getCurtain() {
			var submitData = {
				msid : '${msid}'
			}
			$
					.post(
							'${ctx}/suc/mobilescene!getCurtain.action',
							submitData,
							function(json) {

								var html = "";
								var list = json.list;
								if (json.state == 0) {
									for (var v = 0; v < list.length; v++) {

										html += '<tr><td>'
												+ list[v].sort
												+ '</td>'
												+ '<td>'
												+ list[v].title
												+ '</td>'
												+ '<td class="table-action"><div class="btn-group1 position-r"><a data-toggle="dropdown" class="dropdown-toggle">'
												+ '<i class="fa fa-cog"></i></a>'
												+ '<ul role="menu" class="dropdown-menu pull-right">'
												+ '<li><a href="javascript:upd_curtain('
												+ list[v]._id
												+ ')">'
												+ '<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a></li>'
												+ ' <li><a href="javascript:del_curtain('
												+ list[v]._id
												+ ');"><i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>'
												+ '</ul></div></td></tr>';

									}
								}
								$('#curtains').html('');
								$('#curtains').html(html);

							}, "json")
		}

		//获取文本
		function getText() {
			var submitData = {
				id : layerid
			}
			$
					.post(
							'${ctx}/suc/mobilescene!getText.action',
							submitData,
							function(json) {

								var html = "";
								var list = json.list;
								if (json.state == 0) {
									for (var v = 0; v < list.length; v++) {

										html += '<tr><td>'
												+ list[v].sort
												+ '</td>'
												+ '<td>'
												+ list[v].title
												+ '</td>'
												+ '<td class="table-action"><div class="btn-group1 position-r"><a data-toggle="dropdown" class="dropdown-toggle">'
												+ '<i class="fa fa-cog"></i></a>'
												+ '<ul role="menu" class="dropdown-menu pull-right">'
												+ '<li><a href="javascript:updTxt('
												+ list[v]._id
												+ ')">'
												+ '<i class="fa fa-pencil "></i>&nbsp;&nbsp;&nbsp;&nbsp;修改</a></li>'
												+ ' <li><a href="javascript:delTxt('
												+ list[v]._id
												+ ');"><i class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a></li>'
												+ '</ul></div></td></tr>';

									}
								}
								$('#txts').html('');
								$('#txts').html(html);

							}, "json")
		}
		//初始化层数据
		get_layer();
		function init_slide_roll() {
			//组装幻灯片 
			var slide = $('<div class="div_slide">拖动设置幻灯片幕位置</div>');
			if ('${slidestyle}' != null) {
				slide.css('top', '${slidestyle.margintop}');
				slide.css('left', '${slidestyle.marginleft}');
				slide.css('height', '${slidestyle.height}');
			}
			slide.draggable({
				scroll : false,
				drag : function(event, ui) {
					var obj = ui.helper;
					$('#slide_top').val($(obj).css('top'));
					$('#slide_left').val($(obj).css('left'));
					$('#slide_height').val($(obj).css('height'));

				},
				start : function(event, ui) {
					show_slide();

				}
			});
			slide.resizable({
				//aspectRatio: getproportion(div.css("width"),div.css("height"))
				resize : function(event, ui) {
					$('#slide_height').val($(ui.element).css('height'));
				},
				start : function(event, ui) {
					show_slide();

				}
			});
			$(".iphone-screen").append(slide);

			//组装滚动字幕
			var roll = $('<div class="div_roll">拖动设置滚动字幕位置</div>');

			if ('${rollstyle}' != null) {
				roll.css('top', '${rollstyle.margintop}');
				roll.css('left', '${rollstyle.marginleft}');
				roll.css('height', '${rollstyle.height}');
			}
			roll.draggable({
				scroll : false,
				drag : function(event, ui) {
					var obj = ui.helper;
					$('#roll_top').val($(obj).css('top'));
					$('#roll_left').val($(obj).css('left'));

				},
				start : function(event, ui) {
					show_roll();

				}
			});
			$(".iphone-screen").append(roll);

		}
		//保存幻灯片，滚动样式
		function save_slide_roll() {
			var submitData = {
				id : '${msid}'
			};
			//组装幻灯片数据
			var slide = {};
			slide.height = $('#slide_height').val();
			slide.left = $('#slide_left').val();
			slide.top = $('#slide_top').val();

			submitData.slide = JSON.stringify(slide);
			//组装滚动字幕数据
			var roll = {};
			roll.height = $('#roll_height').val();
			roll.left = $('#roll_left').val();
			roll.top = $('#roll_top').val();
			roll.color = $('#roll_color').val();
			roll.backgroundcolor = $('#roll_bj_color').val();
			submitData.roll = JSON.stringify(roll);
			;
			$.post('${ctx}/suc/mobilescene!saveSlideRoll.action', submitData,
					function(json) {
						if (json.state == 0) {
							// window.location.reload();
						}
					}, "json")

		}
		//预览
		function preview() {
			saveLayer();
			qrcode('http://www.wbaishui.com/Acc_Manage/suc/mobilescene!index.action?custid=${entity.custid}&msid=${msid}');
		}
		//保存
		function saveData() {
			save_slide_roll();
			saveLayer();
			jQuery.gritter.add({
				title : '操作提示',
				text : '保存数据成功',
				class_name : 'growl-success',
				image : '${ctx}/css_js/images/screen.png',
				sticky : false,
				time : ''
			});

		}
		//保存刷新
		function saveDataFresh() {
			save_slide_roll();
			saveLayer();
			jQuery.gritter.add({
				title : '操作提示',
				text : '保存数据成功',
				class_name : 'growl-success',
				image : '${ctx}/css_js/images/screen.png',
				sticky : false,
				time : ''
			});
			window.location.reload();

		}
		//删除层
		function delScene(id) {
			var submitData = {
				id : id,
				msid : '${msid}'
			}
			$.post('${ctx}/suc/mobilescene!delScene.action', submitData,
					function(json) {
						if (json.state == 0) {

						}
						get_layer();
					}, "json")
		}
		//删除
		function delSpirit(id) {
			var submitData = {
				id : id,
				scid : layerid,
				custid : '${entity.custid}'
			}
			$.post('${ctx}/suc/mobilescene!deleteSpirit.action', submitData,
					function(json) {
						if (json.state == 0) {

						}
						get_elve();
						init_layer(layerid);
					}, "json")
		}
		//获取全部动画
		function getAnimas(){
			var submitData = {
					id : id,
					scid : layerid,
					custid : '${entity.custid}'
				}
				$.post('${ctx}/suc/mobilescene!deleteSpirit.action', submitData,
						function(json) {
							if (json.state == 0) {

							}
							get_elve();
							init_layer(layerid);
						}, "json")
		}
		//删除动画
		function delAnimas(){
			var submitData = {
					id : id,
					scid : layerid,
					custid : '${entity.custid}'
				}
				$.post('${ctx}/suc/mobilescene!deleteSpirit.action', submitData,
						function(json) {
							if (json.state == 0) {

							}
							get_elve();
							init_layer(layerid);
						}, "json")
		}
		//保存动画
		function addAnimas(){
			
		}
		//修改动画
		function updAnimas(){
			var submitData = {
					id : id,
					scid : layerid,
					custid : '${entity.custid}'
				}
				$.post('${ctx}/suc/mobilescene!deleteSpirit.action', submitData,
						function(json) {
							if (json.state == 0) {

							}
							get_elve();
							init_layer(layerid);
						}, "json")
		}
		//创建动画
		function createAnimas(){
			var submitData = {
					id : id,
					scid : layerid,
					custid : '${entity.custid}'
				}
				$.post('${ctx}/suc/mobilescene!deleteSpirit.action', submitData,
						function(json) {
							if (json.state == 0) {

							}
							get_elve();
							init_layer(layerid);
						}, "json")
		}
		
		//加载右键菜单
		function initContext() {
			context.init({
				preventDoubleContext : false
			});
			context
					.attach(
							'.elves',
							[
									{
										header : ''
									},
									{
										text : '上移',
										href : '#',
										action : function(e) {
											e.preventDefault();
											var url = context.target.id;
											if (parseInt($('#' + url).css(
													'z-index')) <= 1000) {
												$('#' + url)
														.css(
																'z-index',
																parseInt($(
																		'#'
																				+ url)
																		.css(
																				'z-index')) + 1);
												$('#' + url).attr(
														'z_index',
														$('#' + url).css(
																'z-index'));
											} else {
												//当前精灵为最顶层，其他精灵全部下移;
												$('.elves')
														.each(
																function(e) {
																	if (parseInt($(
																			this)
																			.css(
																					'z-index')) >= 2) {
																		$(this)
																				.css(
																						'z-index',
																						parseInt($(
																								this)
																								.css(
																										'z-index')) - 1);
																		$(this)
																				.attr(
																						'z_index',
																						$(
																								this)
																								.css(
																										'z-index'));
																	}
																});
												$('#' + url).css('z-index',
														1000);
												$('#' + url).attr(
														'z_index',
														$('#' + url).css(
																'z-index'))

											}

										},

									},
									{
										text : '下移',
										href : '#',
										action : function(e) {
											e.preventDefault();
											var url = context.target.id;
											var index = $('#' + url).css(
													'z-index');
											if (parseInt(index) >= 2) {
												$('#' + url).css('z-index',
														parseInt(index) - 1);
												$('#' + url).attr(
														'z_index',
														$('#' + url).css(
																'z-index'))
											} else {
												//当前精灵为最底层，其他精灵全部上移;
												$('.elves')
														.each(
																function(e) {
																	if (parseInt($(
																			this)
																			.css(
																					'z-index')) <= 1000) {
																		$(this)
																				.css(
																						'z-index',
																						parseInt($(
																								this)
																								.css(
																										'z-index')) + 1);
																		$(this)
																				.attr(
																						'z_index',
																						$(
																								this)
																								.css(
																										'z-index'));
																	}

																});
												$('#' + url).css('z-index', 1);
												$('#' + url).attr(
														'z_index',
														$('#' + url).css(
																'z-index'))

											}

										},

									},
									{
										text : '置顶',
										href : '#',
										action : function(e) {
											e.preventDefault();
											var url = context.target.id;
											//当前精灵为最顶层，其他精灵全部下移;
											$('.elves')
													.each(
															function(e) {
																if (parseInt($(
																		this)
																		.css(
																				'z-index')) >= 2) {
																	$(this)
																			.css(
																					'z-index',
																					parseInt($(
																							this)
																							.css(
																									'z-index')) - 1);
																	$(this)
																			.attr(
																					'z_index',
																					$(
																							this)
																							.css(
																									'z-index'));
																}
															});
											$('#' + url).css('z-index', 1000);
											$('#' + url)
													.attr(
															'z_index',
															$('#' + url).css(
																	'z-index'))
										},

									},
									{
										text : '置底',
										href : '#',
										action : function(e) {
											e.preventDefault();
											var url = context.target.id;
											//当前精灵为最底层，其他精灵全部上移;
											$('.elves')
													.each(
															function(e) {
																if (parseInt($(
																		this)
																		.css(
																				'z-index')) <= 1000) {
																	$(this)
																			.css(
																					'z-index',
																					parseInt($(
																							this)
																							.css(
																									'z-index')) + 1);
																	$(this)
																			.attr(
																					'z_index',
																					$(
																							this)
																							.css(
																									'z-index'));
																}

															});
											$('#' + url).css('z-index', 1);
											$('#' + url)
													.attr(
															'z_index',
															$('#' + url).css(
																	'z-index'))

										},

									} ]);
		}

		//加载右键菜单
		function initContext2() {
			context.init({
				preventDoubleContext : false
			});
			context
					.attach(
							'.elves_context',
							[
									{
										header : ''
									},
									{
										text : '上移',
										href : '#',
										action : function(e) {
											e.preventDefault();
											var url = "elve_"
													+ context.target.id;
											if (parseInt($('#' + url).css(
													'z-index')) <= 1000) {
												$('#' + url)
														.css(
																'z-index',
																parseInt($(
																		'#'
																				+ url)
																		.css(
																				'z-index')) + 1);
												$('#' + url).attr(
														'z_index',
														$('#' + url).css(
																'z-index'));
											} else {
												//当前精灵为最顶层，其他精灵全部下移;
												$('.elves')
														.each(
																function(e) {
																	if (parseInt($(
																			this)
																			.css(
																					'z-index')) >= 2) {
																		$(this)
																				.css(
																						'z-index',
																						parseInt($(
																								this)
																								.css(
																										'z-index')) - 1);
																		$(this)
																				.attr(
																						'z_index',
																						$(
																								this)
																								.css(
																										'z-index'));
																	}
																});
												$('#' + url).css('z-index',
														1000);
												$('#' + url).attr(
														'z_index',
														$('#' + url).css(
																'z-index'))

											}

										},

									},
									{
										text : '下移',
										href : '#',
										action : function(e) {
											e.preventDefault();
											var url = "elve_"
													+ context.target.id;
											var index = $('#' + url).css(
													'z-index');
											if (parseInt(index) >= 2) {
												$('#' + url).css('z-index',
														parseInt(index) - 1);
												$('#' + url).attr(
														'z_index',
														$('#' + url).css(
																'z-index'))
											} else {
												//当前精灵为最底层，其他精灵全部上移;
												$('.elves')
														.each(
																function(e) {
																	if (parseInt($(
																			this)
																			.css(
																					'z-index')) <= 1000) {
																		$(this)
																				.css(
																						'z-index',
																						parseInt($(
																								this)
																								.css(
																										'z-index')) + 1);
																		$(this)
																				.attr(
																						'z_index',
																						$(
																								this)
																								.css(
																										'z-index'));
																	}

																});
												$('#' + url).css('z-index', 1);
												$('#' + url).attr(
														'z_index',
														$('#' + url).css(
																'z-index'))

											}

										},

									},
									{
										text : '置顶',
										href : '#',
										action : function(e) {
											e.preventDefault();
											var url = "elve_"
													+ context.target.id;
											//当前精灵为最顶层，其他精灵全部下移;
											$('.elves')
													.each(
															function(e) {
																if (parseInt($(
																		this)
																		.css(
																				'z-index')) >= 2) {
																	$(this)
																			.css(
																					'z-index',
																					parseInt($(
																							this)
																							.css(
																									'z-index')) - 1);
																	$(this)
																			.attr(
																					'z_index',
																					$(
																							this)
																							.css(
																									'z-index'));
																}
															});
											$('#' + url).css('z-index', 1000);
											$('#' + url)
													.attr(
															'z_index',
															$('#' + url).css(
																	'z-index'))
										},

									},
									{
										text : '置底',
										href : '#',
										action : function(e) {
											e.preventDefault();
											var url = "elve_"
													+ context.target.id;
											//当前精灵为最底层，其他精灵全部上移;
											$('.elves')
													.each(
															function(e) {
																if (parseInt($(
																		this)
																		.css(
																				'z-index')) <= 1000) {
																	$(this)
																			.css(
																					'z-index',
																					parseInt($(
																							this)
																							.css(
																									'z-index')) + 1);
																	$(this)
																			.attr(
																					'z_index',
																					$(
																							this)
																							.css(
																									'z-index'));
																}

															});
											$('#' + url).css('z-index', 1);
											$('#' + url)
													.attr(
															'z_index',
															$('#' + url).css(
																	'z-index'))

										},

									} ]);
		}
		//初始化数据
		function initData() {
			var scid = '${scid}';
			if (scid != '') {
				init_layer(scid);
			}
		}
		initData();
		
		
		
	</script>
	<%@include file="/com/img2.jsp"%>
	<%@include file="/com/preview1.jsp"%>

</body>
</html>

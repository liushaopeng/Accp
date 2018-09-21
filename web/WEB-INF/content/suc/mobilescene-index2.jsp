
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/com/libs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${entity.title }</title>
<meta name="author" content="Alvaro Trigo Lopez" />
<meta name="description"
	content="fullPage full-screen sliders navigation widh dots." />
<meta name="keywords"
	content="fullpage,jquery,demo,screen,fullscreen,sliders navigation, horizontal navigation,horizontal,navigation,dots" />
<meta name="Resource-type" content="Document" />
<meta
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<link rel="stylesheet" type="text/css"
	href="${ctx }/scene/css/examples.css" />
<link rel="stylesheet" type="text/css"
	href="${ctx }/scene/css/jquery.fullPage.css" />
<link rel="stylesheet" type="text/css"
	href="${ctx}/css_js/css/font-awesome.min.css" />
<script src="${ctx}/scene/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${ctx }/scene/js/jquery.fullPage.js"></script>
<link href="${ctx}/animo/animate-animo.css" rel="stylesheet" />
<script type="text/javascript" src="${ctx}/animo/animo.js"></script>
<script type="text/javascript" src="${ctx }/html/js/bbsSwipe.js"></script>
<script type="text/javascript" src="${ctx }/html/js/swipe.js"></script>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript" src="${ctx}/transformjs/transform.js"></script>
<script type="text/javascript" src="${ctx}/transformjs/asset/tick.js"></script>
<script type="text/javascript" src="${ctx}/transformjs/asset/to.js"></script>
<script type="text/javascript" src="${ctx}/transformjs/alloy_touch.js"></script>
<script type="text/javascript"
	src="${ctx}/transformjs/asset/alloy_flow.js"></script>
<script type="text/javascript"
	src="${ctx}/transformjs/alloy_touch.full_page.js"></script>
<script type="text/javascript"
	src="${ctx}/transformjs/asset/progress_bar.js"></script>

<style>
html, body {
	margin: 0;
	padding: 0;
	text-align: center;
	overflow: hidden;
	width: 100%;
	height: 100%;
}

* {
	box-sizing: border-box;
}

.section {
	width: 100%;
	font-size: 24px;
	overflow: hidden;
	position: relative;
}

.section .title {
	line-height: 100px;
	font-size: 24px;
}

#fullpage {
	visibility: hidden;
}

.site__header {
	/*-webkit-animation: bounceInUp 1s;*/
	
}

.powered {
	font-size: 20px;
	color: #454545;
	margin-top: 20px;
}

.section-main {
	position: absolute;
	max-top: 50%;
	margin-top: -150px;
	width: 100%;
	text-align: center;;
}

a {
	text-decoration: none;
}

#demo0 {
	width: 160px;
	overflow: hidden;
	border: 1px solid rgb(204, 204, 204);
	text-indent: 10px;
	margin: 0 auto;
}

#demo0 ul {
	list-style: none;
	padding: 0;
	margin: 0;
	width: 100%;
	text-align: left;
}

#demo0 li {
	padding: 0 10px;
	height: 40px;
	line-height: 40px;
	border-bottom: 1px solid #ccc;
	border-top: 1px solid #fff;
	background-color: #fafafa;
	font-size: 14px;
}

#demo1 {
	height: 210px;
	width: 220px;
	margin: 0 auto;
	text-align: center;
}
</style>
<style>
* {
	box-sizing: border-box;
}

.progress {
	width: 100%;
	font-size: 0px;
	white-space: nowrap;
	position: fixed;
	bottom: 0px;
	height: 4px;
	background-color: #CCCCCC;
}

.progress-items {
	width: 100%;
	z-index: 2;
	height: 4px;
	position: absolute;
}

.progress-rate {
	width: 0%;
	z-index: 1;
	position: absolute;
	height: 4px;
	background-color: #00ABEB;
	transition: all .5s ease;
}
</style>
<script type="text/javascript"> 
//获取窗口宽度

var winWidth;
var winHeight; 
//通过深入 Document 内部对 body 进行检测，获取窗口大小
if (document.documentElement && document.documentElement.clientHeight && document.documentElement.clientWidth)
{
winHeight = document.documentElement.clientHeight;
winWidth = document.documentElement.clientWidth;
} 
console.log(winWidth);
console.log(winHeight);
</script>
</head>
<body>
	<c:if test="${not empty slide}">
		<div id="banner_box" class="box_swipe overflow-hidden "
			style="width:100%;position: absolute;z-index: 999;margin-top:${slidestyle.margintop};">
			<ul>
				<c:forEach items="${slide}" var="bean">
					<li><a href="${bean.url}"> <img
							src="${filehttp}/${bean.picurl}" alt="1"
							style="width:100%;height:${slidestyle.height}" />
					</a></li>
				</c:forEach>
			</ul>

		</div>
		<script>
			$(function() {
				new Swipe(document.getElementById('banner_box'), {
					speed : 500,
					auto : 3000,
					callback : function() {
						var lis = $(this.element).next("ol").children();
						lis.removeClass("on").eq(this.index).addClass("on");
					}
				});
			});
		</script>
	</c:if>
	<c:if test="${not empty  roll}">
		<div class="overflow-hidden"
			style="position: absolute;margin-top:${rollstyle.margintop};height:37px;line-height:37px;z-index: 999;background-color: white;">
			<%@ include file="/com/roll.jsp"%>

		</div>
	</c:if>

	<div id="fullpage" class="site__header">


		<c:if test="${not empty scenelist}">
			<c:forEach items="${scenelist}" var="bean">
				<div class="section"
					style="background-image:url(${filehttp}/${bean.picurl});background-size:100% auto;background-color:${bean.backgroundcolor}">

					<c:forEach items="${bean.spritlist}" var="beanchild">
						<a href="${beanchild.url}">

							<div
								style="position:absolute;left:${beanchild.style.marginleft};top:${beanchild.style.margintop}; background-color:${beanchild.style.backgroundcolor};width:${beanchild.style.width};height:${beanchild.style.height};
              border-radius:${beanchild.style.radius};
              background-image:url(${filehttp}/${beanchild.picurl}); background-size:100% auto"
								animo_value="${beanchild.anima.value}"
								animo_time="${beanchild.anima.duration}"
								animo_iterate="${beanchild.anima.iterate}"
								animo_duration="${beanchild.anima.duration}"
								animo_keep="${beanchild.anima.keep}" id="${beanchild.anima._id}"
								style_margin_top="${beanchild.style.margintop};"><div style="position: absolute;top: 103%;font-size: 16px;width: 100%;text-align: center;color:${beanchild.title_color} ">${beanchild.title}</div></div>
								

						</a>

					</c:forEach>
				</div>
			</c:forEach>

		</c:if>

	</div>


	<div id="progress" class="progress">
		<div class="progress-rate"></div>
		<div class="progress-items"></div>

	</div>

<script type="text/javascript">
var obj = {};
var globalID;
var ybobj = null;
		function animation(v, g, t) {
			var element = $(v)[0];
			Transform(element);
			//旋转
			if (g == "spinner") {
				tick(function() {
					if (t > 0) {
						element.rotateZ = element.rotateZ + parseInt(t);
					} else {
						element.rotateZ++;
					}
				});

			}
			//上下翻转
			if (g == "flipOutX") {
				tick(function() {
					if (t > 0) {
						element.rotateX = element.rotateX + parseInt(t);
					} else {
						element.rotateX++;
					}
				});

			}
			//左右翻转
			if (g == "flipOutY") {
				tick(function() {
					if (t > 0) {
						element.rotateY = element.rotateY + parseInt(t);
					} else {
						element.rotateY++;
					}
				});

			}
			//左飞入
			if (g == "fadeInLeft") {
				var qs = element.translateX;
				element.translateX = -300;
				tick(function() {
					if (t > 0 && element.translateX < qs) {
						element.translateX = element.translateX + parseInt(t);
					} else if (element.translateX < qs) {
						element.translateX++;
					}

				});
			}
			//右飞入
			if (g == "fadeInRight") {
				var qs = element.translateX;
				element.translateX = 300;
				tick(function() {
					if (t > 0 && element.translateX > qs) {
						element.translateX = element.translateX - parseInt(t);
					} else if (element.translateX > qs) {
						element.translateX--;
					}

				});
			}
			//上飞入
			if (g == "fadeInUp") {
				var qs = element.translateY;
				element.translateY = -600;
				tick(function() {
					if (g > 0 && element.translateY < qs) {
						element.translateY = element.translateY + parseInt(t);
					} else if (element.translateY < qs) {
						element.translateY++;
					}

				});
			}
			//下飞入
			if (g == "fadeInDown") {
				var qs = element.translateY;
				element.translateY = 600;
				tick(function() {
					if (t > 0 && element.translateY > qs) {
						element.translateY = element.translateY - parseInt(t);
					} else if (element.translateY > qs) {
						element.translateY--;
					}

				});
			}
			//放大
			if (g == "fadeBig") {
				var qs = element.translateZ;
				element.translateZ = -300;
				tick(function() {
					if (t > 0 && element.translateZ < qs) {
						element.translateZ = element.translateZ + parseInt(t);
					} else if (element.translateZ < qs) {
						element.translateZ++;
					}

				});
			}
			//缩小
			if (g == "fadeSmall") {
				var qs = element.translateZ;
				element.translateZ = 300;
				tick(function() {
					if (t > 0 && element.translateZ > qs) {
						element.translateZ = element.translateZ - parseInt(t);
					} else if (element.translateZ > qs) {
						element.translateZ--;
					}

				});
			}
			//左右摇摆
			if (g == "swing") {
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

			if (g == "left_right") {
				var step = 0.02, xStep = 3, skewStep = 1;
				animateX();
			}
			if (g == "up_down") {
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
		
	</script>
	<script>
		var pb;
		var fp = new AlloyTouch.FullPage("#fullpage", {
			animationEnd : function() { 
				 
			},
			leavePage : function(index) {
			
				console.log("leave" + index)
			},
			beginToPage : function(index) {
				console.log("to" + index);
				pb.to(index / (this.length - 1));
				
				tickArr.splice(0);
				To.stopAll();
				To.List.splice(0); 
				if (ybobj != null) {
					ybobj.stop();

				}
				<c:forEach items="${animalist}" var="list">
				var id = '${list}';
				animation('#' + id, $('#' + id).attr('animo_value'), $('#' + id).attr(
						'animo_duration'));
				</c:forEach>
			}
		});
		pb = new ProgressBar("#progress", fp.length - 1)
		
		<c:forEach items="${animalist}" var="list">
		var id = '${list}';
		animation('#' + id, $('#' + id).attr('animo_value'), $('#' + id).attr(
				'animo_duration'));
		</c:forEach>
	</script>
		<c:if test="${not empty entity.music_url}">
		<!--献花button与音乐button-->
		<div class="position-f cmp640"
			style="top: 0px; left: 0px; z-index: 1111;position: fixed;">
			<!--音乐播放器-->
			<a href="javascript:bf();" class="mscBtn" id="audioBtn"
				style="cursor: pointer;">
				<div id="bfid"
					style="margin-left:${mp3.marginleft}%;margin-top:${mp3.margintop}%;color:${entity.music_color}">
					<span class="fa-stack fa-lg"> <i
						class="fa fa-circle-o fa-stack-2x fa-spin"></i> <i
						class="fa fa-music fa-stack-1x fa-spin pr-5"></i>
					</span>
				</div>
			</a>
		</div>

		<!--评论button3 自适应-->

		</div>

		<audio id="bgMusic" src="${entity.music_url}" autoplay="autoplay"></audio>

		<!--音乐播放js-->
		<script>
			var music = document.getElementById("bgMusic");
			$("#audioBtn").click(function() {
				if (music.paused) {
					music.play();
					$("#audioBtn").removeClass("pause").addClass("play");
				} else {
					music.pause();
					$("#audioBtn").removeClass("play").addClass("pause");
				}
			});
		</script>
	</c:if>
	<script>
		var isplay = false;
		function bf() {
			if (!isplay) {
				$("#bfid span i").removeClass("fa-spin");
				isplay = true;
			} else {
				$("#bfid span i").addClass("fa-spin");
				isplay = false;
			}
		}
	</script>
	<!--结束-->


	<script type="text/javascript">
		var bgheight = document.body.clientHeight;
	</script>
	<script type="text/javascript">
		
	</script>
	${scenelist }
	<script>
		wx.config({
			debug : false,
			appId : '${token.appid}',
			timestamp : '${token.timestamp}',
			nonceStr : '${token.noncestr}',
			signature : '${token.signature}',
			jsApiList : [ 'checkJsApi', 'onMenuShareTimeline',
					'onMenuShareAppMessage', 'onMenuShareQQ',
					'onMenuShareWeibo', 'hideMenuItems', 'showMenuItems' ]
		});
		wx.ready(function() {
			var share = {
				title : '${entity.title}', // 分享标题
				desc : '${entity.summary}', // 分享描述
				link : window.location.href, // 分享链接
				imgUrl : '${filehttp}${entity.logo}', // 分享图标
				success : function() {
					check_task();
				},
				cancel : function() {
				}
			};
			wx.onMenuShareAppMessage(share);
			wx.onMenuShareTimeline(share);
			wx.onMenuShareAppMessage(share);
			wx.onMenuShareQQ(share);
			wx.onMenuShareWeibo(share);
		});
	</script>

</body>
</html>

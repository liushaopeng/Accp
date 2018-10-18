
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/com/libs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${entity.title }</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
<meta
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport" id="viewport">
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
<script>
var winWidth;
var winHeight; 
function e() {
			return /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini|Mobi/i.test(navigator.userAgent) || window.innerWidth < 500
		}

		function i() { 
			var e = 1,
				i = document.documentElement.clientWidth || 320,
				n = document.documentElement.clientHeight || 486;
			winWidth=i;
			winHeight=n; 
			e = i / n >= 320 / 486 ?n/ 486:i / 320 ; 
			var o = "width=320, initial-scale=" + e + ", maximum-scale=" + e + ", user-scalable=no";     
			document.querySelector("meta[name=viewport]").setAttribute("content", o); 
		}
if(e()){
	i();	
}		

</script>
<style>
html, body {
	margin: 0;
	padding: 0;
	text-align: center;
	overflow: hidden;
	width: 100%;
	height: 100%;
	font-family: Microsoft YaHei,Helvetica Neue,Helvetica,Arial,sans-serif;
    line-height: 1.231;
    -webkit-touch-callout: none;
    display: -webkit-box;
    -webkit-box-orient: vertical;
    -webkit-box-align: stretch;
    position: fixed;
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
	width: 100%;
	height: 100%;
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
.edit_area{  
    text-align: left;
    width: 320px;
    height:486px;
    background-repeat: no-repeat;
    background-size: 100% 100%;
    position: absolute;
}
</style> 
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
			style="position: absolute;margin-top:${rollstyle.margintop};height:37px;line-height:37px;z-index: 999;background-color:${rollstyle.backgroundcolor}">
			<%@ include file="/com/roll.jsp"%>

		</div>
	</c:if>

	<div id="fullpage" class="site__header">
 
	</div>


	<div id="progress" class="progress">
		<div class="progress-rate"></div>
		<div class="progress-items"></div>

	</div>
<script type="text/javascript">
function  init() {
	var submitData = {
		msid :'${msid}',
		custid:'${custid}'
	};
	$.post('${ctx}/suc/mobilescene!getIndexData.action', submitData,
			function(json) {
				if (json.state == 0) {
					
					/**var winWidth;
					var winHeight; 
					//通过深入 Document 内部对 body 进行检测，获取窗口大小
					if (document.documentElement && document.documentElement.clientHeight && document.documentElement.clientWidth)
					{
					winHeight = document.documentElement.clientHeight;
					winWidth = document.documentElement.clientWidth;
					}  */
					
					var list=json.list;
					var html='';
					for(var i=0;i<list.length;i++){
						html+='<div class="section"  style="background-image:url(${filehttp}/'+list[i].picurl+');background-size:100% 100%;background-color:'+list[i].backgroundcolor+';width:100%;height:100%;"><div><ul class="edit_area">';
						
						var spritlist=list[i].spritlist;
						for(var j=0;j<spritlist.length;j++){
							var left=spritlist[j].style.marginleft.replace("px","");
							var top=spritlist[j].style.margintop.replace("px","");
							var width=spritlist[j].style.width.replace("px","");
							var height=spritlist[j].style.height.replace("px","");

							//left=parseFloat(spritlist[j].style.marginleft.replace("px",""))*(winWidth/375);
							//top=parseFloat(spritlist[j].style.margintop.replace("px",""))*(winHeight/667);
							//var width=parseFloat(spritlist[j].style.width.replace("px",""))*(winWidth/375);
							//height=parseFloat(spritlist[j].style.height.replace("px",""))*(winHeight/667);
							if((375/667)<(winWidth/winHeight)){ 
								//按比例纠正宽度
								//width=height*(parseFloat(spritlist[j].style.width.replace("px",""))/parseFloat(spritlist[j].style.height.replace("px","")));
							}else{
								//按比例纠正高度
								//height=width*(parseFloat(spritlist[j].style.height.replace("px",""))/parseFloat(spritlist[j].style.width.replace("px","")));
							} 
							if(spritlist[j].url!=null){
								html+='<a href="'+spritlist[j].url+'"><li'
							    +' style="position:absolute;left:'+left+'px;top:'+top+'px; background-color:'+spritlist[j].style.backgroundcolor+';width:'+width+'px;height:'+height+'px;'
							    +'border-radius:'+spritlist[j].style.radius+';'
							    +'background-image:url(${filehttp}/'+spritlist[j].picurl+'); background-size:100% auto;z-index:'+spritlist[j].style.z_index+'"'
							    +'animo_value="'+spritlist[j].anima.value+'"'
							    +'animo_time="'+spritlist[j].anima.duration+'"'
							    +'animo_iterate="'+spritlist[j].anima.iterate+'"'
							    +'animo_duration="'+spritlist[j].anima.duration+'"'
							    +'animo_keep="'+spritlist[j].anima.keep+'" id="'+spritlist[j].anima._id+'"'
							    +'style_margin_top="'+spritlist[j].style.margintop+';"><div style="position: absolute;bottom: -20px;font-size: 16px;width: 100%;text-align: center;color:'+spritlist[j].title_color+'">'+spritlist[j].title+'</div></li>'
							    +'</a>'; 
							}else{
								html+='<li'
							    +' style="position:absolute;left:'+left+'px;top:'+top+'px; background-color:'+spritlist[j].style.backgroundcolor+';width:'+width+'px;height:'+height+'px;'
							    +'border-radius:'+spritlist[j].style.radius+';'
							    +'background-image:url(${filehttp}/'+spritlist[j].picurl+'); background-size:100% auto;z-index:'+spritlist[j].style.z_index+'"'
							    +'animo_value="'+spritlist[j].anima.value+'"'
							    +'animo_time="'+spritlist[j].anima.duration+'"'
							    +'animo_iterate="'+spritlist[j].anima.iterate+'"'
							    +'animo_duration="'+spritlist[j].anima.duration+'"'
							    +'animo_keep="'+spritlist[j].anima.keep+'" id="'+spritlist[j].anima._id+'"'
							    +'style_margin_top="'+spritlist[j].style.margintop+';"><div style="position: absolute;bottom: -20px;font-size: 16px;width: 100%;text-align: center;color:'+spritlist[j].title_color+'">'+spritlist[j].title+'</div></li>';
							}
							
						}
						html+='</ul></div></div>';     
					} 
					$('#fullpage').html(html);
					change();
					
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
					 
				} 
			}, "json")

}
init();
//计算偏移
function  change(){ 
    if(winWidth/ winHeight >=320/486){
    	//上下偏移  
    	$('.edit_area').css('margin-left',(document.documentElement.clientWidth-320)/2+'px'); 
    	//n-486*e
    }else{
    	//左右偏移 
    	$('.edit_area').css('margin-top',(document.documentElement.clientHeight-486)/2+'px');
    }
}
</script>
<script type="text/javascript">
var obj = {};
var globalID;
var ybobj = null;
		function animation(v, g, t) {
			t=t*0.1;
			console.log(g);
			console.log(t);
			var element = $(v)[0];
			Transform(element);
			//旋转
			if (g == "spinner") {
				tick(function() {
					if (t > 0) {
						element.rotateZ = element.rotateZ + parseFloat(t);
					} else {
						element.rotateZ = element.rotateZ +0.1;
					}
				});

			}
			//上下翻转
			if (g == "flipOutX") {
				tick(function() {
					if (t > 0) {
						element.rotateX = element.rotateX + parseFloat(t);
					} else {
						element.rotateX = element.rotateX + 0.1;
					}
				});

			}
			//左右翻转
			if (g == "flipOutY") {
				tick(function() {
					if (t > 0) {
						element.rotateY = element.rotateY + parseFloat(t);
					} else {
						element.rotateY = element.rotateY +0.1;
					}
				});

			}
			//左飞入
			if (g == "fadeInLeft") {
				var qs = element.translateX;
				element.translateX = -300;
				tick(function() {
					if (t > 0 && element.translateX < qs) {
						element.translateX = element.translateX + parseFloat(t);
					} else if (element.translateX < qs) {
						element.translateX = element.translateX +0.1;
					}

				});
			}
			//右飞入
			if (g == "fadeInRight") {
				var qs = element.translateX;
				element.translateX = 300;
				tick(function() {
					if (t > 0 && element.translateX > qs) {
						element.translateX = element.translateX - parseFloat(t);
					} else if (element.translateX > qs) {
						element.translateX = element.translateX -0.1;
					}

				});
			}
			//上飞入
			if (g == "fadeInUp") {
				var qs = element.translateY;
				element.translateY = -600;
				tick(function() {
					if (g > 0 && element.translateY < qs) {
						element.translateY = element.translateY + parseFloat(t);
					} else if (element.translateY < qs) {
						element.translateY = element.translateY +0.1;
					}

				});
			}
			//下飞入
			if (g == "fadeInDown") {
				var qs = element.translateY;
				element.translateY = 600;
				tick(function() {
					if (t > 0 && element.translateY > qs) {
						element.translateY = element.translateY - parseFloat(t);
					} else if (element.translateY > qs) {
						element.translateY = element.translateY - 0.1;
					}

				});
			}
			//放大
			if (g == "fadeBig") {
				var qs = element.translateZ;
				element.translateZ = -300;
				tick(function() {
					if (t > 0 && element.translateZ < qs) {
						element.translateZ = element.translateZ + parseFloat(t);
					} else if (element.translateZ < qs) {
						element.translateZ = element.translateZ +0.1;
					}

				});
			}
			//缩小
			if (g == "fadeSmall") {
				var qs = element.translateZ;
				element.translateZ = 300;
				tick(function() {
					if (t > 0 && element.translateZ > qs) {
						element.translateZ = element.translateZ - parseFloat(t);
					} else if (element.translateZ > qs) {
						element.translateZ = element.translateZ -0.1;
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
				imgUrl : '${filehttp}${entity.picurl}', // 分享图标
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

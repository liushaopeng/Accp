<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/com/libs.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>小票</title>
		<style>
		   body{
		   	background:beige ; 
		   }
			.main{ 
				padding-top:10px; 
				background:#ffffff ; 
				width: 280px;
			}
			.name{ 
				font-size:14px ;
				font-weight: bold;
				font-family:arial, "Microsoft Yahei", Simsun, sans-serif; 
				text-align: center; 
				
			}
			.partment{
				font-size:12px ;
				font-weight: 400;
				height:20px ;
				border-bottom:1px black dashed ;
				margin-bottom:5px ; 
				padding-right: 10px; 
				width: 280px;
				
			}
			.tai-name{
				font-size:12px ;
				height:23px ;
				font-weight: 400;
				border-bottom:1px black dashed ; 
				width: 280px;
			}
			.info{
			    font-size:12px ;
				border-bottom:1px black dashed ; 
				width: 280px;
			}
			.customer{
				border-bottom:1px black dashed ;
				width: 280px; 
			}
			.footer{
				font-size:12px ; 
				width: 280px; 
			}
		</style> 
    <script type="text/javascript">
	function doPrint(how) {

		//打印文档对象9
		var myDoc = {
			settings : { 
				leftMargin:100, 
				paperWidth:480,
				topMargin:0, 
			},
			marginIgnored : true,
			documents : document,
			copyrights : '杰创软件拥有版权  www.jatools.com'
		};
		var jatoolsPrinter =navigator.userAgent.indexOf('MSIE') > -1 ? document.getElementById('ojatoolsPrinter'): document.getElementById('ejatoolsPrinter'); 
		if(typeof(jatoolsPrinter)=='undefined'){ 
			window.location.href='${ctx}/css_js/setup.exe';
			return;
		}  
		// 调用打印方法
		 if(how=='打印预览')
		        jatoolsPrinter.printPreview(myDoc);
		    else
		        jatoolsPrinter.print(myDoc,false);
	}
</script>
	</head>
	<body>
		<div class="main"> 
		    
		    <c:forEach items="${list}" var="bean" varStatus="status">
		    <div style="margin-bottom: 2px;width: 400px;"  id="page${status.index+1}"> 
		     <div class="name">  
		    	<p style="font-size:18px ;margin-top:0px ;font-weight: 700;">结账单</p>
		     </div>
		     <div class="partment">单号:${bean._id}</div>
		     <div class="tai-name">座位：<font style="font-size:18px ;">${bean.ramadhin}</font></div>
		     <div class="info">
		    	<p>品名 &nbsp;&nbsp;&nbsp;数量&nbsp;&nbsp;&nbsp;&nbsp;单价  &nbsp;&nbsp;金额</p>
		    	<c:forEach items="${bean.lsRecords}" var="itm">
		    	<p>${itm.title}&nbsp;&nbsp;${itm.count}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${itm.price}&nbsp;&nbsp;${itm.total}</p>
		    	</c:forEach> 
		     </div>
		     <div class="customer">
		    	<p><font style="font-size:12px ;font-weight: bold;">消费:${bean.total}</font><font style="font-size:12px ;font-weight: bold;">&nbsp;&nbsp;实收:</font><font style="font-size:12px ;font-weight: bold;">${bean.paidin}</font></p> 
		    	<p style="font-size:12px ;font-weight: bold;line-height:2px  ;">付款方式：
		    	<c:if test="${bean.paytype==0}">现金</c:if><c:if test="${bean.paytype==1}">刷卡</c:if><c:if test="${bean.paytype==2}">微信</c:if><c:if test="${bean.paytype==3}">支付宝</c:if>
		    	<c:if test="${bean.paytype==4}">其他</c:if></p> 
		    	<div style="margin-left:77px ;margin-bottom:5px; margin-top:5px ;">签字________</div>
		    </div>
		    <div class="footer"> 
		    	结账时间：<fmt:formatDate pattern='yyyy-MM-dd HH:mm' value='${bean.createdate}'/>
		     </div>
		    </div>   
		    </c:forEach>
		    
		     <!-- 插入打印控件 -->
	        <object id="ojatoolsPrinter" codebase="${ctx}/css_js/jatoolsPrinter.cab#version=5,4,0,0" classid="clsid:B43D3361-D075-4BE2-87FE-057188254255" width="0" height="0">
            <embed id="ejatoolsPrinter" type="application/x-vnd.jatoolsPrinter" width="0" height="0"></embed>
            </object>
              
		</div>
		<div style="padding-left: 40px; padding-right: 40px;">
              <button style="width: 80px" onClick="doPrint('打印预览')">打印预览
              </button>
        </div>  
	</body>
</html>

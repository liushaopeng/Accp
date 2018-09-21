<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/com/libs.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en"> 
<script src="${ctx}/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<head> 
    <%@include file="/com/js_css.jsp" %> 
   
 <script type="text/javascript">
  var state='${state}'; 
  function pot(){ 
	  var submitData = {
			  state:'${state}'
          };
          $.post('${ctx}/acc/acc!ajaxStatistics.action', submitData,
                  function (json) {  
        	        Plot_init(json.Datalist1,json.Datalist2);
                  }, "json")
          
  }
  
  function che(){
	  var id=$('#state').val();
	  window.location.href='${ctx}/acc/acc!statistics.action?state='+id;
  }
 </script>  
</head>
<body>
<section>
    <%@include file="/com/header.jsp" %>
    <div class="mainpanel">
        <%@include file="/com/headerbar.jsp" %> 
            <div class="pageheader" style="font-size: 16px"> 
                    <i class="fa fa-user"></i>后台管理 <span style="font-size: 12px"><i class="fa fa-angle-double-right" style="font-size: 16px;margin:0;padding: 0"></i>账单管理</span> 
            </div>
          
      <div class="panel-body">
        <div class="row">
        <div class="col-sm-12">
          <div class="panel panel-default">
            <div class="panel-body">
              <div class="row">
                <div class="col-sm-8">
                  <h5 class="subtitle mb5" style="margin-bottom: 15px">
                  <div class="form-group col-sm-2"> 
                    
                    <div style="width: 60px;height: 20px;background-color: #efea7e;margin-bottom: 5px;border-radius: 2px;text-align: center;line-height: 20px;cursor:pointer" onclick="window.location.href='${ctx}/acc/acc!statistics.action?state=0'">日统计</div>
                    <div style="width: 60px;height: 20px;background-color: #d86ac7;border-radius: 2px;text-align: center;line-height: 20px;cursor:pointer" onclick="window.location.href='${ctx}/acc/acc!statistics.action?state=1'">月统计</div>  
                   </div>
                   </h5>  
                  <p>订单统计     （单量/时间）</p>
                  <div id="basicflot" style="width: 100%; height: 300px; margin-bottom: 20px"></div>
                </div><!-- col-sm-8 -->
                <div class="col-sm-4">
                  <h5 class="subtitle mb5">订单统计</h5>
                  <c:if test="${state==1 }">
                  <p class="mb15">上月订单数（${yesdata }）</p>
                  </c:if>
                  <c:if test="${state==0}">
                  <p class="mb15">昨日订单数（${yesdata }）</p>
                  </c:if> 
                  <span class="sublabel">结算(${yesdata1})</span>
                  <div class="progress progress-sm">
                    <div style="width: 40%" aria-valuemax="100" aria-valuemin="0" aria-valuenow="40" role="progressbar" class="progress-bar progress-bar-primary"></div>
                  </div><!-- progress -->

                  <span class="sublabel">挂账 (${yesdata2})</span>
                  <div class="progress progress-sm">
                    <div style="width: 32%" aria-valuemax="100" aria-valuemin="0" aria-valuenow="40" role="progressbar" class="progress-bar progress-bar-success"></div>
                  </div><!-- progress -->
                  <span class="sublabel">请客 (${yesdata3})</span>
                  <div class="progress progress-sm">
                    <div style="width: 1%" aria-valuemax="100" aria-valuemin="0" aria-valuenow="40" role="progressbar" class="progress-bar progress-bar-success"></div>
                  </div><!-- progress -->
                  <c:if test="${state==1}">
                  <p class="mb15">本月订单数（${nowdata }）</p>
                  </c:if>
                  <c:if test="${state==0}">
                  <p class="mb15">今日订单数（${nowdata }）</p>
                  </c:if> 
                  <span class="sublabel">结算(${nowdata1})</span>
                  <div class="progress progress-sm">
                    <div style="width: 40%" aria-valuemax="100" aria-valuemin="0" aria-valuenow="40" role="progressbar" class="progress-bar progress-bar-primary"></div>
                  </div><!-- progress -->

                  <span class="sublabel">挂账 (${nowdata2})</span>
                  <div class="progress progress-sm">
                    <div style="width: 32%" aria-valuemax="100" aria-valuemin="0" aria-valuenow="40" role="progressbar" class="progress-bar progress-bar-success"></div>
                  </div><!-- progress -->
                  <span class="sublabel">请客 (${nowdata3})</span>
                  <div class="progress progress-sm">
                    <div style="width: 1%" aria-valuemax="100" aria-valuemin="0" aria-valuenow="40" role="progressbar" class="progress-bar progress-bar-success"></div>
                  </div><!-- progress -->
 
 

                </div><!-- col-sm-4 -->
              </div><!-- row -->
            </div><!-- panel-body -->
          </div><!-- panel -->
        </div><!-- col-sm-9 -->
 

      </div><!-- row -->
            </div> 
    </div>
</section>
 
 <script type="text/javascript">
 jQuery(".select0").select2({
     width: '100%'
 });  
 $('#state').val('${state}').trigger("change");
 pot();
 </script>
</body>
</html>

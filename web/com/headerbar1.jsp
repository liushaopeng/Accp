<%@ page contentType="text/html;charset=UTF-8"%> 
<%@ include file="/com/libs.jsp"%>
<div class="headerbar">  
            
      <div class="">
        <ul class="headermenu">
        <li onclick="show_roll()">
            <div class="btn-group">
              <button class="btn btn-default dropdown-toggle tp-icon" data-toggle="dropdown">
                <i class="fa fa-bold"></i>  滚动字幕 
              </button>
              
            </div>
          </li>
        <li onclick="show_slide()">
            <div class="btn-group">
              <button class="btn btn-default dropdown-toggle tp-icon" data-toggle="dropdown">
                <i class="fa fa-newspaper-o"></i> 幻灯片
              </button>
              
            </div>
          </li>
         <li onclick="show_txt()">
            <div class="btn-group">
              <button class="btn btn-default dropdown-toggle tp-icon" data-toggle="dropdown">
                <i class="fa fa-font"></i> 文字 
              </button>
              
            </div>
          </li>
          <li style="display: none">
            <div class="btn-group">
              <button class="btn btn-default dropdown-toggle tp-icon" data-toggle="dropdown">
                <i class="fa fa-photo"></i> 图库 
              </button>
              
            </div>
          </li> 
           <li onclick="show_music()">
            <div class="btn-group">
              <button class="btn btn-default dropdown-toggle tp-icon" data-toggle="dropdown">
                <i class="fa fa-music"></i> 音乐 
              </button>
              
            </div>
          </li> 
           <li onclick="show_share()" style="border-right: 1px solid #eee;">
            <div class="btn-group">
              <button class="btn btn-default dropdown-toggle tp-icon" data-toggle="dropdown">
                <i class="fa fa-cog"></i> 设置 
              </button>
              
            </div>
          </li> 
             <li style="float: right;" onclick="window.location.href='${ctx}/suc/mobilescene.action?'">
            <div class="btn-group">
              <button class="btn btn-default dropdown-toggle tp-icon" data-toggle="dropdown">
                <i class="fa  fa-dot-circle-o"></i> 退出
              </button>
              
            </div>
          </li>
          
          
           
             <li style="float: right;" onclick="preview()">
            <div class="btn-group">
              <button class="btn btn-default dropdown-toggle tp-icon" data-toggle="dropdown">
                <i class="fa fa-share"></i> 预览 
              </button>
              
            </div>
          </li>
             
          <li style="float: right;" onclick="javascript:window.location.href='${ctx}/suc/mobilescene!create.action?'">
            <div class="btn-group">
              <button class="btn btn-default dropdown-toggle tp-icon" data-toggle="dropdown">
                <i class="fa fa-legal "></i>新增
              </button>
              
            </div> 
          </li>
           <li style="float: right;" onclick="saveDataFresh()">
            <div class="btn-group">
              <button class="btn btn-default dropdown-toggle tp-icon" data-toggle="dropdown">
                <i class="fa fa-undo"></i> 刷新
              </button>
              
            </div>
          </li>
           <li style="float: right;" onclick="saveData()">
            <div class="btn-group">
              <button class="btn btn-default dropdown-toggle tp-icon" data-toggle="dropdown">
                <i class="fa fa-recycle"></i> 保存 
              </button>
              
            </div>
          </li>
         
        </ul>
    </div><!-- header-right --> 
</div><!-- headerbar -->
(function() {

	var input = document.querySelector('.fileInput'); 
	var types = [".jpg",".jpeg",".gif",".png",".JPG",".JPEG",".PNG",".RAW"];
	var mpiArr= []; 
	var index = 0; 
    
	input.onchange = function () {
		
	
	  var file = this.files[0];
	  var span = document.createElement('div');
	  var fileName = file.name;
	  var imgSize = file.size;  
	  if($(".pic-list").find('.lig').length==6){
		  alert("最多上传6张图片");
		  return;
	  }
	  if(!checkFileType(fileName)) {
	    alert("文件类型必须为jpg/jpeg/gif/png");
	    return;
	  }
	    if(imgSize > 10*1024*1024) { //大于2M
	    	alert("请上传小于10M的文件");
	    return;
	    }
	    var reader = new FileReader();  
	    reader.onload = function (e) {  
	        var data = e.target.result;  
	        //加载图片获取图片真实宽度和高度  
	        var image = new Image();  
	        image.onload=function(){  
	            var width = image.width;  
	            var height = image.height;  
	            if(width!=height){ 
	            	alert("请上传正方形图片！");
	            	return;
	            }if(width<800){ 
	            	alert("请上传大于800px的图片！");
	            	return;
	            }else{ 
	            	   lrz(file, {
	           	        before: function() {
	           	        	
	           	        },
	           	        fail: function(err) {
	           	            //console.error(err);
	           	        },
	           	        always: function() {
	           	        },
	           	        width: 800
	           	        },
	           	        
	           	        function (results) {
	           	        setTimeout(function () {
	           	        	var host ="http://"+window.location.host;
	           	            $.post(
	           	            		host+"/lrzimg!imginput.action",
	           	            	{
	           	                    imgBase64:results.base64,
	           	                    imgSize: results.base64.length, // 校验用，防止未完整接收
	           	                    imgName: fileName, 
	           	                },
	           	                function (data) {
	           	                	var html=$(".pic-list").html();
	                           	    html+='<div style="margin: 2px 2px;float: left;" data="'+data.path+'" class="lig"><div class="img-wh60 maring-a border-radius3 line-lu logos" style="position: relative;">'
	                           		html+='<img src="'+data.ppath+'" style="width: 100%;height: 100%">'
	                           		html+='<span style="display: block;position: absolute;top: 0px;right: 0;width: 15px;height: 15px;border-radius: 0px 0px 0px 2px;background: #ff0000;color: #fff;line-height:14px;text-align: center;" onclick="removeimg(this)">x</span></div></div>';
	                           	    $(".pic-list").html(html);
	                           	    $("#pics").val($("#pics").val()+","+data.path);  
	                           	    $(input).val('');
	                           	    $('#picurl').val($("#pics").val().split(",")[1]);
	           	                    }
	           	            );
	           	        },"json", 1000);
	           	        }
	           	     );
	            }
	            
	        };  
	        image.src= data;  
	    };  
	    reader.readAsDataURL(file); 
	 
	};

	 

	String.prototype.endWith=function(str){
	  if(str==null||str==""||this.length==0||str.length>this.length)
	     return false;
	  if(this.substring(this.length-str.length)==str)
	     return true;
	  else
	     return false;
	  return true;
	 }

	function checkFileType(name) {
	  var flag = false;
	  $.each(types,function(index,value) {
	    if(name.endWith(value)) {
	      flag = true;
	    }
	  })
	  return flag;
	}
	function  removeimg(v){ 
		$("#pics").val($("#pics").val().replace(','+$(v).parent().attr('data'),'')); 
		$(v).parent().remove();
	}
})();
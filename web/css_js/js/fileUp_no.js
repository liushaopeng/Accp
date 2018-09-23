var fileInput=function(v,l,val,istb,calback) {

	var input =document.querySelector('.'+v);
	var types = [".jpg",".jpeg",".gif",".png",".JPG",".JPEG",".PNG",".RAW"];
	var mpiArr = []; 
	var index = 0;  
	var imgW;
	var imgH;
	input.onchange = function () {  
	  var file = this.files[0]; 
	  var fileName = file.name;
	  var imgSize = file.size;
	  if(!checkFileType(fileName)) {
	    alert("文件类型必须为jpg/jpeg/gif/png");
	    return;
	  }
	  if(imgSize > 10*1024*1024) { //大于2M
	    	alert("请上传小于10M的文件");
	    return;
	  }
	  
	  var base64='';
	  var reader=new FileReader();
	  reader.readAsDataURL(file);
	  reader.onload=function(){
	  base64=this.result;   
	  var image = new Image();  
      image.onload=function(){  
          imgW = image.width;  
          imgH = image.height;  
          
          setTimeout(function () { 
            	var host ="http://"+window.location.host;
      	            $.post(
      	            		host+"/Acc_Manage/lrzimg!imginput.action",
                	{
                        imgBase64:base64,
                        imgSize: base64.length, // 校验用，防止未完整接收
                        imgName: fileName,
                        width:imgW,
                        height:imgH,
                        istb:istb
                    },
                    function (data) {
                    	var html='';
                    	    html+='<div class="col-6"><div class="img-wh60 maring-a border-radius3 line-lu logos">'
                    		html+='<img src="'+data.ppath+'" class="img-60"></div></div>';
                    	   $("."+l).html(html); 
                    	   $("#"+val).val(data.path); 
                    	   $("#"+val).attr("imgW",imgW);
                    	   $("#"+val).attr("imgH",imgH);
                    	   calback(data.path);
                        }
                );
            },"json", 1000);
        };   
        image.src=base64;
	  };  
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
	 
	 
};
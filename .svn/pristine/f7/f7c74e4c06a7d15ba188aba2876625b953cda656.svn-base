Wxlogin=function (v,url,custid,type) {
	var host ="http://"+window.location.host;
	url=host+"/"+url+"?custid="+custid;
	var submitData={ 
			redirect_uri:encodeURI(url),
			custid:custid,
			type:type
	}
	
	 v.post(host+'/ajax!getWxLoginUrl.action', submitData,
             function (json) { 
	            	 if(json.state==0){
	            		 window.location.href=json.value;
	            	 }
             }, "json")   
}  
package com.lsp.wenxin.web; 
import java.net.URLEncoder;
import java.util.Date;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.CacheResource;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.service.AllService;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.SysConfig;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.web.TotalAction;
import com.lsp.wenxin.entity.WxPayInfo;
import com.lsp.wenxin.entity.WxToken;
import com.lsp.wenxin.util.WeiXinUtil;
import com.mongodb.DBObject;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 *微信支付管理
 * @author zyl
 *
 */
@Namespace("/wenxin")
@Results({@Result(name= WxpayAction.RELOAD, location="wxpay.action",params={"_id", "%{_id}"}, type="redirect")})
public class WxpayAction extends TotalAction<WxPayInfo>{

	private static final long serialVersionUID = 1L;
	@Autowired
	private BaseDao basedao;
	private Long _id;
	private WxPayInfo entity = new WxPayInfo();
	private MongoSequence mongoSequence;
	@Autowired
	private AllService allService;
    @Autowired
	public void setMongoSequence(MongoSequence mongoSequence)
	{
     this.mongoSequence = mongoSequence;
	}
	public void set_id(Long _id) {
	    this._id = _id;
	}
    public String execute() throws Exception { 
    	Struts2Utils.getRequest().setAttribute("toUser",CacheResource.wxtouser.get(SpringSecurityUtils.getCurrentUser().getId())); 
    	DBObject taken=basedao.getMessage(PubConstants.WENXIN_WXTOKEN, SpringSecurityUtils.getCurrentUser().getId());
    	Struts2Utils.getRequest().setAttribute("entity", taken);
		return SUCCESS; 
	}
	@Override
	public WxPayInfo getModel() {
		// TODO Auto-generated method stub
		return entity;
	}

	@Override
	public String input() throws Exception {
		// TODO Auto-generated method stub
		return "add";
	}

	@Override
	public String update() throws Exception {
		// TODO Auto-generated method stub
		return "add";
	}

	@Override
	public String save() throws Exception { 
		String toUser=Struts2Utils.getParameter("toUser");
		String partner_key=Struts2Utils.getParameter("partner_key");
		String appid=Struts2Utils.getParameter("appid");
		String appsecret=Struts2Utils.getParameter("appsecret");
		String appkey=Struts2Utils.getParameter("appkey");
		String partner=Struts2Utils.getParameter("partner");
		String name=Struts2Utils.getParameter("name");		
	 	
	        
        WxToken info=new WxToken();
        info.set_id(SpringSecurityUtils.getCurrentUser().getId());
        info.setAppid(appid);
        info.setSecret(appsecret);
        info.setToUser(toUser);
        info.setZhlx(1);
        basedao.insert(PubConstants.WENXIN_WXTOKEN, info); 
        CacheResource.wxtoken.put(toUser,info);
		return RELOAD;
	}

	@Override
	public String delete() throws Exception {
		
		return RELOAD;
	}
	public void upd() throws Exception { 
		
	} 
	@Override
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub
		if (_id!=null) {
			DBObject dbObject =basedao.getMessage(PubConstants.WENXIN_WXTOKEN, _id);
			entity=(WxPayInfo) UniObject.DBObjectToObject1(dbObject, WxPayInfo.class);
		}else{
			entity=new WxPayInfo();
		}
	}
	public String index(){
		DBObject db= basedao.getMessage(PubConstants.WENXIN_WXTOKEN, SpringSecurityUtils.getCurrentUser().getId());
    	Struts2Utils.getRequest().setAttribute("entity", db);
		return "index";
	}
	
	public void check(){
		
	}
	/**
	 * ajax获取微信URL
	 */
	public  void   getwxurl(){ 
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
	    custid=SpringSecurityUtils.getCurrentUser().getId();
	    WxToken token=CacheResource.wxtoken.get(CacheResource.wxtouser.get(SysConfig.getProperty("custid"))); 
		if(token!=null){
			if(token.getSqlx()>0){
				 token=CacheResource.wxtoken.get(allService.getparentcustid(custid)); 
			}
			token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest());
			String  url=Struts2Utils.getParameter("url");
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			sub_map.put("state",0);
			sub_map.put("value",inspection);
			String json = JSONArray.fromObject(sub_map).toString(); 
			Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		}  
		
		
	}
	
}

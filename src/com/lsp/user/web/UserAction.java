package com.lsp.user.web;

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
import com.lsp.pub.util.UniObject;
import com.lsp.pub.web.TotalAction; 
import com.lsp.user.entity.UserInfo;
import com.mongodb.DBObject;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
/**
 * 用户管理
 * @author lsp
 *
 */
@Namespace("/user")
@Results({@Result(name= UserAction.RELOAD, location="user.action",params={"fypage", "%{fypage}"}, type="redirect")})
public class UserAction extends TotalAction<UserInfo>{ 
	private static final long serialVersionUID = 1L;
	@Autowired
	private BaseDao basedao;
	private String _id;
	private UserInfo entity = new UserInfo();
	private MongoSequence mongoSequence;
	@Autowired
	private AllService allService;
    @Autowired
	public void setMongoSequence(MongoSequence mongoSequence)
	{
     this.mongoSequence = mongoSequence;
	}
	public void set_id(String _id) {
	    this._id = _id;
	}
	public String execute() throws Exception {
		HashMap<String,Object>whereMap=new HashMap<>();
		HashMap<String,Object>sortMap=new HashMap<>();
		custid=SpringSecurityUtils.getCurrentUser().getId();
		sortMap.put("createdate",-1);
		whereMap.put("custid",custid);
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		List<DBObject>list=basedao.getList(PubConstants.USER_INFO, whereMap,fypage,10, sortMap);
		System.out.println(list);
		fycount=basedao.getCount(PubConstants.USER_INFO, whereMap);
		Struts2Utils.getRequest().setAttribute("list",list);
		whereMap.clear();
		whereMap.put("custid",custid);
		List<DBObject>roleList=basedao.getList(PubConstants.ROLE_INFO, whereMap, sortMap);
		Struts2Utils.getRequest().setAttribute("roleList", roleList);
		return SUCCESS; 
	} 
	@Override
	public UserInfo getModel() {
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
		// TODO Auto-generated method stub
		if(StringUtils.isEmpty(_id)){
			_id=UUID.randomUUID().toString();
		}
		entity.set_id(_id);
		entity.setCreatedate(new Date());
		entity.setCustid(SpringSecurityUtils.getCurrentUser().getId()); 
		basedao.insert(PubConstants.USER_INFO,entity);
		if (StringUtils.isNotEmpty(entity.getToUser())) {
			CacheResource.wxtouser.put(_id, entity.getToUser());
		}
		
		return RELOAD;
	} 
	@Override
	public String delete() throws Exception {
		// TODO Auto-generated method stub
		SpringSecurityUtils.getCurrentUser().getId();
		basedao.delete(PubConstants.USER_INFO,_id);
		return RELOAD;
	} 
	@Override
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub
		if (_id!=null) {
			DBObject dbObject =basedao.getMessage(PubConstants.USER_INFO, _id);
			entity=(UserInfo) UniObject.DBObjectToObject1(dbObject, UserInfo.class);
		}else{
			entity=new UserInfo();
		}
		
	}
	public void upd() throws Exception { 
		DBObject db = basedao.getMessage(PubConstants.USER_INFO, _id); 
		String json = JSONObject.fromObject(db).toString();
		System.out.println(db);
		Struts2Utils.renderJson(json, new String[0]);
	} 
	/**
	 * ajax添加用户
	 */
	public  void  ajaxsave(){ 
		String name=Struts2Utils.getParameter("name");
		String account=Struts2Utils.getParameter("account");
		String password=Struts2Utils.getParameter("password"); 
		String tel=Struts2Utils.getParameter("tel");
		String part=Struts2Utils.getParameter("part");
		Map<String, Object> sub_map = new HashMap<String, Object>();
		UserInfo info=new UserInfo();
		info.set_id(UUID.randomUUID().toString());
		info.setAccount(account);
		info.setPassword(password);
		info.setTel(tel);
		info.setNickname(name); 
		info.setCreatedate(new Date());
		basedao.insert(PubConstants.USER_INFO, info);
		String json = JSONArray.fromObject(sub_map).toString();
	    Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	public String index(){
		return "index"; 	
	} 
	public String passwd(){
		SpringSecurityUtils.getCurrentUser().getId();
		return "passwd"; 
	}
	/**
	 * 密码修改
	 * @return
	 */
	public String savepasswd(){
		Struts2Utils.getRequest().setAttribute("savepass","error");
		String orderpass=Struts2Utils.getParameter("orderpass");
		String newpass=Struts2Utils.getParameter("newpass");
		String nextpass=Struts2Utils.getParameter("nextpass");
		DBObject db=basedao.getMessage(PubConstants.USER_INFO, SpringSecurityUtils.getCurrentUser().getId());
		
		if(db!=null){
			UserInfo  user=(UserInfo) UniObject.DBObjectToObject(db, UserInfo.class);
			user.set_id(SpringSecurityUtils.getCurrentUser().getId());
			if(user.getPassword().equals(orderpass)){
				if(newpass.equals(nextpass)){
					user.setPassword(newpass);
					basedao.insert(PubConstants.USER_INFO, user);
					Struts2Utils.getRequest().setAttribute("savepass","ok");
				}
			} 
		}
		
		return "passwd"; 
	}

}

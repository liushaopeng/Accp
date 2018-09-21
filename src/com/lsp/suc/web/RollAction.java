package com.lsp.suc.web;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import net.sf.json.JSONObject;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.service.AllService;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.SysConfig;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.web.TotalAction;
import com.lsp.suc.entity.RollInfo; 
import com.mongodb.DBObject;
/**
 * 滚动管理
 * @author lsp
 *
 */
@Namespace("/suc")
@Results( { @Result(name ="reload", location = "roll.action",params = {"type", "%{type}","fypage", "%{fypage}" }, type = "redirect") })
public class RollAction extends TotalAction<RollInfo>{


	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private MongoSequence mongoSequence;	
	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	}  
	private RollInfo entity=new RollInfo();
	private Long _id;

	@Autowired
	private AllService webService;

	@Override
	public String execute() throws Exception { 
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		HashMap<String, Object> backMap =new HashMap<String, Object>();

		sortMap.put("sort", -1); 

		String title=Struts2Utils.getParameter("titles");
		String type=Struts2Utils.getParameter("type");
		if(StringUtils.isNotEmpty(type)){
			whereMap.put("type", type);
			Struts2Utils.getRequest().setAttribute("type",type);
		}
		if(StringUtils.isNotEmpty(title)){
			Pattern pattern = Pattern.compile("^.*" + title + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("title", pattern);
			Struts2Utils.getRequest().setAttribute("titles",  title);
		}
	 
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		
		List<DBObject> list=baseDao.getList(PubConstants.SUC_ROLL,whereMap,fypage,10,sortMap,backMap);
		fycount=baseDao.getCount(PubConstants.SUC_ROLL,whereMap);
		Struts2Utils.getRequest().setAttribute("rollList", list);
		Struts2Utils.getRequest().setAttribute("custid", SpringSecurityUtils.getCurrentUser().getId());
		Struts2Utils.getRequest().setAttribute("fycount", fycount);
		return SUCCESS;
	}
	 


	@Override
	public RollInfo getModel() {
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
	 
		return "add";
	}
	public void upd() throws Exception { 
		DBObject db = baseDao.getMessage(PubConstants.SUC_ROLL, _id); 
		String json = JSONObject.fromObject(db).toString();
		System.out.println("-----:"+json);
		Struts2Utils.renderJson(json, new String[0]);
	}
	
	
	public String  selectroll() throws Exception { 
		DBObject db = baseDao.getMessage(PubConstants.SUC_ROLL, _id); 
		Struts2Utils.getRequest().setAttribute("roll", db);
		
		return "web";
		 
	}


	@Override
	public String save() throws Exception {
		// TODO Auto-generated method stub
		try {
			if(_id==null){
				_id=mongoSequence.currval(PubConstants.SUC_ROLL); 
			} 
			String custid=SpringSecurityUtils.getCurrentUser().getId(); 
			String content=Struts2Utils.getParameter("context");  
			entity.set_id(_id);
			entity.setContent(content);
			entity.setCustid(custid);
			entity.setCreatedate(new Date()); 
			baseDao.insert(PubConstants.SUC_ROLL, entity);
			addActionMessage("添加成功");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			addActionMessage("添加失败");
		}
		return RELOAD;
	}
	
	 
	 

	@Override
	public String delete() throws Exception {
		// TODO Auto-generated method stub 
		try {
			baseDao.delete(PubConstants.SUC_ROLL, _id);
			addActionMessage("删除成功！");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			addActionMessage("删除失败！");
			e.printStackTrace();
		}
		return RELOAD;
	}


	@Override
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub
		try {
			if(_id!=null){
				DBObject db=baseDao.getMessage(PubConstants.SUC_ROLL, _id);
				entity= (RollInfo) UniObject.DBObjectToObject(db, RollInfo.class);
			}else{
				entity=new RollInfo();
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	 	
	}
	public void set_id(Long _id) {
		this._id = _id;
	}
     

}

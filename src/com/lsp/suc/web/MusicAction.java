package com.lsp.suc.web;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import net.sf.json.JSONArray;
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
import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.SysConfig;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.web.TotalAction;
import com.lsp.suc.entity.ImageInfo;
import com.lsp.suc.entity.Slide; 
import com.mongodb.DBObject;

 
/**
 * 音乐管理
 * @author lsp
 *
 */
@Namespace("/suc")
@Results( { @Result(name ="reload", location = "music.action",params={"fypage","%{fypage}","type","%{type}"}, type = "redirect") })
public class MusicAction extends TotalAction<ImageInfo>{

	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private MongoSequence mongoSequence;	
	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	}

	@Autowired
	private AllService webService;
	
	private ImageInfo entity=new ImageInfo();
	private Long _id;


	@Override
	public String execute() throws Exception { 
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		HashMap<String, Object> backMap =new HashMap<String, Object>();
		sortMap.put("sort", -1); 
	
		String type=Struts2Utils.getParameter("type");
		if(StringUtils.isNotEmpty(type)){
			whereMap.put("type", type);	
		}
		String title=Struts2Utils.getParameter("title");
		if(StringUtils.isNotEmpty(title)){
			Pattern pattern = Pattern.compile("^.*" + title + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("title", pattern);
			Struts2Utils.getRequest().setAttribute("title",  title);
		}
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		List<DBObject> list=baseDao.getList(PubConstants.SUC_IMAGE,whereMap,fypage,10,sortMap,backMap);
		fycount=baseDao.getCount(PubConstants.SUC_IMAGE,whereMap);
		Struts2Utils.getRequest().setAttribute("list", list);

		fycount=baseDao.getCount(PubConstants.SUC_IMAGE,whereMap);
		Struts2Utils.getRequest().setAttribute("fycount", fycount);
		
		Struts2Utils.getRequest().setAttribute("custid", SpringSecurityUtils.getCurrentUser().getId());
		return SUCCESS;
	}
   
	@Override
	public ImageInfo getModel() {
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
		DBObject db = baseDao.getMessage(PubConstants.SUC_IMAGE, _id); 
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}


	@Override
	public String save() throws Exception {
		// TODO Auto-generated method stub
		try {
			if(_id==null){
				_id=mongoSequence.currval(PubConstants.SUC_IMAGE); 
			} 
			entity.set_id(_id); 
			entity.setCustid(SpringSecurityUtils.getCurrentUser().getId());
			baseDao.insert(PubConstants.SUC_IMAGE, entity);
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
		if(_id!=null){
			baseDao.delete(PubConstants.SUC_IMAGE,_id);
		}
		return RELOAD;
	}


	@Override
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub
		try {
			if(_id!=null){
				DBObject db=baseDao.getMessage(PubConstants.SUC_IMAGE, _id);
				entity= (ImageInfo) UniObject.DBObjectToObject(db, ImageInfo.class);
			}else{
				entity=new ImageInfo();
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	 	
	}
	public void set_id(Long _id) {
		this._id = _id;
	} 
	/**
	 * ajaxweb
	 */
	public  void   ajaxWeb(){
		Map<String, Object> sub_map = new HashMap<String, Object>();
		sub_map.put("state", 1);
		HashMap<String,Object>whereMap=new HashMap<>();
		HashMap<String,Object>sortMap=new HashMap<>();
		String title=Struts2Utils.getParameter("sel");
		if (StringUtils.isNotEmpty(title)) {
			Pattern pattern = Pattern.compile("^.*" + title + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("title", pattern); 
		}
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));	
		}
		List<DBObject>list=baseDao.getList(PubConstants.SUC_IMAGE, whereMap,fypage,1000,sortMap);
		if(list.size()>0){
			sub_map.put("state",0);
			sub_map.put("list",list);
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1),
				new String[0]);
	}
	/**
	 * ajax添加
	 */
	public  void   ajaxAdd(){
		Map<String, Object> sub_map = new HashMap<String, Object>();
		sub_map.put("state", 1);
		String picurl=Struts2Utils.getParameter("picurl");
		String title=Struts2Utils.getParameter("title");
		String sort=Struts2Utils.getParameter("sort");
		String type=Struts2Utils.getParameter("type");  
		ImageInfo io=new ImageInfo();
		if(StringUtils.isNotEmpty(picurl)){
			io.set_id(mongoSequence.currval(PubConstants.SUC_IMAGE));
			io.setCreatedate(new Date());
			io.setCustid(SpringSecurityUtils.getCurrentUser().getId());
			io.setPicurl(picurl);
			io.setTitle(title);
			if(StringUtils.isNotEmpty(sort)){
				io.setSort(Integer.parseInt(sort));
			}
			if(StringUtils.isNotEmpty(type)){
				io.setType(Long.parseLong(type));
			}
			baseDao.insert(PubConstants.SUC_IMAGE, io);
			sub_map.put("state", 0);
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1),
				new String[0]);
	}
	/**
	 * ajaxweb
	 */
	public  void   ajaxDel(){
		Map<String, Object> sub_map = new HashMap<String, Object>();
		sub_map.put("state", 1);
		HashMap<String,Object>whereMap=new HashMap<>();
		String id=Struts2Utils.getParameter("id");
		if(StringUtils.isNotEmpty(id)){
			whereMap.put("_id",Long.parseLong(id));
			whereMap.put("custid",SpringSecurityUtils.getCurrentUser().getId());
			int count=baseDao.delete(PubConstants.SUC_IMAGE,whereMap);
			whereMap.clear();
			if(count>0){
				HashMap<String,Object>sortMap=new HashMap<>();
				String title=Struts2Utils.getParameter("sel");
				if (StringUtils.isNotEmpty(title)) {
					Pattern pattern = Pattern.compile("^.*" + title + ".*$",
							Pattern.CASE_INSENSITIVE);
					whereMap.put("title", pattern); 
				}
				if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
					fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));	
				}
				List<DBObject>list=baseDao.getList(PubConstants.SUC_IMAGE, whereMap,fypage,1000,sortMap);
				sub_map.put("state",0);
				sub_map.put("list",list);
			}
			
		}
	
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1),
				new String[0]);
	}

}

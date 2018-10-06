package com.lsp.pub.web;

import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.FuncInfo;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.UniObject;
import com.mongodb.DBObject; 
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.regex.Pattern; 
import net.sf.json.JSONObject;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
/**
 * 资源管理
 * @author lsp 
 *   
 */
@Namespace("/pub")
@Results({@org.apache.struts2.convention.annotation.Result(name="reload", location="func.action",params={"parentid", "%{parentid}"},type="redirect")})
public class FuncAction extends TotalAction<FuncInfo>
{
  private static final long serialVersionUID = -6784469775589971579L;

  @Autowired
  private BaseDao basedao;
  private Long _id;
  private FuncInfo entity = new FuncInfo();
  private MongoSequence mongoSequence;

  @Autowired
  public void setMongoSequence(MongoSequence mongoSequence)
  {
    this.mongoSequence = mongoSequence;
  }

  public void set_id(Long _id) {
    this._id = _id;
  }

  public String execute() throws Exception { 
    HashMap<String, Object> sortMap = new HashMap<String, Object>();
    HashMap<String, Object> whereMap = new HashMap<String, Object>();
    sortMap.put("sort", -1);
    if (StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))) {
      this.fypage = Integer.parseInt(Struts2Utils.getParameter("fypage")); 
    }
    String parentid=Struts2Utils.getParameter("parentid");
    if(StringUtils.isNotEmpty(parentid)){
    	whereMap.put("parentid",Long.parseLong(parentid));
    }else{
    	parentid="0";
    	whereMap.put("parentid",0);
    }
    String name = Struts2Utils.getParameter("name");
    if (StringUtils.isNotEmpty(name)) {
      Pattern pattern = Pattern.compile("^.*" + name + ".*$", 
        2);
      whereMap.put("name", pattern);
      Struts2Utils.getRequest().setAttribute("name", name);
    }
    List<DBObject> list = this.basedao.getList(PubConstants.FUNC_INFO, whereMap, this.fypage, 10, sortMap);
    Struts2Utils.getRequest().setAttribute("list", list);
    this.fycount = this.basedao.getCount(PubConstants.FUNC_INFO,whereMap);
    Struts2Utils.getRequest().setAttribute("fycount", Long.valueOf(this.fycount));
    Struts2Utils.getRequest().setAttribute("parentid", parentid);
    return "success";
  }

  public String input()
    throws Exception
  {
    return "add";
  }

  public String update()
    throws Exception
  {
    return "add";
  }
  public void upd() throws Exception { 
		DBObject db = basedao.getMessage(PubConstants.FUNC_INFO, _id); 
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
  }
  public String save() throws Exception
  {
	  try
	    {
	      if (this._id == null)
	      {
	        this._id = this.mongoSequence.currval(PubConstants.FUNC_INFO);
	      }

	      this.entity.set_id(this._id);
	      if (this.entity.getParentid().longValue() != 0L)
	      {
	    	//存在父类，把当前元素添加到父类元素
	        DBObject emDbObject = this.basedao.getMessage(PubConstants.FUNC_INFO, 
	          this.entity.getParentid());
	        FuncInfo entity = (FuncInfo)UniObject.DBObjectToObject(emDbObject, 
	          FuncInfo.class);
	        

	        if (entity.getTfunc() == null) {
	          List<FuncInfo> list = new ArrayList<FuncInfo>();
	          list.add(this.entity);

	          entity.setTfunc(list);
	        } else {
	          List<FuncInfo> list = entity.getTfunc();
	          List<FuncInfo> list1 = new ArrayList<FuncInfo>();
	          list1.add(this.entity);
	          if (list.size() > 0) {
	            for (int i = 0; i < list.size(); i++)
	            {
	              FuncInfo func = (FuncInfo)JSONObject.toBean(JSONObject.fromObject(list.get(i)), FuncInfo.class); 
	              if(func.getTfunc()!=null){
	            	  List<FuncInfo> list2 = func.getTfunc();
	            	  List<FuncInfo> list3 = new ArrayList<>();
	            	  if (list2.size() > 0) {
		                  for (int j = 0; j < list2.size(); j++)
		                  {
		                    FuncInfo childfunc = (FuncInfo)JSONObject.toBean(JSONObject.fromObject(list2.get(j)), FuncInfo.class); 
		                    List<FuncInfo> list6 = new ArrayList<FuncInfo>();
		                    if(childfunc.getTfunc()!=null){
		                    	List<FuncInfo> list5 = childfunc.getTfunc();
		                    	 if(list5.size() > 0){
		 	                    	for (int z = 0; z < list5.size(); z++) {
		 	                    		FuncInfo minfunc = (FuncInfo)JSONObject.toBean(JSONObject.fromObject(list5.get(z)), FuncInfo.class);
		 	                    		list6.add(minfunc);
		 							}
		 	                    }
		                    }
		                    childfunc.setTfunc(list6);
		                    list3.add(childfunc);
		                  }
		                }
	            	  func.setTfunc(list3);
	              }
	              if (Integer.parseInt(func.get_id().toString())!=_id) {
	                list1.add(func);
	              }
	            }
	          }
	          entity.setTfunc(list1);
	        } 
	        this.basedao.insert(PubConstants.FUNC_INFO, entity);
	        //处理子类元素
	        HashMap<String, Object>whereMap=new HashMap<String, Object>();
	        HashMap<String, Object>sortMap=new HashMap<String, Object>();
	        whereMap.put("parentid", _id);
	        sortMap.put("sort",-1);
	        List<FuncInfo> list1 = new ArrayList<FuncInfo>();
	        List<DBObject>list=basedao.getList(PubConstants.FUNC_INFO, whereMap, sortMap);
	        for (DBObject dbObject : list) {
	        	FuncInfo childfunc=(FuncInfo)UniObject.DBObjectToObject(dbObject, FuncInfo.class);
	        	if(childfunc.getTfunc()!=null){
	        		List<FuncInfo> list3 = childfunc.getTfunc();
	                List<FuncInfo> list4 = new ArrayList<FuncInfo>();
	                if (list3.size() > 0) {
	                  for (int i = 0; i < list3.size(); i++)
	                  {
	                    FuncInfo func = (FuncInfo)JSONObject.toBean(JSONObject.fromObject(list3.get(i)), FuncInfo.class); 
	                    list4.add(func);
	                  }
	                }
	                childfunc.setTfunc(list4);
	        	}
	        	list1.add(childfunc);
	    	  }
	          this.entity.setTfunc(list1);
	      }else{
	    	  HashMap<String, Object>whereMap=new HashMap<String, Object>();
	          HashMap<String, Object>sortMap=new HashMap<String, Object>();
	          whereMap.put("parentid", this._id);
	          sortMap.put("sort",-1);
	          List<FuncInfo> list1 = new ArrayList<FuncInfo>();
	          List<DBObject>list=basedao.getList(PubConstants.FUNC_INFO, whereMap, sortMap);
	          for (DBObject dbObject : list) {
	        	FuncInfo childfunc=(FuncInfo)UniObject.DBObjectToObject(dbObject, FuncInfo.class);
	        	if(childfunc.getTfunc()!=null){
	        		List<FuncInfo> list3 = childfunc.getTfunc();
	                List<FuncInfo> list4 = new ArrayList<FuncInfo>();
	                if (list3.size() > 0) {
	                  for (int i = 0; i < list3.size(); i++)
	                  {
	                    FuncInfo func = (FuncInfo)JSONObject.toBean(JSONObject.fromObject(list3.get(i)), FuncInfo.class); 
	                    List<FuncInfo> list6 = new ArrayList<FuncInfo>();
	                    if(func.getTfunc()!=null){
		                    List<FuncInfo> list5 = func.getTfunc();
	                    	 if(list5.size() > 0){
	 	                    	for (int j = 0; j < list5.size(); j++) {
	 	                    		FuncInfo minfunc = (FuncInfo)JSONObject.toBean(JSONObject.fromObject(list5.get(j)), FuncInfo.class);
	 	                    		list6.add(minfunc);
	 							}
	 	                    }
	                    }
	                    func.setTfunc(list6);
	                    list4.add(func);
	                  }
	                }
	                childfunc.setTfunc(list4);
	        	}
	        	list1.add(childfunc);
	    	  }
	         entity.setTfunc(list1);
	      }
	      this.basedao.insert(PubConstants.FUNC_INFO, this.entity);
	      addActionMessage("娣诲姞鎴愬姛!");
	    }
	    catch (Exception e) {
	      e.printStackTrace();
	      addActionMessage("娣诲姞澶辫触!");
	    }
	    return "reload";
  } 
  public String delete() throws Exception
  {
    try
    {
      if (this._id != null) {
        DBObject emDbObject1 = this.basedao.getMessage(PubConstants.FUNC_INFO, 
          this._id);
       this.entity = ((FuncInfo)UniObject.DBObjectToObject(emDbObject1, 
          FuncInfo.class));
        if (this.entity.getParentid().longValue() !=0)
        {
          DBObject emDbObject = this.basedao.getMessage(PubConstants.FUNC_INFO, 
            this.entity.getParentid());
          FuncInfo entity = (FuncInfo)UniObject.DBObjectToObject(emDbObject, 
            FuncInfo.class);

          List<FuncInfo> list = entity.getTfunc();
          List<FuncInfo> list1 = new ArrayList<FuncInfo>();
          if ((list != null) && (list.size() > 0)) {
            for (int i = 0; i < list.size(); i++)
            {
              FuncInfo func = (FuncInfo)JSONObject.toBean(JSONObject.fromObject(list.get(i)), FuncInfo.class);
              if ((func.getName() != this.entity.getName()) && (!func.getName().equals(this.entity.getName())))
              {
                list1.add(func);
              }
            }
            entity.setTfunc(list1);
          }

          this.basedao.insert(PubConstants.FUNC_INFO, entity);
        }

        this.basedao.delete(PubConstants.FUNC_INFO, this._id);
        addActionMessage("删除成功");
      }
    }
    catch (Exception e)
    {
      e.printStackTrace();
      addActionMessage("删除失败");
    }
    return "reload";
  }

  protected void prepareModel()
    throws Exception
  {
    if (this._id != null)
    {
      DBObject emDbObject = this.basedao.getMessage(PubConstants.FUNC_INFO, 
        this._id);
      this.entity = ((FuncInfo)UniObject.DBObjectToObject(emDbObject, 
        FuncInfo.class));
    } else {
      this.entity = new FuncInfo();
    }
  }

  public FuncInfo getModel()
  {
    return this.entity;
  }
  public String deletchildfunc() {
    try {
      if (this._id != null) {
        DBObject emDbObject = this.basedao.getMessage(PubConstants.FUNC_INFO, 
          this._id);
        this.entity = ((FuncInfo)UniObject.DBObjectToObject(emDbObject, 
          FuncInfo.class));
        this.entity.setTfunc(null);
        this.basedao.insert(PubConstants.FUNC_INFO, this.entity);
        HashMap<String, Object>whereMap=new HashMap<String, Object>();
        whereMap.put("parentid",_id);
        basedao.delete(PubConstants.FUNC_INFO, whereMap); 
        addActionMessage("删除成功");
      }

    }
    catch (Exception e)
    {
      e.printStackTrace();
      addActionMessage("删除失败");
    }

    return "reload";
  }
  public void deletAll() {
    this.basedao.delete(PubConstants.FUNC_INFO);
  }
  
   
}
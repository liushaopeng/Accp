package com.lsp.acc.web;

import com.lsp.acc.entity.Goods;
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.FuncInfo;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.web.TotalAction;
import com.mongodb.DBObject; 
import java.util.ArrayList;
import java.util.Date;
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
@Namespace("/acc")
@Results({@org.apache.struts2.convention.annotation.Result(name="reload", location="goods.action",params={"fypage", "%{fypage}"},type="redirect")})
public class GoodsAction extends TotalAction<Goods>
{
  private static final long serialVersionUID = -6784469775589971579L;

  @Autowired
  private BaseDao basedao;
  private Long _id;
  private Goods entity = new Goods();
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
    custid=SpringSecurityUtils.getCurrentUser().getId();
    whereMap.put("custid", custid);
    if (StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))) {
      this.fypage = Integer.parseInt(Struts2Utils.getParameter("fypage")); 
    } 
    String name = Struts2Utils.getParameter("name");
    if (StringUtils.isNotEmpty(name)) {
      Pattern pattern = Pattern.compile("^.*" + name + ".*$", 
        2);
      whereMap.put("name", pattern);
      Struts2Utils.getRequest().setAttribute("name", name);
    }
    List<DBObject> list = this.basedao.getList(PubConstants.ACC_GOODS, whereMap, this.fypage, 10, sortMap);
    Struts2Utils.getRequest().setAttribute("list", list);
    this.fycount = this.basedao.getCount(PubConstants.ACC_GOODS,whereMap);
    Struts2Utils.getRequest().setAttribute("fycount", Long.valueOf(this.fycount)); 
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
		DBObject db = basedao.getMessage(PubConstants.ACC_GOODS, _id); 
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
  }
  public String save() throws Exception
  {
     if (_id==null) {
		_id=mongoSequence.currval(PubConstants.ACC_GOODS);
	 }
     entity.set_id(_id);
     entity.setCustid(SpringSecurityUtils.getCurrentUser().getId());
     entity.setCreatedate(new Date());
     basedao.insert(PubConstants.ACC_GOODS,entity);
   
    return "reload";
  } 
  public String delete() throws Exception
  {
     basedao.delete(PubConstants.ACC_GOODS,_id);
    return "reload";
  }

  protected void prepareModel()
    throws Exception
  {
    if (this._id != null)
    {
      DBObject emDbObject = this.basedao.getMessage(PubConstants.ACC_GOODS, 
        this._id);
      this.entity = ((Goods)UniObject.DBObjectToObject(emDbObject, 
    		  Goods.class));
    } else {
      this.entity = new Goods();
    }
  }

  public Goods getModel()
  {
    return this.entity;
  }
   
   
}
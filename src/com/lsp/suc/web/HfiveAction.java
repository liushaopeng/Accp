package com.lsp.suc.web; 
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence; 
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.web.TotalAction;
import com.lsp.suc.entity.HFive;
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
 * H5动画管理
 * @author lsp 
 *   
 */
@Namespace("/pub")
@Results({@org.apache.struts2.convention.annotation.Result(name="reload", location="hfive.action",params={"parentid", "%{parentid}"},type="redirect")})
public class HfiveAction extends TotalAction<HFive>
{
  private static final long serialVersionUID = -6784469775589971579L;

  @Autowired
  private BaseDao basedao;
  private Long _id;
  private HFive entity = new HFive();
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
		HashMap<String, Object> backMap = new HashMap<String, Object>();
		custid=SpringSecurityUtils.getCurrentUser().getId();
		sortMap.put("sort", -1);
		whereMap.put("custid", custid); 
		String title = Struts2Utils.getParameter("title");
		if (StringUtils.isNotEmpty(title)) {
			Pattern pattern = Pattern.compile("^.*" + title + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("title", pattern);
			Struts2Utils.getRequest().setAttribute("title", title);
		}
		backMap.put("context", 0);
		backMap.put("summary", 0);

		if (StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))) {
			fypage = Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}

		List<DBObject> list = basedao.getList(PubConstants.SUC_HFIVE,
				whereMap, fypage, 10, sortMap, backMap);
		fycount = basedao.getCount(PubConstants.SUC_HFIVE, whereMap);
		Struts2Utils.getRequest().setAttribute("mobilesceneList", list);
		Struts2Utils.getRequest().setAttribute("custid", custid);
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
		DBObject db = basedao.getMessage(PubConstants.SUC_HFIVE, _id); 
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
  }
  public String save() throws Exception
  {
    
    return "reload";
  } 
  public String delete() throws Exception
  {
     
    
    return "reload";
  }

	protected void prepareModel() throws Exception {
		if (this._id != null) {
			DBObject emDbObject = this.basedao.getMessage(PubConstants.FUNC_INFO, this._id);
			this.entity = ((HFive) UniObject.DBObjectToObject(emDbObject, HFive.class));
		} else {
			this.entity = new HFive();
		}
	}

  public HFive getModel()
  {
    return this.entity;
  }
  public String deletchildfunc() { 

    return "reload";
  }
  public void deletAll() {
    this.basedao.delete(PubConstants.FUNC_INFO);
  }
   
}
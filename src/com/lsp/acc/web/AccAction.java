package com.lsp.acc.web;

import com.lsp.acc.entity.AccRecord;
import com.lsp.acc.entity.Accounting;
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence; 
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.DateUtil;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.TenpayUtil;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.web.TotalAction;
import com.lsp.user.entity.UserInfo;
import com.mongodb.BasicDBList;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import com.sun.corba.se.spi.orb.StringPair;
import com.sun.org.apache.bcel.internal.generic.NEW;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

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
@Results({@org.apache.struts2.convention.annotation.Result(name="reload", location="acc.action",params={"fypage", "%{fypage}"},type="redirect")})
public class AccAction extends TotalAction<Accounting>
{
  private static final long serialVersionUID = -6784469775589971579L;

  @Autowired
  private BaseDao basedao;
  private String _id;
  private Accounting entity = new Accounting();
  private MongoSequence mongoSequence;

  @Autowired
  public void setMongoSequence(MongoSequence mongoSequence)
  {
    this.mongoSequence = mongoSequence;
  }

  public void set_id(String _id) {
    this._id = _id;
  }

  public String execute() throws Exception {
    HashMap<String, Object> sortMap = new HashMap<String, Object>();
    HashMap<String, Object> whereMap = new HashMap<String, Object>();
    sortMap.put("createdate", -1);
    custid=SpringSecurityUtils.getCurrentUser().getId();
    whereMap.put("custid", custid);
    if (StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))) {
      this.fypage = Integer.parseInt(Struts2Utils.getParameter("fypage")); 
    }
    
    String  sel_insdate=Struts2Utils.getParameter("sel_insdate");
	String  sel_enddate=Struts2Utils.getParameter("sel_enddate");
	if (StringUtils.isNotEmpty(sel_enddate)) {
			BasicDBObject dateCondition = new BasicDBObject();
			dateCondition.append("$gte", DateFormat.getFormat(sel_insdate));
			dateCondition.append("$lte", DateFormat.getFormat(sel_enddate));
			whereMap.put("createdate", dateCondition);
			Struts2Utils.getRequest().setAttribute("sel_enddate", sel_enddate);
			Struts2Utils.getRequest().setAttribute("sel_insdate", sel_insdate);

	}
	String gid=Struts2Utils.getParameter("gid");
	String did=Struts2Utils.getParameter("did");
    if(StringUtils.isNotEmpty(gid)){
    	Pattern pattern = Pattern.compile("^.*" + gid + ".*$", 
    	        2);
    	      whereMap.put("gid", pattern); 
		  Struts2Utils.getRequest().setAttribute("gid", gid); 
	}
    if(StringUtils.isNotEmpty(did)){ 
		  whereMap.put("did",Long.parseLong(did)); 
		  Struts2Utils.getRequest().setAttribute("did", did);
	}
    String name = Struts2Utils.getParameter("name");
    if (StringUtils.isNotEmpty(name)) {
      Pattern pattern = Pattern.compile("^.*" + name + ".*$", 
        2);
      whereMap.put("name", pattern);
      Struts2Utils.getRequest().setAttribute("name", name);
    }
    
    String paystate = Struts2Utils.getParameter("paystate");
    if (StringUtils.isNotEmpty(paystate)) { 
    	if (Integer.parseInt(paystate)==3) {
    		whereMap.put("paystate",0); 	
		}else{
			whereMap.put("paystate",Integer.parseInt(paystate)); 
		}
    	 Struts2Utils.getRequest().setAttribute("paystate", paystate);
    }  
    String paytype = Struts2Utils.getParameter("paytype");
    if (StringUtils.isNotEmpty(paytype)) { 
    	if (Integer.parseInt(paytype)==5) {
    		whereMap.put("paytype", 0); 
		}else{
			whereMap.put("paytype", Integer.parseInt(paytype)); 
		}
    	Struts2Utils.getRequest().setAttribute("paytype", paytype);
    } 
    String state=Struts2Utils.getParameter("state");
    if(StringUtils.isNotEmpty(state)){
    	if (Integer.parseInt(state)==1) {
    		whereMap.put("state", 0);
		}else{
			whereMap.put("state",1);
		}
    	
        Struts2Utils.getRequest().setAttribute("state", state);
    }
    List<DBObject> list = this.basedao.getList(PubConstants.ACC_ACCOUNTING, whereMap, this.fypage, 100, sortMap); 
    for (DBObject dbObject : list) {
    	/**if(dbObject.get("gid")!=null){
    		DBObject goDbObject=basedao.getMessage(PubConstants.ACC_GOODS,Long.parseLong(dbObject.get("gid").toString()));
    		if(goDbObject!=null){
    			dbObject.put("goodsname", goDbObject.get("title"));
    		}
    		
    	}*/
       if(dbObject.get("did")!=null){ 
    	   DBObject maDbObject=basedao.getMessage(PubConstants.ACC_DUTYMAN,Long.parseLong(dbObject.get("did").toString()));
    	   if(maDbObject!=null){
    		   dbObject.put("mansname", maDbObject.get("name"));   
    	   }
    	  
    	}
    	
    	
	}
    Struts2Utils.getRequest().setAttribute("list", list);
    fycount=basedao.getCount(PubConstants.ACC_ACCOUNTING, whereMap);
    whereMap.clear();
    whereMap.put("custid",SpringSecurityUtils.getCurrentUser().getId()); 
    List<DBObject>manlist=basedao.getList(PubConstants.ACC_DUTYMAN, whereMap, sortMap);
    List<DBObject>goodslist=basedao.getList(PubConstants.ACC_GOODS, whereMap, sortMap);
    Struts2Utils.getRequest().setAttribute("manlist", manlist);
    Struts2Utils.getRequest().setAttribute("goodslist", goodslist); 
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
		DBObject db = basedao.getMessage(PubConstants.ACC_ACCOUNTING, _id); 
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
  }
  public String save() throws Exception
  {
	  if(StringUtils.isEmpty(_id)){
		  String random = TenpayUtil.buildRandom(4) + "";
		  String no= DateFormat.getDate()+random+mongoSequence.currval(PubConstants.ACC_ACCOUNTING);
		  entity.set_id(no); 
	  }else{
		  entity.set_id(_id);   
	  } 
	  entity.setCustid(SpringSecurityUtils.getCurrentUser().getId());
	  entity.setCreatedate(new Date()); 
	  String gids=Struts2Utils.getParameter("gids"); 
	  String ids="";
	  if (StringUtils.isNotEmpty(gids)) {
		  List<AccRecord> lsRecords=new ArrayList<>();
		for (int i = 0; i <=Integer.parseInt(gids); i++) {
			AccRecord accRecord =new AccRecord();
			accRecord.setTitle(Struts2Utils.getParameter("title"+i));
			accRecord.setCount(Integer.parseInt(Struts2Utils.getParameter("count"+i)));
			accRecord.setGid(Long.parseLong(Struts2Utils.getParameter("gid"+i)));
			accRecord.setPrice(Double.parseDouble(Struts2Utils.getParameter("price"+i)));
			accRecord.setTotal(accRecord.getPrice()*accRecord.getCount());
			lsRecords.add(accRecord);
			ids=ids+Struts2Utils.getParameter("gid"+i)+",";
		}
		entity.setGid(ids);
		entity.setLsRecords(lsRecords);
	  } 
	  basedao.insert(PubConstants.ACC_ACCOUNTING, entity);
	return RELOAD;
     
  } 
  public String delete() throws Exception
  { 
       basedao.delete(PubConstants.ACC_ACCOUNTING,_id);
    return "reload";
  } 
  protected void prepareModel()
    throws Exception
  {
    if (this._id != null)
    {
      DBObject emDbObject = this.basedao.getMessage(PubConstants.ACC_ACCOUNTING, 
        this._id);
      this.entity = ((Accounting)UniObject.DBObjectToObject(emDbObject, 
    		  Accounting.class));
    } else {
      this.entity = new Accounting();
    }
  }

  public Accounting getModel()
  {
    return this.entity;
  }
  /**
   * 统计
   */
  public String  statistics(){
	  HashMap<String,Object>whereMap=new HashMap<>(); 
	  String state=Struts2Utils.getParameter("state"); 
	  custid=SpringSecurityUtils.getCurrentUser().getId();
	  if (StringUtils.isEmpty(state)||Integer.parseInt(state)==0) {
			//日统计
		  BasicDBObject dateCondition = new BasicDBObject();
			dateCondition.append("$gte",DateUtil.getTimesmorning());
			dateCondition.append("$lte",new Date());
			whereMap.put("createdate", dateCondition);
			whereMap.put("custid", custid);
		  Long nowday=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  Struts2Utils.getRequest().setAttribute("nowdata", nowday);
		  whereMap.put("paystate",0);
		  Long nowdayState1=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  Struts2Utils.getRequest().setAttribute("nowdata1", nowdayState1);
		  whereMap.put("paystate",1);
		  Long nowdayState2=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  Struts2Utils.getRequest().setAttribute("nowdata2", nowdayState2);
		  whereMap.put("paystate",2);
		  Long nowdayState3=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  Struts2Utils.getRequest().setAttribute("nowdata3", nowdayState3);
		  whereMap.clear();
		  dateCondition = new BasicDBObject();
	      dateCondition.append("$gte",DateUtil.addDay(DateUtil.getTimesmorning(), -1));
		  dateCondition.append("$lte",DateUtil.getTimesmorning()); 
		  whereMap.put("createdate", dateCondition);
		  whereMap.put("custid", custid);
		  Long yesday=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  Struts2Utils.getRequest().setAttribute("yesdata", yesday);
		  whereMap.put("paystate",0);
		  Long yesdayState1=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  Struts2Utils.getRequest().setAttribute("yesdata1", yesdayState1);
		  whereMap.put("paystate",1);
		  Long yesdayState2=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  Struts2Utils.getRequest().setAttribute("yesdata2", yesdayState2);
		  whereMap.put("paystate",2);
		  Long yesdayState3=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  Struts2Utils.getRequest().setAttribute("yesdata3", yesdayState3);
		  
		  //分时统计
		  
		  List<Object>Datalist1=new ArrayList<>();
		  List<Object>data=new ArrayList<>();
		  whereMap.clear();
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.getTimesmorning());
		  dateCondition.append("$lte",DateUtil.addHour(DateUtil.getTimesmorning(),4));
		  whereMap.put("createdate", dateCondition);
		  Long nowdayTime4=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(4);
		  data.add(nowdayTime4);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.addHour(DateUtil.getTimesmorning(),4));
		  dateCondition.append("$lte",DateUtil.addHour(DateUtil.getTimesmorning(),8));
		  whereMap.put("createdate", dateCondition);
		  Long nowdayTime8=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap); 
		  data.add(8);
		  data.add(nowdayTime8);
		  Datalist1.add(data); 
		  data=new ArrayList<>();
		  whereMap.clear();
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.addHour(DateUtil.getTimesmorning(),8));
		  dateCondition.append("$lte",DateUtil.addHour(DateUtil.getTimesmorning(),12));
		  whereMap.put("createdate", dateCondition);
		  Long nowdayTime12=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(12);
		  data.add(nowdayTime12);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.addHour(DateUtil.getTimesmorning(),12));
		  dateCondition.append("$lte",DateUtil.addHour(DateUtil.getTimesmorning(),16));
		  whereMap.put("createdate", dateCondition);
		  Long nowdayTime16=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(16);
		  data.add(nowdayTime16);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.addHour(DateUtil.getTimesmorning(),16));
		  dateCondition.append("$lte",DateUtil.addHour(DateUtil.getTimesmorning(),20));
		  whereMap.put("createdate", dateCondition);
		  Long nowdayTime20=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(20);
		  data.add(nowdayTime20);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.addHour(DateUtil.getTimesmorning(),20));
		  dateCondition.append("$lte",DateUtil.addHour(DateUtil.getTimesmorning(),24));
		  whereMap.put("createdate", dateCondition);
		  Long nowdayTime24=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		 
		  data.add(24);
		  data.add(nowdayTime24);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  
		  Struts2Utils.getRequest().setAttribute("Datalist1", Datalist1);
		  Datalist1.clear();
		  whereMap.clear();
		  dateCondition=new BasicDBObject();
		  Date ddDate=DateUtil.addDay(DateUtil.getTimesmorning(), -1);
		  dateCondition.append("$gte",ddDate);
		  dateCondition.append("$lte",DateUtil.addHour(ddDate,4));
		  whereMap.put("createdate", dateCondition);
		  Long yesdayTime4=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(4);
		  data.add(yesdayTime4); 
		  Datalist1.add(data); 
		  data=new ArrayList<>();
		  whereMap.clear();
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.addHour(ddDate,4));
		  dateCondition.append("$lte",DateUtil.addHour(ddDate,8));
		  whereMap.put("createdate", dateCondition);
		  Long yesdayTime8=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(8);
		  data.add(yesdayTime8);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.addHour(ddDate,8));
		  dateCondition.append("$lte",DateUtil.addHour(ddDate,12));
		  whereMap.put("createdate", dateCondition);
		  Long yesdayTime12=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(12);
		  data.add(yesdayTime12);
		  Datalist1.add(data); 
		  data=new ArrayList<>();
		  whereMap.clear();
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.addHour(ddDate,12));
		  dateCondition.append("$lte",DateUtil.addHour(ddDate,16));
		  whereMap.put("createdate", dateCondition);
		  Long yesdayTime16=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(16);
		  data.add(yesdayTime16);
		  Datalist1.add(data); 
		  data=new ArrayList<>();
		  whereMap.clear();
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.addHour(ddDate,16));
		  dateCondition.append("$lte",DateUtil.addHour(ddDate,20));
		  whereMap.put("createdate", dateCondition);
		  Long yesdayTime20=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(20);
		  data.add(yesdayTime20);
		  Datalist1.add(data); 
		  data=new ArrayList<>();
		  whereMap.clear();
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.addHour(ddDate,20));
		  dateCondition.append("$lte",DateUtil.addHour(ddDate,24));
		  whereMap.put("createdate", dateCondition);
		  Long yesdayTime24=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(24);
		  data.add(yesdayTime24);
		  Datalist1.add(data);
		  data=new ArrayList<>(); 
		  Struts2Utils.getRequest().setAttribute("Datalist2", Datalist1);
		  Struts2Utils.getRequest().setAttribute("state", 0);
		  
		}else if(Integer.parseInt(state)==1){
			//月统计
			
			BasicDBObject dateCondition = new BasicDBObject(); 
			dateCondition.append("$gte",DateUtil.getfirstday());
			dateCondition.append("$lte",DateUtil.getlastday()); 
			whereMap.put("createdate", dateCondition);
		  Long nowday=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap); 
		  Struts2Utils.getRequest().setAttribute("nowdata", nowday);
		  whereMap.put("paystate",0);
		  Long nowdayState1=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  Struts2Utils.getRequest().setAttribute("nowdata1", nowdayState1);
		  whereMap.put("paystate",1);
		  Long nowdayState2=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  Struts2Utils.getRequest().setAttribute("nowdata2", nowdayState2);
		  whereMap.put("paystate",2);
		  Long nowdayState3=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  Struts2Utils.getRequest().setAttribute("nowdata3", nowdayState3);
		  whereMap.clear();
		  dateCondition = new BasicDBObject();
	      dateCondition.append("$gte",DateUtil.getLastfirstday());
		  dateCondition.append("$lte",DateUtil.getLastlastday());
		  whereMap.put("createdate", dateCondition);
		  Long yesday=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  Struts2Utils.getRequest().setAttribute("yesdata", yesday);
		  whereMap.put("paystate",0);
		  Long yesdayState1=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  Struts2Utils.getRequest().setAttribute("yesdata1", yesdayState1);
		  whereMap.put("paystate",1);
		  Long yesdayState2=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  Struts2Utils.getRequest().setAttribute("yesdata2", yesdayState2);
		  whereMap.put("paystate",2);
		  Long yesdayState3=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  Struts2Utils.getRequest().setAttribute("yesdata3", yesdayState3);
		  
		  //分时统计
		  
		  List<Object>Datalist1=new ArrayList<>();
		  List<Object>data=new ArrayList<>();
		  whereMap.clear();
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.getfirstday());
		  dateCondition.append("$lte",DateUtil.addDay(DateUtil.getfirstday(),3));
		  whereMap.put("createdate", dateCondition);
		  Long nowdayTime3=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(3);
		  data.add(nowdayTime3);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.addDay(DateUtil.getfirstday(),3));
		  dateCondition.append("$lte",DateUtil.addDay(DateUtil.getfirstday(),6));
		  whereMap.put("createdate", dateCondition);
		  Long nowdayTime6=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(6);
		  data.add(nowdayTime6);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.addDay(DateUtil.getfirstday(),6));
		  dateCondition.append("$lte",DateUtil.addDay(DateUtil.getfirstday(),9));
		  whereMap.put("createdate", dateCondition);
		  Long nowdayTime9=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(9);
		  data.add(nowdayTime9);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.addDay(DateUtil.getfirstday(),9));
		  dateCondition.append("$lte",DateUtil.addDay(DateUtil.getfirstday(),12));
		  whereMap.put("createdate", dateCondition);
		  Long nowdayTime12=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(12);
		  data.add(nowdayTime12);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.addDay(DateUtil.getfirstday(),12));
		  dateCondition.append("$lte",DateUtil.addDay(DateUtil.getfirstday(),15));
		  whereMap.put("createdate", dateCondition);
		  Long nowdayTime15=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(15);
		  data.add(nowdayTime15);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.addDay(DateUtil.getfirstday(),15));
		  dateCondition.append("$lte",DateUtil.addDay(DateUtil.getfirstday(),18));
		  whereMap.put("createdate", dateCondition);
		  Long nowdayTime18=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		 
		  data.add(18);
		  data.add(nowdayTime18);
		  Datalist1.add(data);
		  data=new ArrayList<>(); 
		  
		  whereMap.clear();
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.addDay(DateUtil.getfirstday(),18));
		  dateCondition.append("$lte",DateUtil.addDay(DateUtil.getfirstday(),21));
		  whereMap.put("createdate", dateCondition);
		  Long nowdayTime21=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		 
		  data.add(21);
		  data.add(nowdayTime21);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  
		  whereMap.clear();
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.addDay(DateUtil.getfirstday(),21));
		  dateCondition.append("$lte",DateUtil.addDay(DateUtil.getfirstday(),24));
		  whereMap.put("createdate", dateCondition);
		  Long nowdayTime24=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		 
		  data.add(24);
		  data.add(nowdayTime24);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  
		  whereMap.clear();
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.addDay(DateUtil.getfirstday(),24));
		  dateCondition.append("$lte",DateUtil.addDay(DateUtil.getfirstday(),27));
		  whereMap.put("createdate", dateCondition);
		  Long nowdayTime27=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		 
		  data.add(27);
		  data.add(nowdayTime27);
		  Datalist1.add(data);
		  data=new ArrayList<>(); 
		  
		  whereMap.clear();
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.addDay(DateUtil.getfirstday(),27));
		  dateCondition.append("$lte",DateUtil.addDay(DateUtil.getfirstday(),30));
		  whereMap.put("createdate", dateCondition);
		  Long nowdayTime30=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		 
		  data.add(30);
		  data.add(nowdayTime30);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  
		  Struts2Utils.getRequest().setAttribute("Datalist1", Datalist1);
		  Datalist1.clear();
		  whereMap.clear();
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.getLastfirstday());
		  dateCondition.append("$lte",DateUtil.addDay(DateUtil.getLastfirstday(),3));
		  whereMap.put("createdate", dateCondition);
		  Long yesdayTime3=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(3);
		  data.add(yesdayTime3);
		  Datalist1.add(data);
		  data=new ArrayList<>(); 
		  whereMap.clear();
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.addDay(DateUtil.getLastfirstday(),3));
		  dateCondition.append("$lte",DateUtil.addDay(DateUtil.getLastfirstday(),6));
		  whereMap.put("createdate", dateCondition);
		  Long yesdayTime6=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(6);
		  data.add(yesdayTime6);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.addDay(DateUtil.getLastfirstday(),6));
		  dateCondition.append("$lte",DateUtil.addDay(DateUtil.getLastfirstday(),9));
		  whereMap.put("createdate", dateCondition);
		  Long yesdayTime9=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(9);
		  data.add(yesdayTime9);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.addDay(DateUtil.getLastfirstday(),9));
		  dateCondition.append("$lte",DateUtil.addDay(DateUtil.getLastfirstday(),12));
		  whereMap.put("createdate", dateCondition);
		  Long yesdayTime12=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(12);
		  data.add(yesdayTime12);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.addDay(DateUtil.getLastfirstday(),12));
		  dateCondition.append("$lte",DateUtil.addDay(DateUtil.getLastfirstday(),15));
		  whereMap.put("createdate", dateCondition);
		  Long yesdayTime15=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(15);
		  data.add(yesdayTime15);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.addDay(DateUtil.getLastfirstday(),15));
		  dateCondition.append("$lte",DateUtil.addDay(DateUtil.getLastfirstday(),18));
		  whereMap.put("createdate", dateCondition);
		  Long yesdayTime18=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(18);
		  data.add(yesdayTime18);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.addDay(DateUtil.getLastfirstday(),18));
		  dateCondition.append("$lte",DateUtil.addDay(DateUtil.getLastfirstday(),21));
		  whereMap.put("createdate", dateCondition);
		  Long yesdayTime21=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(21);
		  data.add(yesdayTime21);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.addDay(DateUtil.getLastfirstday(),21));
		  dateCondition.append("$lte",DateUtil.addDay(DateUtil.getLastfirstday(),24));
		  whereMap.put("createdate", dateCondition);
		  Long yesdayTime24=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(24);
		  data.add(yesdayTime24);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.addDay(DateUtil.getLastfirstday(),27));
		  dateCondition.append("$lte",DateUtil.addDay(DateUtil.getLastfirstday(),27));
		  whereMap.put("createdate", dateCondition);
		  Long yesdayTime27=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(27);
		  data.add(yesdayTime27);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.addDay(DateUtil.getLastfirstday(),27));
		  dateCondition.append("$lte",DateUtil.addDay(DateUtil.getLastfirstday(),30));
		  whereMap.put("createdate", dateCondition);
		  Long yesdayTime30=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(30);
		  data.add(yesdayTime30);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  Struts2Utils.getRequest().setAttribute("Datalist2", Datalist1);  
		  Struts2Utils.getRequest().setAttribute("state", 1);
		} 
	  
	return "statistics";
	   
  }
  public void ajaxStatistics(){
	  
	  //分时统计
	  Map<String, Object> sub_map = new HashMap<String, Object>();
	  String state=Struts2Utils.getParameter("state");
	  custid=SpringSecurityUtils.getCurrentUser().getId();
	  HashMap<String,Object>whereMap=new HashMap<>();
	  BasicDBObject dateCondition = new BasicDBObject();
	  List<Object>Datalist1=new ArrayList<>();
	  List<Object>data=new ArrayList<>(); 
	  if (Integer.parseInt(state)==0) {
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.getTimesmorning());
		  dateCondition.append("$lte",DateUtil.addHour(DateUtil.getTimesmorning(),4));
		  whereMap.put("createdate", dateCondition);
		  whereMap.put("custid", custid);
		  Long nowdayTime4=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(4);
		  data.add(nowdayTime4);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.addHour(DateUtil.getTimesmorning(),4));
		  dateCondition.append("$lte",DateUtil.addHour(DateUtil.getTimesmorning(),8));
		  whereMap.put("createdate", dateCondition);
		  whereMap.put("custid", custid);
		  Long nowdayTime8=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap); 
		  data.add(8);
		  data.add(nowdayTime8);
		  Datalist1.add(data); 
		  data=new ArrayList<>();
		  whereMap.clear();
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.addHour(DateUtil.getTimesmorning(),8));
		  dateCondition.append("$lte",DateUtil.addHour(DateUtil.getTimesmorning(),12));
		  whereMap.put("createdate", dateCondition);
		  whereMap.put("custid", custid);
		  Long nowdayTime12=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(12);
		  data.add(nowdayTime12);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.addHour(DateUtil.getTimesmorning(),12));
		  dateCondition.append("$lte",DateUtil.addHour(DateUtil.getTimesmorning(),16));
		  whereMap.put("createdate", dateCondition);
		  whereMap.put("custid", custid);
		  Long nowdayTime16=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(16);
		  data.add(nowdayTime16);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.addHour(DateUtil.getTimesmorning(),16));
		  dateCondition.append("$lte",DateUtil.addHour(DateUtil.getTimesmorning(),20));
		  whereMap.put("createdate", dateCondition);
		  whereMap.put("custid", custid);
		  Long nowdayTime20=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(20);
		  data.add(nowdayTime20);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.addHour(DateUtil.getTimesmorning(),20));
		  dateCondition.append("$lte",DateUtil.addHour(DateUtil.getTimesmorning(),24));
		  whereMap.put("createdate", dateCondition);
		  whereMap.put("custid", custid);
		  Long nowdayTime24=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		 
		  data.add(24);
		  data.add(nowdayTime24);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  sub_map.put("Datalist1", Datalist1);
		  Datalist1=new ArrayList<>();
		  
		  for(int i=1;i<=24;i++){
			  whereMap.clear();
			  dateCondition=new BasicDBObject();
			  Date ddDate=DateUtil.addDay(DateUtil.getTimesmorning(), -1);
			  dateCondition.append("$gte",ddDate);
			  dateCondition.append("$lte",DateUtil.addHour(ddDate,i));
			  whereMap.put("createdate", dateCondition);
			  whereMap.put("custid", custid);
			  Long yesdayTime4=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
			  data.add(i);
			  data.add(yesdayTime4); 
			  Datalist1.add(data); 
			  data=new ArrayList<>();
		  } 
		  sub_map.put("Datalist2", Datalist1); 
	  }else if(Integer.parseInt(state)==1){  
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.getTimesmornig(DateUtil.getfirstday()));
		  dateCondition.append("$lte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),1)));
		  whereMap.put("createdate", dateCondition);
		  whereMap.put("custid", custid);
		  Long nowdayTime1=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(1);
		  data.add(nowdayTime1);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),1)));
		  dateCondition.append("$lte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),2)));
		  whereMap.put("createdate", dateCondition);
		  whereMap.put("custid", custid);
		  Long nowdayTime2=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(2);
		  data.add(nowdayTime2);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),2)));
		  dateCondition.append("$lte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),3)));
		  whereMap.put("createdate", dateCondition);
		  whereMap.put("custid", custid);
		  Long nowdayTime3=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(3);
		  data.add(nowdayTime3);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),3)));
		  dateCondition.append("$lte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),4)));
		  whereMap.put("createdate", dateCondition);
		  whereMap.put("custid", custid);
		  Long nowdayTime4=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(4);
		  data.add(nowdayTime4);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  
		  
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),4)));
		  dateCondition.append("$lte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),5)));
		  whereMap.put("createdate", dateCondition);
		  whereMap.put("custid", custid);
		  Long nowdayTime5=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(5);
		  data.add(nowdayTime5);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  
		  
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),5)));
		  dateCondition.append("$lte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),6)));
		  whereMap.put("createdate", dateCondition);
		  whereMap.put("custid", custid);
		  Long nowdayTime6=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(6);
		  data.add(nowdayTime6);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  
		  
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),6)));
		  dateCondition.append("$lte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),7)));
		  whereMap.put("createdate", dateCondition);
		  whereMap.put("custid", custid);
		  Long nowdayTime7=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(7);
		  data.add(nowdayTime7);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),7)));
		  dateCondition.append("$lte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),8)));
		  whereMap.put("createdate", dateCondition);
		  whereMap.put("custid", custid);
		  Long nowdayTime8=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(8);
		  data.add(nowdayTime8);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),8)));
		  dateCondition.append("$lte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),9)));
		  whereMap.put("createdate", dateCondition);
		  whereMap.put("custid", custid);
		  Long nowdayTime9=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(9);
		  data.add(nowdayTime9);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),9)));
		  dateCondition.append("$lte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),10)));
		  whereMap.put("createdate", dateCondition);
		  whereMap.put("custid", custid);
		  Long nowdayTime10=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(10);
		  data.add(nowdayTime10);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),10)));
		  dateCondition.append("$lte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),11)));
		  whereMap.put("createdate", dateCondition);
		  whereMap.put("custid", custid);
		  Long nowdayTime11=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(11);
		  data.add(nowdayTime11);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),11)));
		  dateCondition.append("$lte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),12)));
		  whereMap.put("createdate", dateCondition);
		  whereMap.put("custid", custid);
		  Long nowdayTime12=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(12);
		  data.add(nowdayTime12);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),12)));
		  dateCondition.append("$lte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),13)));
		  whereMap.put("createdate", dateCondition);
		  whereMap.put("custid", custid);
		  Long nowdayTime13=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(13);
		  data.add(nowdayTime13);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),13)));
		  dateCondition.append("$lte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),14)));
		  whereMap.put("createdate", dateCondition);
		  whereMap.put("custid", custid);
		  Long nowdayTime14=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(14);
		  data.add(nowdayTime14);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),14)));
		  dateCondition.append("$lte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),15)));
		  whereMap.put("createdate", dateCondition);
		  whereMap.put("custid", custid);
		  Long nowdayTime15=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(15);
		  data.add(nowdayTime15);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),15)));
		  dateCondition.append("$lte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),16)));
		  whereMap.put("createdate", dateCondition);
		  whereMap.put("custid", custid);
		  Long nowdayTime16=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(16);
		  data.add(nowdayTime16);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),16)));
		  dateCondition.append("$lte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),17)));
		  whereMap.put("createdate", dateCondition);
		  whereMap.put("custid", custid);
		  Long nowdayTime17=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(17);
		  data.add(nowdayTime17);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),17)));
		  dateCondition.append("$lte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),18)));
		  whereMap.put("createdate", dateCondition);
		  whereMap.put("custid", custid);
		  Long nowdayTime18=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(18);
		  data.add(nowdayTime18);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),18)));
		  dateCondition.append("$lte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),19)));
		  whereMap.put("createdate", dateCondition);
		  whereMap.put("custid", custid);
		  Long nowdayTime19=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(19);
		  data.add(nowdayTime19);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),19)));
		  dateCondition.append("$lte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),20)));
		  whereMap.put("createdate", dateCondition);
		  whereMap.put("custid", custid);
		  Long nowdayTime20=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(20);
		  data.add(nowdayTime20);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),20)));
		  dateCondition.append("$lte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),21)));
		  whereMap.put("createdate", dateCondition);
		  whereMap.put("custid", custid);
		  Long nowdayTime21=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(21);
		  data.add(nowdayTime21);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),21)));
		  dateCondition.append("$lte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),22)));
		  whereMap.put("createdate", dateCondition);
		  whereMap.put("custid", custid);
		  Long nowdayTime22=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(22);
		  data.add(nowdayTime22);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),22)));
		  dateCondition.append("$lte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),23)));
		  whereMap.put("createdate", dateCondition);
		  whereMap.put("custid", custid);
		  Long nowdayTime23=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(23);
		  data.add(nowdayTime23);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),23)));
		  dateCondition.append("$lte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),24)));
		  whereMap.put("createdate", dateCondition);
		  whereMap.put("custid", custid);
		  Long nowdayTime24=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(24);
		  data.add(nowdayTime24);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  
		  
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),24)));
		  dateCondition.append("$lte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),25)));
		  whereMap.put("createdate", dateCondition);
		  whereMap.put("custid", custid);
		  Long nowdayTime25=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(25);
		  data.add(nowdayTime25);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),25)));
		  dateCondition.append("$lte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),26)));
		  whereMap.put("createdate", dateCondition);
		  whereMap.put("custid", custid);
		  Long nowdayTime26=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(26);
		  data.add(nowdayTime26);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),26)));
		  dateCondition.append("$lte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),27)));
		  whereMap.put("createdate", dateCondition);
		  whereMap.put("custid", custid);
		  Long nowdayTime27=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(27);
		  data.add(nowdayTime27);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),27)));
		  dateCondition.append("$lte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),28)));
		  whereMap.put("createdate", dateCondition);
		  whereMap.put("custid", custid);
		  Long nowdayTime28=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(28);
		  data.add(nowdayTime28);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),28)));
		  dateCondition.append("$lte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),29)));
		  whereMap.put("createdate", dateCondition);
		  whereMap.put("custid", custid);
		  Long nowdayTime29=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(29);
		  data.add(nowdayTime29);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear();
		  
		  dateCondition=new BasicDBObject();
		  dateCondition.append("$gte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),29)));
		  dateCondition.append("$lte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getfirstday(),30)));
		  whereMap.put("createdate", dateCondition);
		  whereMap.put("custid", custid);
		  Long nowdayTime30=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
		  data.add(30);
		  data.add(nowdayTime30);
		  Datalist1.add(data);
		  data=new ArrayList<>();
		  whereMap.clear(); 
		  
		  sub_map.put("Datalist1", Datalist1);
		  Datalist1=new ArrayList<>();
		  for(int i=1;i<=30;i++){ 
			  whereMap.clear();
			  dateCondition=new BasicDBObject();
			  dateCondition.append("$gte",DateUtil.getTimesmornig(DateUtil.getLastfirstday()));
			  dateCondition.append("$lte",DateUtil.getTimesmornig(DateUtil.addDay(DateUtil.getLastfirstday(),i)));
			  whereMap.put("createdate", dateCondition);
			  whereMap.put("custid", custid);
			  Long yesdayTime3=basedao.getCount(PubConstants.ACC_ACCOUNTING,whereMap);
			  data.add(i);
			  data.add(yesdayTime3);
			  Datalist1.add(data);
			  data=new ArrayList<>(); 
		  } 
		  sub_map.put("Datalist2", Datalist1);
	  }
	 
	  String json = JSONArray.fromObject(sub_map).toString();  
	  Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
  }
  public String print(){
	  String custid=SpringSecurityUtils.getCurrentUser().getId();
	  String id=Struts2Utils.getParameter("id");
	  if (StringUtils.isNotEmpty(id)) {
			String str[]=id.split(",");
			HashMap<String,Object>whereMap=new HashMap<>();
			HashMap<String,Object>sortMap=new HashMap<>();
			sortMap.put("createdate", -1);
			BasicDBList   dblist=new BasicDBList(); 
			for (String string : str) {
				if(StringUtils.isNotEmpty(string)){
					dblist.add(new BasicDBObject("_id",string));
				}
			} 
			whereMap.put("$or", dblist); 
			List<DBObject>list=basedao.getList(PubConstants.ACC_ACCOUNTING, whereMap, sortMap);
			Struts2Utils.getRequest().setAttribute("list",list);
		 }
	return "print";   
  } 
  public void getPrice(){
	  Map<String, Object> sub_map = new HashMap<String, Object>();
	  String id=Struts2Utils.getParameter("id");
	  if (StringUtils.isNotEmpty(id)) {
		 DBObject dbObject=basedao.getMessage(PubConstants.ACC_GOODS, Long.parseLong(id));
		 if (dbObject!=null) {
			 sub_map.put("price",dbObject.get("price"));
			 sub_map.put("title",dbObject.get("title"));
			 sub_map.put("state", 0);
		}
	  }else {
		sub_map.put("state", 1);
	  }
	  String json = JSONArray.fromObject(sub_map).toString();
	  Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
  }
  /**
   * 更新订单
   */
  public  void  setState(){
	  Map<String, Object> sub_map = new HashMap<String, Object>();
	  sub_map.put("state", 1);
	  try {
		  String id=Struts2Utils.getParameter("id");
		  String state=Struts2Utils.getParameter("state");
		  String invalids=Struts2Utils.getParameter("invalids");
		  if (StringUtils.isNotEmpty(id)) {
			DBObject dbObject=basedao.getMessage(PubConstants.ACC_ACCOUNTING, id);
			if (dbObject!=null) {
				Accounting accounting=(Accounting) UniObject.DBObjectToObject(dbObject, Accounting.class);
				accounting.setState(Integer.parseInt(state));
				if (StringUtils.isNotEmpty(invalids)) { 
					accounting.setInvalids(invalids);
				} 
				List<AccRecord> lsRecords=accounting.getLsRecords();
				List<AccRecord> list=new ArrayList<>();
				for (int i = 0; i < lsRecords.size(); i++) {
					JsonConfig jsonConfig = new JsonConfig(); 
					jsonConfig.setRootClass(AccRecord.class); 
					AccRecord accRecord=(AccRecord) JSONObject.toBean(JSONObject.fromObject(lsRecords.get(i)), jsonConfig);
					list.add(accRecord);
				}
				accounting.setLsRecords(list);
				basedao.insert(PubConstants.ACC_ACCOUNTING, accounting);
				sub_map.put("state",0); 
			}
		}
	 } catch (NumberFormatException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	  String json = JSONArray.fromObject(sub_map).toString();
	  Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
  }
   
  /**
   * 获取打印数据
   */
  public  void getPrintData(){
	  Map<String, Object> sub_map = new HashMap<String, Object>();
	  sub_map.put("state", 1);
	  String ids=Struts2Utils.getParameter("ids");
	  if (StringUtils.isNotEmpty(ids)) {
		String str[]=ids.split(",");
		HashMap<String,Object>whereMap=new HashMap<>();
		HashMap<String,Object>sortMap=new HashMap<>();
		sortMap.put("createdate", -1);
		BasicDBList   dblist=new BasicDBList(); 
		for (String string : str) {
			if(StringUtils.isNotEmpty(string)){
				dblist.add(new BasicDBObject("_id",string));
			}
		} 
		whereMap.put("$or", dblist); 
		List<DBObject>list=basedao.getList(PubConstants.ACC_ACCOUNTING, whereMap, sortMap);
		if(list.size()>0){
			sub_map.put("list",list);
			sub_map.put("state", 0);
		}
	 }
	  String json = JSONArray.fromObject(sub_map).toString();
	  Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
  }
  public void  updage() {
	  String sd="cc6a0bee-987e-4b55-bfcc-a53b380676dc";
	  HashMap<String,Object>whereMap=new HashMap<>();
	  whereMap.put("account", "元亨商贸");
	  DBObject dbObject=basedao.getMessage(PubConstants.USER_INFO, whereMap);
	  if (dbObject!=null) {
		UserInfo info=(UserInfo) UniObject.DBObjectToObject(dbObject, UserInfo.class);
		info.set_id(sd);
		basedao.insert(PubConstants.USER_INFO, info);
	}
	  
  } 
}
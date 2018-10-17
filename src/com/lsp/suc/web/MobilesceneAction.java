package com.lsp.suc.web;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.activemq.filter.function.splitFunction;
import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.alibaba.fastjson.JSON;
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
import com.lsp.suc.entity.AnimationInfo;
import com.lsp.suc.entity.Curtain;
import com.lsp.suc.entity.MobileScene;
import com.lsp.suc.entity.RollInfo;
import com.lsp.suc.entity.SceneInfo;
import com.lsp.suc.entity.Slide;
import com.lsp.suc.entity.SpiritInfo;
import com.lsp.suc.entity.StyleInfo;
import com.lsp.suc.entity.Text;
import com.lsp.wenxin.entity.WxToken;
import com.lsp.wenxin.util.WeiXinUtil;
import com.mongodb.DBObject;

/**
 * 移动场景管理
 * 
 * @author lsp
 * 
 */
@Namespace("/suc")
@Results({ @Result(name = MobilesceneAction.RELOAD, location = "mobilescene.action", type = "redirect") })
public class MobilesceneAction extends TotalAction<MobileScene> {

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

	private MobileScene entity = new MobileScene();
	private Long _id;

	public void set_id(Long _id) {
		this._id = _id;
	}

	@Override
	public String execute() throws Exception {
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		HashMap<String, Object> backMap = new HashMap<String, Object>();
		custid = SpringSecurityUtils.getCurrentUser().getId();
		sortMap.put("sort", -1);
		whereMap.put("custid", custid);

		String title = Struts2Utils.getParameter("title");
		if (StringUtils.isNotEmpty(title)) {
			Pattern pattern = Pattern.compile("^.*" + title + ".*$", Pattern.CASE_INSENSITIVE);
			whereMap.put("title", pattern);
			Struts2Utils.getRequest().setAttribute("title", title);
		}
		backMap.put("context", 0);
		backMap.put("summary", 0);

		if (StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))) {
			fypage = Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}

		List<DBObject> list = baseDao.getList(PubConstants.SUC_MOBLILESCENE, whereMap, fypage, 20, sortMap, backMap);
		fycount = baseDao.getCount(PubConstants.SUC_MOBLILESCENE, whereMap);
		Struts2Utils.getRequest().setAttribute("mobilesceneList", list);
		Struts2Utils.getRequest().setAttribute("custid", custid);
		return MobilesceneAction.SUCCESS;

	}

	@Override
	public String input() throws Exception {
		// TODO Auto-generated method stub
		Struts2Utils.getRequest().setAttribute("tab", 0);
		String msid = Struts2Utils.getParameter("msid");
		String custid = SpringSecurityUtils.getCurrentUser().getId();
		Struts2Utils.getRequest().setAttribute("custid", custid);
		if (StringUtils.isNotEmpty(msid)) {
			Struts2Utils.getRequest().setAttribute("entity",
					baseDao.getMessage(PubConstants.SUC_MOBLILESCENE, Long.parseLong(msid)));
		}
		Struts2Utils.getRequest().setAttribute("msid", msid);
		Struts2Utils.getRequest().setAttribute("scid", Struts2Utils.getParameter("scid"));
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		HashMap<String, Object> sortMap = new HashMap<String, Object>();

		whereMap.put("custid", custid);
		if (StringUtils.isNotEmpty(msid)) {

			whereMap.put("msid", Long.parseLong(msid));
		} else {
			whereMap.put("msid", null);
		}
		sortMap.put("sort", 1);
		List<DBObject> scenelist = baseDao.getList(PubConstants.SUC_SCENE, whereMap, sortMap);
		Struts2Utils.getRequest().setAttribute("scenelist", scenelist);
		Struts2Utils.getRequest().setAttribute("styleid", msid);
		return "add";
	}

	@Override
	public String update() throws Exception {
		// TODO Auto-generated method stub
		if (_id != null) {
			DBObject db = baseDao.getMessage(PubConstants.SUC_MOBLILESCENE, _id);
			Struts2Utils.getRequest().setAttribute("entity", db);
		}
		return "add";
	}

	/**
	 * 根据ID查询对应层集合
	 * 
	 * @return
	 */
	public String getSceneById() {
		String id = Struts2Utils.getParameter("id");
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		sortMap.put("sort", -1);
		whereMap.put("msid", Long.parseLong(id));
		List<DBObject> list = baseDao.getList(PubConstants.SUC_SCENE, whereMap, sortMap);
		Struts2Utils.getRequest().setAttribute("sceneList", list);
		return null;

	}

	/**
	 * 根据ID查询对应精灵集合
	 * 
	 * @return
	 */
	public String getSpiritById() {
		String id = Struts2Utils.getParameter("id");
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		sortMap.put("sort", -1);
		whereMap.put("scid", Long.parseLong(id));
		List<DBObject> list = baseDao.getList(PubConstants.SUC_SPIRIT, whereMap, sortMap);
		Struts2Utils.getRequest().setAttribute("spiritList", list);
		return null;

	}

	/**
	 * 查询图层集合
	 */
	public void getScene() {
		String id = Struts2Utils.getParameter("id");
		String custid = Struts2Utils.getParameter("custid");
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		Map<String, Object> sub_map = new HashMap<String, Object>();
		sortMap.put("sort", 1);
		whereMap.put("msid", Long.parseLong(id));
		whereMap.put("custid", custid);
		List<DBObject> list = baseDao.getList(PubConstants.SUC_SCENE, whereMap, sortMap);
		if (list.size() > 0) {
			sub_map.put("list", list);
			sub_map.put("state", 0);
		} else {
			sub_map.put("state", 1);
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);

	}

	/**
	 * 查询精灵集合
	 */
	public void getSpirits() {
		String id = Struts2Utils.getParameter("id");
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		Map<String, Object> sub_map = new HashMap<String, Object>();
		sortMap.put("sort", 1);
		whereMap.put("scid", Long.parseLong(id));
		List<DBObject> list = baseDao.getList(PubConstants.SUC_SPIRIT, whereMap, sortMap);
		if (list.size() > 0) {
			sub_map.put("list", list);
			sub_map.put("state", 0);
		} else {
			sub_map.put("state", 1);
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);

	}

	/**
	 * ajax删除精灵
	 */
	public void deleteSpirit() {
		try {
			String id = Struts2Utils.getParameter("id");
			String scid = Struts2Utils.getParameter("scid");
			String custid = Struts2Utils.getParameter("custid");
			HashMap<String, Object> whereMap = new HashMap<String, Object>();
			HashMap<String, Object> sortMap = new HashMap<String, Object>();
			Map<String, Object> sub_map = new HashMap<String, Object>();
			if (StringUtils.isNotEmpty(id)) {
				baseDao.delete(PubConstants.SUC_SPIRIT, Long.parseLong(id));
				baseDao.delete(PubConstants.SUC_STYLEINFO, custid + "-scene-" + scid + "-" + id);
				baseDao.delete(PubConstants.SUC_ANIMATIONINFO, custid + "-scene-" + scid + "-" + id);
				sub_map.put("delete", 0);
			}
			sortMap.put("sort", 1);
			whereMap.put("scid", Long.parseLong(scid));
			List<DBObject> list = baseDao.getList(PubConstants.SUC_SPIRIT, whereMap, sortMap);
			if (list.size() > 0) {
				sub_map.put("list", list);
				sub_map.put("state", 0);
			} else {
				sub_map.put("state", 1);
			}

			String json = JSONArray.fromObject(sub_map).toString();
			Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * 保存层
	 * 
	 * @return
	 */
	public String saveScene() {
		try {
			String id = Struts2Utils.getParameter("id");
			String msid = Struts2Utils.getParameter("msid");
			Struts2Utils.getRequest().setAttribute("msid", msid);
			Struts2Utils.getRequest().setAttribute("tab", Struts2Utils.getParameter("tab"));
			String title = Struts2Utils.getParameter("title");
			String summary = Struts2Utils.getParameter("summary");
			String picurl = Struts2Utils.getParameter("picurl");
			String sort = Struts2Utils.getParameter("sort");
			String custid = SpringSecurityUtils.getCurrentUser().getId();
			Struts2Utils.getRequest().setAttribute("custid", custid);
			SceneInfo sceneInfo = new SceneInfo();
			if (!StringUtils.isNotEmpty(id)) {
				sceneInfo.set_id(mongoSequence.currval(PubConstants.SUC_SCENE));
			} else {
				sceneInfo.set_id(Long.parseLong(id));
			}
			sceneInfo.setPicurl(picurl);
			sceneInfo.setMsid(Long.parseLong(msid));
			sceneInfo.setSort(Integer.parseInt(sort));
			sceneInfo.setTitle(title);
			sceneInfo.setSummary(summary);
			sceneInfo.setCustid(custid);
			baseDao.insert(PubConstants.SUC_SCENE, sceneInfo);
			HashMap<String, Object> whereMap = new HashMap<String, Object>();
			HashMap<String, Object> sortMap = new HashMap<String, Object>();
			whereMap.put("custid", custid);
			sortMap.put("sort", 1);
			whereMap.put("msid", Long.parseLong(msid));
			List<DBObject> scenelist = baseDao.getList(PubConstants.SUC_SCENE, whereMap, sortMap);
			Struts2Utils.getRequest().setAttribute("scenelist", scenelist);
			Struts2Utils.getRequest().setAttribute("entity",
					baseDao.getMessage(PubConstants.SUC_MOBLILESCENE, Long.parseLong(msid)));
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "add";

	}

	/**
	 * 保存精灵
	 * 
	 * @return
	 */
	public String saveSpirit() {
		try {
			String id = Struts2Utils.getParameter("id");
			String scid = Struts2Utils.getParameter("scid");
			Struts2Utils.getRequest().setAttribute("scid", scid);
			Struts2Utils.getRequest().setAttribute("tab", Struts2Utils.getParameter("tab"));
			String title = Struts2Utils.getParameter("title");
			String summary = Struts2Utils.getParameter("summary");
			String picurl = Struts2Utils.getParameter("picurl");
			String sort = Struts2Utils.getParameter("sort");
			SpiritInfo spiritInfo = new SpiritInfo();
			if (!StringUtils.isNotBlank(id)) {
				spiritInfo.set_id(mongoSequence.currval(PubConstants.SUC_SPIRIT));
			}
			spiritInfo.set_id(Long.parseLong(id));
			spiritInfo.setPicurl(picurl);
			spiritInfo.setScid(Long.parseLong(id));
			spiritInfo.setSort(Integer.parseInt(sort));
			spiritInfo.setSummary(summary);
			spiritInfo.setTitle(title);
			baseDao.insert(PubConstants.SUC_SPIRIT, spiritInfo);
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

	}

	/**
	 * 根据ID修改层
	 * 
	 * @return
	 */
	public void updateSceneById() {
		String id = Struts2Utils.getParameter("id");
		try {
			if (StringUtils.isNotEmpty(id)) {
				DBObject db = baseDao.getMessage(PubConstants.SUC_SCENE, Long.parseLong(id));
				String json = JSONObject.fromObject(db).toString();
				Struts2Utils.renderJson(json, new String[0]);

			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	/**
	 * 根据ID修改精灵
	 * 
	 * 
	 */
	public void updateSpirit() {
		String id = Struts2Utils.getParameter("id");
		DBObject db = baseDao.getMessage(PubConstants.SUC_SPIRIT, Long.parseLong(id));
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}

	/**
	 * ajax更新或添加精灵
	 */
	public void updSpirit() {
		try {
			String id = Struts2Utils.getParameter("id");
			String custid = Struts2Utils.getParameter("custid");
			String title = Struts2Utils.getParameter("title");
			String picurl = Struts2Utils.getParameter("picurl");
			String url = Struts2Utils.getParameter("url");
			String summary = Struts2Utils.getParameter("summary");
			String sort = Struts2Utils.getParameter("sort");
			String scid = Struts2Utils.getParameter("scid");
			String type = Struts2Utils.getParameter("type");
			String width = Struts2Utils.getParameter("width");
			String height = Struts2Utils.getParameter("height");
			SpiritInfo obj = null;
			if (StringUtils.isNotEmpty(id)) {
				DBObject db = baseDao.getMessage(PubConstants.SUC_SPIRIT, Long.parseLong(id));
				if (db == null) {
					obj = new SpiritInfo();

					obj.set_id(mongoSequence.currval(PubConstants.SUC_SPIRIT));
				} else {
					obj = (SpiritInfo) UniObject.DBObjectToObject(db, SpiritInfo.class);
				}
			} else {
				obj = new SpiritInfo();
				obj.set_id(mongoSequence.currval(PubConstants.SUC_SPIRIT));
			}
			obj.setPicurl(picurl);
			obj.setScid(Long.parseLong(scid));
			obj.setSort(Integer.parseInt(sort));
			obj.setSummary(summary);
			obj.setUrl(url);
			obj.setTitle(title);
			obj.setCustid(custid);
			obj.setType(type);
			baseDao.insert(PubConstants.SUC_SPIRIT, obj);

			if (StringUtils.isEmpty(id)) {
				StyleInfo style = new StyleInfo();
				style.set_id(custid + "-scene-" + scid + "-" + obj.get_id());
				if (StringUtils.isNotEmpty(width)) {
					style.setWidth(width);
				} else {
					style.setWidth("0");
				}
				if (StringUtils.isNotEmpty(height)) {
					style.setHeight(height);
				} else {
					style.setHeight("0");
				}
				style.setMarginleft("0");
				style.setMargintop("0");
				style.setRadius("0");
				baseDao.insert(PubConstants.SUC_STYLEINFO, style);

			}

			HashMap<String, Object> whereMap = new HashMap<String, Object>();
			HashMap<String, Object> sortMap = new HashMap<String, Object>();
			Map<String, Object> sub_map = new HashMap<String, Object>();
			whereMap.put("custid", custid);
			whereMap.put("scid", Long.parseLong(scid));
			sortMap.put("sort", 1);
			List<DBObject> list = baseDao.getList(PubConstants.SUC_SPIRIT, whereMap, sortMap);
			if (list.size() > 0) {
				sub_map.put("list", list);
				sub_map.put("state", 0);
			} else {
				sub_map.put("state", 1);
			}
			String json = JSONArray.fromObject(sub_map).toString();
			Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public String save() throws Exception {
		// TODO Auto-generated method stub
		try {
			if (_id == null) {
				_id = mongoSequence.currval(PubConstants.SUC_MOBLILESCENE);
			}
			entity.set_id(_id);
			entity.setToUser(SpringSecurityUtils.getCurrentUser().getToUser());
			entity.setCustid(SpringSecurityUtils.getCurrentUser().getId());
			entity.setCreatedate(new Date());
			baseDao.insert(PubConstants.SUC_MOBLILESCENE, entity);
			Struts2Utils.getRequest().setAttribute("msid", _id);
			Struts2Utils.getRequest().setAttribute("entity", entity);
			Struts2Utils.getRequest().setAttribute("tab", Struts2Utils.getParameter("tab"));

			HashMap<String, Object> whereMap = new HashMap<String, Object>();
			HashMap<String, Object> sortMap = new HashMap<String, Object>();
			String custid = SpringSecurityUtils.getCurrentUser().getId();
			whereMap.put("custid", custid);
			whereMap.put("msid", _id);
			sortMap.put("sort", 1);
			Struts2Utils.getRequest().setAttribute("custid", custid);
			Struts2Utils.getRequest().setAttribute("msid", _id);
			List<DBObject> scenelist = baseDao.getList(PubConstants.SUC_SCENE, whereMap, sortMap);
			Struts2Utils.getRequest().setAttribute("scenelist", scenelist);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "add";
	}

	@Override
	public String delete() throws Exception {
		custid = SpringSecurityUtils.getCurrentUser().getId();
		// TODO Auto-generated method stub
		try {
			if (_id != null) {
				// 加载场景
				DBObject db = baseDao.getMessage(PubConstants.SUC_MOBLILESCENE, _id);

				// 加载图层
				HashMap<String, Object> whereMap = new HashMap<String, Object>();
				HashMap<String, Object> sortMap = new HashMap<String, Object>();
				whereMap.put("msid", _id);
				sortMap.put("sort", 1);
				List<DBObject> scenelist = baseDao.getList(PubConstants.SUC_SCENE, whereMap, sortMap);
				for (DBObject dbObject : scenelist) {
					SceneInfo scene = (SceneInfo) UniObject.DBObjectToObject(dbObject, SceneInfo.class);
					// 加载精灵
					HashMap<String, Object> whereSpiritMap = new HashMap<String, Object>();
					HashMap<String, Object> sortSpiritMap = new HashMap<String, Object>();
					whereSpiritMap.put("scid", Long.parseLong(scene.get("_id").toString()));
					sortSpiritMap.put("sort", 1);
					List<DBObject> spritlist = baseDao.getList(PubConstants.SUC_SPIRIT, whereSpiritMap, sortSpiritMap);
					for (DBObject dbObject2 : spritlist) {
						SpiritInfo spirit = (SpiritInfo) UniObject.DBObjectToObject(dbObject2, SpiritInfo.class);
						// 删除样式
						baseDao.delete(PubConstants.SUC_STYLEINFO, db.get("custid").toString() + "-scene-"
								+ scene.get_id().toString() + "-" + spirit.get_id().toString());
						// 删除动画
						baseDao.delete(PubConstants.SUC_ANIMATIONINFO, db.get("custid").toString() + "-scene-"
								+ scene.get_id().toString() + "-" + spirit.get_id().toString());

					}
					// 删除精灵
					baseDao.delete(PubConstants.SUC_SPIRIT, whereSpiritMap);
				}
				// 删除图层
				baseDao.delete(PubConstants.SUC_SCENE, whereMap);

			}
			// 删除场景
			baseDao.delete(PubConstants.SUC_MOBLILESCENE, _id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return RELOAD;
	}

	@Override
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub
		if (_id != null) {
			DBObject db = baseDao.getMessage(PubConstants.SUC_MOBLILESCENE, _id);
			entity = (MobileScene) UniObject.DBObjectToObject(db, MobileScene.class);
		} else {
			entity = new MobileScene();
		}

	}

	@Override
	public MobileScene getModel() {
		// TODO Auto-generated method stub
		return entity;
	}

	public String web() {
		String custid = Struts2Utils.getParameter("custid");
		Struts2Utils.getRequest().setAttribute("custid", custid);
		String msid = Struts2Utils.getParameter("msid");
		WxToken token = CacheResource.wxtoken.get(CacheResource.wxtouser.get(SysConfig.getProperty("custid")));
		Struts2Utils.getRequest().setAttribute("token", WeiXinUtil.getSignature(token, Struts2Utils.getRequest()));
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		List<String> animalist = new ArrayList<String>();

		try {
			if (StringUtils.isNotEmpty(msid)) {
				DBObject db = baseDao.getMessage(PubConstants.SUC_MOBLILESCENE, Long.parseLong(msid));
				Struts2Utils.getRequest().setAttribute("entity", db);

				DBObject mp3 = baseDao.getMessage(PubConstants.SUC_STYLEINFO,
						custid + "-mp3-" + db.get("_id").toString());
				Struts2Utils.getRequest().setAttribute("mp3", mp3);

				whereMap.put("msid", Long.parseLong(msid));
				sortMap.put("sort", 1);
				List<DBObject> scenelist = baseDao.getList(PubConstants.SUC_SCENE, whereMap, sortMap);

				whereMap.clear();
				for (DBObject dbObject : scenelist) {
					whereMap.put("scid", Long.parseLong(dbObject.get("_id").toString()));
					List<DBObject> spritlist = baseDao.getList(PubConstants.SUC_SPIRIT, whereMap, sortMap);
					for (DBObject dbObject2 : spritlist) {
						DBObject spiritStyle = baseDao.getMessage(PubConstants.SUC_STYLEINFO, custid + "-scene-"
								+ dbObject.get("_id").toString() + "-" + dbObject2.get("_id").toString());
						dbObject2.put("style", spiritStyle);

						DBObject spiritAnima = baseDao.getMessage(PubConstants.SUC_ANIMATIONINFO, custid + "-scene-"
								+ dbObject.get("_id").toString() + "-" + dbObject2.get("_id").toString());
						dbObject2.put("anima", spiritAnima);
						if (spiritAnima != null) {
							animalist.add(spiritAnima.get("_id").toString());
						}

					}
					dbObject.put("spritlist", spritlist);
				}
				Struts2Utils.getRequest().setAttribute("scenelist", scenelist);
				System.out.println(scenelist);
			}

			Struts2Utils.getRequest().setAttribute("animalist", animalist);
			Struts2Utils.getRequest().setAttribute("roll", webService.getRoll(custid, "scene" + msid));
			Struts2Utils.getRequest().setAttribute("slide", webService.getSlide(custid, "scene" + msid));
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "web";

	}

	public String yl() {
		String custid = Struts2Utils.getParameter("custid");
		Struts2Utils.getRequest().setAttribute("custid", custid);
		String msid = Struts2Utils.getParameter("msid");
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		List<String> animalist = new ArrayList<String>();

		try {
			if (StringUtils.isNotEmpty(msid)) {
				DBObject db = baseDao.getMessage(PubConstants.SUC_MOBLILESCENE, Long.parseLong(msid));
				Struts2Utils.getRequest().setAttribute("entity", db);

				DBObject mp3 = baseDao.getMessage(PubConstants.SUC_STYLEINFO,
						custid + "-mp3-" + db.get("_id").toString());
				Struts2Utils.getRequest().setAttribute("mp3", mp3);

				whereMap.put("msid", Long.parseLong(msid));
				sortMap.put("sort", 1);
				List<DBObject> scenelist = baseDao.getList(PubConstants.SUC_SCENE, whereMap, sortMap);

				whereMap.clear();
				for (DBObject dbObject : scenelist) {
					whereMap.put("scid", Long.parseLong(dbObject.get("_id").toString()));
					List<DBObject> spritlist = baseDao.getList(PubConstants.SUC_SPIRIT, whereMap, sortMap);
					for (DBObject dbObject2 : spritlist) {
						DBObject spiritStyle = baseDao.getMessage(PubConstants.SUC_STYLEINFO, custid + "-scene-"
								+ dbObject.get("_id").toString() + "-" + dbObject2.get("_id").toString());
						dbObject2.put("style", spiritStyle);

						DBObject spiritAnima = baseDao.getMessage(PubConstants.SUC_ANIMATIONINFO, custid + "-scene-"
								+ dbObject.get("_id").toString() + "-" + dbObject2.get("_id").toString());
						dbObject2.put("anima", spiritAnima);
						if (spiritAnima != null) {
							animalist.add(spiritAnima.get("_id").toString());
						}

					}
					dbObject.put("spritlist", spritlist);
				}
				Struts2Utils.getRequest().setAttribute("scenelist", scenelist);
				System.out.println(scenelist);
			}

			Struts2Utils.getRequest().setAttribute("animalist", animalist);
			Struts2Utils.getRequest().setAttribute("roll", webService.getRoll(custid, "scene" + msid));
			Struts2Utils.getRequest().setAttribute("slide", webService.getSlide(custid, "scene" + msid));
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "yl";

	}

	public void updateMp3() {
		String id = Struts2Utils.getParameter("id");
		String custid = Struts2Utils.getParameter("custid");
		String ml = Struts2Utils.getParameter("ml");
		String mt = Struts2Utils.getParameter("mt");
		String h = Struts2Utils.getParameter("h");
		String w = Struts2Utils.getParameter("w");
		DBObject db = baseDao.getMessage(PubConstants.SUC_STYLEINFO, custid + "-mp3-" + id);
		StyleInfo obj;
		if (db == null) {
			obj = new StyleInfo();
			obj.set_id(custid + "-mp3-" + id);

		} else {

		}
		obj = (StyleInfo) UniObject.DBObjectToObject(db, StyleInfo.class);
		obj.setMarginleft(ml);
		obj.setMargintop(mt);
		obj.setWidth(w);
		obj.setHeight(h);
		baseDao.insert(PubConstants.SUC_STYLEINFO, obj);
		String json = JSONObject.fromObject(obj).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}

	public void updStyle() {

		String id = Struts2Utils.getParameter("id");
		DBObject db = baseDao.getMessage(PubConstants.SUC_STYLEINFO, id);
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}

	public void updateStyle() {
		String id = Struts2Utils.getParameter("id");
		String custid = Struts2Utils.getParameter("custid");
		String type = Struts2Utils.getParameter("type");
		String ml = Struts2Utils.getParameter("ml");
		String mt = Struts2Utils.getParameter("mt");
		String h = Struts2Utils.getParameter("h");
		String w = Struts2Utils.getParameter("w");
		String radius = Struts2Utils.getParameter("radius");
		String color = Struts2Utils.getParameter("color");

		DBObject db = baseDao.getMessage(PubConstants.SUC_STYLEINFO, custid + "-" + type + "-" + id);
		StyleInfo obj;
		if (db == null) {
			obj = new StyleInfo();
			obj.set_id(custid + "-" + type + "-" + id);

		} else {
			obj = (StyleInfo) UniObject.DBObjectToObject(db, StyleInfo.class);
		}

		obj.setMarginleft(ml);
		obj.setMargintop(mt);
		obj.setWidth(w);
		obj.setHeight(h);
		obj.setRadius(radius);
		obj.setColor(color);
		baseDao.insert(PubConstants.SUC_STYLEINFO, obj);
		String json = JSONObject.fromObject(obj).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}

	public void updAnima() {
		String id = Struts2Utils.getParameter("id");
		DBObject db = baseDao.getMessage(PubConstants.SUC_ANIMATIONINFO, id);
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}

	public void updateAnima() {
		String id = Struts2Utils.getParameter("id");
		String custid = Struts2Utils.getParameter("custid");
		String type = Struts2Utils.getParameter("type");
		String value = Struts2Utils.getParameter("value");
		String time = Struts2Utils.getParameter("time");
		String iterate = Struts2Utils.getParameter("iterate");
		String duration = Struts2Utils.getParameter("duration");
		String keep = Struts2Utils.getParameter("keep");

		DBObject db = baseDao.getMessage(PubConstants.SUC_ANIMATIONINFO, custid + "-" + type + "-" + id);
		AnimationInfo obj;
		if (db == null) {
			obj = new AnimationInfo();
			obj.set_id(custid + "-" + type + "-" + id);

		} else {
			obj = (AnimationInfo) UniObject.DBObjectToObject(db, AnimationInfo.class);
		}
		if (StringUtils.isNotEmpty(time)) {
			obj.setDuration(time);
		} else {
			obj.setDuration("1");
		}
		if (StringUtils.isNotEmpty(iterate)) {
			if (Integer.parseInt(iterate) > 0) {
				obj.setIterate(iterate);
			} else {
				obj.setIterate("infinite");
			}

		} else {
			obj.setIterate("infinite");
		}

		obj.setValue(value);
		obj.setDuration(duration);
		obj.setKeep(keep);
		baseDao.insert(PubConstants.SUC_ANIMATIONINFO, obj);
		String json = JSONObject.fromObject(obj).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}

	/**
	 * ajax删除图层
	 */
	public void delScene() {
		String id = Struts2Utils.getParameter("id");
		String msid = Struts2Utils.getParameter("msid");
		custid = SpringSecurityUtils.getCurrentUser().getId();
		if (StringUtils.isNotEmpty(id)) {
			// 加载图层
			DBObject db = baseDao.getMessage(PubConstants.SUC_SCENE, Long.parseLong(id));

			// 加载精灵
			HashMap<String, Object> whereSpiritMap = new HashMap<String, Object>();
			HashMap<String, Object> sortSpiritMap = new HashMap<String, Object>();
			whereSpiritMap.put("scid", Long.parseLong(db.get("_id").toString()));
			sortSpiritMap.put("sort", 1);
			List<DBObject> spritlist = baseDao.getList(PubConstants.SUC_SPIRIT, whereSpiritMap, sortSpiritMap);
			for (DBObject dbObject : spritlist) {
				SpiritInfo spirit = (SpiritInfo) UniObject.DBObjectToObject(dbObject, SpiritInfo.class);
				// 删除样式
				baseDao.delete(PubConstants.SUC_STYLEINFO,
						db.get("custid").toString() + "-scene-" + id + "-" + spirit.get_id().toString());
				// 删除样式
				baseDao.delete(PubConstants.SUC_ANIMATIONINFO,
						db.get("custid").toString() + "-scene-" + id + "-" + spirit.get_id().toString());
				// 删除精灵
				baseDao.delete(PubConstants.SUC_SPIRIT, Long.parseLong(spirit.get_id().toString()));
			}
			// 删除图层
			baseDao.delete(PubConstants.SUC_SCENE, Long.parseLong(id));
		}
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		whereMap.put("msid", Long.parseLong(msid));
		whereMap.put("custid", custid);
		sortMap.put("sort", 1);
		List<DBObject> list = baseDao.getList(PubConstants.SUC_SCENE, whereMap, sortMap);
		Map<String, Object> sub_map = new HashMap<String, Object>();

		if (list.size() > 0) {
			sub_map.put("list", list);
			sub_map.put("state", 0);
		} else {
			sub_map.put("state", 1);
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);

	}

	/**
	 * 获取系统全部场景模板
	 */
	public String getAll() {
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		HashMap<String, Object> backMap = new HashMap<String, Object>();
		sortMap.put("sort", -1);

		String title = Struts2Utils.getParameter("title");
		if (StringUtils.isNotEmpty(title)) {
			Pattern pattern = Pattern.compile("^.*" + title + ".*$", Pattern.CASE_INSENSITIVE);
			whereMap.put("title", pattern);
			Struts2Utils.getRequest().setAttribute("title", title);
		}
		backMap.put("_id", 1);
		backMap.put("title", 1);
		backMap.put("sort", 1);
		backMap.put("picurl", 1);
		backMap.put("custid", 1);

		if (StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))) {
			fypage = Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}

		List<DBObject> list = baseDao.getList(PubConstants.SUC_MOBLILESCENE, whereMap, sortMap, backMap);
		Struts2Utils.getRequest().setAttribute("mobilesceneList", list);
		return "all";

	}

	/**
	 * 克隆场景
	 * 
	 * @return
	 */
	public String copyScene() {
		String msid = Struts2Utils.getParameter("msid");
		String custid = SpringSecurityUtils.getCurrentUser().getId();
		DBObject db = baseDao.getMessage(PubConstants.SUC_MOBLILESCENE, Long.parseLong(msid));
		MobileScene newenity = new MobileScene();
		MobileScene obj = (MobileScene) UniObject.DBObjectToObject(db, MobileScene.class);
		newenity.set_id(mongoSequence.currval(PubConstants.SUC_MOBLILESCENE));
		newenity.setContext(obj.getContext());
		newenity.setCreatedate(new Date());
		newenity.setFoot(obj.getFoot());
		newenity.setLogo(obj.getLogo());
		newenity.setMp3(obj.getMp3());
		newenity.setPicurl(obj.getPicurl());
		newenity.setSummary(obj.getSummary());
		newenity.setTitle(obj.getTitle() + "—副本");
		newenity.setSort(obj.getSort());
		newenity.setYdl(0);
		newenity.setCustid(custid);
		baseDao.insert(PubConstants.SUC_MOBLILESCENE, newenity);
		// TODO Auto-generated method stub

		// 加载层
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		// whereMap.put("toUser",obj.getToUser());
		whereMap.put("msid", Long.parseLong(obj.get_id().toString()));
		sortMap.put("sort", 1);
		List<DBObject> scenelist = baseDao.getList(PubConstants.SUC_SCENE, whereMap, sortMap);
		for (DBObject dbObject : scenelist) {
			SceneInfo scene = (SceneInfo) UniObject.DBObjectToObject(dbObject, SceneInfo.class);
			SceneInfo newSceneInfo = new SceneInfo();
			newSceneInfo.set_id(mongoSequence.currval(PubConstants.SUC_SCENE));
			newSceneInfo.setCustid(custid);
			newSceneInfo.setMsid(Long.parseLong(newenity.get_id().toString()));
			newSceneInfo.setBg(scene.getBg());
			newSceneInfo.setPicurl(scene.getPicurl());
			newSceneInfo.setSort(scene.getSort());
			newSceneInfo.setTitle(scene.getTitle());
			newSceneInfo.setUrl(scene.getUrl());
			baseDao.insert(PubConstants.SUC_SCENE, newSceneInfo);
			// 加载精灵
			HashMap<String, Object> whereSpiritMap = new HashMap<String, Object>();
			HashMap<String, Object> sortSpiritMap = new HashMap<String, Object>();
			whereSpiritMap.put("scid", Long.parseLong(scene.get("_id").toString()));
			sortSpiritMap.put("sort", 1);
			List<DBObject> spritlist = baseDao.getList(PubConstants.SUC_SPIRIT, whereSpiritMap, sortSpiritMap);

			for (DBObject dbObject2 : spritlist) {
				SpiritInfo spirit = (SpiritInfo) UniObject.DBObjectToObject(dbObject2, SpiritInfo.class);
				SpiritInfo newspirit = (SpiritInfo) UniObject.DBObjectToObject(dbObject2, SpiritInfo.class);
				newspirit.set_id(mongoSequence.currval(PubConstants.SUC_SPIRIT));
				newspirit.setCustid(custid);
				newspirit.setScid(Long.parseLong(newSceneInfo.get_id().toString()));
				baseDao.insert(PubConstants.SUC_SPIRIT, newspirit);

				// 加载样式
				DBObject styledb = baseDao.getMessage(PubConstants.SUC_STYLEINFO, db.get("custid").toString()
						+ "-scene-" + scene.get_id().toString() + "-" + spirit.get_id().toString());
				if (styledb != null) {
					StyleInfo style = (StyleInfo) UniObject.DBObjectToObject(styledb, StyleInfo.class);
					StyleInfo newstyle = new StyleInfo();
					newstyle.set_id(custid + "-scene-" + newSceneInfo.get_id().toString() + "-"
							+ newspirit.get_id().toString());
					newstyle.setBackgroundcolor(style.getBackgroundcolor());
					newstyle.setAnimation(style.getAnimation());
					newstyle.setColor(style.getColor());
					newstyle.setHeight(style.getHeight());
					newstyle.setLocation(style.getLocation());
					newstyle.setMargin(style.getMargin());
					newstyle.setMarginleft(style.getMarginleft());
					newstyle.setMargintop(style.getMargintop());
					newstyle.setMb(style.getMb());
					newstyle.setPadding(style.getPadding());
					newstyle.setRadius(style.getRadius());
					newstyle.setSort(style.getSort());
					newstyle.setWidth(style.getWidth());
					baseDao.insert(PubConstants.SUC_STYLEINFO, newstyle);
				}

				// 加载动画
				DBObject animadb = baseDao.getMessage(PubConstants.SUC_ANIMATIONINFO, db.get("custid").toString()
						+ "-scene-" + scene.get_id().toString() + "-" + spirit.get_id().toString());

				if (animadb != null) {
					System.out.println("*****");
					System.out.println(animadb);
					System.out.println("-----");
					AnimationInfo anima = (AnimationInfo) UniObject.DBObjectToObject(animadb, AnimationInfo.class);
					AnimationInfo newanima = new AnimationInfo();
					newanima.set_id(custid + "-scene-" + newSceneInfo.get_id().toString() + "-"
							+ newspirit.get_id().toString());
					newanima.setDuration(anima.getDuration());
					newanima.setIterate(anima.getIterate());
					newanima.setKeep(anima.getKeep());
					newanima.setCustid(custid);
					newanima.setType(anima.getType());
					newanima.setValue(anima.getValue());
					baseDao.insert(PubConstants.SUC_ANIMATIONINFO, newanima);
				}

			}

		}
		whereMap.clear();
		sortMap.clear();
		whereMap.put("custid", custid);

		whereMap.put("msid", newenity.get_id());
		sortMap.put("sort", 1);
		List<DBObject> newscenelist = baseDao.getList(PubConstants.SUC_SCENE, whereMap, sortMap);
		Struts2Utils.getRequest().setAttribute("custid", custid);
		Struts2Utils.getRequest().setAttribute("entity", newenity);
		Struts2Utils.getRequest().setAttribute("scenelist", newscenelist);
		Struts2Utils.getRequest().setAttribute("msid", newenity.get_id().toString());
		Struts2Utils.getRequest().setAttribute("styleid", newenity.get_id().toString());
		Struts2Utils.getRequest().setAttribute("tab", 0);

		return "add";

	}

	/**
	 * 创建
	 * 
	 * @return
	 */
	public String create() { 
		String id=Struts2Utils.getParameter("id");
		custid=SpringSecurityUtils.getCurrentUser().getId();
		if(StringUtils.isNotEmpty(id)){
			DBObject db=baseDao.getMessage(PubConstants.SUC_MOBLILESCENE, Long.parseLong(id));
			if(db!=null){
				Struts2Utils.getRequest().setAttribute("msid", id);
			}else{
				//创建新场景
				MobileScene ms=new MobileScene();
				ms.set_id(mongoSequence.currval(PubConstants.SUC_MOBLILESCENE));
				ms.setCustid(SpringSecurityUtils.getCurrentUser().getId());
				ms.setCreatedate(new Date());
				ms.setTitle("空白场景");
				baseDao.insert(PubConstants.SUC_MOBLILESCENE, ms);
				Struts2Utils.getRequest().setAttribute("msid", ms.get_id());
			}
			 
		}else{
			//创建新场景
			/**MobileScene ms=new MobileScene();
			ms.set_id(mongoSequence.currval(PubConstants.SUC_MOBLILESCENE));
			ms.setCustid(SpringSecurityUtils.getCurrentUser().getId());
			ms.setCreatedate(new Date());
			ms.setTitle("空白场景");
			baseDao.insert(PubConstants.SUC_MOBLILESCENE, ms);
			id=ms.get_id().toString();
			Struts2Utils.getRequest().setAttribute("msid", ms.get_id());*/
		}
		//获取幻灯片样式
		DBObject slidestyle = baseDao.getMessage(PubConstants.SUC_STYLEINFO, custid + "-mbscene-"
				+ id + "-slide");  
		//获取滚动样式
		DBObject rollstyle = baseDao.getMessage(PubConstants.SUC_STYLEINFO, custid + "-mbscene-"
				+ id + "-roll");
	 
		Struts2Utils.getRequest().setAttribute("entity",baseDao.getMessage(PubConstants.SUC_MOBLILESCENE, Long.parseLong(id)));
		Struts2Utils.getRequest().setAttribute("slidestyle",slidestyle);
		Struts2Utils.getRequest().setAttribute("rollstyle",rollstyle); 
		
		return "create";
	}

	/**
	 * 创建空白图层
	 */
	public void create_layer() {
		// 获取场景ID
		Map<String, Object> sub_map = new HashMap<>();
		sub_map.put("state", 1);
		String sid = Struts2Utils.getParameter("sid");
		HashMap<String, Object> whereMap = new HashMap<>();
		whereMap.put("msid", Long.parseLong(sid));
		Long count = baseDao.getCount(PubConstants.SUC_SCENE, whereMap);
		SceneInfo sc = new SceneInfo();
		sc.set_id(mongoSequence.currval(PubConstants.SUC_SCENE));
		sc.setCustid(SpringSecurityUtils.getCurrentUser().getId());
		sc.setSort(Integer.parseInt((count + 1) + ""));
		sc.setTitle("图层" + sc.getSort());
		sc.setCreatedate(new Date());
		sc.setMsid(Long.parseLong(sid));
		baseDao.insert(PubConstants.SUC_SCENE, sc);
		sub_map.put("state", 0);
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);

	}

	/**
	 * 创建空白精灵
	 */
	public void create_elve() {
		// 获取场景ID
		Map<String, Object> sub_map = new HashMap<>();
		sub_map.put("state", 1);
		String cid = Struts2Utils.getParameter("cid");
		HashMap<String, Object> whereMap = new HashMap<>();
		whereMap.put("scid", Long.parseLong(cid));
		Long count = baseDao.getCount(PubConstants.SUC_SPIRIT, whereMap);
		SpiritInfo sc = new SpiritInfo();
		sc.set_id(mongoSequence.currval(PubConstants.SUC_SPIRIT));
		sc.setCustid(SpringSecurityUtils.getCurrentUser().getId());
		sc.setSort(Integer.parseInt((count + 1) + ""));
		sc.setTitle("精灵" + sc.getSort());
		sc.setCreatedate(new Date());
		sc.setScid(Long.parseLong(cid));
		baseDao.insert(PubConstants.SUC_SPIRIT, sc);
		sub_map.put("state", 0);
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);

	}

	/**
	 * 获取层
	 */
	public void get_layer() {
		Map<String, Object> sub_map = new HashMap<>();
		sub_map.put("state", 1);
		String id = Struts2Utils.getParameter("sid");
		HashMap<String, Object> whereMap = new HashMap<>();
		HashMap<String, Object> sortMap = new HashMap<>();
		whereMap.put("msid", Long.parseLong(id));
		sortMap.put("sort",-1);
		List<DBObject> list = baseDao.getList(PubConstants.SUC_SCENE, whereMap, sortMap);
		if (list.size() > 0) {
			sub_map.put("state", 0);
			sub_map.put("list", list);
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 获取模板(my=1个人模板，不传为获取全部模板)
	 */
	public void get_mb() {
		Map<String, Object> sub_map = new HashMap<>();
		sub_map.put("state", 1);
		String id = Struts2Utils.getParameter("sid");
		HashMap<String, Object> whereMap = new HashMap<>();
		HashMap<String, Object> sortMap = new HashMap<>();
		if(Struts2Utils.getParameter("my").equals("1")){
			whereMap.put("custid",SpringSecurityUtils.getCurrentUser().getId());
		} 
		sortMap.put("sort", 1);
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		List<DBObject> list = baseDao.getList(PubConstants.SUC_MOBLILESCENE, whereMap,fypage,20,sortMap);
		if (list.size() > 0) {
			sub_map.put("state", 0);
			sub_map.put("list", list);
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}

	/**
	 * 获取精灵
	 */
	public void get_elve() {
		Map<String, Object> sub_map = new HashMap<>();
		sub_map.put("state", 1);
		String id = Struts2Utils.getParameter("cid");
		HashMap<String, Object> whereMap = new HashMap<>();
		HashMap<String, Object> sortMap = new HashMap<>();
		whereMap.put("scid", Long.parseLong(id));
		sortMap.put("sort", -1);
		List<DBObject> list = baseDao.getList(PubConstants.SUC_SPIRIT, whereMap, sortMap);
		if (list.size() > 0) {
			sub_map.put("state", 0);
			sub_map.put("list", list);
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 根据层获取层和层下面的精灵数据
	 */
	public void  get_layer_ById(){
		custid=SpringSecurityUtils.getCurrentUser().getId();
		String  id=Struts2Utils.getParameter("id");
		Map<String, Object> sub_map = new HashMap<>();
		sub_map.put("state", 1);
		if(StringUtils.isNotEmpty(id)){
			DBObject  db=baseDao.getMessage(PubConstants.SUC_SCENE, Long.parseLong(id));
			if(db!=null){
				sub_map.put("state", 0);
				sub_map.put("obj",db);
				HashMap<String, Object> whereMap = new HashMap<>();
				HashMap<String, Object> sortMap = new HashMap<>();
				whereMap.put("scid", Long.parseLong(id));
				sortMap.put("sort", -1); 
				List<DBObject> list = baseDao.getList(PubConstants.SUC_SPIRIT, whereMap, sortMap);
				if (list.size() > 0) { 
					for (DBObject dbObject : list) { 
						DBObject spiritStyle = baseDao.getMessage(PubConstants.SUC_STYLEINFO, custid + "-scene-"
								+ id + "-" + dbObject.get("_id").toString());
						dbObject.put("style", spiritStyle);

						DBObject spiritAnima = baseDao.getMessage(PubConstants.SUC_ANIMATIONINFO, custid + "-scene-"
								+ id + "-" + dbObject.get("_id").toString());
						dbObject.put("anima", spiritAnima);
					}
					sub_map.put("list", list);
				}
				
				//获取文本
				list = baseDao.getList(PubConstants.SUC_TEXT, whereMap, sortMap);
				if (list.size() > 0) { 
					for (DBObject dbObject : list) {  
						DBObject spiritAnima = baseDao.getMessage(PubConstants.SUC_ANIMATIONINFO, custid + "-scene-"
								+ id + "-txt-" + dbObject.get("_id").toString());
						dbObject.put("anima", spiritAnima);
					}
					sub_map.put("text", list);
				}
			 
			} 
			String json = JSONArray.fromObject(sub_map).toString();
			Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		}
	}
	/**
	 * 根据id获取精灵
	 */
	public void get_elve_ById(){
		custid=SpringSecurityUtils.getCurrentUser().getId();
		String  id=Struts2Utils.getParameter("id");
		Map<String, Object> sub_map = new HashMap<>();
		sub_map.put("state",1);
		if(StringUtils.isNotEmpty(id)){
			DBObject  dbObject=baseDao.getMessage(PubConstants.SUC_SPIRIT, Long.parseLong(id));
			 
			if(dbObject!=null){
				DBObject spiritStyle = baseDao.getMessage(PubConstants.SUC_STYLEINFO, custid + "-scene-"
						+ dbObject.get("scid").toString() + "-" + dbObject.get("_id").toString());
				dbObject.put("style", spiritStyle);

				DBObject spiritAnima = baseDao.getMessage(PubConstants.SUC_ANIMATIONINFO, custid + "-scene-"
						+  dbObject.get("scid").toString() + "-" + dbObject.get("_id").toString());
				dbObject.put("anima", spiritAnima);
				sub_map.put("state",0);
				sub_map.put("data", dbObject);
			}
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length()-1), new String[0]);
	}

	/**
	 * 保存层数据
	 */
	public void  save_layer(){
		custid=SpringSecurityUtils.getCurrentUser().getId();
		String  id=Struts2Utils.getParameter("id");
		String  data=Struts2Utils.getParameter("layer");
		JSONObject layer=JSONObject.fromObject(data); 
		String  elvels=layer.getString("elvels");
		//文本框
		String  texts=layer.getString("texts");
		//滚动字幕
		String  roll=layer.getString("roll");
		//幻灯片
		String  slide=layer.getString("slide");
		JSONArray  lsevle=JSONArray.fromObject(elvels);
		
		Map<String, Object> sub_map = new HashMap<>();
		sub_map.put("state",1);
		//保存层
		SceneInfo s = new SceneInfo();
		s.set_id(Long.parseLong(layer.getString("id")));
		s.setCustid(SpringSecurityUtils.getCurrentUser().getId()); 
		s.setTitle(layer.getString("title")); 
		s.setMsid(Long.parseLong(id));
		s.setOpacity(layer.getString("opacity"));
		if(layer.get("sort")!=null){
			s.setSort(Integer.parseInt(layer.getString("sort")));	
		}
		
		if(layer.get("backgroundcolor")!=null){
			s.setBackgroundcolor(layer.getString("backgroundcolor"));
		} 
		s.setPicurl(layer.getString("picurl"));
		baseDao.insert(PubConstants.SUC_SCENE, s);
		//保存精灵数据
		for (Object object : lsevle) {
			JSONObject  elve=JSONObject.fromObject(object);
			SpiritInfo sc = new SpiritInfo();
			sc.set_id(Long.parseLong(elve.getString("id")));
			sc.setCustid(SpringSecurityUtils.getCurrentUser().getId()); 
			sc.setTitle(elve.getString("title")); 
			if(elve.get("title_color")!=null){
				sc.setTitle_color(elve.getString("title_color"));
			} 
			sc.setScid(Long.parseLong(layer.getString("id"))); 
			if(elve.get("picurl")!=null){
				sc.setPicurl(elve.getString("picurl"));
			} 
			if(elve.get("sort")!=null){
				sc.setSort(Integer.parseInt(elve.getString("sort")));
			} 
			if(elve.get("url")!=null){
				sc.setUrl(elve.getString("url"));
			} 
			baseDao.insert(PubConstants.SUC_SPIRIT, sc);
			//保存样式
			StyleInfo info=new StyleInfo(); 
			info.set_id(custid + "-scene-"
					+ layer.getString("id")+ "-" + elve.getString("id"));
			if(elve.get("picurl")!=null){
				info.setBackgroundimage(elve.getString("picurl"));
			} 
			info.setMarginleft(elve.getString("left"));
			info.setMargintop(elve.getString("top"));
			info.setColor(elve.getString("color"));
			info.setBackgroundcolor(elve.getString("backgroundcolor"));
			info.setShadow(elve.getString("box_shadow"));
			info.setWidth(elve.getString("width"));
			info.setHeight(elve.getString("height"));
			info.setBorder(elve.getString("border"));
			info.setOpacity(elve.getString("opacity"));
			info.setRadius(elve.getString("radius"));
			info.setZ_index(elve.getString("z_index"));
			
			if(elve.get("transform")!=null){
				info.setRotate(elve.getString("transform"));	
			}
			
			baseDao.insert(PubConstants.SUC_STYLEINFO, info); 
			
			
			//保存精灵动画
			AnimationInfo  anima=new AnimationInfo();
			anima.set_id(custid + "-scene-"
					+ layer.getString("id")+ "-" + elve.getString("id"));
			anima.setCustid(SpringSecurityUtils.getCurrentUser().getId());
			System.out.println("********-"+elve.getString("id"));
			System.out.println(elve.get("anima_value"));
			System.out.println(elve.get("anima_duration"));
			if(elve.get("anima_value")!=null){
				anima.setValue(elve.getString("anima_value"));
			}
			if(elve.get("anima_duration")!=null){
				anima.setDuration(elve.getString("anima_duration"));
			}
			if(elve.get("anima_iterate")!=null){
				anima.setIterate(elve.getString("anima_iterate"));
			}
			if(elve.get("anima_keep")!=null){
				anima.setKeep(elve.getString("anima_keep"));
			}
			if(elve.get("anima_type")!=null){
				anima.setType(elve.getString("anima_type"));
			} 
			baseDao.insert(PubConstants.SUC_ANIMATIONINFO, anima);
			
			
		}
	
		//保存文本
		JSONArray  lstext=JSONArray.fromObject(texts);
		for (Object object : lstext) {
			JSONObject obj=JSONObject.fromObject(object);
			Text txt=new Text();
			if(obj.get("id")!=null){
				txt.set_id(Long.parseLong(obj.getString("id")));
				if(obj.get("color")!=null){
					txt.setColor(obj.getString("color"));
				}
				if(obj.get("content")!=null){
					txt.setContent(obj.getString("content"));
				}
				
				txt.setCreatedate(new Date());
				txt.setCustid(SpringSecurityUtils.getCurrentUser().getId());
				txt.setScid(Long.parseLong(layer.getString("id"))); 
				if(obj.get("font_size")!=null){
					txt.setFont_size(obj.getString("font_size"));
				}
				if(obj.get("left")!=null){
					txt.setLeft(obj.getString("left"));
				}
				if(obj.get("top")!=null){
					txt.setTop(obj.getString("top"));
				}
				if(obj.get("line_height")!=null){
					txt.setLine_height(obj.getString("line_height"));
				}
				if(obj.get("min_height")!=null){
					txt.setMin_height(obj.getString("min_height"));
				}
				if(obj.get("position")!=null){
					txt.setPosition(obj.getString("position"));
				}
				if(obj.get("text_align")!=null){
					txt.setText_align(obj.getString("text_align"));
				} 
				baseDao.insert(PubConstants.SUC_TEXT, txt);
				
				//保存文本动画
				AnimationInfo  anima=new AnimationInfo();
				anima.set_id(custid + "-scene-"
						+ layer.getString("id")+ "-txt-" + obj.getString("id"));
				anima.setCustid(SpringSecurityUtils.getCurrentUser().getId());
				if(obj.get("anima_value")!=null){
					anima.setValue(obj.getString("anima_value"));
				}
				if(obj.get("anima_duration")!=null){
					anima.setDuration(obj.getString("anima_duration"));
				}
				if(obj.get("anima_iterate")!=null){
					anima.setIterate(obj.getString("anima_iterate"));
				}
				if(obj.get("anima_keep")!=null){
					anima.setKeep(obj.getString("anima_keep"));
				}
				if(obj.get("anima_type")!=null){
					anima.setType(obj.getString("anima_type"));
				} 
				baseDao.insert(PubConstants.SUC_ANIMATIONINFO, anima);
			}
		
		}
		 
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length()-1), new String[0]);
	}
	/**
	 * 获取幻灯片
	 */
	public void  getSlide(){
		SpringSecurityUtils.getCurrentUser().getId();
		String msid=Struts2Utils.getParameter("msid");
		Map<String, Object> sub_map = new HashMap<>();
		sub_map.put("state",1);
		List<DBObject>list=webService.getSlide(SpringSecurityUtils.getCurrentUser().getId(), "scene" + msid);
		if(list!=null&&list.size()>0){
			sub_map.put("state", 0);
			sub_map.put("list",list);
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length()-1), new String[0]);   
	}
	/**
	 * 获取滚动字幕
	 */
	public void  getRoll(){
		SpringSecurityUtils.getCurrentUser().getId();
		String msid=Struts2Utils.getParameter("msid");
		Map<String, Object> sub_map = new HashMap<>();
		sub_map.put("state",1);
		List<DBObject>list=webService.getRoll(SpringSecurityUtils.getCurrentUser().getId(), "scene" + msid);
		if(list!=null&&list.size()>0){
			sub_map.put("state", 0);
			sub_map.put("list",list);
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length()-1), new String[0]);  
	}
	/**
	 * 获取滚动字幕
	 */
	public void  getCurtain(){
		SpringSecurityUtils.getCurrentUser().getId();
		String msid=Struts2Utils.getParameter("msid");
		Map<String, Object> sub_map = new HashMap<>();
		sub_map.put("state",1);
		List<DBObject>list=webService.getRoll(SpringSecurityUtils.getCurrentUser().getId(), "scene" + msid);
		if(list!=null&&list.size()>0){
			sub_map.put("state", 0);
			sub_map.put("list",list);
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length()-1), new String[0]);  
	}
	/**
	 * 获取滚动字幕
	 */
	public void  updCurtain(){
		SpringSecurityUtils.getCurrentUser().getId();
		String msid=Struts2Utils.getParameter("msid");
		Map<String, Object> sub_map = new HashMap<>();
		sub_map.put("state",1);
		List<DBObject>list=webService.getRoll(SpringSecurityUtils.getCurrentUser().getId(), "scene" + msid);
		if(list!=null&&list.size()>0){
			sub_map.put("state", 0);
			sub_map.put("list",list);
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length()-1), new String[0]);  
	}
	/**
	 * 删除滚动
	 */
	public void  delRoll(){
		SpringSecurityUtils.getCurrentUser().getId(); ;
		Map<String, Object> sub_map = new HashMap<>();
		sub_map.put("state",1);
		String id=Struts2Utils.getParameter("id");
	    int count=baseDao.delete(PubConstants.SUC_ROLL, Long.parseLong(id));
	    if(count>0){
	    	sub_map.put("state", 0);
	    }
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length()-1), new String[0]);  
		
	}
	/**
	 * 删除幻灯片
	 */
    public void  delSlide(){
    	SpringSecurityUtils.getCurrentUser().getId(); ;
		Map<String, Object> sub_map = new HashMap<>();
		sub_map.put("state",1);
		String id=Struts2Utils.getParameter("id");
	    int count=baseDao.delete(PubConstants.SUC_SLIDE, Long.parseLong(id));
	    if(count>0){
	    	sub_map.put("state", 0);
	    }
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length()-1), new String[0]);  
	}
    /**
	 * 删除幻灯片
	 */
    public void  delCurtain(){
    	SpringSecurityUtils.getCurrentUser().getId(); ;
		Map<String, Object> sub_map = new HashMap<>();
		sub_map.put("state",1);
		String id=Struts2Utils.getParameter("id");
	    int count=baseDao.delete(PubConstants.SUC_CURTAIN, Long.parseLong(id));
	    if(count>0){
	    	sub_map.put("state", 0);
	    }
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length()-1), new String[0]);  
	}
    /**
     * 保存滚动字幕
     */
    public void  save_Roll(){
    	Map<String, Object> sub_map = new HashMap<>();
		sub_map.put("state",1);
    	String id=Struts2Utils.getParameter("id");
    	String type=Struts2Utils.getParameter("type");
    	String title=Struts2Utils.getParameter("title");
    	String sort=Struts2Utils.getParameter("sort");
    	String url=Struts2Utils.getParameter("url"); 
    	RollInfo roll=new RollInfo();
    	if(StringUtils.isNotEmpty(id)){
    		DBObject  obj=baseDao.getMessage(PubConstants.SUC_ROLL, Long.parseLong(id)); 
    		if(obj!=null){
    			roll=(RollInfo) UniObject.DBObjectToObject(obj, RollInfo.class);
    			roll.set_id(Long.parseLong(id));
    		}
    	}else{
    		roll.set_id(mongoSequence.currval(PubConstants.SUC_ROLL));
    	}
    	roll.setTitle(title);
    	roll.setType(type);
    	roll.setCreatedate(new Date());
    	roll.setCustid(SpringSecurityUtils.getCurrentUser().getId());
    	roll.setUrl(url);
    	roll.setSort(Integer.parseInt(sort));
    	baseDao.insert(PubConstants.SUC_ROLL, roll);
    	sub_map.put("state", 0);
    	String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length()-1), new String[0]);  
    	
    }
    /**
     * 保存幻灯片
     */
    public void  save_Slide(){
    	Map<String, Object> sub_map = new HashMap<>();
		sub_map.put("state",1);
    	String id=Struts2Utils.getParameter("id");
    	String type=Struts2Utils.getParameter("type");
    	String title=Struts2Utils.getParameter("title");
    	String sort=Struts2Utils.getParameter("sort");
    	String picurl=Struts2Utils.getParameter("picurl");
    	String url=Struts2Utils.getParameter("url");
    	
    	Slide roll=new Slide();
    	if(StringUtils.isNotEmpty(id)){
    		DBObject  obj=baseDao.getMessage(PubConstants.SUC_SLIDE, Long.parseLong(id)); 
    		if(obj!=null){
    			roll=(Slide) UniObject.DBObjectToObject(obj, Slide.class);
    			roll.set_id(Long.parseLong(id));
    		}
    	}else{
    		roll.set_id(mongoSequence.currval(PubConstants.SUC_SLIDE));
    	}
    	roll.setTitle(title);
    	roll.setType(type);
    	roll.setCreatedate(new Date());
    	roll.setCustid(SpringSecurityUtils.getCurrentUser().getId());
    	roll.setUrl(url);
    	roll.setPicurl(picurl);
    	roll.setSort(Integer.parseInt(sort));
    	baseDao.insert(PubConstants.SUC_SLIDE, roll);
    	sub_map.put("state", 0);
    	String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length()-1), new String[0]);  
    }
    
    /**
     * 保存幕布
     */
    public void  save_Curtain(){
    	Map<String, Object> sub_map = new HashMap<>();
		sub_map.put("state",1);
    	String id=Struts2Utils.getParameter("id");
    	String type=Struts2Utils.getParameter("type");
    	String title=Struts2Utils.getParameter("title");
    	String sort=Struts2Utils.getParameter("sort");
    	String picurl=Struts2Utils.getParameter("picurl");
    	String url=Struts2Utils.getParameter("url");
    	
    	Curtain roll=new Curtain();
    	if(StringUtils.isNotEmpty(id)){
    		DBObject  obj=baseDao.getMessage(PubConstants.SUC_CURTAIN, Long.parseLong(id)); 
    		if(obj!=null){
    			roll=(Curtain) UniObject.DBObjectToObject(obj, Curtain.class);
    			roll.set_id(Long.parseLong(id));
    		}
    	}else{
    		roll.set_id(mongoSequence.currval(PubConstants.SUC_CURTAIN));
    	}
    	roll.setTitle(title);
    	roll.setType(type);
    	roll.setCreatedate(new Date());
    	roll.setCustid(SpringSecurityUtils.getCurrentUser().getId());
    	roll.setUrl(url);
    	roll.setPicurl(picurl);
    	roll.setSort(Integer.parseInt(sort));
    	baseDao.insert(PubConstants.SUC_CURTAIN, roll);
    	sub_map.put("state", 0);
    	String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length()-1), new String[0]);  
    }
    /**
     * 获取文本
     */
    public void getText(){
    	SpringSecurityUtils.getCurrentUser().getId(); ;
		Map<String, Object> sub_map = new HashMap<>();
		sub_map.put("state",1);
		String id=Struts2Utils.getParameter("id");
		
		HashMap<String, Object>whereMap=new HashMap<>();
		HashMap<String, Object>sortMap=new HashMap<>();
		whereMap.put("scid",Long.parseLong(id));
		sortMap.put("createdate", -1);
		List<DBObject>list = baseDao.getList(PubConstants.SUC_TEXT, whereMap, sortMap);
		if (list.size() > 0) { 
			for (DBObject dbObject : list) {  
				DBObject spiritAnima = baseDao.getMessage(PubConstants.SUC_ANIMATIONINFO, custid + "-scene-"
						+ id + "-txt-" + dbObject.get("_id").toString());
				dbObject.put("anima", spiritAnima);
			}
			sub_map.put("list", list);
		} 
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length()-1), new String[0]);  
    }
    /**
     * 保存音乐
     */
    public void  saveMp3(){
    	SpringSecurityUtils.getCurrentUser().getId(); ;
		Map<String, Object> sub_map = new HashMap<>();
		sub_map.put("state",1);
		String id=Struts2Utils.getParameter("id");
		String music_url=Struts2Utils.getParameter("music_url");
		String music_color=Struts2Utils.getParameter("music_color");
		String music_transparent=Struts2Utils.getParameter("music_transparent");
		if(StringUtils.isNotEmpty(id)){
			DBObject db=baseDao.getMessage(PubConstants.SUC_MOBLILESCENE, Long.parseLong(id));
			MobileScene ms=(MobileScene) UniObject.DBObjectToObject(db, MobileScene.class);
			ms.set_id(Long.parseLong(id));
			ms.setMusic_color(music_color);
			ms.setMusic_transparent(music_transparent);
			ms.setMusic_url(music_url);
			baseDao.insert(PubConstants.SUC_MOBLILESCENE, ms);
			sub_map.put("state", 0);
		} 
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length()-1), new String[0]);  
    }
    /**
     * 保存分享
     */
    public void  saveShare(){
    	SpringSecurityUtils.getCurrentUser().getId(); ;
		Map<String, Object> sub_map = new HashMap<>();
		sub_map.put("state",1);
		String id=Struts2Utils.getParameter("id");
		String title=Struts2Utils.getParameter("title");
		String summary=Struts2Utils.getParameter("summary");
		String picurl=Struts2Utils.getParameter("picurl");
		if(StringUtils.isNotEmpty(id)){
			DBObject db=baseDao.getMessage(PubConstants.SUC_MOBLILESCENE, Long.parseLong(id));
			MobileScene ms=(MobileScene) UniObject.DBObjectToObject(db, MobileScene.class);
			ms.set_id(Long.parseLong(id));
			ms.setTitle(title);
			ms.setSummary(summary);
			ms.setPicurl(picurl);
			baseDao.insert(PubConstants.SUC_MOBLILESCENE, ms);
			sub_map.put("state", 0);
		} 
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length()-1), new String[0]);  
    }
    /**
     * 保存幻灯片和滚动字幕样式
     */
    public void  saveSlideRoll(){
    	String id=Struts2Utils.getParameter("id");
    	String slide=Struts2Utils.getParameter("slide");
    	String roll=Struts2Utils.getParameter("roll");
    	custid=SpringSecurityUtils.getCurrentUser().getId();
    	Map<String, Object> sub_map = new HashMap<>();
		sub_map.put("state",1);
    	//保存幻灯片样式
		JSONObject slideobj=JSONObject.fromObject(slide);  
		StyleInfo info=new StyleInfo(); 
		info.set_id(custid +"-mbscene-"
				+ id+ "-slide"); 
		System.out.println("slide"+info.get_id());
		if(slideobj.get("left")!=null){
			info.setMarginleft(slideobj.getString("left"));
		}
		if(slideobj.get("top")!=null){
			info.setMargintop(slideobj.getString("top"));
		}
		if(slideobj.get("color")!=null){
			info.setColor(slideobj.getString("color"));
		}
		if(slideobj.get("backgroundcolor")!=null){
			info.setBackgroundcolor(slideobj.getString("backgroundcolor")); 
		}
		if(slideobj.get("width")!=null){
			info.setWidth(slideobj.getString("width"));
		}
		if(slideobj.get("height")!=null){
			info.setHeight(slideobj.getString("height")); 
		}
		if(slideobj.get("radius")!=null){
			info.setRadius(slideobj.getString("radius"));
		}
		if(slideobj.get("z_index")!=null){
			info.setZ_index(slideobj.getString("z_index"));
		}
		
		baseDao.insert(PubConstants.SUC_STYLEINFO, info); 
		
		//保存滚动字幕样式
		JSONObject rollobj=JSONObject.fromObject(roll);  
		StyleInfo rollstyle=new StyleInfo(); 
		rollstyle.set_id(custid +"-mbscene-"
				+ id+ "-roll"); 
		System.out.println("roll"+info.get_id());
		if(rollobj.get("left")!=null){
			rollstyle.setMarginleft(rollobj.getString("left"));
		}
		if(rollobj.get("top")!=null){
			rollstyle.setMargintop(rollobj.getString("top"));
		}
		if(rollobj.get("color")!=null){
			rollstyle.setColor(rollobj.getString("color"));
		}
		if(rollobj.get("backgroundcolor")!=null){
			rollstyle.setBackgroundcolor(rollobj.getString("backgroundcolor")); 
		}
		if(rollobj.get("width")!=null){
			rollstyle.setWidth(rollobj.getString("width"));
		}
		if(rollobj.get("height")!=null){
			rollstyle.setHeight(rollobj.getString("height")); 
		}
		if(rollobj.get("radius")!=null){
			rollstyle.setRadius(rollobj.getString("radius"));
		}
		if(rollobj.get("z_index")!=null){
			rollstyle.setZ_index(rollobj.getString("z_index"));	
		} 
		baseDao.insert(PubConstants.SUC_STYLEINFO, rollstyle); 
		sub_map.put("state",0);
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length()-1), new String[0]);  
    }
    public String  index() {
		String custid = Struts2Utils.getParameter("custid");
		Struts2Utils.getRequest().setAttribute("custid", custid);
		String msid = Struts2Utils.getParameter("msid");
		Struts2Utils.getRequest().setAttribute("msid",msid);
		WxToken token = CacheResource.wxtoken.get(CacheResource.wxtouser.get(SysConfig.getProperty("custid")));
		Struts2Utils.getRequest().setAttribute("token", WeiXinUtil.getSignature(token, Struts2Utils.getRequest()));
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		List<String> animalist = new ArrayList<String>();

		try {
			if (StringUtils.isNotEmpty(msid)) {
				DBObject db = baseDao.getMessage(PubConstants.SUC_MOBLILESCENE, Long.parseLong(msid));
				Struts2Utils.getRequest().setAttribute("entity", db);

				DBObject mp3 = baseDao.getMessage(PubConstants.SUC_STYLEINFO,
						custid + "-mp3-" + db.get("_id").toString());
				Struts2Utils.getRequest().setAttribute("mp3", mp3);

				whereMap.put("msid", Long.parseLong(msid));
				sortMap.put("sort", -1);
				List<DBObject> scenelist = baseDao.getList(PubConstants.SUC_SCENE, whereMap, sortMap);

				whereMap.clear();
				for (DBObject dbObject : scenelist) {
					whereMap.put("scid", Long.parseLong(dbObject.get("_id").toString()));
					List<DBObject> spritlist = baseDao.getList(PubConstants.SUC_SPIRIT, whereMap, sortMap);
					
					for (DBObject dbObject2 : spritlist) {
						DBObject spiritStyle = baseDao.getMessage(PubConstants.SUC_STYLEINFO, custid + "-scene-"
								+ dbObject.get("_id").toString() + "-" + dbObject2.get("_id").toString());
						System.out.println(spiritStyle);
						dbObject2.put("style", spiritStyle);

						DBObject spiritAnima = baseDao.getMessage(PubConstants.SUC_ANIMATIONINFO, custid + "-scene-"
								+ dbObject.get("_id").toString() + "-" + dbObject2.get("_id").toString());
						System.out.println(spiritAnima);
						dbObject2.put("anima", spiritAnima);
						if (spiritAnima != null) {
							animalist.add(spiritAnima.get("_id").toString());
						}

					}
					dbObject.put("spritlist", spritlist);
					System.out.println(dbObject.get("spritlist"));
				}
				Struts2Utils.getRequest().setAttribute("scenelist", scenelist);
				System.out.println(scenelist);
			}

			Struts2Utils.getRequest().setAttribute("animalist", animalist);
			if(webService.getRoll(custid, "scene" + msid)!=null){
				Struts2Utils.getRequest().setAttribute("roll", webService.getRoll(custid, "scene" + msid));
			}else{
				Struts2Utils.getRequest().setAttribute("roll","");
			}
			if( webService.getSlide(custid, "scene" + msid)!=null){
				Struts2Utils.getRequest().setAttribute("slide", webService.getSlide(custid, "scene" + msid));
			}else{
				Struts2Utils.getRequest().setAttribute("slide","");
			}
			
			System.out.println(webService.getRoll(custid, "scene" + msid));
			//获取幻灯片样式
			DBObject slidestyle = baseDao.getMessage(PubConstants.SUC_STYLEINFO, custid + "-mbscene-"
					+ msid + "-slide");  
			//获取滚动样式
			DBObject rollstyle = baseDao.getMessage(PubConstants.SUC_STYLEINFO, custid + "-mbscene-"
					+ msid + "-roll");
		 
			 
			Struts2Utils.getRequest().setAttribute("slidestyle",slidestyle);
			Struts2Utils.getRequest().setAttribute("rollstyle",rollstyle); 
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "index";

	}
    public void  getIndexData(){
    	String custid = Struts2Utils.getParameter("custid");
		Struts2Utils.getRequest().setAttribute("custid", custid);
		String msid = Struts2Utils.getParameter("msid");
		Map<String, Object> sub_map = new HashMap<>();
		sub_map.put("state",1);
		WxToken token = CacheResource.wxtoken.get(CacheResource.wxtouser.get(SysConfig.getProperty("custid")));
		Struts2Utils.getRequest().setAttribute("token", WeiXinUtil.getSignature(token, Struts2Utils.getRequest()));
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		List<String> animalist = new ArrayList<String>();

		try {
			if (StringUtils.isNotEmpty(msid)) {
				DBObject db = baseDao.getMessage(PubConstants.SUC_MOBLILESCENE, Long.parseLong(msid));
				Struts2Utils.getRequest().setAttribute("entity", db);

				DBObject mp3 = baseDao.getMessage(PubConstants.SUC_STYLEINFO,
						custid + "-mp3-" + db.get("_id").toString());
				Struts2Utils.getRequest().setAttribute("mp3", mp3);

				whereMap.put("msid", Long.parseLong(msid));
				sortMap.put("sort", -1);
				List<DBObject> scenelist = baseDao.getList(PubConstants.SUC_SCENE, whereMap, sortMap);

				whereMap.clear();
				for (DBObject dbObject : scenelist) {
					whereMap.put("scid", Long.parseLong(dbObject.get("_id").toString()));
					List<DBObject> spritlist = baseDao.getList(PubConstants.SUC_SPIRIT, whereMap, sortMap);
					
					for (DBObject dbObject2 : spritlist) {
						DBObject spiritStyle = baseDao.getMessage(PubConstants.SUC_STYLEINFO, custid + "-scene-"
								+ dbObject.get("_id").toString() + "-" + dbObject2.get("_id").toString()); 
						dbObject2.put("style", spiritStyle);

						DBObject spiritAnima = baseDao.getMessage(PubConstants.SUC_ANIMATIONINFO, custid + "-scene-"
								+ dbObject.get("_id").toString() + "-" + dbObject2.get("_id").toString());
						 
						dbObject2.put("anima", spiritAnima);
						if (spiritAnima != null) {
							animalist.add(spiritAnima.get("_id").toString());
						}

					}
					dbObject.put("spritlist", spritlist); 
				} 
				if(scenelist.size()>0){
					sub_map.put("state",0);
					sub_map.put("list", scenelist);
				} 
			} 
			
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length()-1), new String[0]);  
    }
     
  
}

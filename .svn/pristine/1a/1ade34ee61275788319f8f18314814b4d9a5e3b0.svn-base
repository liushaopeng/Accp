package com.lsp.sys.security;

import com.alibaba.fastjson.JSON;
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.entity.FuncInfo;
import com.lsp.pub.entity.CacheResource;
import com.lsp.pub.entity.PubConstants; 
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.UniObject;
import com.lsp.wenxin.entity.WxToken;
import com.mongodb.DBObject;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
/***
 * 资源管理
 * @author lsp
 *
 */
@Transactional(readOnly=true)
public class ResourceDetailsServiceImpl  implements ResourceDetailsService{

  @Autowired
  private BaseDao baseDao;

  public LinkedHashMap<String, String> getRequestMap()
  {
	  HashMap<String, Object> funcsortMap =new HashMap<String, Object>();
	  funcsortMap.put("sort", 1);
	  List<DBObject> funcinfo=baseDao.getList(PubConstants.FUNC_INFO,null, funcsortMap);
	  List<FuncInfo> resourceList = new ArrayList<FuncInfo>();
		for(int i=0;i<funcinfo.size();i++){
			FuncInfo func=new FuncInfo();
			func=JSON.parseObject(funcinfo.get(i).toString(), FuncInfo.class);
			func.set_id((Long)funcinfo.get(i).get("_id"));
			resourceList.add(func);
		}

    ResourceScope.ALL_RESOURCE_LIST = resourceList;

    HashMap<String, Object> whereMap =new HashMap<String, Object>();
	LinkedHashMap<String, String> requestMap = new LinkedHashMap<String, String>(resourceList.size());
    for (FuncInfo resource : resourceList) {
    	//初始化加载一级菜单
      requestMap.put(resource.getUrl(), resource.getAuthName()); 
      if (resource.getParentid().longValue() == 0L) {
        whereMap.clear();
        whereMap.put("parentid", (Long)resource.get_id());
        List<FuncInfo> wfuncList=new ArrayList<FuncInfo>();
		List<DBObject> funcinfo2= baseDao.getList(PubConstants.FUNC_INFO,whereMap, funcsortMap);
        for (int i = 0; i < funcinfo2.size(); i++) {
          FuncInfo func = (FuncInfo)UniObject.DBObjectToObject((DBObject)funcinfo2.get(i), FuncInfo.class);

          func.set_id((Long)((DBObject)funcinfo2.get(i)).get("_id"));
          wfuncList.add(func); 
        }
        resource.setTfunc(wfuncList);
        CacheResource.setGetAllFunc(resource);
        
        List<DBObject>TokenList=baseDao.getList(PubConstants.WENXIN_WXTOKEN, null, null);
        for (DBObject dbObject : TokenList) {
        	if (dbObject.get("toUser")!=null) {
        		CacheResource.wxtoken.put(dbObject.get("toUser").toString(),(WxToken)UniObject.DBObjectToObject(dbObject,WxToken.class));
			}
        	
		}
        List<DBObject>UserList=baseDao.getList(PubConstants.USER_INFO, null, null);
        for (DBObject dbObject : UserList) {
        	if (dbObject.get("toUser")!=null) {
        		CacheResource.wxtouser.put(dbObject.get("_id").toString(), dbObject.get("toUser").toString());
			}
        	
		}
        
        
      }
    } 
    whereMap.clear();
    requestMap.put("/init.action", "ROLE_0");

    return requestMap;
  }
}
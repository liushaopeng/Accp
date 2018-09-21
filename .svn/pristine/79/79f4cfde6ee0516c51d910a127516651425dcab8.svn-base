package com.lsp.pub.service;
 
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.junit.internal.runners.ErrorReportingRunner;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
 
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence; 
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.UniObject;
import com.lsp.suc.entity.ImageInfo;
import com.mongodb.DB;
import com.mongodb.DBObject;
/**
 * 总服务
 * 
 * @author lsp
 * 
 */ 

@Component
@Transactional
public class AllService {

	@Autowired
	private BaseDao baseDao;
	private MongoSequence mongoSequence;
	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	}
	/**
	 * 获取父ID
	 */
	public String  getparentcustid(String custid){
		if(StringUtils.isNotEmpty(custid)){
			DBObject user=baseDao.getMessage(PubConstants.USER_INFO, custid);
			if(user!=null){
				if(user.get("custid")!=null){
					return user.get("custid").toString(); 
				}
			}
		}
		return null; 
	}
	/**
	 * 获取滚动字幕
	 * @param custid
	 * @param type
	 * @return
	 */
	public List<DBObject>getRoll(String custid,String type){
		HashMap<String,Object>whereMap=new HashMap<>();
		HashMap<String,Object>sortMap=new HashMap<>();
		sortMap.put("sort",-1);
		whereMap.put("custid", custid);
		whereMap.put("type",type);
		List<DBObject>list=baseDao.getList(PubConstants.SUC_ROLL, whereMap, sortMap);
		if(list.size()>0){
			return list;
		}
		return null; 
	}
	/**
	 * 获取幻灯片
	 * @param custid
	 * @param type
	 * @return
	 */
	public List<DBObject>getSlide(String custid,String type){
		HashMap<String,Object>whereMap=new HashMap<>();
		HashMap<String,Object>sortMap=new HashMap<>();
		sortMap.put("sort",-1);
		whereMap.put("custid", custid);
		whereMap.put("type",type);
		List<DBObject>list=baseDao.getList(PubConstants.SUC_SLIDE, whereMap, sortMap);
		if(list.size()>0){
			return list;
		}
		return null; 
	}
	/**
	 * 添加图片
	 * @param picurl
	 * @param title
	 * @param sort
	 * @param type
	 * @return
	 */
	public  boolean  addImg(String picurl,String title,String sort,String type,String width,String height){
		ImageInfo io=new ImageInfo();
		if(StringUtils.isNotEmpty(picurl)){
			io.set_id(mongoSequence.currval(PubConstants.SUC_IMAGE));
			io.setCreatedate(new Date());
			io.setCustid(SpringSecurityUtils.getCurrentUser().getId());
			io.setPicurl(picurl);
			io.setTitle(title);
			if(StringUtils.isNotEmpty(width)){
				io.setWidth(Double.parseDouble(width));
			}
			if(StringUtils.isNotEmpty(height)){
				io.setHeight(Double.parseDouble(height));
			}
			if(StringUtils.isNotEmpty(sort)){
				io.setSort(Integer.parseInt(sort));
			}
			if(StringUtils.isNotEmpty(type)){
				io.setType(Long.parseLong(type));
			}
			baseDao.insert(PubConstants.SUC_IMAGE, io); 
		}
		return false; 
	}
	
	 
}

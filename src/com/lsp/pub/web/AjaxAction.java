package com.lsp.pub.web;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream; 
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Results; 
import org.springframework.beans.factory.annotation.Autowired;

import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence; 
import com.lsp.pub.entity.PubConstants; 
import com.lsp.pub.service.AllService;
import com.lsp.pub.util.BaseDate;
import com.lsp.pub.util.BaseDecimal;
import com.lsp.pub.util.EncodeUtils; 
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.SysConfig;
import com.lsp.pub.util.UniObject; 
import com.mongodb.DBObject;

import net.sf.json.JSONArray;
/***
 * 通用ajax Action
 * @author lsp
 *
 */
@Namespace("/")
@Results({ @org.apache.struts2.convention.annotation.Result(name = "reload", location = "ajax.action", type = "redirect") })
public class AjaxAction extends TotalAction{
 
	@Autowired
	private BaseDao basedao;
	private MongoSequence mongoSequence;
	@Autowired
	private AllService allService;
    @Autowired
	public void setMongoSequence(MongoSequence mongoSequence)
	{
     this.mongoSequence = mongoSequence;
	}
	/**
	 * 裁剪上传图片
	 * @return
	 * @throws Exception 
	 */
	public void upimage() throws Exception {

		String baseurl=Struts2Utils.getParameter("baseurl"); 
		String type=baseurl.substring(0,baseurl.indexOf(";"));
		type=type.substring(type.indexOf("/")+1);
		String path=BaseDate.getDayUuid()+"-upimage."+type;  
		String imgBase64=baseurl.substring(baseurl.indexOf(",")+1); 
		byte[]files=EncodeUtils.decodeBuffer(imgBase64); 
	    File filess=new File(SysConfig.getProperty("imgpath"));
		if(!filess.exists()){
			filess.mkdir();  
		} 
		Date date = new Date();
			//格式化并转换String类型
		String dtpath=new SimpleDateFormat("yyyy/MM/dd").format(date);
			//创建文件夹
		File f = new File(SysConfig.getProperty("imgpath")+"/"+dtpath);
		if(!f.exists())
		f.mkdirs(); 
		File  createFile=new File(SysConfig.getProperty("imgpath")+"/"+dtpath+"/"+path); 
		OutputStream  fileWrite=new FileOutputStream(createFile);  
		fileWrite.write(files); 
		    
		fileWrite.flush();
		fileWrite.close();
		//同步图片
		String istb=Struts2Utils.getParameter("istb");
		String width=Struts2Utils.getParameter("width");
		String height=Struts2Utils.getParameter("height"); 
		if(StringUtils.isNotEmpty(istb)&&istb.equals("1")){
			allService.addImg(dtpath+"/"+path, Struts2Utils.getParameter("name"),null,null,width,height);
		}
		//File file=CodeImageUtil.base64StringToImage(baseurl,"/uploads/"+path);
		Map<String, Object> sub_map = new HashMap<String, Object>();
		sub_map.put("state", 0); 
		sub_map.put("path",dtpath+"/"+path);
		String json = JSONArray.fromObject(sub_map).toString();
		 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}

	@Override
	public Object getModel() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String input() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String update() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String save() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String delete() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub
		
	}
	 
}

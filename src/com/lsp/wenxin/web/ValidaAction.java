package com.lsp.wenxin.web;

import java.io.BufferedReader;
import java.io.IOException;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Results;
import org.omg.CosNaming.NamingContextExtPackage.StringNameHelper;
import org.springframework.beans.factory.annotation.Autowired;

import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.service.AllService; 
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.SysConfig;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.web.TotalAction;
import com.lsp.user.entity.UserInfo; 
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;

import net.sf.json.JSONArray;
import sun.rmi.server.UnicastRef;

/***
 * 通用ajax Action
 * @author lsp
 *
 */
@Namespace("/")
@Results({ @org.apache.struts2.convention.annotation.Result(name = "reload", location = "valida.action", type = "redirect") })
public class ValidaAction extends TotalAction{
 
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
	public void  accp() throws IOException {
		BufferedReader reader = new BufferedReader(Struts2Utils
				.getRequest().getReader());
		String line = null;
		StringBuffer buffer = new StringBuffer();

		while ((line = reader.readLine()) != null) {
			buffer.append(line);
		}
		String xml = buffer.toString(); 
		if(xml.length()==0){
			System.out.println("************");
			//验证 开始
			String signature = Struts2Utils.getParameter("signature");
			String timestamp = Struts2Utils.getParameter("timestamp");
			String nonce = Struts2Utils.getParameter("nonce");
			String echostr = Struts2Utils.getParameter("echostr");
			System.out.println(echostr); 
			Struts2Utils.getSession().setAttribute("echostr", echostr);
			if(StringUtils.isNotEmpty(echostr)){
				Struts2Utils.getResponse().getWriter().write(echostr);
			} 
			//验证 结束 
			return;
		}else {
			System.out.println("============");
		}
		Struts2Utils.getResponse().getWriter().write("success");
	}
 
	
} 

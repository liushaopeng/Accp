package com.lsp.pub.web;   
import com.lsp.pub.util.SysConfig; 
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.Preparable;  
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;  
/**
 * 通用action
 * @author lsp 
 *   
 */
public abstract class TotalAction<T> extends ActionSupport implements ModelDriven<T>, Preparable {

	private static final long serialVersionUID = 1L; 
	/** 进行增删改操作后,以redirect方式重新打开action默认页的result名.*/
	public static final String RELOAD = "reload";
	public static final String UPDATE = "update";
	public static final String LIST = "list";
	protected Logger logger = LoggerFactory.getLogger(getClass());
	private String cate_id; 
	public String filehttp; 
	public String custid; 
	//分页数据
	public long fycount;
	public int fypage=0;
	public int fyts=10;
	public String logo;
	
	//定义公共参数
	public long  parentid;
	public String type;
	//-- CRUD Action函数 --//
	/**
	 * Action函数,显示Entity列表界面.
	 * 建议return SUCCESS.
	 */

	/**
	 * Action函数,显示新增或修改Entity界面.
	 * 建议return INPUT.
	 */
	@Override
	public abstract String input() throws Exception;
	
	public abstract String update() throws Exception; 

	public  String list() throws Exception{
		return null;
	}
	
	public abstract String save() throws Exception; 
	public abstract String delete() throws Exception;
 
	public void prepare() throws Exception {
	} 
	public void prepareInput() throws Exception {
		prepareModel();
	} 
	public void prepareUpdate() throws Exception {
		prepareModel();
	} 
	public void prepareSch() throws Exception {
		prepareModel();
	}  
	protected abstract void prepareModel() throws Exception;

	public String getCate_id() {
		return cate_id;
	}

	public void setCate_id(String cate_id) {
		this.cate_id = cate_id;
	}
 
	public Logger getLogger() {
		return logger;
	}

	public void setLogger(Logger logger) {
		this.logger = logger;
	} 
	 
	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public static String getReload() {
		return RELOAD;
	}

	public static String getUpdate() {
		return UPDATE;
	}

	public static String getList() {
		return LIST;
	}

	public String getOsshttp() {
		
			return SysConfig.getProperty("osshttp");
		
	} 
	public long getFycount() {
		return fycount;
	}

	public void setFycount(long fycount) {
		this.fycount = fycount;
	}

	public int getFypage() {
		return fypage;
	}

	public void setFypage(int fypage) {
		this.fypage = fypage;
	}

	public int getFyts() {
		return fyts;
	}

	public void setFyts(int fyts) {
		this.fyts = fyts;
	}
	
	public long getParentid() {
		return parentid;
	}

	public void setParentid(long parentid) {
		this.parentid = parentid;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getFilehttp() {
		return SysConfig.getProperty("filehttp");
	}

	public void setFilehttp(String filehttp) {
		this.filehttp = filehttp;
	}  
	public void setCustid(String custid) {
		this.custid = custid;
	} 
 
}
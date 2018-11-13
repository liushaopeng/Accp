package com.lsp.suc.entity;

import com.mongodb.ReflectionDBObject;
import java.util.List;
/**
 * 文件夹
 * @author Administrator
 *
 */
public class FolderInfo extends ReflectionDBObject {
	private Integer sort;
	private String toUser;
	private Long custid;
	private String title;
	private int state;
	private String createdate;
	private List<FolderInfo> lsfolder; 
	private Long parentid; 
	private String type;

	public Long getParentid() {
		return this.parentid;
	}

	public void setParentid(Long parentid) {
		this.parentid = parentid;
	}

	public Integer getSort() {
		return this.sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	public String getToUser() {
		return this.toUser;
	}

	public void setToUser(String toUser) {
		this.toUser = toUser;
	}

	public Long getCustid() {
		return this.custid;
	}

	public void setCustid(Long custid) {
		this.custid = custid;
	}

	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getState() {
		return this.state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public String getCreatedate() {
		return this.createdate;
	}

	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}

	public List<FolderInfo> getLsfolder() {
		return this.lsfolder;
	}

	public void setLsfolder(List<FolderInfo> lsfolder) {
		this.lsfolder = lsfolder;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
 
}
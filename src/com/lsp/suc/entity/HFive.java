package com.lsp.suc.entity;

import java.util.Date; 
import com.mongodb.ReflectionDBObject;

/**
 * H5动画
 * @author lsp
 *
 */
public class HFive extends ReflectionDBObject{
 
	private String custid;
	private String type;
	private String mp3;
	/**
	 * logo图
	 */
	private String logo;
	/**
	 * 首页图片
	 */
	private String picurl;
	/**
	 * 首页链接
	 */
	private String url;
	private int sort;
	private Date createdate;
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getMp3() {
		return mp3;
	}
	public void setMp3(String mp3) {
		this.mp3 = mp3;
	}
	public String getLogo() {
		return logo;
	}
	public void setLogo(String logo) {
		this.logo = logo;
	}
	public String getPicurl() {
		return picurl;
	}
	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	
}

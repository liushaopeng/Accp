package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;

/**
 * 精灵
 * @author lsp
 *
 */
public class SpiritInfo extends ReflectionDBObject{

	private String custid;
	private String toUser;
	private int    sort;
	private String title;
	private String summary;
	private String picurl;
	private String url;
	/**
	 * 标题颜色
	 */
	private String title_color;
	/**
	 * 精灵类型0为普通（不带任何样式），1为两个一排（50%）2为3个一排（33%）3为4个一排（25%）
	 */
	private String type;
	//层ID
	private Long   scid;
	private Date   createdate; 
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	}
	public String getToUser() {
		return toUser;
	}
	public void setToUser(String toUser) {
		this.toUser = toUser;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	public String getPicurl() {
		return picurl;
	}
	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}
	public Long getScid() {
		return scid;
	}
	public void setScid(Long scid) {
		this.scid = scid;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getTitle_color() {
		return title_color;
	}
	public void setTitle_color(String title_color) {
		this.title_color = title_color;
	}
	 
	
}
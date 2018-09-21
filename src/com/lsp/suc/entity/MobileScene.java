package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/***
 * 资源管理
 * @author lsp
 *
 */
public class MobileScene extends ReflectionDBObject{
	private int  sort;
	private String custid;
	private String  toUser;
	/**
	 * 标题
	 */
	private String  title;
	 
	private String  context;
	private String  summary;
	private Date    createdate;
	private int     ydl;
	private String  picurl;
	private String  foot;
	private String  logo;
	private String  mp3;
	/**
	 * 音乐链接
	 */
	private String  music_url;
	/**
	 * 音乐图标颜色
	 */
	private String  music_color;
	/**
	 * 音乐透明度
	 */
	private String  music_transparent;
	 
	public String getMusic_url() {
		return music_url;
	}
	public void setMusic_url(String music_url) {
		this.music_url = music_url;
	}
	public String getMusic_color() {
		return music_color;
	}
	public void setMusic_color(String music_color) {
		this.music_color = music_color;
	}
	public String getMusic_transparent() {
		return music_transparent;
	}
	public void setMusic_transparent(String music_transparent) {
		this.music_transparent = music_transparent;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public String getToUser() {
		return toUser;
	}
	public void setToUser(String toUser) {
		this.toUser = toUser;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContext() {
		return context;
	}
	public void setContext(String context) {
		this.context = context;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	 
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public int getYdl() {
		return ydl;
	}
	public void setYdl(int ydl) {
		this.ydl = ydl;
	}
	public String getPicurl() {
		return picurl;
	}
	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}
	public String getFoot() {
		return foot;
	}
	public void setFoot(String foot) {
		this.foot = foot;
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
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	}
	

}

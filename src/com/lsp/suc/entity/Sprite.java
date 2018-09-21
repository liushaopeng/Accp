package com.lsp.suc.entity;

import java.util.Date;

import org.omg.CosNaming.NamingContextExtPackage.StringNameHelper;

import com.mongodb.ReflectionDBObject;

/**
 * 精灵
 * @author lsp
 *
 */
public class Sprite extends ReflectionDBObject{

	private String custid;
	private Long sid;
	private String picurl;
	private String wdtih;
	private String height;
	private int sort;
	/**
	 * 背景色
	 */
	private String bgcolor;
	/**
	 * 左边距（padding）
	 */
	private String pl;
	/**
	 * 右边距（padding）
	 */
	private String pr;
	/**
	 * 上边距（padding）
	 */
	private String pt;
	/**
	 * 下边距（padding）
	 */
	private String pb;
	/**
	 * 左边距（margin）
	 */
	private String ml;
	/**
	 * 右边距（margin）
	 */
	private String mr;
	/**
	 * 上边距（margin）
	 */
	private String mt;
	/**
	 * 下边距（margin）
	 */
	private String mb;
	/**
	 * 弧度
	 */
	private String radius;
	/**
	 * 动画
	 */
	private String anima;
	private Date createdate;
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	}
	public Long getSid() {
		return sid;
	}
	public void setSid(Long sid) {
		this.sid = sid;
	}
	public String getPicurl() {
		return picurl;
	}
	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}
	public String getWdtih() {
		return wdtih;
	}
	public void setWdtih(String wdtih) {
		this.wdtih = wdtih;
	}
	public String getHeight() {
		return height;
	}
	public void setHeight(String height) {
		this.height = height;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public String getBgcolor() {
		return bgcolor;
	}
	public void setBgcolor(String bgcolor) {
		this.bgcolor = bgcolor;
	}
	public String getPl() {
		return pl;
	}
	public void setPl(String pl) {
		this.pl = pl;
	}
	public String getPr() {
		return pr;
	}
	public void setPr(String pr) {
		this.pr = pr;
	}
	public String getPt() {
		return pt;
	}
	public void setPt(String pt) {
		this.pt = pt;
	}
	public String getPb() {
		return pb;
	}
	public void setPb(String pb) {
		this.pb = pb;
	}
	public String getMl() {
		return ml;
	}
	public void setMl(String ml) {
		this.ml = ml;
	}
	public String getMr() {
		return mr;
	}
	public void setMr(String mr) {
		this.mr = mr;
	}
	public String getMt() {
		return mt;
	}
	public void setMt(String mt) {
		this.mt = mt;
	}
	public String getMb() {
		return mb;
	}
	public void setMb(String mb) {
		this.mb = mb;
	}
	public String getRadius() {
		return radius;
	}
	public void setRadius(String radius) {
		this.radius = radius;
	}
	public String getAnima() {
		return anima;
	}
	public void setAnima(String anima) {
		this.anima = anima;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	
}

package com.lsp.suc.entity;

import com.mongodb.ReflectionDBObject;
/**
 * 动画样式
 * @author lsp
 *
 */
public class AnimationInfo extends ReflectionDBObject{

	private  String custid;
	private  String toUser; 
	private  int  sort;
	/**
	 * 动作分类（多个动作时候用）
	 */
	private  String type;
	/**
	 * 动画名称
	 */
	private  String value;
	/**
	 * 持续时间
	 */
	private  String duration;
	/**
	 * 迭代
	 */
	private  String iterate;
	/**
	 * 保持 0为开，1为关
	 */
	private  String keep;
	/**
	 * 延时
	 */
	private  String timeDelay; 
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public String getTimeDelay() {
		return timeDelay;
	}
	public void setTimeDelay(String timeDelay) {
		this.timeDelay = timeDelay;
	}
	public String getToUser() {
		return toUser;
	}
	public void setToUser(String toUser) {
		this.toUser = toUser;
	} 
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getDuration() {
		return duration;
	}
	public void setDuration(String duration) {
		this.duration = duration;
	}
	public String getIterate() {
		return iterate;
	}
	public void setIterate(String iterate) {
		this.iterate = iterate;
	}
	public String getKeep() {
		return keep;
	}
	public void setKeep(String keep) {
		this.keep = keep;
	}
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	}
	 
	

}

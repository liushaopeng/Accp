package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 文本
 * @author lsp
 *
 */
public class Text extends ReflectionDBObject{

	private String custid;
	private Long scid;
	private Date createdate;
	private String content;
	private String width; 
	private String min_height;
	private String top;
	private String left;
	private String color;
	private String position;
	private String line_height;
	private String text_align;
	private String font_size;
	public String getFont_size() {
		return font_size;
	}
	public void setFont_size(String font_size) {
		this.font_size = font_size;
	}
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	}
	public Long getScid() {
		return scid;
	}
	public void setScid(Long scid) {
		this.scid = scid;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWidth() {
		return width;
	}
	public void setWidth(String width) {
		this.width = width;
	}
	public String getMin_height() {
		return min_height;
	}
	public void setMin_height(String min_height) {
		this.min_height = min_height;
	}
	public String getTop() {
		return top;
	}
	public void setTop(String top) {
		this.top = top;
	}
	public String getLeft() {
		return left;
	}
	public void setLeft(String left) {
		this.left = left;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getLine_height() {
		return line_height;
	}
	public void setLine_height(String line_height) {
		this.line_height = line_height;
	}
	public String getText_align() {
		return text_align;
	}
	public void setText_align(String text_align) {
		this.text_align = text_align;
	} 
	
	
	
}

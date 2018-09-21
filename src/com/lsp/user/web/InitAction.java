package com.lsp.user.web;

import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Results;
/***
 * 初始化平台
 * @author lsp
 *
 */
@Namespace("/")
@Results({@org.apache.struts2.convention.annotation.Result(name="reload", location="init.action", type="redirect")})
public class InitAction extends ActionSupport
{
  private static final long serialVersionUID = 1L; 

  public String execute()
    throws Exception
  {
	   
    return "success";
  }
}
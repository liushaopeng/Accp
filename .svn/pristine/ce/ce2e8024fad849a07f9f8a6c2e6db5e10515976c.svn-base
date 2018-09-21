package com.lsp.user.web; 
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Results;

import com.lsp.pub.util.Struts2Utils;
import com.opensymphony.xwork2.ActionSupport;
/**
 * 注册
 * @author lsp
 *
 */
@Namespace("/")
@Results({@org.apache.struts2.convention.annotation.Result(name="reload", location="signup.action", type="redirect")})
public class SignupAction extends ActionSupport {

	private static final long serialVersionUID = 1L;

	public String execute() throws Exception {
		return "success";
	}

	public String error() throws Exception {
		addActionMessage("账号或密码错误");
		return "reload";
	} 
	 

}

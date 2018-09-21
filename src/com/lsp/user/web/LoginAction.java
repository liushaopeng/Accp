package com.lsp.user.web; 
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Results;

import com.lsp.pub.util.Struts2Utils;
import com.opensymphony.xwork2.ActionSupport;
/**
 * 登录
 * @author lsp
 *
 */
@Namespace("/")
@Results({@org.apache.struts2.convention.annotation.Result(name="reload", location="login.action", type="redirect")})
public class LoginAction extends ActionSupport {

	private static final long serialVersionUID = 1L;

	public String execute() throws Exception {
		return "success";
	}

	public String error() throws Exception {
		addActionMessage("账号或密码错误");
		return "reload";
	}
	public String signup() throws Exception { 
		return "signup";
	} 
	public String logout() throws Exception {
		try {
			Struts2Utils.getSession().invalidate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "out";
	}

}

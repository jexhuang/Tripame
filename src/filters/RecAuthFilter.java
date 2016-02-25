package filters;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;

import com.emp.model.*;

public class RecAuthFilter implements Filter {
	
	private FilterConfig config;
	
	public void init(FilterConfig config){
		this.config = config;
	}
	
	public void destroy(){
		config = null;
	}
    
  public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
        throws ServletException, IOException{

		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		// 【取得 session】
		HttpSession session = req.getSession();
		// 【從 session 判斷此user是否登入過】
		EmpVO empvo = (EmpVO) session.getAttribute("empvo");
		String rec = empvo.getEmprec();
		if ("disable".equals(rec)) {
			res.sendRedirect(req.getContextPath()
					+ "/tripame/BackSelectPage?page=auth");
			return;
		} else{
			chain.doFilter(request,response);
		}
	}
}

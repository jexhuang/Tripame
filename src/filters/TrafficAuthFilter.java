package filters;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;

import com.emp.model.*;

public class TrafficAuthFilter implements Filter {

	private FilterConfig config;

	public void init(FilterConfig config) {
		this.config = config;
	}

	public void destroy() {
		config = null;
	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws ServletException, IOException {

		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		// 【取得 session】
		HttpSession session = req.getSession();
		// 【從 session 判斷此user是否登入過】
		EmpVO empvo = (EmpVO) session.getAttribute("empvo");
		String traffic = empvo.getEmptraffic();
		if ("disable".equals(traffic)) {
			res.sendRedirect(req.getContextPath()
					+ "/tripame/BackSelectPage?page=auth");
			return;
		} else{
			chain.doFilter(request,response);
		}
	}
}

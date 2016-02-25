package com.mem.controller;

import java.io.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.DataSource;

import com.mem.model.MemService;
import com.mem.model.MemVO;

public class MemPicReader extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		res.setContentType("image/gif");
		ServletOutputStream out = res.getOutputStream();
		Integer memno = Integer.parseInt(req.getParameter("memno"));
		MemService memsvc = new MemService();
		MemVO memvo = memsvc.getOneMem(memno);
		InputStream in = new ByteArrayInputStream(memvo.getMempic());
		byte[] temp = new byte[4096];
		int read;
		try {
			while ((read = in.read(temp)) >= 0) {
				out.write(temp, 0, read);
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}

package com.rec.controller;

import java.io.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.DataSource;

import com.rec.model.*;


public class RecPicReader extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		res.setContentType("image/gif");
		ServletOutputStream out = res.getOutputStream();
		Integer recno = Integer.parseInt(req.getParameter("recno"));
		RecService recsvc = new RecService();
		RecVO recvo = recsvc.getOneRec(recno);
		InputStream in = new ByteArrayInputStream(recvo.getRecpic());
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

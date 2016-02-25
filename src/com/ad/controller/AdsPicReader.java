package com.ad.controller;

import java.io.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.DataSource;

import com.ad.model.*;


public class AdsPicReader extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		res.setContentType("image/gif");
		ServletOutputStream out = res.getOutputStream();
		Integer adno = Integer.parseInt(req.getParameter("adsno"));
		AdService adsvc = new AdService();
		AdVO advo = adsvc.getOneAd(adno);
		InputStream in = new ByteArrayInputStream(advo.getAdpic());
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

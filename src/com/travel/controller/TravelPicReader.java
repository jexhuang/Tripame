package com.travel.controller;

import java.io.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.DataSource;

import com.travel.model.*;

public class TravelPicReader extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		res.setContentType("image/gif");
		ServletOutputStream out = res.getOutputStream();
		Integer travelno = Integer.parseInt(req.getParameter("travelno"));
		TravelService trasvc=new TravelService();
		TravelVO travo = trasvc.getOneTravel(travelno);
		InputStream in = new ByteArrayInputStream(travo.getTravelpic());
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

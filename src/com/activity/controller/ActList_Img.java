package com.activity.controller;

import java.io.*;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.activity.model.ActivityService;
import com.activity.model.ActivityVO;
import com.spot.model.SpotDAO;
import com.spot.model.SpotService;
import com.spot.model.SpotVO;

/**
 * Servlet implementation class SpotList
 */

public class ActList_Img extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException 
	{
		res.setContentType("image/gif");

		try
		{
			ServletOutputStream out = res.getOutputStream();
			String actStr = req.getParameter("actno");
			
				int actno = Integer.parseInt(actStr);
				ActivityService actSvc = new ActivityService();
				ActivityVO actVO = actSvc.findAct(actno);
				InputStream in = new ByteArrayInputStream(actVO.getActpic());
				byte[] buffer = new byte[4*1024];
				int read = 0;
				while((read = in.read(buffer)) != -1)
				{
					out.write(buffer,0,read);
				}					
		}
		catch(Exception e)
		{
			e.getMessage();
		}		
	}

}

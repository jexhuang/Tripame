package com.mem.controller;

import java.net.*;
import java.io.*;

class GetURLConnectionContent {

	public static void returnFile(InputStream in, OutputStream out)
			throws IOException {
		byte[] buf = new byte[1024 * 1024];
		int bytesRead;
		while ((bytesRead = in.read(buf)) != -1) {
			out.write(buf, 0, bytesRead);
			System.out.println(bytesRead);
		}
	}
	public static void GetPic(String url) {
		URL urllink = null;
		try {
			urllink = new URL(url); // 建立URL物件url
			System.out.println(urllink);
		} catch (MalformedURLException e) {
			System.out.println("Malformed URL error!");
		}

		try {
			InputStream in = urllink.openStream();//urllink.openConnection().getInputStream();
			OutputStream out = new BufferedOutputStream(new FileOutputStream("C:/xxx/xxx.jpg"));
			returnFile(in,out);
			out.close();
			in.close();
		} catch (IOException ioe) {
			ioe.printStackTrace();
		}
	}
	
	public static void main(String args[]){
		GetURLConnectionContent.GetPic("http://graph.facebook.com/10202643896093128/picture?type=large");
	}
}
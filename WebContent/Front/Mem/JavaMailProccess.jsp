<%@ page language="java" import="java.util.*,java.io.*" contentType="text/html;charset=UTF-8" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="javax.activation.*" %>


<%!
	InternetAddress[] address = null ;
%>

<%

	String fpw=(String)request.getAttribute("fpw");
	String fname=(String)request.getAttribute("fname");
	String femail=(String)request.getAttribute("femail");
	String code=(String)request.getAttribute("code");
	String name=(String)request.getAttribute("name");
	String email=(String)request.getAttribute("email");
if(code!=null && name!=null && email!=null){
	String mailserver   = "140.115.236.9";
	String From         = "Tripame@gmail.com";
	String to           = email;
	String Subject      = "[Tripame]"+name+"會員您好";
  String messageText  = name+"會員您好，感謝您加入本網站，這是您的會員驗證碼:"+code+"\n輸入正確後，即驗證成功";      

        boolean sessionDebug = false;

try {

  // 設定所要用的Mail 伺服器和所使用的傳送協定
  java.util.Properties props = System.getProperties();
  props.put("mail.host",mailserver);
  props.put("mail.transport.protocol","smtp");
  
  // 產生新的Session 服務
  javax.mail.Session mailSession = javax.mail.Session.getDefaultInstance(props,null);
  mailSession.setDebug(sessionDebug);
	
  Message msg = new MimeMessage(mailSession);
  
  // 設定傳送郵件的發信人
  msg.setFrom(new InternetAddress(From));
  
  // 設定傳送郵件至收信人的信箱
  address = InternetAddress.parse(to,false);
  msg.setRecipients(Message.RecipientType.TO, address);
  
  // 設定信中的主題 
  msg.setSubject(Subject);
  // 設定送信的時間
  msg.setSentDate(new Date());
  
  // 設定傳送信的MIME Type
  msg.setText(messageText);
  
  // 送信
  Transport.send(msg);

      //response.sendRedirect("emp_select.jsp?msg=Y");
    System.out.println("傳送成功!");	
}
    catch (MessagingException mex) {
      //response.sendRedirect("emp_select.jsp?msg=N");
    System.out.println("傳送失敗!");
      //mex.printStackTrace();
    }
}


else{
	String mailserver   = "140.115.236.9";
	String From         = "Tripame@gmail.com";
	String to           = femail;
	String Subject      = "[Tripame]"+fname+"會員您好";
  String messageText  = fname+"會員您好，感謝您加入本網站，這是您新的會員密碼:"+fpw;      

        boolean sessionDebug = false;

try {

  // 設定所要用的Mail 伺服器和所使用的傳送協定
  java.util.Properties props = System.getProperties();
  props.put("mail.host",mailserver);
  props.put("mail.transport.protocol","smtp");
  
  // 產生新的Session 服務
  javax.mail.Session mailSession = javax.mail.Session.getDefaultInstance(props,null);
  mailSession.setDebug(sessionDebug);
	
  Message msg = new MimeMessage(mailSession);
  
  // 設定傳送郵件的發信人
  msg.setFrom(new InternetAddress(From));
  
  // 設定傳送郵件至收信人的信箱
  address = InternetAddress.parse(to,false);
  msg.setRecipients(Message.RecipientType.TO, address);
  
  // 設定信中的主題 
  msg.setSubject(Subject);
  // 設定送信的時間
  msg.setSentDate(new Date());
  
  // 設定傳送信的MIME Type
  msg.setText(messageText);
  
  // 送信
  Transport.send(msg);

      //response.sendRedirect("emp_select.jsp?msg=Y");
    System.out.println("傳送成功!");	
}
    catch (MessagingException mex) {
      //response.sendRedirect("emp_select.jsp?msg=N");
    System.out.println("傳送失敗!"); 
      //mex.printStackTrace();
    }
}
%>
package TestDB;

import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class MemMailService {
	private final String username = "hellotripame@gmail.com";
	private final String password = "ya101g1t";

	public void sendPassword(String code, String name, String email)
			throws MessagingException {
		
		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.socketFactory.port", "465");
		props.put("mail.smtp.socketFactory.class",
				"javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.port", "465");

		Session session = Session.getInstance(props, new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		});

		Message message = new MimeMessage(session);
		message.setFrom(new InternetAddress("hellotripame@gmail.com"));
		message.setRecipients(Message.RecipientType.TO,
				InternetAddress.parse(email));
		message.setSubject("[Tripame]會員"+name+"您好");
		message.setText("Dear： " + name + " ，這是您的會員驗證碼:" + code);

		Transport.send(message);
		System.out.println("Done");
	}

}

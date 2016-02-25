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

public class MailService {
	private final String username = "hellotripame@gmail.com";
	private final String password = "ya101g1t";

	public void sendPassword(String empName, String empPassword, String empMail)
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
				InternetAddress.parse(empMail));
		message.setSubject("[Tripame]員工"+empName+"您好");
		message.setText("Dear： " + empName + " ，這是您的員工密碼:" + empPassword);

		Transport.send(message);
		System.out.println("Done");
	}

}

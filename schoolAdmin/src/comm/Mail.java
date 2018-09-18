package comm;
import java.util.Properties;  
import javax.mail.*;  
import javax.mail.internet.*;  
public class Mail {
	private String from = "sunkiha123@126.com"; // 发件人邮箱地址  
    private String user = "sunkiha123@126.com"; // 发件人称号，同邮箱地址  
    private String password = "sunkiha123"; // 发件人邮箱客户端授权码  
  
    /** 
     *  
     * @param to 
     * @param text 
     * @param title 
     */  
    /* 发送验证信息的邮件 */  
    public boolean sendMail(String to, String text, String title) {  
        Properties props = new Properties();  
        props.setProperty("mail.smtp.host", "smtp.126.com"); // 设置发送邮件的邮件服务器的属性（这里使用网易的smtp服务器）  
        props.put("mail.smtp.host", "smtp.126.com"); // 需要经过授权，也就是有户名和密码的校验，这样才能通过验证（一定要有这一条）  
        props.put("mail.smtp.auth", "true"); // 用刚刚设置好的props对象构建一个session  
        Session session = Session.getDefaultInstance(props); // 有了这句便可以在发送邮件的过程中在console处显示过程信息，供调试使  
                                                                // 用（你可以在控制台（console)上看到发送邮件的过程）  
        session.setDebug(true); // 用session为参数定义消息对象  
        MimeMessage message = new MimeMessage(session); // 加载发件人地址  
        try {  
            message.setFrom(new InternetAddress(from));  
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to)); // 加载收件人地址  
            message.setSubject(title); // 加载标题  
            Multipart multipart = new MimeMultipart(); // 向multipart对象中添加邮件的各个部分内容，包括文本内容和附件  
            BodyPart contentPart = new MimeBodyPart(); // 设置邮件的文本内容  
            contentPart.setContent(text, "text/html;charset=utf-8");  
            multipart.addBodyPart(contentPart);  
            message.setContent(multipart);  
            message.saveChanges(); // 保存变化  
            Transport transport = session.getTransport("smtp"); // 连接服务器的邮箱  
            transport.connect("smtp.126.com", user, password); // 把邮件发送出去  
            transport.sendMessage(message, message.getAllRecipients());  
            transport.close();  
        } catch (MessagingException e) {  
            e.printStackTrace();  
            return false;  
        }  
        return true;  
    }  
}

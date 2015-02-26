package bean;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class User {
	private Connection conn;
	private int id;
	private String email = "";
	private String password = "";
	private int userType;
	private int status;
	private String userName;
	private String userLastName;
	private String socialSecurity;
	private String telephone;
	private Date birthday;
	private int maritalStatusId;
	private int supervisorId;
	private String userAddress;
	private String sex;
	private String maritalStatus;

	private String message = "";

	public String getMessage() {
		return message;
	}

	public User() {

	}

	public User(String email, int userType, String userName,
			String userLastName, String socialSecurity, String telephone,
			Date birthday, int maritalStatusId, String userAddress, String sex, Connection conn) {
		this.email = email;
		this.userType = userType;
		this.userName = userName;
		this.userLastName = userLastName;
		this.socialSecurity = socialSecurity;
		this.telephone = telephone;
		this.birthday = birthday;
		this.maritalStatusId = maritalStatusId;
		this.userAddress = userAddress;
		this.sex = sex;
		this.conn = conn;
	}

	public User(String email, Connection conn) {
		this.email = email;
		this.conn = conn;
	}

	public User(String email, String password, Connection conn) {
		this.conn = conn;
		this.email = email;
		this.password = password;
	}
	
	public User(int id, String userName, String userLastName){
		this.id=id;
		this.userName=userName;
		this.userLastName=userLastName;
	}
	
	public User(int id, Connection conn){
		this.id=id;
		this.conn = conn;
	}

	public int getId(){
		
		return id;
	}
	public int getUserType() {
		return userType;
	}

	public void setUserType(int userType) {
		this.userType = userType;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserLastName() {
		return userLastName;
	}

	public void setUserLastName(String userLastName) {
		this.userLastName = userLastName;
	}

	public String getSocialSecurity() {
		return socialSecurity;
	}

	public void setSocialSecurity(String socialSecurity) {
		this.socialSecurity = socialSecurity;
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public int getMaritalStatusId() {
		return maritalStatusId;
	}

	public void setMaritalStatusId(int maritalStatusId) {
		this.maritalStatusId = maritalStatusId;
	}

	public int getSupervisorId() {
		return supervisorId;
	}

	public void setSupervisorId(int supervisorId) {
		this.supervisorId = supervisorId;
	}
	
	public void setUserAddress(String userAddress){
		this.userAddress = userAddress;
	}
	
	public String getUserAddress(){
		return userAddress;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	
	public String getSex(){
		return sex;
	}
	
	public void setSex(String sex){
		this.sex = sex;
	}
	
	public void setMaritalStatus(String maritalStatus){
		this.maritalStatus = maritalStatus;
	}
	
	public String getMaritalStatus(){
		return maritalStatus;
	}

	public boolean validate() {

		if (email == null) {
			message = "Invalid email address";
			return false;
		}

		if (password == null) {
			message = "Invalid password";
			return false;
		}

		if (!email.matches("\\w+@\\w+\\.\\w+")) {
			message = "Invalid email address";
			return false;
		}

		if (password.length() < 8) {
			message = "Password must be at least 8 characters.";
			return false;
		} else if (password.matches("\\w*\\s+\\w*")) {
			message = "Password cannot contain space.";
			return false;
		}

		return true;
	}

	public boolean login() throws SQLException {
		String sql = "SELECT COUNT(*) as count FROM system_user WHERE login=? and login_password=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, email);
		stmt.setString(2, password);

		ResultSet rs = stmt.executeQuery();
		int count = 0;

		if (rs.next()) {
			count = rs.getInt("count");

		}

		rs.close();
		stmt.close();

		if (count == 0) {
			return false;
		} else {
			return true;
		}
	}
	
	public List<String> login1() throws SQLException{
		
		List<String> list = new ArrayList<String>();
		String sql = "SELECT * FROM system_user WHERE login=? OR login_password=?";
				PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, email);
			stmt.setString(2, password);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()){
				String userName= rs.getString("user_name");
				String userLastName= rs.getString("user_last_name");
				String login = rs.getString("login");
				String loginPassword = rs.getString("login_password");
				String socialSecurity = rs.getString("social_security");
				int id1=rs.getInt("id");
				int userType1 = rs.getInt("user_type");
				String id = Integer.toString(id1);
				String userType = Integer.toString(userType1);
				list.add(userName);
				list.add(userLastName);
				list.add(login);
				list.add(loginPassword);
				list.add(socialSecurity);
				list.add(id);
				list.add(userType);
			}
		return list;
	}

	public void create() throws SQLException {
		String sql = "INSERT INTO system_user (login, login_password, user_type, user_name, user_last_name, social_security, telephone, birthdate, marital_status_id, user_address, sex) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		PreparedStatement stmt = conn.prepareStatement(sql);

		stmt.setString(1, email);
		stmt.setString(2, password);
		stmt.setInt(3, userType);
		stmt.setString(4, userName);
		stmt.setString(5, userLastName);
		stmt.setString(6, socialSecurity);
		stmt.setString(7, telephone);
		stmt.setDate(8, birthday);
		stmt.setInt(9, maritalStatusId);
		stmt.setString(10, userAddress);
		stmt.setString(11, sex);
		
		stmt.executeUpdate();

		stmt.close();
	}

	public boolean exists() throws SQLException {

		String sql = "SELECT COUNT(*) AS count FROM system_user WHERE login=?";

		PreparedStatement stmt = conn.prepareStatement(sql);

		stmt.setString(1, email);

		ResultSet rs = stmt.executeQuery();

		int count = 0;

		if (rs.next()) {
			count = rs.getInt("count");
		}

		rs.close();
		stmt.close();

		if (count == 0) {
			return false;
		} else {
			return true;
		}
	}

	public boolean requestPassword() {

		String sql = "SELECT login_password FROM system_user WHERE login=?";

		try {
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, email);

			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				setPassword(rs.getString("login_password"));
			} else {
				setMessage("This email addres doesn't exist in the database.");
				rs.close();
				stmt.close();
				return false;
			}
			rs.close();
			stmt.close();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return true;
	}

	public boolean sendEmail() {

		if (!requestPassword()) {
			return false;
		} else {
			
			System.out.println(password);
						
			Properties props = new Properties();

			props.put("mail.smtp.host", "smtp.gmail.com");
			props.put("mail.smtp.socketFactory.port", "465");
			props.put("mail.smtp.socketFactory.class",
					"javax.net.ssl.SSLSocketFactory");
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.port", "465");
			

			Authenticator auth = new Authenticator(){
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(
							"ddsreportabusesystem@gmail.com", "group1project");
				}
			};

			Session session = Session.getDefaultInstance(props, auth);

			Message msg = new MimeMessage(session);

			try {
				msg.setSubject("DDSReportingAbuseSystem-Password Recovery");
				msg.setFrom(new InternetAddress(
						"ddsreportabusesystem@gmail.com", "Administrator"));
				msg.setRecipient(Message.RecipientType.TO, new InternetAddress(
						email));
				msg.setText("The password for your account: "+email+" is: "+password);

				Transport.send(msg);

			} catch (MessagingException | UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		setMessage("The password has already sent to your email.");
		return true;
	}
	
	public void setUserInfo(){
		
		String sql= "SELECT * FROM system_user WHERE id = ?";
		try {
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, id);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()){
				setUserName(rs.getString("user_name"));
				setUserAddress(rs.getString("user_address"));
				setTelephone(rs.getString("telephone"));
				setSocialSecurity(rs.getString("social_security"));
				setBirthday(rs.getDate("birthdate"));
				setSex(rs.getString("sex"));
				setUserLastName(rs.getString("user_last_name"));
				setEmail(rs.getString("login"));
				setUserType(rs.getInt("user_type"));
				setMaritalStatusId(rs.getInt("marital_status_id"));
				setSocialSecurity(rs.getString("social_security"));
				
			}
			rs.close();
			stmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
		
	
	public static List<User> getStaffMembers(Connection conn, int userType){
		List<User> listStaffMembers = new LinkedList<User>();
		String sql=null;
		if (userType==1){
			sql = "SELECT * FROM all_user_view WHERE user_type > ? AND status=1";
		}else {
		sql="SELECT * FROM system_user WHERE user_type = ? AND status=1";
		}
		try {
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, userType);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()){
				
				int id = rs.getInt("id");
				String userName = rs.getString("user_name");
				String userLastName = rs.getString("user_last_name");
				User user = new User(id, userName, userLastName);
				user.setBirthday(rs.getDate("birthdate"));
				user.setEmail(rs.getString("login"));
				user.setUserType(rs.getInt("user_type"));
				user.setTelephone(rs.getString("telephone"));
				String sex1 = rs.getString("sex");
						if(sex1.equals("M")){
							user.setSex("Male");
							}else if(sex1.equals("F")){
								user.setSex("Female");
							}
						if(userType==1){
							user.setMaritalStatus(rs.getString("master_data_name"));
						}
				
				user.setUserAddress(rs.getString("user_address"));
				
				
				listStaffMembers.add(user);
				
			}
			rs.close();
			stmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return listStaffMembers;
	}
	public void changePassword(String password){
		String sql = "UPDATE system_user SET login_password=? WHERE login=?";
		try {
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, password);
			stmt.setString(2, email);
			stmt.executeUpdate();
			stmt.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static void delete(Connection conn, int id){
		String sql = "DELETE FROM system_user WHERE id = ?";
		try {
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, id);
			stmt.executeUpdate();
			stmt.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	public void update(){
		String sql = "UPDATE system_user SET user_type=?, user_name=?, user_last_name=?, social_security=?, telephone=?, birthdate=?, marital_status_id=?, user_address=?, sex=? WHERE login=? ";
		try {
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, userType);
			stmt.setString(2, userName);
			stmt.setString(3, userLastName);
			stmt.setString(4, socialSecurity);
			stmt.setString(5, telephone);
			stmt.setDate(6, birthday);
			stmt.setInt(7, maritalStatusId);
			stmt.setString(8, userAddress);
			stmt.setString(9, sex);
			stmt.setString(10, email);
			stmt.executeUpdate();
			stmt.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}

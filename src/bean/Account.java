package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Account {
	private Connection conn;

	public Account(Connection conn) {
		this.conn = conn;
	}

	public boolean login(String email, String password) throws SQLException {
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

		if (count == 0) {
			return false;
		} else {
			return true;
		}
	}
	
	public void create(String email, String password) throws SQLException {
		String sql = "INSERT INTO system_user (login, login_password) VALUES (?, ?)";

		PreparedStatement stmt = conn.prepareStatement(sql);

		stmt.setString(1, email);
		stmt.setString(2, password);
		
		stmt.executeUpdate();
		
		stmt.close();
	}
	
	public boolean exists(String email) throws SQLException {

		String sql = "SELECT COUNT(*) AS count FROM system_user WHERE login=?";

		PreparedStatement stmt = conn.prepareStatement(sql);

		stmt.setString(1, email);

		ResultSet rs = stmt.executeQuery();

		int count = 0;

		if (rs.next()) {
			count = rs.getInt("count");
		}
		
		rs.close();

		if (count == 0) {
			return false;
		} else {
			return true;
		}
	}

}

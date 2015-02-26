package bean;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.List;

public class DisabilityType {

	private int id;
	private String type;
	private Connection conn;
	
	
	public DisabilityType(int id, String type, Connection conn) {
		this.id = id;
		this.type = type;
		this.conn = conn;
	}


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public String getType() {
		return type;
	}


	public void setType(String type) {
		this.type = type;
	}


	public static List<DisabilityType> getDisabilityType(Connection conn){
	
		List<DisabilityType> listOfDisability = new LinkedList<DisabilityType>();
		String sql = "SELECT * FROM disabiltity_type";
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()){
				int id = rs.getInt("id");
				String type = rs.getString("name_disabiltity_type");
				DisabilityType disabilityType = new DisabilityType(id, type, conn);
				listOfDisability.add(disabilityType);
			}
			rs.close();
			stmt.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return listOfDisability;
	}
	
}

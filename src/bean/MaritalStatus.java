package bean;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.List;

public class MaritalStatus {

	private int id;
	private int status;
	private String masterDataName;
	private String description;
	private Connection conn;
	
	
	public MaritalStatus(int id, int status, String masterDataName, String decription, Connection conn){
		this.id = id;
		this.status = status;
		this.masterDataName = masterDataName;
		this.description = description;
		this.conn = conn;
	}
	
	
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getMasterDataName() {
		return masterDataName;
	}

	public void setMasterDataName(String masterDataName) {
		this.masterDataName = masterDataName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}


	public static List<MaritalStatus> getMaritalStatus(Connection conn){
		List<MaritalStatus> listOfMaritalStatus = new LinkedList<MaritalStatus>();
		String sql = "SELECT * FROM marital_status WHERE status=1";
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()){
				int id = rs.getInt("id");
				int status = rs.getInt("status");
				String masterDataName = rs.getString("master_data_name");
				String description = rs.getString("description");
				
				MaritalStatus maritalStatus = new MaritalStatus(id, status, masterDataName, description, conn);
				listOfMaritalStatus.add(maritalStatus);
			}
			
			rs.close();
			stmt.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return listOfMaritalStatus;
	}
}

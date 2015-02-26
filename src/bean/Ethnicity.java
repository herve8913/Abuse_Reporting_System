package bean;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.List;

public class Ethnicity {

	private int id;
	private int status;
	private String masterDataName;
	private String description;
	private Connection conn;
	
	public Ethnicity(int id, int status, String masterDataName, String description, Connection conn){
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

	public static List<Ethnicity> getEthnicityList(Connection conn){
		List<Ethnicity> listOfEthnicity = new LinkedList<>();
		String sql = "SELECT * FROM ethnicity WHERE status =1";
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()){
				int id = rs.getInt("id");
				int status =rs.getInt("status");
				String masterDataName = rs.getString("master_data_name");
				String description = rs.getString("description");
				Ethnicity ethnicity = new Ethnicity(id, status, masterDataName, description, conn);
				listOfEthnicity.add(ethnicity);
			}
			rs.close();
			stmt.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return listOfEthnicity;
	}
	
}

package bean;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.List;

public class HealthCareOrg {

	private int id;
	private int status;
	private String masterDataName;
	private String description;
	private String zipcode;
	private String address;
	private String state;
	private Connection conn;
	
	public HealthCareOrg(int id, String masterDataName, String description,
			String zipcode, String address, String state, Connection conn) {
		this.id = id;
		this.masterDataName = masterDataName;
		this.description = description;
		this.zipcode = zipcode;
		this.address = address;
		this.state = state;
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

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public static List<HealthCareOrg> getHealthList(Connection conn){
		List<HealthCareOrg> listOfHealthCare = new LinkedList<>();
		String sql = "SELECT * FROM healthcareorg WHERE status = 1";
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()){
				int id = rs.getInt("id");
				String masterDataName = rs.getString("master_data_name");
				String description = rs.getString("description");
				String zipcode = rs.getString("zipcode");
				String address = rs.getString("address");
				String state = rs.getString("state");
				HealthCareOrg healthCareOrg = new HealthCareOrg(id, masterDataName, description, zipcode, address, state, conn);
				listOfHealthCare.add(healthCareOrg);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return listOfHealthCare;
	}
}

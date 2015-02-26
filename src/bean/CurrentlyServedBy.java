package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.List;

public class CurrentlyServedBy {

	private int id;
	private int status;
	private String masterDataName;
	private String description;
	private Connection conn;
	
	public CurrentlyServedBy(){
		
	}
	
	public CurrentlyServedBy(int id, int status, String masterDataName, String description, Connection conn){
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

	public static String getCurrentlyServedBy(int id, Connection conn){
		String valueCurrentlyServedBy="";
		String sql = "SELECT * FROM currently_served_by WHERE id = ? AND status= 1";
		try {
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, id);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()){
				valueCurrentlyServedBy=rs.getString("master_data_name");
			}
			
			rs.close();
			stmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return valueCurrentlyServedBy;
	}
	
	public static List<CurrentlyServedBy> getServedList(Connection conn){
		List<CurrentlyServedBy> listOfCurrentlyServed = new LinkedList<>();
		String sql = "SELECT * FROM currently_served_by WHERE status=1";
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()){
				int id = rs.getInt("id");
				int status = rs.getInt("status");
				String masterDataName = rs.getString("master_data_name");
				String description = rs.getString("description");
				CurrentlyServedBy currentlyServedBy = new CurrentlyServedBy(id, status, masterDataName, description, conn);
				listOfCurrentlyServed.add(currentlyServedBy);
			}
			rs.close();
			stmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return listOfCurrentlyServed;
	}
	
}

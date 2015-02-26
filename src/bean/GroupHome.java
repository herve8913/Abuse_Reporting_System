package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.List;

public class GroupHome {

	private int id;
	private int status;
	private String masterDataName;
	private String description;
	private String address;
	private int healthCareOrgId;
	private Connection conn;
	
	public GroupHome(int id, int status, String masterDataName,
			String description, String address, int healthCareOrgId,
			Connection conn) {
		this.id = id;
		this.status = status;
		this.masterDataName = masterDataName;
		this.description = description;
		this.address = address;
		this.healthCareOrgId = healthCareOrgId;
		this.conn = conn;
	}

	public GroupHome(int id, Connection conn) {
		this.id = id;
		this.conn = conn;
	}

	public GroupHome(String name, String address, String description, int healthCareOrgId, Connection conn){
		this.masterDataName = name;
		this.address = address;
		this.description = description;
		this.healthCareOrgId = healthCareOrgId;
		this.conn = conn;
	}
	
	public GroupHome(int id, String name, String address, String description, int healthCareOrgId, Connection conn){
		this.id = id;
		this.masterDataName = name;
		this.address = address;
		this.description = description;
		this.healthCareOrgId = healthCareOrgId;
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

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getHealthCareOrgId() {
		return healthCareOrgId;
	}

	public void setHealthCareOrgId(int healthCareOrgId) {
		this.healthCareOrgId = healthCareOrgId;
	}

	public static List<GroupHome> getGroupHomeList(Connection conn){
		List<GroupHome> listOfGroupHome = new LinkedList<>();
		String sql="SELECT * FROM group_home WHERE status=1 ORDER BY id";
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()){
				int id = rs.getInt("id");
				int status = rs.getInt("status");
				String masterDataName = rs.getString("master_data_name");
				String description = rs.getString("description");
				String address = rs.getString("address");
				int healthCareOrgId = rs.getInt("healthcareorg_id");
				GroupHome groupHome = new GroupHome(id, status, masterDataName, description, address, healthCareOrgId, conn);
				listOfGroupHome.add(groupHome);
			}
			rs.close();
			stmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return listOfGroupHome;
	}
	
	public void create(){
		String sql = "INSERT INTO group_home(master_data_name, description, address, healthcareorg_id) VALUES(?, ?, ?, ?)";
		try {
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, masterDataName);
			stmt.setString(2, description);
			stmt.setString(3, address);
			stmt.setInt(4, healthCareOrgId);
			stmt.executeUpdate();
			stmt.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public static void delete(Connection conn, int id){
		String sql="DELETE FROM group_home WHERE id=?";
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
	public void search(){
		String sql = "SELECT * FROM group_home WHERE id=?";
		try {
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, id);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()){
				setAddress(rs.getString("address"));
				setMasterDataName(rs.getString("master_data_name"));
				setDescription(rs.getString("description"));
				setHealthCareOrgId(rs.getInt("healthcareorg_id"));
				setStatus(rs.getInt("status"));
				
			}
			rs.close();
			stmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void update(){
		String sql ="UPDATE group_home SET master_data_name=?, description=?, address=?, healthcareorg_id=?, status=? WHERE id=?";
		try {
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, masterDataName);
			stmt.setString(2, description);
			stmt.setString(3, address);
			stmt.setInt(4, healthCareOrgId);
			stmt.setInt(5, status);
			stmt.setInt(6, id);
			stmt.executeUpdate();
			stmt.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}

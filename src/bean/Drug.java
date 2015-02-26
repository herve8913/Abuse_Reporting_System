package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Time;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

public class Drug {
	private Connection conn;
	private int id;
	private int status;
	private String drugName;
	private String descriptionText;
	private String message;
	private String searchResult;

	public Drug(int status, String drugName, String descriptionText,
			Connection conn) {
		this.status = status;
		this.drugName = drugName;
		this.descriptionText = descriptionText;
		this.conn = conn;
	}

	public Drug(int id , Connection conn){
		this.id = id;
		this.conn = conn;
	}
	
	public Drug(String drugName, Connection conn) {
		this.drugName = drugName;
		this.conn = conn;
	}

	public Drug(String drugName, String descriptionText, Connection conn){
		this.drugName = drugName;
		this.descriptionText = descriptionText;
		this.conn = conn;
	}
	
	public Drug(int id, int status, String drugName,
			String descriptionText, Connection conn) {
		this.conn = conn;
		this.id = id;
		this.status = status;
		this.drugName = drugName;
		this.descriptionText = descriptionText;
	}

	public void setId(int id){
		this.id = id;
	}
	
	public int getId(){
		return id;
	}
	
	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getDrugName() {
		return drugName;
	}

	public void setDrugName(String drugName) {
		this.drugName = drugName;
	}

	public String getDescriptionText() {
		return descriptionText;
	}

	public void setDescriptionText(String descriptionText) {
		this.descriptionText = descriptionText;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getSearchResult() {
		return searchResult;
	}

	public void setSearchResult(Date date, Time time, int stat, String drug_name, String description) {
		this.searchResult = "Date: " + date + "Time: " + time + "Status: "
				+ stat + "drug_name: " + drug_name + "description"
				+ description;;
	}

	public boolean valid() {

		if (drugName == "") {
			message = "Drug Name cannot be null";
		} else if (descriptionText == "") {
			message = "Description Text cannot be null";
		} else {
			return true;
		}
		setMessage(message);
		return false;
	}

	public boolean exist() {
		int count = 0;
		String sql = "SELECT COUNT(*) AS count FROM drug WHERE drug_name=?";

		PreparedStatement stmt;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, drugName);

			ResultSet rs = stmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt("count");
			}

			rs.close();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		if (count == 0) {
			setMessage("This drug doesn't exist in the database.");
			return false;
		} else {
			return true;
		}
	}

	public void register() {
		String sql = "INSERT INTO drug (drug_name, description) VALUES (?, ?)";

		PreparedStatement stmt;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, drugName);
			stmt.setString(2, descriptionText);

			stmt.executeUpdate();

			stmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	
	public static void deleter(Connection conn, int id){
		String sql = "DELETE FROM drug WHERE id=?";
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

	public void search() {
		searchResult = null;
		String sql = "SELECT drug_name, description FROM drug WHERE id=?";
		PreparedStatement selectStmt;
		try {
			selectStmt = conn.prepareStatement(sql);
			selectStmt.setInt(1, id);

			ResultSet rs = selectStmt.executeQuery();
		
			if(rs.next()){
				String drug_name = rs.getString("drug_name");
				String description = rs.getString("description");
				setDrugName(drug_name);
				setDescriptionText(description);
			} 
			rs.close();
			selectStmt.close();
		} catch (SQLException e) {
			System.out.println("sql");
		}

	}
	
	public void update(){
		
		String sql="UPDATE drug SET drug_name=?, description=? WHERE drug_name=?";
		PreparedStatement updateStmt;
		try {
			updateStmt = conn.prepareStatement(sql);
			updateStmt.setString(1,	drugName);
			updateStmt.setString(2, descriptionText);
			updateStmt.setString(3, drugName);
			updateStmt.executeUpdate();
			updateStmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public static List<Drug> getAllDrugs(Connection conn){
			
		List<Drug> listOfDrugs = new LinkedList<Drug>();
		String sql="SELECT * FROM drug WHERE status=1";
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs= stmt.executeQuery(sql);
			while(rs.next()){
				int status = rs.getInt("status");
				String drugName = rs.getString("drug_name");
				int id = rs.getInt("id");
				String description = rs.getString("description");
				Drug drug = new Drug(id, status, drugName, description, conn);
				listOfDrugs.add(drug);
			}
			
			rs.close();
			stmt.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return listOfDrugs;
	}

}

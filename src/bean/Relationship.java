package bean;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.List;

public class Relationship {

	private int id;
	private int status;
	private String masterDataName;
	private String description;
	private Connection conn;
	
	public Relationship(int id, String masterDataName){
		this.id = id;
		this.masterDataName = masterDataName;
	}
	
	public int getId(){
		return id;
	}
	
	public String getMasterDataName(){
		return masterDataName;
	}
	
	public static List<Relationship> getRelationshipList(Connection conn){
		List<Relationship> listOfRelationship = new LinkedList<Relationship>();
		
		String sql = "SELECT master_data_name, id FROM relationship WHERE status=1";
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()){
				String masterDataName = rs.getString("master_data_name");
				int id = rs.getInt("id");
				
				Relationship relationship = new Relationship(id, masterDataName);
				listOfRelationship.add(relationship);
			}
			
			
			rs.close();
			stmt.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return listOfRelationship;
	}
}

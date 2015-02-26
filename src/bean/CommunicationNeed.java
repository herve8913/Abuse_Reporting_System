package bean;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.List;

public class CommunicationNeed {

	private int id;
	private int status;
	private String masterDataName;
	private String description;
	private Connection conn;
	
	public CommunicationNeed(int id, String masterDataName, Connection conn){
		this.id = id;
		this.masterDataName = masterDataName;
		this.conn = conn;
	}
	
	
	
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getMasterDataName() {
		return masterDataName;
	}

	public void setMasterDataName(String masterDataName) {
		this.masterDataName = masterDataName;
	}

	
	
	public static List<CommunicationNeed> getListOfComNeed(Connection conn){
		List<CommunicationNeed> listOfComNeed = new LinkedList<CommunicationNeed>();
		String sql = "SELECT * FROM comunication_need WHERE status=1 ORDER BY id";
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()){
				int id = rs.getInt("id");
				String masterDataName = rs.getString("master_data_name");
				CommunicationNeed communicationNeed = new CommunicationNeed(id, masterDataName, conn);
				listOfComNeed.add(communicationNeed);
				
			}
			
			rs.close();
			stmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return listOfComNeed;
	}
}

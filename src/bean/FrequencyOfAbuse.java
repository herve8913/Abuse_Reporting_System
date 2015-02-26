package bean;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.List;

public class FrequencyOfAbuse {

	private int id;
	private int status;
	private String masterDataName;
	private String description;
	private Connection conn;
	
	public FrequencyOfAbuse(int id, String masterDataName){
		this.id = id;
		this.masterDataName = masterDataName;
	}
	
	
	public int getId(){
		return id;
	}
	
	public String getMasterDataName(){
		return masterDataName;
	}
	
	public static List<FrequencyOfAbuse> getFrequencyOfAbuse(Connection conn){
		List<FrequencyOfAbuse> listOfFrequency = new LinkedList<FrequencyOfAbuse>();
		String sql="SELECT master_data_name, id FROM frequency_of_abuse WHERE status=1";
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			
			while(rs.next()){
				int id = rs.getInt("id");
				String masterDataName = rs.getString("master_data_name");
				
				FrequencyOfAbuse frequencyOfAbuse = new FrequencyOfAbuse(id, masterDataName);
				listOfFrequency.add(frequencyOfAbuse);
			}
	
			
			rs.close();
			stmt.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return listOfFrequency;
	}
}

package bean;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.List;

public class TypeOfService {

	private int id;
	private String masterDataName;
	private String description;
	private Connection conn;
	
	
	
	public TypeOfService(int id, String masterDataName, String description) {
		this.id = id;
		this.masterDataName = masterDataName;
		this.description = description;
	}



	public int getId() {
		return id;
	}



	public String getMasterDataName() {
		return masterDataName;
	}



	public static List<TypeOfService> getListOfService(Connection conn){
		List<TypeOfService> listOfService = new LinkedList<TypeOfService>();
		
		String sql = "SELECT * FROM type_of_service WHERE status=1";
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs= stmt.executeQuery(sql);
			while(rs.next()){
				
				int id = rs.getInt("id");
				String masterDataName = rs.getString("master_data_name");
				String description = rs.getString("description");
				TypeOfService typeOfService = new TypeOfService(id, masterDataName, description);
				
				listOfService.add(typeOfService);
				
			}
			
			rs.close();
			stmt.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return listOfService;
	}
}

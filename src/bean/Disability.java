package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.List;

public class Disability {

	private int id;
	private int status;
	private int typeId;
	private String type;
	private String name;
	private String description;
	private Connection conn;
	
		
	
	public Disability(int id, int typeId, String type, String name,
			String description, int status, Connection conn) {
		this.id = id;
		this.typeId = typeId;
		this.type = type;
		this.name = name;
		this.description = description;
		this.status = status;
		this.conn = conn;
	}
	
	public Disability (String name, int typeId, String description, Connection conn){
		this.name = name;
		this.typeId = typeId;
		this.description = description;
		this.conn = conn;
	}
	
	public Disability(int id, Connection conn){
		this.id = id;
		this.conn = conn;
	}
	
	public Disability (int id, String name, int typeId, String description, Connection conn){
		this.id = id;
		this.name = name;
		this.typeId = typeId;
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

	public int getTypeId() {
		return typeId;
	}

	public void setTypeId(int typeId) {
		this.typeId = typeId;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}


	public void search(){
		String sql = "SELECT * FROM disability WHERE id = ?";
		try {
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, id);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()){
				setDescription(rs.getString("description"));
				setName(rs.getString("disability_name"));
				setTypeId(rs.getInt("disability_type_id"));
			}
			rs.close();
			stmt.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public void createDisability(){
		String sql = "INSERT INTO disability(disability_name,description, disability_type_id) VALUES(?, ?, ?)";
		try {
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, name);
			stmt.setString(2, description);
			stmt.setInt(3, typeId);
			stmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	
	
	public static List<Disability> getAllDisability(Connection conn){
		List<Disability> listOfDisability = new LinkedList<Disability>();
		String sql="SELECT * FROM view_disability_type WHERE status=1 ORDER BY id";
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()){
				int id = rs.getInt("id");
				int status = rs.getInt("status");
				String name = rs.getString("disability_name");
				String description = rs.getString("description");
				int typeId = rs.getInt("disability_type_id");
				String type = rs.getString("name_disabiltity_type");
				Disability disability = new Disability(id, typeId, type, name, description, status, conn);
				listOfDisability.add(disability);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return listOfDisability;
	}
	
	public static void deleteDisability(Connection conn, int id){
		String sql = "DELETE FROM disability WHERE id = ?";
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
	
	public void updateDisability(){
		String sql = "UPDATE disability SET disability_name=?, description=?, disability_type_id=? WHERE id=? ";
		try {
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, name);
			stmt.setString(2, description);
			stmt.setInt(3, typeId);
			stmt.setInt(4, id);
			stmt.executeUpdate();
			stmt.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
}

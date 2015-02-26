package bean;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.List;

public class Patient {

	private int id;
	private int status;
	private String patientName;
	private String patientMidname;
	private String patientLastName;
	private int iq;
	private Date birthdate;
	private String sex;
	private String telephone;
	private int maritalStatusId;
	private String maritalStatus;
	private int groupHomeId;
	private String groupHome;
	private String currentlyServedBy;
	private String clientGuardian;
	private int clientGuardianId;
	private int ethnicityId;
	private String ethnicity;
	private int currentlyServedById;
	private String logNumber;
	private Connection conn;

	public Patient(int id, int status, String patientName, String patientMidname,
			String patientLastName, int iq, Date birthdate, String sex,
			String telephone, int maritalStatusId, int groupHomeId,
			int currentlyServedById, Connection conn) {
		this.id=id;
		this.status = status;
		this.patientName = patientName;
		this.patientMidname = patientMidname;
		this.patientLastName = patientLastName;
		this.iq = iq;
		this.birthdate = birthdate;
		this.sex = sex;
		this.telephone = telephone;
		this.maritalStatusId = maritalStatusId;
		this.groupHomeId = groupHomeId;
		this.currentlyServedById = currentlyServedById;
		this.conn = conn;
	}
	
	
	
	public Patient(int id, String patientName, String patientMidname,
			String patientLastName, int iq, Date birthdate, String sex,
			String telephone, String maritalStatus, String groupHome,
			String currentlyServedBy, String clientGuardian, String ethnicity,
			String logNumber, Connection conn) {
		this.id = id;
		this.patientName = patientName;
		this.patientMidname = patientMidname;
		this.patientLastName = patientLastName;
		this.iq = iq;
		this.birthdate = birthdate;
		this.sex = sex;
		this.telephone = telephone;
		this.maritalStatus = maritalStatus;
		this.groupHome = groupHome;
		this.currentlyServedBy = currentlyServedBy;
		this.clientGuardian = clientGuardian;
		this.ethnicity = ethnicity;
		this.logNumber = logNumber;
		this.conn = conn;
	}

	public Patient(String patientName, String patientMidname, String patientLastName, String sex, int iq, Date birthdate, String telephone, int maritalStatusId, int groupHomeId, int currentlyServedById, int ethnicityId, int clientGuardianId, Connection conn){
		this.patientName = patientName;
		this.patientMidname = patientMidname;
		this.patientLastName = patientLastName;
		this.sex = sex;
		this.iq = iq;
		this.birthdate = birthdate;
		this.telephone = telephone;
		this.maritalStatusId = maritalStatusId;
		this.groupHomeId = groupHomeId;
		this.currentlyServedById = currentlyServedById;
		this.ethnicityId = ethnicityId;
		this.clientGuardianId = clientGuardianId;
		this.conn = conn;
	}
	
	public Patient(String logNumber, String patientName, String patientMidname, String patientLastName, String sex, int iq, Date birthdate, String telephone, int maritalStatusId, int groupHomeId, int currentlyServedById, int ethnicityId, int clientGuardianId, Connection conn){
		this.logNumber = logNumber;
		this.patientName = patientName;
		this.patientMidname = patientMidname;
		this.patientLastName = patientLastName;
		this.sex = sex;
		this.iq = iq;
		this.birthdate = birthdate;
		this.telephone = telephone;
		this.maritalStatusId = maritalStatusId;
		this.groupHomeId = groupHomeId;
		this.currentlyServedById = currentlyServedById;
		this.ethnicityId = ethnicityId;
		this.clientGuardianId = clientGuardianId;
		this.conn = conn;
	}
	
	public Patient(Connection conn, String logNumber){
		this.conn = conn;
		this.logNumber = logNumber;
	}

	public int getStatus() {
		return status;
	}


	public void setStatus(int status) {
		this.status = status;
	}


	public int getIq() {
		return iq;
	}


	public void setIq(int iq) {
		this.iq = iq;
	}


	public String getMaritalStatus() {
		return maritalStatus;
	}


	public void setMaritalStatus(String maritalStatus) {
		this.maritalStatus = maritalStatus;
	}


	public int getGroupHomeId() {
		return groupHomeId;
	}


	public void setGroupHomeId(int groupHomeId) {
		this.groupHomeId = groupHomeId;
	}


	public String getGroupHome() {
		return groupHome;
	}


	public void setGroupHome(String groupHome) {
		this.groupHome = groupHome;
	}


	public String getCurrentlyServedBy() {
		return currentlyServedBy;
	}


	public void setCurrentlyServedBy(String currentlyServedBy) {
		this.currentlyServedBy = currentlyServedBy;
	}


	public String getClientGuardian() {
		return clientGuardian;
	}


	public void setClientGuardian(String clientGuardian) {
		this.clientGuardian = clientGuardian;
	}


	public int getEthnicityId() {
		return ethnicityId;
	}


	public void setEthnicityId(int ethnicityId) {
		this.ethnicityId = ethnicityId;
	}


	public String getEthnicity() {
		return ethnicity;
	}


	public void setEthnicity(String ethnicity) {
		this.ethnicity = ethnicity;
	}


	public String getLogNumber() {
		return logNumber;
	}


	public void setLogNumber(String logNumber) {
		this.logNumber = logNumber;
	}


	public void setId(int id) {
		this.id = id;
	}


	public void setPatientMidname(String patientMidname) {
		this.patientMidname = patientMidname;
	}


	public void setPatientLastName(String patientLastName) {
		this.patientLastName = patientLastName;
	}


	public Patient(int id, Connection conn){
		this.id=id;
		this.conn=conn;
	}
	
	public int getId(){
		return id;
	}

	public String getPatientName() {
		return patientName;
	}

	public String getPatientMidname() {
		return patientMidname;
	}

	public String getPatientLastName() {
		return patientLastName;
	}
	

	public Date getBirthdate() {
		return birthdate;
	}

	public void setBirthdate(Date birthdate) {
		this.birthdate = birthdate;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public int getMaritalStatusId() {
		return maritalStatusId;
	}

	public void setMaritalStatusId(int maritalStatusId) {
		this.maritalStatusId = maritalStatusId;
	}

	public void setPatientName(String patientName) {
		this.patientName = patientName;
	}
	
	public int getCurrentlyServedById(){
		return currentlyServedById;
	}
	
	public void setCurrentlyServedById(int currentlyServedById){
		this.currentlyServedById = currentlyServedById;
	}

	public int getClientGuardianId() {
		return clientGuardianId;
	}



	public void setClientGuardianId(int clientGuardianId) {
		this.clientGuardianId = clientGuardianId;
	}



	public static List<Patient> getAllPatient(Connection conn) {
		List<Patient> listOfAllPatient = new LinkedList<Patient>();

		String sql = "SELECT * FROM patient";
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
				int id = rs.getInt("id");
				int status = rs.getInt("status");
				String patientName = rs.getString("patient_name");
				String patientMidname = rs.getString("patient_midname");
				String patientLastName = rs.getString("patient_last_name");
				int iq = rs.getInt("iq");
				Date birthdate = rs.getDate("birthdate");
				String sex = rs.getString("sex");
				String telephone = rs.getString("telephone");
				int maritalStatusId = rs.getInt("marital_status_id");
				int groupHomeId = rs.getInt("group_home_id");
				int currentlyServedById = rs.getInt("currently_served_by_id");

				Patient patient = new Patient(id, status, patientName,
						patientMidname, patientLastName, iq, birthdate, sex,
						telephone, maritalStatusId, groupHomeId, currentlyServedById, conn);
				
				listOfAllPatient.add(patient);
				
			}
			
			rs.close();
			stmt.close();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return listOfAllPatient;
	}

	public void setPatientInfo(int type){
		String sql=null;
		if(type==1){
		sql = "SELECT * FROM patient WHERE id = ?";
		}else if(type==2){
			sql = "SELECT * FROM patient WHERE patient_log_number = ?";
		}
		try {
			PreparedStatement stmt = conn.prepareStatement(sql);
			if(type==1){
			stmt.setInt(1, id);
			}else if (type==2){
				stmt.setString(1, logNumber);
			}
			ResultSet rs = stmt.executeQuery();
			if(rs.next()){
				setPatientName(rs.getString("patient_name"));
				setPatientLastName(rs.getString("patient_last_name"));
				setPatientMidname(rs.getString("patient_midname"));
				setIq(rs.getInt("iq"));
				setGroupHomeId(rs.getInt("group_home_id"));
				setClientGuardianId(rs.getInt("client_guardian_id"));
				setEthnicityId(rs.getInt("ethnicity_id"));
				setSex(rs.getString("sex"));
				setTelephone(rs.getString("telephone"));
				setBirthdate(rs.getDate("birthdate"));
				setMaritalStatusId(rs.getInt("marital_status_id"));
				setCurrentlyServedById(rs.getInt("currently_served_by_id"));
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static List<Patient> getPatientPanelList(Connection conn){
		List<Patient> listOfPatient = new LinkedList<>();
		String sql = "SELECT * FROM view_patient WHERE patient_status=1 ORDER BY id";
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()){
				int id  = rs.getInt("id");
				String name = rs.getString("patient_name");
				String midName = rs.getString("patient_midname");
				String lastName = rs.getString("patient_last_name");
				String logNumber = rs.getString("patient_log_number");
				int iq = rs.getInt("iq");
				Date birthdate = rs.getDate("birthdate");
				String sex = rs.getString("sex");
				String telephone = rs.getString("telephone");
				String maritalStatus = rs.getString("marital_status");
				String groupHome = rs.getString("address");
				String currentlyServedBy = rs.getString("currently_served_by");
				String clientGuardianName = rs.getString("user_name");
				String clientGuardianLastName = rs.getString("user_last_name");
				String clientGuardian = clientGuardianName+" "+clientGuardianLastName;
				String ethnicity = rs.getString("ethnicity");
				Patient patient = new Patient(id, name, midName, lastName, iq, birthdate, sex, telephone, maritalStatus, groupHome, currentlyServedBy, clientGuardian, ethnicity, logNumber, conn );
				listOfPatient.add(patient);
			}
			rs.close();
			stmt.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return listOfPatient;
	}
	
	public void createPatient(){
		String sql = "INSERT INTO patient(patient_name, patient_midname,patient_last_name, iq, birthdate, sex, telephone, marital_status_id, group_home_id, currently_served_by_id, client_guardian_id, ethnicity_id) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, patientName);
			stmt.setString(2, patientMidname);
			stmt.setString(3, patientLastName);
			stmt.setInt(4, iq);
			stmt.setDate(5, birthdate);
			stmt.setString(6, sex);
			stmt.setString(7, telephone);
			stmt.setInt(8, maritalStatusId);
			stmt.setInt(9, groupHomeId);
			stmt.setInt(10,currentlyServedById);
			stmt.setInt(11, clientGuardianId);
			stmt.setInt(12, ethnicityId);
			stmt.executeUpdate();
			stmt.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public static void deletePatient(Connection conn, String logNumber){
		String sql = "DELETE FROM patient WHERE patient_log_number = ?";
		try {
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, logNumber);
			stmt.executeUpdate();
			stmt.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void updatePatient(){
		String sql = "UPDATE patient SET patient_name=?, patient_midname=?, patient_last_name=?, iq=?, birthdate=?, sex=?, telephone=?, marital_status_id=?, group_home_id=?, currently_served_by_id=?, client_guardian_id=?, ethnicity_id=? WHERE patient_log_number=?";
		try {
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, patientName);
			stmt.setString(2, patientMidname);
			stmt.setString(3, patientLastName);
			stmt.setInt(4, iq);
			stmt.setDate(5, birthdate);
			stmt.setString(6, sex);
			stmt.setString(7, telephone);
			stmt.setInt(8, maritalStatusId);
			stmt.setInt(9, groupHomeId);
			stmt.setInt(10, currentlyServedById);
			stmt.setInt(11, clientGuardianId);
			stmt.setInt(12, ethnicityId);
			stmt.setString(13, logNumber);
			stmt.executeUpdate();
			stmt.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}

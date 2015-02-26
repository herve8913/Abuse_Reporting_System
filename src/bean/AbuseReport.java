package bean;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.List;

public class AbuseReport {

	private int id;
	private int status;
	private String logNumber;
	private int reporterId;
	private String reporterName;
	private String reporterAddress;
	private String reporterTelephone;
	private String mandated;
	private String reporterRelationshipToVictim;
	private int allegedVictimPatientId;
	private String allegedVictimName;
	private String allegedVictimAddress;
	private String allegedVictimTelephone;
	private String allegedVictimSex;
	private int allegedVictimStaffId;
	private Date allegedVictimDatebirth;
	private int allegedVictimMaritalStatusId;
	private int allegedAbuserPatientId;
	private int allegedAbuserStaffId;
	private String allegedAbuserName;
	private String allegedAbuserAddress;
	private String allegedAbuserRelationship;
	private String allegedAbuserSocialSecurity;
	private Date allegedAbuserDatebirth;
	private String allegedAbuserTelephone;
	private String communicationNeed;
	private int clientGuardianId;
	private String clientGuardianName;
	private String clientGuardianAddress;
	private String clientGuardianRelationship;
	private String clientGuardianTelephone;
	private int currentlyServedById;
	private String currentlyServedByComment;
	private String collateralContactsNotification;
	private String typeOfServiceComment;
	private String typeOfAbuseReport;
	private String frequencyOfAbuse;
	private String isVictimAware;
	private String descriptionAllegedReport;
	private String descriptionLevelRisk;
	private String descriptionResultingInjuries;
	private String descriptionWitnesses;
	private String descriptionCaregiverRelationship;
	private String oralReportFilled;
	private String oralReportFilledComment;
	private String riskToInvestigator;
	private String riskToInvestigatorComment;
	private Date dateOfLastIncident;
	private String dispositionLetter;
	private String decisionLetter;
	private String appealLetter;
	private String maritalStatus;
	private Date dueDate;
	private List<String> disabilityList;
	private String patientLogNumber;
	private Date dispositionLetterDate;
	private Date decisionLetterDate;
	private Date appealLetterDate;
	private Date approvedBySupervisorDate;
	private Date submittedByStaffDate;
	private String ethnicity;
	private Connection conn;

	
	
	public AbuseReport(int id, String reporterName, int status, String logNumber, Connection conn) {
		this.id = id;
		this.reporterName = reporterName;
		this.status = status;
		this.logNumber = logNumber;
		this.conn = conn;
	}
	
	public AbuseReport(int id, String reporterName, int status, String logNumber, String dispositionLetter, String decisionLetter, String appealLetter, Date dueDate, Connection conn){
		this.id = id;
		this.reporterName = reporterName;
		this.status = status;
		this.logNumber = logNumber;
		this.dispositionLetter = dispositionLetter;
		this.decisionLetter = decisionLetter;
		this.appealLetter = appealLetter;
		this.dueDate = dueDate;
		this.conn = conn;
	}

	public AbuseReport(int reporterId, int allegedVictimPatientId,
			Connection conn) {
		this.reporterId = reporterId;
		this.allegedVictimPatientId = allegedVictimPatientId;
		this.conn = conn;
	}

	public AbuseReport(int reporterId, Connection conn) {
		this.reporterId = reporterId;
		this.conn = conn;
	}
	public AbuseReport(Connection conn){
		this.conn = conn;
	}

	public int getReporterId() {
		return reporterId;
	}

	public void setReporterId(int reporterId) {
		this.reporterId = reporterId;
	}
	
	public String getLogNumber(){
		return logNumber;
	}
	
	public String getMaritalStatus() {
		return maritalStatus;
	}

	public void setMaritalStatus(String maritalStatus) {
		this.maritalStatus = maritalStatus;
	}

	public void setLogNumber(String logNumber){
		this.logNumber = logNumber;
	}

	public String getReporterAddress() {
		return reporterAddress;
	}

	public void setReporterAddress(String reporterAddress) {
		this.reporterAddress = reporterAddress;
	}

	public String getReporterTelephone() {
		return reporterTelephone;
	}

	public void setReporterTelephone(String reporterTelephone) {
		this.reporterTelephone = reporterTelephone;
	}

	public String getMandated() {
		return mandated;
	}

	public void setMandated(String mandated) {
		this.mandated = mandated;
	}

	public String getReporterRelationshipToVictim() {
		return reporterRelationshipToVictim;
	}

	public void setReporterRelationshipToVictim(
			String reporterRelationshipToVictim) {
		this.reporterRelationshipToVictim = reporterRelationshipToVictim;
	}

	public int getAllegedVictimPatientId() {
		return allegedVictimPatientId;
	}

	public void setAllegedVictimPatientId(int allegedVictimPatientId) {
		this.allegedVictimPatientId = allegedVictimPatientId;
	}

	public String getAllegedVictimName() {
		return allegedVictimName;
	}

	public void setAllegedVictimName(String allegedVictimName) {
		this.allegedVictimName = allegedVictimName;
	}

	public String getAllegedVictimAddress() {
		return allegedVictimAddress;
	}

	public void setAllegedVictimAddress(String allegedVictimAddress) {
		this.allegedVictimAddress = allegedVictimAddress;
	}

	public String getAllegedVictimTelephone() {
		return allegedVictimTelephone;
	}

	public void setAllegedVictimTelephone(String allegedVictimTelephone) {
		this.allegedVictimTelephone = allegedVictimTelephone;
	}

	public String getAllegedVictimSex() {
		return allegedVictimSex;
	}

	public void setAllegedVictimSex(String allegedVictimSex) {
		this.allegedVictimSex = allegedVictimSex;
	}

	public int getAllegedVictimStaffId() {
		return allegedVictimStaffId;
	}

	public void setAllegedVictimStaffId(int allegedVictimStaffId) {
		this.allegedVictimStaffId = allegedVictimStaffId;
	}

	public Date getAllegedVictimDatebirth() {
		return allegedVictimDatebirth;
	}

	public void setAllegedVictimDatebirth(Date allegedVictimDatebirth) {
		this.allegedVictimDatebirth = allegedVictimDatebirth;
	}

	public int getAllegedVictimMaritalStatusId() {
		return allegedVictimMaritalStatusId;
	}

	public void setAllegedVictimMaritalStatusId(int allegedVictimMaritalStatusId) {
		this.allegedVictimMaritalStatusId = allegedVictimMaritalStatusId;
	}

	public int getAllegedAbuserPatientId() {
		return allegedAbuserPatientId;
	}

	public void setAllegedAbuserPatientId(int allegedAbuserPatientId) {
		this.allegedAbuserPatientId = allegedAbuserPatientId;
	}

	public int getAllegedAbuserStaffId() {
		return allegedAbuserStaffId;
	}

	public void setAllegedAbuserStaffId(int allegedAbuserStaffId) {
		this.allegedAbuserStaffId = allegedAbuserStaffId;
	}

	public String getAllegedAbuserName() {
		return allegedAbuserName;
	}

	public void setAllegedAbuserName(String allegedAbuserName) {
		this.allegedAbuserName = allegedAbuserName;
	}

	public String getAllegedAbuserAddress() {
		return allegedAbuserAddress;
	}

	public void setAllegedAbuserAddress(String allegedAbuserAddress) {
		this.allegedAbuserAddress = allegedAbuserAddress;
	}

	public String getAllegedAbuserRelationship() {
		return allegedAbuserRelationship;
	}

	public void setAllegedAbuserRelationship(String allegedAbuserRelationship) {
		this.allegedAbuserRelationship = allegedAbuserRelationship;
	}

	public String getAllegedAbuserSocialSecurity() {
		return allegedAbuserSocialSecurity;
	}

	public void setAllegedAbuserSocialSecurity(
			String allegedAbuserSocialSecurity) {
		this.allegedAbuserSocialSecurity = allegedAbuserSocialSecurity;
	}

	public Date getAllegedAbuserDatebirth() {
		return allegedAbuserDatebirth;
	}

	public void setAllegedAbuserDatebirth(Date allegedAbuserDatebirth) {
		this.allegedAbuserDatebirth = allegedAbuserDatebirth;
	}

	public String getAllegedAbuserTelephone() {
		return allegedAbuserTelephone;
	}

	public void setAllegedAbuserTelephone(String allegedAbuserTelephone) {
		this.allegedAbuserTelephone = allegedAbuserTelephone;
	}

	public List<String> getDisabilityList() {
		return disabilityList;
	}

	public void setDisabilityList(List<String> disabilityList) {
		this.disabilityList = disabilityList;
	}

	public String getCommunicationNeed() {
		return communicationNeed;
	}

	public void setCommunicationNeed(String communicationNeed) {
		this.communicationNeed = communicationNeed;
	}

	public int getClientGuardianId() {
		return clientGuardianId;
	}

	public void setClientGuardianId(int clientGuardianId) {
		this.clientGuardianId = clientGuardianId;
	}

	public String getClientGuardianName() {
		return clientGuardianName;
	}

	public void setClientGuardianName(String clientGuardianName) {
		this.clientGuardianName = clientGuardianName;
	}

	public String getClientGuardianAddress() {
		return clientGuardianAddress;
	}

	public void setClientGuardianAddress(String clientGuardianAddress) {
		this.clientGuardianAddress = clientGuardianAddress;
	}

	public String getClientGuardianRelationship() {
		return clientGuardianRelationship;
	}

	public void setClientGuardianRelationship(String clientGuardianRelationship) {
		this.clientGuardianRelationship = clientGuardianRelationship;
	}

	public String getClientGuardianTelephone() {
		return clientGuardianTelephone;
	}

	public void setClientGuardianTelephone(String clientGuardianTelephone) {
		this.clientGuardianTelephone = clientGuardianTelephone;
	}

	public int getCurrentlyServedById() {
		return currentlyServedById;
	}

	public void setCurrentlyServedById(int currentlyServedById) {
		this.currentlyServedById = currentlyServedById;
	}

	public String getCurrentlyServedByComment() {
		return currentlyServedByComment;
	}

	public void setCurrentlyServedByComment(String currentlyServedByComment) {
		this.currentlyServedByComment = currentlyServedByComment;
	}

	public String getCollateralContactsNotification() {
		return collateralContactsNotification;
	}

	public void setCollateralContactsNotification(
			String collateralContactsNotification) {
		this.collateralContactsNotification = collateralContactsNotification;
	}

	public String getTypeOfServiceComment() {
		return typeOfServiceComment;
	}

	public void setTypeOfServiceComment(String typeOfServiceComment) {
		this.typeOfServiceComment = typeOfServiceComment;
	}

	public String getTypeOfAbuseReport() {
		return typeOfAbuseReport;
	}

	public void setTypeOfAbuseReport(String typeOfAbuseReport) {
		this.typeOfAbuseReport = typeOfAbuseReport;
	}

	public String getFrequencyOfAbuse() {
		return frequencyOfAbuse;
	}

	public void setFrequencyOfAbuse(String frequencyOfAbuse) {
		this.frequencyOfAbuse = frequencyOfAbuse;
	}

	public String getIsVictimAware() {
		return isVictimAware;
	}

	public void setIsVictimAware(String isVictimAware) {
		this.isVictimAware = isVictimAware;
	}

	public String getDescriptionAllegedReport() {
		return descriptionAllegedReport;
	}

	public void setDescriptionAllegedReport(String descriptionAllegedReport) {
		this.descriptionAllegedReport = descriptionAllegedReport;
	}

	public String getDescriptionLevelRisk() {
		return descriptionLevelRisk;
	}

	public void setDescriptionLevelRisk(String descriptionLevelRisk) {
		this.descriptionLevelRisk = descriptionLevelRisk;
	}

	public String getDescriptionResultingInjuries() {
		return descriptionResultingInjuries;
	}

	public void setDescriptionResultingInjuries(
			String descriptionResultingInjuries) {
		this.descriptionResultingInjuries = descriptionResultingInjuries;
	}

	public String getDescriptionWitnesses() {
		return descriptionWitnesses;
	}

	public void setDescriptionWitnesses(String descriptionWitnesses) {
		this.descriptionWitnesses = descriptionWitnesses;
	}

	public String getDescriptionCaregiverRelationship() {
		return descriptionCaregiverRelationship;
	}

	public void setDescriptionCaregiverRelationship(
			String descriptionCaregiverRelationship) {
		this.descriptionCaregiverRelationship = descriptionCaregiverRelationship;
	}

	public String getOralReportFilled() {
		return oralReportFilled;
	}

	public void setOralReportFilled(String oralReportFilled) {
		this.oralReportFilled = oralReportFilled;
	}

	public String getOralReportFilledComment() {
		return oralReportFilledComment;
	}

	public void setOralReportFilledComment(String oralReportFilledComment) {
		this.oralReportFilledComment = oralReportFilledComment;
	}

	public String getRiskToInvestigator() {
		return riskToInvestigator;
	}

	public void setRiskToInvestigator(String riskToInvestigator) {
		this.riskToInvestigator = riskToInvestigator;
	}

	public String getRiskToInvestigatorComment() {
		return riskToInvestigatorComment;
	}

	public void setRiskToInvestigatorComment(String riskToInvestigatorComment) {
		this.riskToInvestigatorComment = riskToInvestigatorComment;
	}

	public Date getDateOfLastIncident() {
		return dateOfLastIncident;
	}

	public void setDateOfLastIncident(Date dateOfLastIncident) {
		this.dateOfLastIncident = dateOfLastIncident;
	}

	public String getDispositionLetter() {
		return dispositionLetter;
	}

	public void setDispositionLetter(String dispositionLetter) {
		this.dispositionLetter = dispositionLetter;
	}

	public String getDecisionLetter() {
		return decisionLetter;
	}

	public void setDecisionLetter(String decisionLetter) {
		this.decisionLetter = decisionLetter;
	}

	public String getAppealLetter() {
		return appealLetter;
	}

	public void setAppealLetter(String appealLetter) {
		this.appealLetter = appealLetter;
	}

	public Connection getConn() {
		return conn;
	}

	public void setConn(Connection conn) {
		this.conn = conn;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public void setReporterName(String reporterName) {
		this.reporterName = reporterName;
	}

	public int getId() {
		return id;
	}

	public String getReporterName() {
		return reporterName;
	}

	public int getStatus() {
		return status;
	}
	
	public Date getDueDate() {
		return dueDate;
	}

	public void setDueDate(Date dueDate) {
		this.dueDate = dueDate;
	}

	public String getPatientLogNumber() {
		return patientLogNumber;
	}

	public void setPatientLogNumber(String patientLogNumber) {
		this.patientLogNumber = patientLogNumber;
	}

	public Date getDispositionLetterDate() {
		return dispositionLetterDate;
	}

	public void setDispositionLetterDate(Date dispositionLetterDate) {
		this.dispositionLetterDate = dispositionLetterDate;
	}

	public Date getDecisionLetterDate() {
		return decisionLetterDate;
	}

	public void setDecisionLetterDate(Date decisionLetterDate) {
		this.decisionLetterDate = decisionLetterDate;
	}

	public Date getAppealLetterDate() {
		return appealLetterDate;
	}

	public void setAppealLetterDate(Date appealLetterDate) {
		this.appealLetterDate = appealLetterDate;
	}

	public Date getApprovedBySupervisorDate() {
		return approvedBySupervisorDate;
	}

	public void setApprovedBySupervisorDate(Date approvedBySupervisorDate) {
		this.approvedBySupervisorDate = approvedBySupervisorDate;
	}

	public Date getSubmittedByStaffDate() {
		return submittedByStaffDate;
	}

	public void setSubmittedByStaffDate(Date submittedByStaffDate) {
		this.submittedByStaffDate = submittedByStaffDate;
	}

	public String getEthnicity() {
		return ethnicity;
	}

	public void setEthnicity(String ethnicity) {
		this.ethnicity = ethnicity;
	}

	public static List<AbuseReport> supervisorApprovalView(Connection conn, int sta){
		List<AbuseReport> listOfSupervisorReport = new LinkedList<>();
		String sql = null;
		if(sta==2){
		 sql ="SELECT id, reporter_name, status, public_log_number, disposition_letter, decision_letter, appeal_letter, due_date FROM abusereport WHERE status = ? ORDER BY id DESC";
		}else if (sta==3||sta==5){
			sql="SELECT id, reporter_name, status, public_log_number, disposition_letter, decision_letter, appeal_letter, due_date FROM abusereport WHERE status >= ? ORDER BY id DESC";
		}
		try {PreparedStatement stmt = conn.prepareStatement(sql);
		
			stmt.setInt(1, sta);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()){
				int id = rs.getInt("id");
				String reporterName = rs.getString("reporter_name");
				String logNumber = rs.getString("public_log_number");
				int status = rs.getInt("status");
				String dispositionLetter = rs.getString("disposition_letter");
				String decisionLetter = rs.getString("decision_letter");
				String appealLetter = rs.getString("appeal_letter");
				Date dueDate = rs.getDate("due_date");
				AbuseReport abuseReport = new AbuseReport(id,reporterName,status,logNumber,dispositionLetter, decisionLetter, appealLetter, dueDate, conn);
				listOfSupervisorReport.add(abuseReport);
				
			}
			
			rs.close();
			stmt.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return listOfSupervisorReport;
	}

	public static AbuseReport approvalAbuseReport(Connection conn, int id){
		AbuseReport abuseReport = new AbuseReport(conn);
		List<String> disabilityList = new LinkedList<>();
		String sql = "SELECT * FROM view_abuse_report WHERE id = ?";
		try {
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, id);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()){
				abuseReport.setId(id);
				abuseReport.setStatus(rs.getInt("status"));
				abuseReport.setLogNumber(rs.getString("public_log_number"));
				abuseReport.setReporterId(rs.getInt("reporter_id"));
				abuseReport.setReporterName(rs.getString("reporter_name"));
				abuseReport.setReporterAddress(rs.getString("reporter_address")) ;
				abuseReport.setReporterTelephone(rs.getString("reporter_telephone"));
				abuseReport.setMandated(rs.getString("mandated"));
				abuseReport.setReporterRelationshipToVictim(rs.getString("reporter_relationship_to_victim"));
				abuseReport.setAllegedVictimPatientId(rs.getInt("alleged_victim_patient_id"));
				abuseReport.setAllegedVictimName(rs.getString("alleged_victim_name"));
				abuseReport.setAllegedVictimAddress(rs.getString("alleged_victim_address"));
				abuseReport.setAllegedVictimTelephone(rs.getString("alleged_victim_telephone"));
				abuseReport.setAllegedVictimSex(rs.getString("alleged_victim_sex"));
				abuseReport.setAllegedVictimStaffId(rs.getInt("alleged_victim_staff_id"));
				abuseReport.setAllegedVictimDatebirth(rs.getDate("alleged_victim_datebirth"));
				abuseReport.setAllegedVictimMaritalStatusId(rs.getInt("alleged_victim_marital_status_id"));
				abuseReport.setMaritalStatus(rs.getString("marital_status"));
				abuseReport.setAllegedAbuserPatientId(rs.getInt("alleged_abuser_patient_id"));
				abuseReport.setAllegedAbuserStaffId(rs.getInt("alleged_abuser_staff_id"));
				abuseReport.setAllegedAbuserName(rs.getString("alleged_abuser_name"));
				abuseReport.setAllegedAbuserAddress(rs.getString("alleged_abuser_address"));
				abuseReport.setAllegedAbuserRelationship(rs.getString("alleged_abuser_relationship"));
				abuseReport.setAllegedAbuserSocialSecurity(rs.getString("alleged_abuser_social_security"));
				abuseReport.setAllegedAbuserDatebirth(rs.getDate("alleged_abuser_datebirth"));
				abuseReport.setAllegedAbuserTelephone(rs.getString("alleged_abuser_telephone"));
				abuseReport.setCommunicationNeed(rs.getString("comunication_need"));
				abuseReport.setClientGuardianId(rs.getInt("client_guardian_id"));
				abuseReport.setClientGuardianName(rs.getString("client_guardian_name"));
				abuseReport.setClientGuardianAddress(rs.getString("client_guardian_address"));
				abuseReport.setClientGuardianRelationship(rs.getString("client_guardian_relationship"));
				abuseReport.setClientGuardianTelephone(rs.getString("client_guardian_telephone"));
				abuseReport.setCurrentlyServedById(rs.getInt("currently_served_by_id"));
				abuseReport.setCurrentlyServedByComment(rs.getString("currently_served_by_department"));
				abuseReport.setCollateralContactsNotification(rs.getString("collateral_contacts_notification"));
				abuseReport.setTypeOfServiceComment(rs.getString("type_of_service"));
				abuseReport.setTypeOfAbuseReport(rs.getString("type_of_abusereport"));
				abuseReport.setFrequencyOfAbuse(rs.getString("frequency_of_abuse"));
				abuseReport.setIsVictimAware(rs.getString("is_victim_aware"));
				abuseReport.setDateOfLastIncident(rs.getDate("date_of_last_incident"));
				abuseReport.setDescriptionAllegedReport(rs.getString("description_alleged_report"));
				abuseReport.setDescriptionLevelRisk(rs.getString("description_level_risk"));
				abuseReport.setDescriptionResultingInjuries(rs.getString("description_resulting_injuries"));
				abuseReport.setDescriptionWitnesses(rs.getString("description_witnesses"));
				abuseReport.setDescriptionCaregiverRelationship(rs.getString("description_caregiver_relationship"));
				abuseReport.setOralReportFilled(rs.getString("oral_report_filed"));
				abuseReport.setOralReportFilledComment(rs.getString("oral_report_filed_comment"));
				abuseReport.setRiskToInvestigator(rs.getString("risk_to_investigator"));
				abuseReport.setRiskToInvestigatorComment(rs.getString("risk_to_investigator_comment"));
				abuseReport.setDispositionLetter(rs.getString("disposition_letter"));
				abuseReport.setDecisionLetter(rs.getString("decision_letter"));
				abuseReport.setAppealLetter(rs.getString("appeal_letter"));
				disabilityList.add(rs.getString("disability_name"));
				abuseReport.setPatientLogNumber(rs.getString("patient_log_number"));
				abuseReport.setSubmittedByStaffDate(rs.getDate("submitted_by_staff_date"));
				abuseReport.setApprovedBySupervisorDate(rs.getDate("approved_by_supervisor_date"));
				abuseReport.setDispositionLetterDate(rs.getDate("disposition_letter_date"));
				abuseReport.setDecisionLetterDate(rs.getDate("decision_letter_date"));
				abuseReport.setAppealLetterDate(rs.getDate("appeal_letter_date"));
				abuseReport.setEthnicity(rs.getString("ethnicity"));
			}
			while(rs.next()){
				disabilityList.add(rs.getString("disability_name"));
			}
			abuseReport.setDisabilityList(disabilityList);
			for(String s : abuseReport.getDisabilityList()){
				System.out.println("here: "+s);
			}
			rs.close();
			stmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return abuseReport;
	}
	
	public static List<AbuseReport> userAbuseReportView(int userType,
			int userId, Connection conn) {
		List<AbuseReport> listOfAbuseReport = new LinkedList<AbuseReport>();
		if (userType == 1 || userType == 2) {
			String sql = "SELECT id, reporter_name, status, public_log_number  FROM abusereport ORDER BY id DESC";
			try {
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(sql);
				while (rs.next()) {

					int id = rs.getInt("id");
					String reporterName = rs.getString("reporter_name");
					String logNumber = rs.getString("public_log_number");
					int status = rs.getInt("status");
					AbuseReport abuseReport = new AbuseReport(id, reporterName,
							status, logNumber, conn);
					listOfAbuseReport.add(abuseReport);
				}
				rs.close();
				stmt.close();

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		} else if (userType == 3) {
			String sql = "SELECT id,reporter_name, status, public_log_number FROM abusereport WHERE reporter_id=?  ORDER BY id DESC";
			PreparedStatement stmt;
			try {
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, userId);
				ResultSet rs = stmt.executeQuery();
				while (rs.next()) {
					int id = rs.getInt("id");
					String reporterName = rs.getString("reporter_name");
					String logNumber = rs.getString("public_log_number");
					int status = rs.getInt("status");
					AbuseReport abuseReport = new AbuseReport(id, reporterName,
							status, logNumber, conn);
				}
				rs.close();
				stmt.close();

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
		return listOfAbuseReport;
	}

	public void setVictimPatientGuardian() {
		String sql = "SELECT * FROM view_staff_guardian_patient WHERE status=1 AND staff_id =? AND id= ?";
		try {
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, reporterId);
			stmt.setInt(2, allegedVictimPatientId);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				
				setReporterName(rs.getString("staff_user_name")+" "+rs.getString("staff_user_last_name"));
				setReporterTelephone(rs.getString("staff_telephone"));
				setAllegedVictimAddress(rs.getString("group_home_address"));
				setAllegedVictimDatebirth(rs.getDate("birthdate"));
				setAllegedVictimMaritalStatusId(rs.getInt("marital_status_id"));
				setAllegedVictimName(rs.getString("patient_name")+" "+rs.getString("patient_midname")+" "+rs.getString("patient_last_name"));
				setAllegedVictimSex(rs.getString("sex"));
				setAllegedVictimTelephone(rs.getString("telephone"));
				setClientGuardianId(rs.getInt("client_guardian_id"));
				setClientGuardianName(rs.getString("client_guardian_name")+" "+rs.getString("client_guardian_user_last_name"));
				setReporterAddress(rs.getString("user_address"));
				User clientGuardian = new User(rs.getInt("client_guardian_id"),
						conn);
				clientGuardian.setUserInfo();
				setClientGuardianAddress(clientGuardian.getUserAddress());

			}
			rs.close();
			stmt.close();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public void setAbuserPatientGuardian(int allegedAbuserPatientId) {
		setAllegedAbuserPatientId(allegedAbuserPatientId);
		String sql = "SELECT * FROM view_staff_guardian_patient WHERE status=1 AND staff_id =? AND id= ?";
		try {
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, reporterId);
			stmt.setInt(2, allegedAbuserPatientId);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				setReporterName(rs.getString("staff_user_name")+" "+rs.getString("staff_user_last_name"));
				// staffuserlastname?
				setReporterTelephone(rs.getString("staff_telephone"));
				setReporterAddress(rs.getString("user_address"));
				setAllegedAbuserAddress(rs.getString("group_home_address"));
				setAllegedAbuserDatebirth(rs.getDate("birthdate"));
				setAllegedAbuserName(rs.getString("patient_name")+" "+rs.getString("patient_midname")+" "+rs.getString("patient_last_name"));
				setAllegedAbuserTelephone(rs.getString("telephone"));
				setClientGuardianId(rs.getInt("client_guardian_id"));
				setClientGuardianName(rs.getString("client_guardian_name")+" "+rs.getString("client_guardian_user_last_name"));
				User clientGuardian = new User(rs.getInt("client_guardian_id"),
						conn);
				clientGuardian.setUserInfo();
				setClientGuardianAddress(clientGuardian.getUserAddress());

			}
			rs.close();
			stmt.close();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public void setAbuserPatientGuardian2(int allegedAbuserPatientId) {
		setAllegedAbuserPatientId(allegedAbuserPatientId);
		String sql = "SELECT * FROM view_staff_guardian_patient WHERE status=1 AND staff_id =? AND id= ?";
		try {
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, reporterId);
			stmt.setInt(2, allegedAbuserPatientId);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				setReporterName(rs.getString("staff_user_name")+" "+rs.getString("staff_user_last_name"));
				// staffuserlastname?
				setReporterTelephone(rs.getString("staff_telephone"));
				setReporterAddress(rs.getString("user_address"));
				setAllegedAbuserAddress(rs.getString("group_home_address"));
				setAllegedAbuserDatebirth(rs.getDate("birthdate"));
				setAllegedAbuserName(rs.getString("patient_name")+" "+rs.getString("patient_midname")+" "+rs.getString("patient_last_name"));
				setAllegedAbuserTelephone(rs.getString("telephone"));
				/*
				 * setClientGuardianId(rs.getInt("client_guardian_id"));
				 * setClientGuardianName(rs.getString("client_guardian_name"));
				 * User clientGuardian = new
				 * User(rs.getInt("client_guardian_id"),conn);
				 * clientGuardian.setUserInfo();
				 * setClientGuardianAddress(clientGuardian.getUserAddress());
				 */

			}
			rs.close();
			stmt.close();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	
	public static void deleteAbuseReport(String logNumber, Connection conn){
		
		String sql = "DELETE FROM abusereport WHERE public_log_number = ?";
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

	public void updateAbuseReport(int caseType, int reportId){
		String sql="";
		if(caseType==1){
		sql = "UPDATE abusereport SET status=?, reporter_id=?, reporter_name=?, reporter_address=?, reporter_telephone=?, mandated=?, reporter_relationship_to_victim=?, alleged_victim_patient_id=?, alleged_victim_name=?, alleged_victim_address=?, alleged_victim_telephone=?, alleged_victim_sex=?, alleged_victim_datebirth=?, alleged_victim_marital_status_id=?,  alleged_abuser_staff_id=?, alleged_abuser_name=?, alleged_abuser_address=?, alleged_abuser_relationship=?, alleged_abuser_social_security=?, alleged_abuser_datebirth=?, alleged_abuser_telephone=?, comunication_need=?, client_guardian_id=?, client_guardian_name=?, client_guardian_address=?, client_guardian_relationship=?, client_guardian_telephone=?, currently_served_by_id=?, currently_served_by_department=?, collateral_contacts_notification=?, type_of_service=?, type_of_abusereport=?, frequency_of_abuse=?, is_victim_aware=?, date_of_last_incident=?, description_alleged_report=?, description_level_risk=?, description_resulting_injuries=?, description_witnesses=?, description_caregiver_relationship=?, oral_report_filed=?, oral_report_filed_comment=?, risk_to_investigator=?, risk_to_investigator_comment=? WHERE id=?";
		}else if (caseType == 2){
			sql = "UPDATE abusereport SET status=?, reporter_id=?, reporter_name=?, reporter_address=?, reporter_telephone=?, mandated=?, reporter_relationship_to_victim=?, alleged_victim_patient_id=?, alleged_victim_name=?, alleged_victim_address=?, alleged_victim_telephone=?, alleged_victim_sex=?, alleged_victim_datebirth=?, alleged_victim_marital_status_id=?,  alleged_abuser_patient_id=?, alleged_abuser_name=?, alleged_abuser_address=?, alleged_abuser_relationship=?, alleged_abuser_social_security=?, alleged_abuser_datebirth=?, alleged_abuser_telephone=?, comunication_need=?, client_guardian_id=?, client_guardian_name=?, client_guardian_address=?, client_guardian_relationship=?, client_guardian_telephone=?, currently_served_by_id=?, currently_served_by_department=?, collateral_contacts_notification=?, type_of_service=?, type_of_abusereport=?, frequency_of_abuse=?, is_victim_aware=?, date_of_last_incident=?, description_alleged_report=?, description_level_risk=?, description_resulting_injuries=?, description_witnesses=?, description_caregiver_relationship=?, oral_report_filed=?, oral_report_filed_comment=?, risk_to_investigator=?, risk_to_investigator_comment=? WHERE id=?";
			
		}else if (caseType == 3){
			sql = "UPDATE abusereport SET status=?, reporter_id=?, reporter_name=?, reporter_address=?, reporter_telephone=?, mandated=?, reporter_relationship_to_victim=?, alleged_victim_staff_id=?, alleged_victim_name=?, alleged_victim_address=?, alleged_victim_telephone=?, alleged_victim_sex=?, alleged_victim_datebirth=?, alleged_victim_marital_status_id=?,  alleged_abuser_patient_id=?, alleged_abuser_name=?, alleged_abuser_address=?, alleged_abuser_relationship=?, alleged_abuser_social_security=?, alleged_abuser_datebirth=?, alleged_abuser_telephone=?, comunication_need=?, client_guardian_id=?, client_guardian_name=?, client_guardian_address=?, client_guardian_relationship=?, client_guardian_telephone=?, currently_served_by_id=?, currently_served_by_department=?, collateral_contacts_notification=?, type_of_service=?, type_of_abusereport=?, frequency_of_abuse=?, is_victim_aware=?, date_of_last_incident=?, description_alleged_report=?, description_level_risk=?, description_resulting_injuries=?, description_witnesses=?, description_caregiver_relationship=?, oral_report_filed=?, oral_report_filed_comment=?, risk_to_investigator=?, risk_to_investigator_comment=? WHERE id=?";
			
		}
		PreparedStatement stmt;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, status);
			stmt.setInt(2, reporterId);
			stmt.setString(3, reporterName);
			stmt.setString(4, reporterAddress);
			stmt.setString(5, reporterTelephone);
			stmt.setString(6, mandated);
			stmt.setString(7, reporterRelationshipToVictim);
			if(caseType==1||caseType==2){
			stmt.setInt(8, allegedVictimPatientId);
			}else if(caseType==3){
				stmt.setInt(8, allegedVictimStaffId);
			}
			stmt.setString(9, allegedVictimName);
			stmt.setString(10, allegedVictimAddress);
			stmt.setString(11, allegedVictimTelephone);
			stmt.setString(12, allegedVictimSex);
			stmt.setDate(13, allegedVictimDatebirth);
			stmt.setInt(14, allegedVictimMaritalStatusId);
			if(caseType==1){
			stmt.setInt(15, allegedAbuserStaffId);
			}else if(caseType==2||caseType==3){
				stmt.setInt(15, allegedAbuserPatientId);
			}
			stmt.setString(16, allegedAbuserName);
			stmt.setString(17, allegedAbuserAddress);
			stmt.setString(18, allegedAbuserRelationship);
			stmt.setString(19, allegedAbuserSocialSecurity);
			stmt.setDate(20, allegedAbuserDatebirth);
			stmt.setString(21, allegedAbuserTelephone);
			stmt.setString(22, communicationNeed);
			stmt.setInt(23, clientGuardianId);
			stmt.setString(24, clientGuardianName);
			stmt.setString(25, clientGuardianAddress);
			stmt.setString(26, clientGuardianRelationship);
			stmt.setString(27, clientGuardianTelephone);
			stmt.setInt(28, currentlyServedById);
			stmt.setString(29, currentlyServedByComment);
			stmt.setString(30, collateralContactsNotification);
			stmt.setString(31, typeOfServiceComment);
			stmt.setString(32, typeOfAbuseReport);
			stmt.setString(33, frequencyOfAbuse);
			stmt.setString(34, isVictimAware);
			stmt.setDate(35, dateOfLastIncident);
			stmt.setString(36, descriptionAllegedReport);
			stmt.setString(37, descriptionLevelRisk);
			stmt.setString(38, descriptionResultingInjuries);
			stmt.setString(39, descriptionWitnesses);
			stmt.setString(40, descriptionCaregiverRelationship);
			stmt.setString(41, oralReportFilled);
			stmt.setString(42, oralReportFilledComment);
			stmt.setString(43, riskToInvestigator);
			stmt.setString(44, riskToInvestigatorComment);
			stmt.setInt(45, reportId);
			stmt.executeUpdate();
			
			
			stmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void saveAbuseReport(int caseType) {
		String sql="";
		if(caseType==1){
		sql = "INSERT INTO abusereport(status, reporter_id, reporter_name, reporter_address, reporter_telephone, mandated, reporter_relationship_to_victim, alleged_victim_patient_id, alleged_victim_name, alleged_victim_address, alleged_victim_telephone, alleged_victim_sex, alleged_victim_datebirth, alleged_victim_marital_status_id,  alleged_abuser_staff_id, alleged_abuser_name, alleged_abuser_address, alleged_abuser_relationship, alleged_abuser_social_security, alleged_abuser_datebirth, alleged_abuser_telephone, comunication_need, client_guardian_id, client_guardian_name, client_guardian_address, client_guardian_relationship, client_guardian_telephone, currently_served_by_id, currently_served_by_department, collateral_contacts_notification, type_of_service, type_of_abusereport, frequency_of_abuse, is_victim_aware, date_of_last_incident, description_alleged_report, description_level_risk, description_resulting_injuries, description_witnesses, description_caregiver_relationship, oral_report_filed, oral_report_filed_comment, risk_to_investigator, risk_to_investigator_comment) VALUES(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?, ?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?,?)";
		}else if (caseType == 2){
			sql = "INSERT INTO abusereport(status, reporter_id, reporter_name, reporter_address, reporter_telephone, mandated, reporter_relationship_to_victim, alleged_victim_patient_id, alleged_victim_name, alleged_victim_address, alleged_victim_telephone, alleged_victim_sex, alleged_victim_datebirth, alleged_victim_marital_status_id,  alleged_abuser_patient_id, alleged_abuser_name, alleged_abuser_address, alleged_abuser_relationship, alleged_abuser_social_security, alleged_abuser_datebirth, alleged_abuser_telephone, comunication_need, client_guardian_id, client_guardian_name, client_guardian_address, client_guardian_relationship, client_guardian_telephone, currently_served_by_id, currently_served_by_department, collateral_contacts_notification, type_of_service, type_of_abusereport, frequency_of_abuse, is_victim_aware, date_of_last_incident, description_alleged_report, description_level_risk, description_resulting_injuries, description_witnesses, description_caregiver_relationship, oral_report_filed, oral_report_filed_comment, risk_to_investigator, risk_to_investigator_comment) VALUES(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?, ?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?,?)";
			
		}else if (caseType == 3){
			sql = "INSERT INTO abusereport(status, reporter_id, reporter_name, reporter_address, reporter_telephone, mandated, reporter_relationship_to_victim, alleged_victim_staff_id, alleged_victim_name, alleged_victim_address, alleged_victim_telephone, alleged_victim_sex, alleged_victim_datebirth, alleged_victim_marital_status_id,  alleged_abuser_patient_id, alleged_abuser_name, alleged_abuser_address, alleged_abuser_relationship, alleged_abuser_social_security, alleged_abuser_datebirth, alleged_abuser_telephone, comunication_need, client_guardian_id, client_guardian_name, client_guardian_address, client_guardian_relationship, client_guardian_telephone, currently_served_by_id, currently_served_by_department, collateral_contacts_notification, type_of_service, type_of_abusereport, frequency_of_abuse, is_victim_aware, date_of_last_incident, description_alleged_report, description_level_risk, description_resulting_injuries, description_witnesses, description_caregiver_relationship, oral_report_filed, oral_report_filed_comment, risk_to_investigator, risk_to_investigator_comment) VALUES(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?, ?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?,?)";
			
		}
		PreparedStatement stmt;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, status);
			stmt.setInt(2, reporterId);
			stmt.setString(3, reporterName);
			stmt.setString(4, reporterAddress);
			stmt.setString(5, reporterTelephone);
			stmt.setString(6, mandated);
			stmt.setString(7, reporterRelationshipToVictim);
			if(caseType==1||caseType==2){
			stmt.setInt(8, allegedVictimPatientId);
			}else if(caseType==3){
				stmt.setInt(8, allegedVictimStaffId);
			}
			stmt.setString(9, allegedVictimName);
			stmt.setString(10, allegedVictimAddress);
			stmt.setString(11, allegedVictimTelephone);
			stmt.setString(12, allegedVictimSex);
			stmt.setDate(13, allegedVictimDatebirth);
			stmt.setInt(14, allegedVictimMaritalStatusId);
			if(caseType==1){
			stmt.setInt(15, allegedAbuserStaffId);
			}else if(caseType==2||caseType==3){
				stmt.setInt(15, allegedAbuserPatientId);
			}
			stmt.setString(16, allegedAbuserName);
			stmt.setString(17, allegedAbuserAddress);
			stmt.setString(18, allegedAbuserRelationship);
			stmt.setString(19, allegedAbuserSocialSecurity);
			stmt.setDate(20, allegedAbuserDatebirth);
			stmt.setString(21, allegedAbuserTelephone);
			stmt.setString(22, communicationNeed);
			stmt.setInt(23, clientGuardianId);
			stmt.setString(24, clientGuardianName);
			stmt.setString(25, clientGuardianAddress);
			stmt.setString(26, clientGuardianRelationship);
			stmt.setString(27, clientGuardianTelephone);
			stmt.setInt(28, currentlyServedById);
			stmt.setString(29, currentlyServedByComment);
			stmt.setString(30, collateralContactsNotification);
			stmt.setString(31, typeOfServiceComment);
			stmt.setString(32, typeOfAbuseReport);
			stmt.setString(33, frequencyOfAbuse);
			stmt.setString(34, isVictimAware);
			stmt.setDate(35, dateOfLastIncident);
			stmt.setString(36, descriptionAllegedReport);
			stmt.setString(37, descriptionLevelRisk);
			stmt.setString(38, descriptionResultingInjuries);
			stmt.setString(39, descriptionWitnesses);
			stmt.setString(40, descriptionCaregiverRelationship);
			stmt.setString(41, oralReportFilled);
			stmt.setString(42, oralReportFilledComment);
			stmt.setString(43, riskToInvestigator);
			stmt.setString(44, riskToInvestigatorComment);
			
			stmt.executeUpdate();
			
			
			stmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public void uploadFile(int typeOfLetter, int id, String filename){
		
		if (typeOfLetter==1){
			String sql = "UPDATE abusereport SET disposition_letter=? WHERE id=? ";
			try {
				PreparedStatement stmt = conn.prepareStatement(sql);
				stmt.setString(1, filename);
				stmt.setInt(2, id);
				stmt.executeUpdate();
				
				stmt.close();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}else if (typeOfLetter==2){
			String sql = "UPDATE abusereport SET decision_letter=? WHERE id=?";
			try {
				PreparedStatement stmt = conn.prepareStatement(sql);
				stmt.setString(1, filename);
				stmt.setInt(2, id);
				stmt.executeUpdate();
				
				stmt.close();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if (typeOfLetter==3){
			String sql = "UPDATE abusereport SET appeal_letter=? WHERE id=?";
			try {
				PreparedStatement stmt = conn.prepareStatement(sql);
				stmt.setString(1, filename);
				stmt.setInt(2, id);
				stmt.executeUpdate();
				
				stmt.close();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	public void approveLetter(int reportId, int status){
		
		String sql = "UPDATE abusereport SET status=? WHERE id=?";
		PreparedStatement stmt;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, status);
			stmt.setInt(2, reportId);
			stmt.executeUpdate();
			
			stmt.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
}

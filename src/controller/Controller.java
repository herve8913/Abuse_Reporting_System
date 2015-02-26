package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.Servlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import bean.AbuseReport;
import bean.CommunicationNeed;
import bean.CurrentlyServedBy;
import bean.Disability;
import bean.DisabilityType;
import bean.Drug;
import bean.Ethnicity;
import bean.FrequencyOfAbuse;
import bean.GroupHome;
import bean.HealthCareOrg;
import bean.MaritalStatus;
import bean.Patient;
import bean.Relationship;
import bean.TypeOfAbuse;
import bean.TypeOfService;
import bean.User;

/**
 * Servlet implementation class Controller
 */
@WebServlet("/Controller")
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DataSource ds;
	private HttpSession session;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Controller() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		try {
			InitialContext initContext = new InitialContext();

			ds = (DataSource) initContext
					.lookup("java:/comp/env/jdbc/abusereport");

			System.out.println("datasource");
		} catch (NamingException e) {
			System.out.println("ds");
			throw new ServletException();
		}
		if (ds == null) {
			System.out.println("dsnull");
		}
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		String action = request.getParameter("action");

		if (action == null) {
			request.setAttribute("message", "");
			request.getRequestDispatcher("/index.jsp").forward(request,
					response);

		} else if (action.equals("login")) {
			request.setAttribute("email", "");
			request.setAttribute("password", "");
			request.setAttribute("message", "");
			request.getRequestDispatcher("/pages/login.jsp").forward(request,
					response);

		} else if (action.equals("createaccount")) {
			request.setAttribute("email", "");
			request.setAttribute("password", "");
			request.setAttribute("repeatpassword", "");
			request.setAttribute("message", "");
			request.getRequestDispatcher("/pages/createaccount.jsp").forward(
					request, response);

		} else if (action.equals("registerdrug")) {
			request.setAttribute("drugName", "");
			request.setAttribute("descriptionText", "");
			request.setAttribute("status", "1");
			request.setAttribute("message", "");
			request.getRequestDispatcher("/pages/registerdrug.jsp").forward(
					request, response);
		} else if (action.equals("searchdrug")) {
			request.setAttribute("drugName", "");
			request.setAttribute("message", "");
			request.getRequestDispatcher("/pages/searchdrug.jsp").forward(
					request, response);
		}  else if (action.equals("approveabusereport")){
			Connection conn=null;
			try {
				conn = ds.getConnection();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			int userType= (Integer)session.getAttribute("userType");
			if(userType==2){
				List<AbuseReport> listOfSupervisorReport = AbuseReport.supervisorApprovalView(conn, 2);
				request.setAttribute("listOfSupervisorReport", listOfSupervisorReport);
				session.setAttribute("submittedreport", listOfSupervisorReport.size());
				List<AbuseReport> listOfApproveReport = AbuseReport.supervisorApprovalView(conn, 3);
				request.setAttribute("listOfApproveReport", listOfApproveReport);
				request.getRequestDispatcher("/ApproveAbuseReportViewPage.jsp").forward(request, response);
				
			}
		}else if (action.equals("approvalpage")){
			Connection conn=null;
			try {
				conn = ds.getConnection();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			int reportId = Integer.parseInt(request.getParameter("reportId"));
			AbuseReport abuseReport = AbuseReport.approvalAbuseReport(conn, reportId);
			request.setAttribute("abuseReport", abuseReport);
			System.out.println("patient id: "+abuseReport.getAllegedVictimPatientId());
			List<Relationship> listOfRelationship = Relationship.getRelationshipList(conn);
			request.setAttribute("listOfRelationship", listOfRelationship);
			List<Patient> listOfAllPatient = Patient.getAllPatient(conn);
			request.setAttribute("listOfAllPatient", listOfAllPatient);
			List<User> listStaffMembers = User.getStaffMembers(conn,3);
			request.setAttribute("listStaffMembers", listStaffMembers);
			List<TypeOfService> listOfService = TypeOfService.getListOfService(conn);
			request.setAttribute("listOfService", listOfService);
			List<FrequencyOfAbuse> listOfFrequency = FrequencyOfAbuse.getFrequencyOfAbuse(conn);
			request.setAttribute("listOfFrequency", listOfFrequency);
			List<TypeOfAbuse> listOfAbuseType = TypeOfAbuse.getAbuseTypeList(conn);
			request.setAttribute("listOfAbuseType", listOfAbuseType);
			List<CommunicationNeed> listOfComNeed = CommunicationNeed.getListOfComNeed(conn);
			request.setAttribute("listOfComNeed", listOfComNeed);
			request.getRequestDispatcher("/ApproveAbuseReportApprovePage.jsp").forward(request, response);
			
			
		} else if (action.equals("createreport")) {
			Connection conn;
			try {
				conn = ds.getConnection();
				List<User> listStaffMembers = User.getStaffMembers(conn,3);
				request.setAttribute("listStaffMembers", listStaffMembers);
				int id = (Integer)session.getAttribute("userId");
				User user = new User(id,conn);
				user.setUserInfo();
				request.setAttribute("userInfo", user);
				List<Patient> listOfAllPatient = Patient.getAllPatient(conn);
				request.setAttribute("listOfAllPatient", listOfAllPatient);
				List<Relationship> listOfRelationship = Relationship.getRelationshipList(conn);
				request.setAttribute("listOfRelationship", listOfRelationship);
				List<TypeOfService> listOfService = TypeOfService.getListOfService(conn);
				request.setAttribute("listOfService", listOfService);
				List<FrequencyOfAbuse> listOfFrequency = FrequencyOfAbuse.getFrequencyOfAbuse(conn);
				request.setAttribute("listOfFrequency", listOfFrequency);
				List<TypeOfAbuse> listOfAbuseType = TypeOfAbuse.getAbuseTypeList(conn);
				request.setAttribute("listOfAbuseType", listOfAbuseType);
				List<CommunicationNeed> listOfComNeed = CommunicationNeed.getListOfComNeed(conn);
				request.setAttribute("listOfComNeed", listOfComNeed);
				
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			request.getRequestDispatcher("/CreateAbuseReportCreatePage.jsp")
					.forward(request, response);

		} else if(action.equals("logout")) {
			request.setAttribute("message", "");
			request.getRequestDispatcher("/index.jsp").forward(request, response);
			
		} else if (action.equals("approveletter")){
			int reportId = Integer.parseInt(request.getParameter("reportId"));
			int status = Integer.parseInt(request.getParameter("sta"));
			Connection conn=null;
			try {
				conn = ds.getConnection();
				AbuseReport abuseReport = new AbuseReport(conn);
				abuseReport.approveLetter(reportId, status);
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			List<AbuseReport> listOfAbuseReport = AbuseReport.userAbuseReportView((Integer)session.getAttribute("userType"), (Integer)session.getAttribute("userId"), conn);
			session.setAttribute("userAbuseReportView", listOfAbuseReport);
			request.getRequestDispatcher("/Controller?action=approveabusereport").forward(request, response);
		}else if (action.equals("user")){
			Connection conn=null;
			try {
				conn = ds.getConnection();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			List<User> listOfUsers = User.getStaffMembers(conn, 1);
			request.setAttribute("listOfUsers", listOfUsers);
			request.getRequestDispatcher("/Users.jsp").forward(request, response);
			
		}else if(action.equals("newuser")){
			Connection conn=null;
			try {
				conn = ds.getConnection();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			List<MaritalStatus> listOfMaritalStatus = MaritalStatus.getMaritalStatus(conn);
			request.setAttribute("listOfMaritalStatus", listOfMaritalStatus);
			request.getRequestDispatcher("/CreateUser.jsp").forward(request, response);
		}else if (action.equals("updateuser")){
			Connection conn=null;
			try {
				conn = ds.getConnection();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			int id = Integer.parseInt(request.getParameter("userId"));
			User user = new User(id, conn);
			user.setUserInfo();
			request.setAttribute("user", user);
			List<MaritalStatus> listOfMaritalStatus = MaritalStatus.getMaritalStatus(conn);
			request.setAttribute("listOfMaritalStatus", listOfMaritalStatus);
			request.getRequestDispatcher("/UpdateUser.jsp").forward(request, response);
			
		}else if(action.equals("patient")){
			
			Connection conn=null;
			try {
				conn = ds.getConnection();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			List<Patient> listOfPatient = Patient.getPatientPanelList(conn);
			request.setAttribute("listOfPatient", listOfPatient);
			request.getRequestDispatcher("/Patients.jsp").forward(request, response);
			
		}else if (action.equals("newpatient")){
			Connection conn=null;
			try {
				conn = ds.getConnection();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			List<MaritalStatus> listOfMaritalStatus = MaritalStatus.getMaritalStatus(conn);
			request.setAttribute("listOfMaritalStatus", listOfMaritalStatus);
			List<GroupHome> listOfGroupHome = GroupHome.getGroupHomeList(conn);
			request.setAttribute("listOfGroupHome", listOfGroupHome);
			List<CurrentlyServedBy> listOfCurrentlyServed = CurrentlyServedBy.getServedList(conn);
			request.setAttribute("listOfCurrentlyServed", listOfCurrentlyServed);
			List<User> listOfClientGuardian = User.getStaffMembers(conn, 3);
			request.setAttribute("listOfClientGuardian", listOfClientGuardian);
			List<Ethnicity> listOfEthnicity = Ethnicity.getEthnicityList(conn);
			request.setAttribute("listOfEthnicity", listOfEthnicity);
			request.getRequestDispatcher("/CreatePatient.jsp").forward(request, response);
			
		}else if(action.equals("updatepatient")){
			Connection conn=null;
			try {
				conn = ds.getConnection();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			String logNumber = request.getParameter("patientlognumber");
			Patient patient = new Patient(conn, logNumber);
			patient.setPatientInfo(2);
			request.setAttribute("patient", patient);
			List<MaritalStatus> listOfMaritalStatus = MaritalStatus.getMaritalStatus(conn);
			request.setAttribute("listOfMaritalStatus", listOfMaritalStatus);
			List<GroupHome> listOfGroupHome = GroupHome.getGroupHomeList(conn);
			request.setAttribute("listOfGroupHome", listOfGroupHome);
			List<CurrentlyServedBy> listOfCurrentlyServed = CurrentlyServedBy.getServedList(conn);
			request.setAttribute("listOfCurrentlyServed", listOfCurrentlyServed);
			List<User> listOfClientGuardian = User.getStaffMembers(conn, 3);
			request.setAttribute("listOfClientGuardian", listOfClientGuardian);
			List<Ethnicity> listOfEthnicity = Ethnicity.getEthnicityList(conn);
			request.setAttribute("listOfEthnicity", listOfEthnicity);
			request.getRequestDispatcher("/UpdatePatient.jsp").forward(request, response);
		}
		else if (action.equals("drug")){
			Connection conn=null;
			try {
				conn = ds.getConnection();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			List<Drug> listOfDrugs = Drug.getAllDrugs(conn);
			request.setAttribute("listOfDrugs", listOfDrugs);
			request.getRequestDispatcher("/Drugs.jsp").forward(request, response);
		}else if (action.equals("newdrug")){
			Connection conn=null;
			try {
				conn = ds.getConnection();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.getRequestDispatcher("/CreateDrug.jsp").forward(request, response);
		}else if (action.equals("updatedrug")){
			Connection conn=null;
			try {
				conn = ds.getConnection();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			int drugId = Integer.parseInt(request.getParameter("drugId"));
			Drug drug = new Drug(drugId, conn);
			drug.search();
			request.setAttribute("drug", drug);
			request.getRequestDispatcher("/UpdateDrug.jsp").forward(request, response);
		}
		else if (action.equals("modifypage")){
			Connection conn=null;
			try {
				conn = ds.getConnection();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			int reportId = Integer.parseInt(request.getParameter("reportId"));
			AbuseReport abuseReport = AbuseReport.approvalAbuseReport(conn, reportId);
			request.setAttribute("abuseReport", abuseReport);
			List<Relationship> listOfRelationship = Relationship.getRelationshipList(conn);
			request.setAttribute("listOfRelationship", listOfRelationship);
			List<Patient> listOfAllPatient = Patient.getAllPatient(conn);
			request.setAttribute("listOfAllPatient", listOfAllPatient);
			List<User> listStaffMembers = User.getStaffMembers(conn,3);
			request.setAttribute("listStaffMembers", listStaffMembers);
			List<TypeOfService> listOfService = TypeOfService.getListOfService(conn);
			request.setAttribute("listOfService", listOfService);
			List<FrequencyOfAbuse> listOfFrequency = FrequencyOfAbuse.getFrequencyOfAbuse(conn);
			request.setAttribute("listOfFrequency", listOfFrequency);
			List<TypeOfAbuse> listOfAbuseType = TypeOfAbuse.getAbuseTypeList(conn);
			request.setAttribute("listOfAbuseType", listOfAbuseType);
			List<CommunicationNeed> listOfComNeed = CommunicationNeed.getListOfComNeed(conn);
			request.setAttribute("listOfComNeed", listOfComNeed);
			request.getRequestDispatcher("/CreateAbuseReportModifyPage.jsp").forward(request, response);
		}
		else if(action.equals("disability")){
			Connection conn=null;
			try {
				conn = ds.getConnection();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			List<Disability> listOfDisability = Disability.getAllDisability(conn);
			request.setAttribute("listOfDisability", listOfDisability);
			request.getRequestDispatcher("/Disabilities.jsp").forward(request, response);
		}else if (action.equals("newdisability")){
			Connection conn=null;
			try {
				conn = ds.getConnection();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			List<DisabilityType> listOfDisabilityType = DisabilityType.getDisabilityType(conn);
			request.setAttribute("listOfDisabilityType", listOfDisabilityType);
			request.getRequestDispatcher("/CreateDisability.jsp").forward(request, response);
		}else if (action.equals("updatedisability")){
			Connection conn=null;
			try {
				conn = ds.getConnection();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			int disabilityId = Integer.parseInt(request.getParameter("disabilityId"));
			Disability disability = new Disability(disabilityId, conn);
			disability.search();
			request.setAttribute("disability", disability);
			List<DisabilityType> listOfDisabilityType = DisabilityType.getDisabilityType(conn);
			request.setAttribute("listOfDisabilityType", listOfDisabilityType);
			request.getRequestDispatcher("/UpdateDisability.jsp").forward(request, response);
		}else if(action.equals("hrc")){
			Connection conn=null;
			try {
				conn = ds.getConnection();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			List<AbuseReport> listOfApproveReport = AbuseReport.supervisorApprovalView(conn, 5);
			request.setAttribute("listOfApproveReport", listOfApproveReport);
			request.getRequestDispatcher("/HumanRightsComittee.jsp").forward(request, response);
		}else if (action.equals("homegroup")){
			Connection conn=null;
			try {
				conn = ds.getConnection();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			List<GroupHome> listOfGroupHome = GroupHome.getGroupHomeList(conn);
			request.setAttribute("listOfGroupHome", listOfGroupHome);
			request.getRequestDispatcher("/HomeGroups.jsp").forward(request, response);
		}else if (action.equals("newgrouphome")){
			Connection conn=null;
			try {
				conn = ds.getConnection();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			List<HealthCareOrg> listOfHealthCare = HealthCareOrg.getHealthList(conn);
			request.setAttribute("listOfHealthCare", listOfHealthCare);
			request.getRequestDispatcher("/CreateHomeGroup.jsp").forward(request, response);
		}else if(action.equals("updategrouphome")){
			Connection conn=null;
			try {
				conn = ds.getConnection();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			int id = Integer.parseInt(request.getParameter("groupHomeId"));
			GroupHome groupHome = new GroupHome(id, conn);
			groupHome.search();
			request.setAttribute("groupHome", groupHome);
			List<HealthCareOrg> listOfHealthCare = HealthCareOrg.getHealthList(conn);
			request.setAttribute("listOfHealthCare", listOfHealthCare);
			request.getRequestDispatcher("/UpdateGroupHome.jsp").forward(request, response);
			
		}else if (action.equals("viewabusereportpage")){
			Connection conn=null;
			try {
				conn = ds.getConnection();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			int reportId = Integer.parseInt(request.getParameter("reportId"));
			AbuseReport abuseReport = AbuseReport.approvalAbuseReport(conn, reportId);
			request.setAttribute("abuseReport", abuseReport);
			request.getRequestDispatcher("/CreateAbuseReportViewSingle.jsp").forward(request, response);
		}else if (action.equals("track")){
			Connection conn=null;
			try {
				conn = ds.getConnection();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			List<AbuseReport> listOfApproveReport = AbuseReport.supervisorApprovalView(conn, 3);
			request.setAttribute("listOfApproveReport", listOfApproveReport);
			request.getRequestDispatcher("/TrackReports.jsp").forward(request, response);
		}
		else {
			System.out.println("lol");
			out.println("unrecognized1111111");
			return;
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		PrintWriter out = response.getWriter();
		String action = request.getParameter("action");
		if (action == null) {

			out.println("unrecognized");
			return;
		}
		Connection conn = null;

		try {
			conn = ds.getConnection();
			System.out.println("connected");
		} catch (SQLException e) {
			System.out.println("connection problem");
		}

		if (action.equals("dologin")) {
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			session = request.getSession();
			session.setAttribute("email", email);

			request.setAttribute("email", email);
			request.setAttribute("password", "");

			User user = new User(email, password, conn);

			try {
				List<String> list = user.login1();
				if (list.size()!=0) {
					request.setAttribute("email", email);
					session.setAttribute("userName", list.get(0));
					int userId = Integer.parseInt(list.get(5));
					session.setAttribute("userId",userId);
					int userType = Integer.parseInt(list.get(6));
					session.setAttribute("userType", userType);
					session.setAttribute("account", list.get(2));
					
					if(userType==4){
						//HRC
						System.out.println(userType+"hello");
						List<AbuseReport> listOfApproveReport = AbuseReport.supervisorApprovalView(conn, 5);
						request.setAttribute("listOfApproveReport", listOfApproveReport);
						request.getRequestDispatcher("/HumanRightsComittee.jsp").forward(request, response);
						
					}else if(userType==1){
						List<User> listOfUsers = User.getStaffMembers(conn, 1);
						request.setAttribute("listOfUsers", listOfUsers);
						request.getRequestDispatcher("/Users.jsp").forward(request, response);
						
					}else {
					List<AbuseReport> listOfAbuseReport = AbuseReport.userAbuseReportView(userType, userId, conn);
					System.out.println(listOfAbuseReport.size());
					session.setAttribute("userAbuseReportView", listOfAbuseReport);
					List<AbuseReport> listOfSupervisorReport = AbuseReport.supervisorApprovalView(conn, 2);
					session.setAttribute("submittedreport", listOfSupervisorReport.size());
					request.getRequestDispatcher(
							"/CreateAbuseReportViewPage.jsp").forward(request,
							response);
				}
				} else {
					request.setAttribute("message", " The username or password is invalid. Please check them. ");
					request.getRequestDispatcher("/index.jsp").forward(request,
							response);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (action.equals("docreateuser")) {
			String email = request.getParameter("username");
			String password = request.getParameter("password");
			String repeatpassword = request.getParameter("repeatpassword");
			String telephone = request.getParameter("telephone");
			String firstName = request.getParameter("firstname");
			String lastName = request.getParameter("lastname");
			String sex = request.getParameter("sex");
			int maritalStatus = Integer.parseInt(request.getParameter("maritalstatus"));
			String ssn = request.getParameter("ssn");
			System.out.println(request.getParameter("birthdate"));
			Date birthdate = Date.valueOf(request.getParameter("birthdate"));
			String address = request.getParameter("address");
			int userType = Integer.parseInt(request.getParameter("usertype"));

			request.setAttribute("username", email);
			request.setAttribute("telephone", telephone);
			request.setAttribute("firstname", firstName);
			request.setAttribute("lastname", lastName);
			request.setAttribute("sex",sex);
			request.setAttribute("maritalstatus", maritalStatus);
			request.setAttribute("ssn", ssn);
			request.setAttribute("birthdate", birthdate);
			request.setAttribute("address", address);
			request.setAttribute("usertype", userType);
			request.setAttribute("message", "");

			if (!password.equals(repeatpassword)) {
				request.setAttribute("message", "check your passowrd");
				List<MaritalStatus> listOfMaritalStatus = MaritalStatus.getMaritalStatus(conn);
				request.setAttribute("listOfMaritalStatus", listOfMaritalStatus);
				request.getRequestDispatcher("/CreateUser.jsp")
						.forward(request, response);
			} else {
				User user = new User(email, password, conn);

				if (!user.validate()) {
					// Password or email address has wrong format.
					request.setAttribute("message", user.getMessage());
					List<MaritalStatus> listOfMaritalStatus = MaritalStatus.getMaritalStatus(conn);
					request.setAttribute("listOfMaritalStatus", listOfMaritalStatus);
					request.getRequestDispatcher("/CreateUser.jsp")
							.forward(request, response);
				} else {
					try {
						if (user.exists()) {
							// This email address already exists in the user
							// database.
							request.setAttribute("message",
									"An account with this email address already exists");
							List<MaritalStatus> listOfMaritalStatus = MaritalStatus.getMaritalStatus(conn);
							request.setAttribute("listOfMaritalStatus", listOfMaritalStatus);
							request.getRequestDispatcher(
									"/CreateUser.jsp").forward(
									request, response);
						} else {
							// We create create the account.
							user.setBirthday(birthdate);
							user.setMaritalStatusId(maritalStatus);
							user.setSex(sex);
							user.setTelephone(telephone);
							user.setUserAddress(address);
							user.setSocialSecurity(ssn);
							user.setUserName(firstName);
							user.setUserLastName(lastName);
							user.setUserType(userType);
							user.create();
							List<User> listOfUsers = User.getStaffMembers(conn, 1);
							request.setAttribute("listOfUsers", listOfUsers);
							request.getRequestDispatcher(
									"/Users.jsp").forward(
									request, response);
						}
					} catch (SQLException e) {
						
						request.getRequestDispatcher("/pages/error.jsp")
								.forward(request, response);
					}
				}

			}
		} else if (action.equals("docreatedrug")) {

			String drugName = request.getParameter("drugname");
			String descriptionText = request.getParameter("description");

			Drug drug = new Drug(drugName, descriptionText, conn);
			
				if (drug.exist()) {
					// already exist
					request.setAttribute("message",
							"This drug has already been registered");
					request.getRequestDispatcher("/CreateDrug.jsp")
							.forward(request, response);
				} else {
					// register the drug
					drug.register();
					List<Drug> listOfDrugs = Drug.getAllDrugs(conn);
					request.setAttribute("listOfDrugs", listOfDrugs);
					request.getRequestDispatcher("/Drugs.jsp")
							.forward(request, response);
				}

		} else if (action.equals("dodeletedrug")){
			int id = Integer.parseInt(request.getParameter("drugid"));
			Drug.deleter(conn, id);
			List<Drug> listOfDrugs = Drug.getAllDrugs(conn);
			request.setAttribute("listOfDrugs", listOfDrugs);
			request.getRequestDispatcher("/Drugs.jsp").forward(request, response);
			
		}
			else if (action.equals("dosearch")) {
			String drugName = request.getParameter("drugName");
			request.setAttribute("drugName", drugName);
			Drug drug = new Drug(drugName, conn);
			
				request.setAttribute("message", drug.getSearchResult());
				request.getRequestDispatcher("/pages/searchsuccess.jsp")
						.forward(request, response);
			

		} else if (action.equals("doupdatedrug")) {

			String drugName = request.getParameter("drugname");
			String descriptionText = request.getParameter("description");
			request.setAttribute("drugname", drugName);
			request.setAttribute("description", descriptionText);

			Drug drug = new Drug(drugName, descriptionText, conn);
				
					drug.update();
					List<Drug> listOfDrugs = Drug.getAllDrugs(conn);
					request.setAttribute("listOfDrugs", listOfDrugs);
					request.getRequestDispatcher("/Drugs.jsp").forward(request, response);
				
			
		} else if (action.equals("dosendemail")) {
			String email = request.getParameter("email");
			User user = new User(email, conn);
			if (!user.sendEmail()) {
				request.setAttribute("message", user.getMessage());
				request.getRequestDispatcher("/index.jsp").forward(request,
						response);

			} else {
				request.setAttribute("message", user.getMessage());
				request.getRequestDispatcher("/index.jsp").forward(request,
						response);
			}
		} else if (action.equals("dodelete")){
			
			String logNumber = request.getParameter("lognumber");
			String src = request.getParameter("src");
			AbuseReport.deleteAbuseReport(logNumber, conn);
			if(src.equals("createviewpage")){
			int userType = (Integer)session.getAttribute("userType");
			int userId = (Integer)session.getAttribute("userId");
			List<AbuseReport> listOfAbuseReport = AbuseReport.userAbuseReportView(userType, userId, conn);
			session.setAttribute("userAbuseReportView", listOfAbuseReport);
			request.getRequestDispatcher("/CreateAbuseReportViewPage.jsp").forward(request, response);
			}
			else if(src.equals("approvepage")){
				List<AbuseReport> listOfSupervisorReport = AbuseReport.supervisorApprovalView(conn,2);
				request.setAttribute("listOfSupervisorReport", listOfSupervisorReport);
				session.setAttribute("submittedreport", listOfSupervisorReport.size());
				List<AbuseReport> listOfApproveReport = AbuseReport.supervisorApprovalView(conn, 3);
				request.setAttribute("listOfApproveReport", listOfApproveReport);
				request.getRequestDispatcher("/ApproveAbuseReportViewPage.jsp").forward(request, response);
			}
			
		}else if (action.equals("docreatereport")) {
			int caseType;
			AbuseReport abuseReport;
			
				int id = (Integer)session.getAttribute("userId");
				User user = new User(id,conn);
				user.setUserInfo();
				String mandated = request.getParameter("mandated");
				String reporterRelationToVictim = request.getParameter("relationship");
				
				if(request.getParameter("radio1").equals("Patient")){
					System.out.println("patient");
					caseType=1;
				int allegedVictimPatientId = Integer.parseInt(request.getParameter("allegedVictimPatient"));
				//Patient victim = new Patient(allegedVictimPatientId,conn);
				//victim.setPatientInfo();
				abuseReport = new AbuseReport(id,allegedVictimPatientId,conn);
				abuseReport.setVictimPatientGuardian();
				Patient patient = new Patient(allegedVictimPatientId,conn);
				patient.setPatientInfo(1);
				abuseReport.setCurrentlyServedById(patient.getCurrentlyServedById());
				abuseReport.setCurrentlyServedByComment(CurrentlyServedBy.getCurrentlyServedBy(patient.getCurrentlyServedById(), conn));
				
				}else{
					System.out.println("staff");
					caseType=3;
					int allegedVictimStaffId = Integer.parseInt(request.getParameter("allegedVictimStaff"));
					User victim = new User(allegedVictimStaffId,conn);
					victim.setUserInfo();
					abuseReport = new AbuseReport(id,conn);
					abuseReport.setAllegedVictimAddress(victim.getUserAddress());
					abuseReport.setAllegedVictimDatebirth(victim.getBirthday());
					abuseReport.setAllegedVictimMaritalStatusId(victim.getMaritalStatusId());
					abuseReport.setAllegedVictimStaffId(victim.getId());
					abuseReport.setAllegedVictimName(victim.getUserName()+" "+victim.getUserLastName());
					abuseReport.setAllegedVictimTelephone(victim.getTelephone());
					abuseReport.setAllegedVictimSex(victim.getSex());
					
				}
				if(request.getParameter("radio2").equals("Staff")){
					System.out.println("Abuser Staff");
					if(request.getParameter("radio1").equals("Staff")){
						request.setAttribute("message", "Staff cannot be the victim and abuser at the same time");
						request.getRequestDispatcher("/CreateAbuseReportCreatePage.jsp").forward(request, response);
					}
					
				int abuserStaffId = Integer.parseInt(request.getParameter("allegedAbuserStaff"));
				User abuser = new User(abuserStaffId,conn);
				abuser.setUserInfo();
				String name = abuser.getUserName()+" "+abuser.getUserLastName();
				abuseReport.setAllegedAbuserStaffId(abuser.getId());
				abuseReport.setAllegedAbuserAddress(abuser.getUserAddress());
				abuseReport.setAllegedAbuserDatebirth(abuser.getBirthday());
				abuseReport.setAllegedAbuserName(name);
				abuseReport.setAllegedAbuserSocialSecurity(abuser.getSocialSecurity());
				abuseReport.setAllegedAbuserTelephone(abuser.getTelephone());
				}else{
					int abuserPatientId = Integer.parseInt(request.getParameter("allegedAbuserPatient"));
					if(request.getParameter("radio1").equals("Patient")){
						caseType=2;
						abuseReport.setAbuserPatientGuardian2(abuserPatientId);
					}else{
						abuseReport.setAbuserPatientGuardian(abuserPatientId);
						Patient patient =new Patient(abuserPatientId,conn);
						patient.setPatientInfo(1);
						abuseReport.setCurrentlyServedById(patient.getCurrentlyServedById());
						abuseReport.setCurrentlyServedByComment(CurrentlyServedBy.getCurrentlyServedBy(patient.getCurrentlyServedById(), conn));

					}
				}
				
				abuseReport.setMandated(mandated);
				abuseReport.setReporterRelationshipToVictim(reporterRelationToVictim);
				String abuserRelationship = request.getParameter("relationship2");
				String collateralContacts = request.getParameter("collateralcontacts");
				String typeOfService = request.getParameter("typeofservice");
				String communicationNeeds = request.getParameter("communicationneeds");
				if (communicationNeeds.equals("Other")){
					communicationNeeds= request.getParameter("textinputcomneed");
				}
				abuseReport.setAllegedAbuserRelationship(abuserRelationship);
				abuseReport.setCollateralContactsNotification(collateralContacts);
				abuseReport.setTypeOfServiceComment(typeOfService);
				abuseReport.setCommunicationNeed(communicationNeeds);
				
				//Abuse Information
				String frequencyOfAbuse = request.getParameter("frequencyofabuse");
				abuseReport.setFrequencyOfAbuse(frequencyOfAbuse);
				abuseReport.setIsVictimAware(request.getParameter("awareofreport"));
				String typeOfAbuse = request.getParameter("typesofabuse");
				if (typeOfAbuse==null){
					//user should check at least one checkbox
				}
					if(typeOfAbuse.equals("Other")){
						typeOfAbuse=request.getParameter("textinputabusetype");
					}
				abuseReport.setTypeOfAbuseReport(typeOfAbuse);
				abuseReport.setDescriptionAllegedReport(request.getParameter("descriptionallegedabuse"));
				abuseReport.setDescriptionLevelRisk(request.getParameter("descriptionlevelrisk"));
				abuseReport.setDescriptionResultingInjuries(request.getParameter("resultinginjuries"));
				abuseReport.setDescriptionWitnesses(request.getParameter("witnesses"));
				abuseReport.setDescriptionCaregiverRelationship(request.getParameter("caregiverrelationship"));
				
				String oralReport = request.getParameter("Hotline");
				if(oralReport.equals("Yes")){
					abuseReport.setOralReportFilled(oralReport);
					abuseReport.setOralReportFilledComment(request.getParameter("oralreportcomment"));
				}else {
					abuseReport.setOralReportFilled(oralReport);
				}
				
				String riskToInvestigator = request.getParameter("Risk");
				if(riskToInvestigator.equals("Yes")){
					abuseReport.setRiskToInvestigator(riskToInvestigator);
					abuseReport.setRiskToInvestigatorComment(request.getParameter("risktoinvestigatorcomment"));
				}else {
					abuseReport.setRiskToInvestigator(riskToInvestigator);
				}
				if (request.getParameter("submit")!=null){
					System.out.println("submit");
						abuseReport.setStatus(2);
						abuseReport.saveAbuseReport(caseType);
						List<AbuseReport> listOfSupervisorReport = AbuseReport.supervisorApprovalView(conn, 2);
						session.setAttribute("submittedreport", listOfSupervisorReport.size());
						List<AbuseReport> listOfAbuseReport = AbuseReport.userAbuseReportView((Integer)session.getAttribute("userType"), (Integer)session.getAttribute("userId"), conn);
						session.setAttribute("userAbuseReportView", listOfAbuseReport);
						request.getRequestDispatcher("/CreateAbuseReportViewPage.jsp").forward(request, response);
				}
				else if(request.getParameter("save")!=null){
				System.out.println("save");
				abuseReport.setStatus(1);
				abuseReport.saveAbuseReport(caseType);
				List<AbuseReport> listOfAbuseReport = AbuseReport.userAbuseReportView((Integer)session.getAttribute("userType"), (Integer)session.getAttribute("userId"), conn);
				session.setAttribute("userAbuseReportView", listOfAbuseReport);
				request.getRequestDispatcher("/CreateAbuseReportViewPage.jsp").forward(request, response);
			}
	
		}else if(action.equals("doapprovereport")){
			int caseType;
			AbuseReport abuseReport;
			
				int id = Integer.parseInt(request.getParameter("reporterId"));
				User user = new User(id,conn);
				user.setUserInfo();
				String mandated = request.getParameter("mandated");
				String reporterRelationToVictim = request.getParameter("relationship");
				
				if(request.getParameter("radio1").equals("Patient")){
					System.out.println("patient");
					caseType=1;
				int allegedVictimPatientId = Integer.parseInt(request.getParameter("allegedVictimPatient"));
				//Patient victim = new Patient(allegedVictimPatientId,conn);
				//victim.setPatientInfo();
				abuseReport = new AbuseReport(id,allegedVictimPatientId,conn);
				abuseReport.setVictimPatientGuardian();
				Patient patient = new Patient(allegedVictimPatientId,conn);
				patient.setPatientInfo(1);
				abuseReport.setCurrentlyServedById(patient.getCurrentlyServedById());
				abuseReport.setCurrentlyServedByComment(CurrentlyServedBy.getCurrentlyServedBy(patient.getCurrentlyServedById(), conn));
				
				}else{
					System.out.println("staff");
					caseType=3;
					int allegedVictimStaffId = Integer.parseInt(request.getParameter("allegedVictimStaff"));
					User victim = new User(allegedVictimStaffId,conn);
					victim.setUserInfo();
					abuseReport = new AbuseReport(id,conn);
					abuseReport.setAllegedVictimAddress(victim.getUserAddress());
					abuseReport.setAllegedVictimDatebirth(victim.getBirthday());
					abuseReport.setAllegedVictimMaritalStatusId(victim.getMaritalStatusId());
					abuseReport.setAllegedVictimStaffId(victim.getId());
					abuseReport.setAllegedVictimName(victim.getUserName()+" "+victim.getUserLastName());
					abuseReport.setAllegedVictimTelephone(victim.getTelephone());
					abuseReport.setAllegedVictimSex(victim.getSex());
					
				}
				if(request.getParameter("radio2").equals("Staff")){
					System.out.println("Abuser Staff");
					if(request.getParameter("radio1").equals("Staff")){
						request.setAttribute("message", "Staff cannot be the victim and abuser at the same time");
						request.getRequestDispatcher("/CreateAbuseReportCreatePage.jsp").forward(request, response);
					}
					
				int abuserStaffId = Integer.parseInt(request.getParameter("allegedAbuserStaff"));
				User abuser = new User(abuserStaffId,conn);
				abuser.setUserInfo();
				abuseReport.setAllegedAbuserStaffId(abuser.getId());
				abuseReport.setAllegedAbuserAddress(abuser.getUserAddress());
				abuseReport.setAllegedAbuserDatebirth(abuser.getBirthday());
				abuseReport.setAllegedAbuserName(abuser.getUserName()+" "+abuser.getUserLastName());
				abuseReport.setAllegedAbuserSocialSecurity(abuser.getSocialSecurity());
				abuseReport.setAllegedAbuserTelephone(abuser.getTelephone());
				}else{
					int abuserPatientId = Integer.parseInt(request.getParameter("allegedAbuserPatient"));
					if(request.getParameter("radio1").equals("Patient")){
						caseType=2;
						abuseReport.setAbuserPatientGuardian2(abuserPatientId);
					}else{
						abuseReport.setAbuserPatientGuardian(abuserPatientId);
						Patient patient =new Patient(abuserPatientId,conn);
						patient.setPatientInfo(1);
						abuseReport.setCurrentlyServedById(patient.getCurrentlyServedById());
						abuseReport.setCurrentlyServedByComment(CurrentlyServedBy.getCurrentlyServedBy(patient.getCurrentlyServedById(), conn));

					}
				}
				
				abuseReport.setMandated(mandated);
				abuseReport.setReporterRelationshipToVictim(reporterRelationToVictim);
				String abuserRelationship = request.getParameter("relationship2");
				String collateralContacts = request.getParameter("collateralcontacts");
				String typeOfService = request.getParameter("typeofservice");
				String communicationNeeds = request.getParameter("communicationneeds");
				if (communicationNeeds.equals("Other")){
					communicationNeeds= request.getParameter("textinputcomneed");
				}
				abuseReport.setAllegedAbuserRelationship(abuserRelationship);
				abuseReport.setCollateralContactsNotification(collateralContacts);
				abuseReport.setTypeOfServiceComment(typeOfService);
				abuseReport.setCommunicationNeed(communicationNeeds);
				
				//Abuse Information
				String frequencyOfAbuse = request.getParameter("frequencyofabuse");
				abuseReport.setFrequencyOfAbuse(frequencyOfAbuse);
				abuseReport.setIsVictimAware(request.getParameter("awareofreport"));
				String typeOfAbuse = request.getParameter("typesofabuse");
				if (typeOfAbuse==null){
					//user should check at least one checkbox
				}
					if(typeOfAbuse.equals("Other")){
						typeOfAbuse=request.getParameter("textinputabusetype");
					}
				abuseReport.setTypeOfAbuseReport(typeOfAbuse);
				abuseReport.setDescriptionAllegedReport(request.getParameter("descriptionallegedabuse"));
				abuseReport.setDescriptionLevelRisk(request.getParameter("descriptionlevelrisk"));
				abuseReport.setDescriptionResultingInjuries(request.getParameter("resultinginjuries"));
				abuseReport.setDescriptionWitnesses(request.getParameter("witnesses"));
				abuseReport.setDescriptionCaregiverRelationship(request.getParameter("caregiverrelationship"));
				
				String oralReport = request.getParameter("Hotline");
				if(oralReport.equals("Yes")){
					abuseReport.setOralReportFilled(oralReport);
					abuseReport.setOralReportFilledComment(request.getParameter("oralreportcomment"));
				}else {
					abuseReport.setOralReportFilled(oralReport);
				}
				
				String riskToInvestigator = request.getParameter("Risk");
				if(riskToInvestigator.equals("Yes")){
					abuseReport.setRiskToInvestigator(riskToInvestigator);
					abuseReport.setRiskToInvestigatorComment(request.getParameter("risktoinvestigatorcomment"));
				}else {
					abuseReport.setRiskToInvestigator(riskToInvestigator);
				}
				if (request.getParameter("approve")!=null){
					System.out.println("approve");
						abuseReport.setStatus(3);
						abuseReport.updateAbuseReport(caseType, Integer.parseInt(request.getParameter("reportId")));
						List<AbuseReport> listOfSupervisorReport = AbuseReport.supervisorApprovalView(conn,2);
						request.setAttribute("listOfSupervisorReport", listOfSupervisorReport);
						session.setAttribute("submittedreport", listOfSupervisorReport.size());
						List<AbuseReport> listOfApproveReport = AbuseReport.supervisorApprovalView(conn, 3);
						request.setAttribute("listOfApproveReport", listOfApproveReport);
						List<AbuseReport> listOfAbuseReport = AbuseReport.userAbuseReportView((Integer)session.getAttribute("userType"), (Integer)session.getAttribute("userId"), conn);
						session.setAttribute("userAbuseReportView", listOfAbuseReport);
						request.getRequestDispatcher("/ApproveAbuseReportViewPage.jsp").forward(request, response);
				}
				else if(request.getParameter("save")!=null){
				System.out.println("save");
				abuseReport.setStatus(2);
				abuseReport.updateAbuseReport(caseType, Integer.parseInt(request.getParameter("reportId")));
				List<AbuseReport> listOfSupervisorReport = AbuseReport.supervisorApprovalView(conn,2);
				request.setAttribute("listOfSupervisorReport", listOfSupervisorReport);
				session.setAttribute("submittedreport", listOfSupervisorReport.size());
				List<AbuseReport> listOfApproveReport = AbuseReport.supervisorApprovalView(conn, 3);
				request.setAttribute("listOfApproveReport", listOfApproveReport);
				List<AbuseReport> listOfAbuseReport = AbuseReport.userAbuseReportView((Integer)session.getAttribute("userType"), (Integer)session.getAttribute("userId"), conn);
				session.setAttribute("userAbuseReportView", listOfAbuseReport);
				request.getRequestDispatcher("/ApproveAbuseReportViewPage.jsp").forward(request, response);
				}
		}else if(action.equals("upload")){
			int id = (Integer) request.getAttribute("id");
			int typeOfLetter = (Integer) request.getAttribute("typeofletter");
			String fileName = (String) request.getAttribute("filename");
			System.out.println("controller upload");
			if(id!=0&&typeOfLetter!=0&&fileName!=null){
				AbuseReport abuseReport = new AbuseReport(conn);
				abuseReport.uploadFile(typeOfLetter, id, fileName);
				
			}
			List<AbuseReport> listOfSupervisorReport = AbuseReport.supervisorApprovalView(conn, 2);
			request.setAttribute("listOfSupervisorReport", listOfSupervisorReport);
			session.setAttribute("submittedreport", listOfSupervisorReport.size());
			List<AbuseReport> listOfApproveReport = AbuseReport.supervisorApprovalView(conn, 3);
			request.setAttribute("listOfApproveReport", listOfApproveReport);
			request.getRequestDispatcher("/ApproveAbuseReportViewPage.jsp").forward(request, response);
		}else if (action.equals("domodify")){
			int caseType;
			AbuseReport abuseReport;
			
				int id = Integer.parseInt(request.getParameter("reporterId"));
				User user = new User(id,conn);
				user.setUserInfo();
				String mandated = request.getParameter("mandated");
				String reporterRelationToVictim = request.getParameter("relationship");
				
				if(request.getParameter("radio1").equals("Patient")){
					System.out.println("patient");
					caseType=1;
				int allegedVictimPatientId = Integer.parseInt(request.getParameter("allegedVictimPatient"));
				//Patient victim = new Patient(allegedVictimPatientId,conn);
				//victim.setPatientInfo();
				abuseReport = new AbuseReport(id,allegedVictimPatientId,conn);
				abuseReport.setVictimPatientGuardian();
				Patient patient = new Patient(allegedVictimPatientId,conn);
				patient.setPatientInfo(1);
				abuseReport.setCurrentlyServedById(patient.getCurrentlyServedById());
				abuseReport.setCurrentlyServedByComment(CurrentlyServedBy.getCurrentlyServedBy(patient.getCurrentlyServedById(), conn));
				
				}else{
					System.out.println("staff");
					caseType=3;
					int allegedVictimStaffId = Integer.parseInt(request.getParameter("allegedVictimStaff"));
					User victim = new User(allegedVictimStaffId,conn);
					victim.setUserInfo();
					abuseReport = new AbuseReport(id,conn);
					abuseReport.setAllegedVictimAddress(victim.getUserAddress());
					abuseReport.setAllegedVictimDatebirth(victim.getBirthday());
					abuseReport.setAllegedVictimMaritalStatusId(victim.getMaritalStatusId());
					abuseReport.setAllegedVictimStaffId(victim.getId());
					abuseReport.setAllegedVictimName(victim.getUserName()+" "+victim.getUserLastName());
					abuseReport.setAllegedVictimTelephone(victim.getTelephone());
					abuseReport.setAllegedVictimSex(victim.getSex());
					
				}
				if(request.getParameter("radio2").equals("Staff")){
					System.out.println("Abuser Staff");
					if(request.getParameter("radio1").equals("Staff")){
						request.setAttribute("message", "Staff cannot be the victim and abuser at the same time");
						request.getRequestDispatcher("/CreateAbuseReportCreatePage.jsp").forward(request, response);
					}
					
				int abuserStaffId = Integer.parseInt(request.getParameter("allegedAbuserStaff"));
				User abuser = new User(abuserStaffId,conn);
				abuser.setUserInfo();
				abuseReport.setAllegedAbuserStaffId(abuser.getId());
				abuseReport.setAllegedAbuserAddress(abuser.getUserAddress());
				abuseReport.setAllegedAbuserDatebirth(abuser.getBirthday());
				abuseReport.setAllegedAbuserName(abuser.getUserName()+" "+abuser.getUserLastName());
				abuseReport.setAllegedAbuserSocialSecurity(abuser.getSocialSecurity());
				abuseReport.setAllegedAbuserTelephone(abuser.getTelephone());
				}else{
					int abuserPatientId = Integer.parseInt(request.getParameter("allegedAbuserPatient"));
					if(request.getParameter("radio1").equals("Patient")){
						caseType=2;
						abuseReport.setAbuserPatientGuardian2(abuserPatientId);
					}else{
						abuseReport.setAbuserPatientGuardian(abuserPatientId);
						Patient patient =new Patient(abuserPatientId,conn);
						patient.setPatientInfo(1);
						abuseReport.setCurrentlyServedById(patient.getCurrentlyServedById());
						abuseReport.setCurrentlyServedByComment(CurrentlyServedBy.getCurrentlyServedBy(patient.getCurrentlyServedById(), conn));

					}
				}
				
				abuseReport.setMandated(mandated);
				abuseReport.setReporterRelationshipToVictim(reporterRelationToVictim);
				String abuserRelationship = request.getParameter("relationship2");
				String collateralContacts = request.getParameter("collateralcontacts");
				String typeOfService = request.getParameter("typeofservice");
				String communicationNeeds = request.getParameter("communicationneeds");
				if (communicationNeeds.equals("Other")){
					communicationNeeds= request.getParameter("textinputcomneed");
				}
				abuseReport.setAllegedAbuserRelationship(abuserRelationship);
				abuseReport.setCollateralContactsNotification(collateralContacts);
				abuseReport.setTypeOfServiceComment(typeOfService);
				abuseReport.setCommunicationNeed(communicationNeeds);
				
				//Abuse Information
				String frequencyOfAbuse = request.getParameter("frequencyofabuse");
				abuseReport.setFrequencyOfAbuse(frequencyOfAbuse);
				abuseReport.setIsVictimAware(request.getParameter("awareofreport"));
				String typeOfAbuse = request.getParameter("typesofabuse");
				if (typeOfAbuse==null){
					//user should check at least one checkbox
				}
					if(typeOfAbuse.equals("Other")){
						typeOfAbuse=request.getParameter("textinputabusetype");
					}
				abuseReport.setTypeOfAbuseReport(typeOfAbuse);
				abuseReport.setDescriptionAllegedReport(request.getParameter("descriptionallegedabuse"));
				abuseReport.setDescriptionLevelRisk(request.getParameter("descriptionlevelrisk"));
				abuseReport.setDescriptionResultingInjuries(request.getParameter("resultinginjuries"));
				abuseReport.setDescriptionWitnesses(request.getParameter("witnesses"));
				abuseReport.setDescriptionCaregiverRelationship(request.getParameter("caregiverrelationship"));
				
				String oralReport = request.getParameter("Hotline");
				if(oralReport.equals("Yes")){
					abuseReport.setOralReportFilled(oralReport);
					abuseReport.setOralReportFilledComment(request.getParameter("oralreportcomment"));
				}else {
					abuseReport.setOralReportFilled(oralReport);
				}
				
				String riskToInvestigator = request.getParameter("Risk");
				if(riskToInvestigator.equals("Yes")){
					abuseReport.setRiskToInvestigator(riskToInvestigator);
					abuseReport.setRiskToInvestigatorComment(request.getParameter("risktoinvestigatorcomment"));
				}else {
					abuseReport.setRiskToInvestigator(riskToInvestigator);
				}
				if (request.getParameter("submit")!=null){
					System.out.println("approve");
						abuseReport.setStatus(2);
						abuseReport.updateAbuseReport(caseType, Integer.parseInt(request.getParameter("reportId")));
						List<AbuseReport> listOfSupervisorReport = AbuseReport.supervisorApprovalView(conn,2);
						session.setAttribute("submittedreport", listOfSupervisorReport.size());
						List<AbuseReport> listOfAbuseReport = AbuseReport.userAbuseReportView((Integer)session.getAttribute("userType"), (Integer)session.getAttribute("userId"), conn);
						session.setAttribute("userAbuseReportView", listOfAbuseReport);
						request.getRequestDispatcher("/CreateAbuseReportViewPage.jsp").forward(request, response);
				}
				else if(request.getParameter("save")!=null){
				System.out.println("save");
				abuseReport.setStatus(1);
				abuseReport.updateAbuseReport(caseType, Integer.parseInt(request.getParameter("reportId")));
				List<AbuseReport> listOfSupervisorReport = AbuseReport.supervisorApprovalView(conn,2);
				session.setAttribute("submittedreport", listOfSupervisorReport.size());
				List<AbuseReport> listOfAbuseReport = AbuseReport.userAbuseReportView((Integer)session.getAttribute("userType"), (Integer)session.getAttribute("userId"), conn);
				session.setAttribute("userAbuseReportView", listOfAbuseReport);
				request.getRequestDispatcher("/CreateAbuseReportViewPage.jsp").forward(request, response);
				}
		}else if (action.equals("docreatedisability")){
			String name = request.getParameter("disabilityname");
			int typeId = Integer.parseInt(request.getParameter("disabilitytype"));
			String description = request.getParameter("description");
			Disability disability = new Disability(name, typeId, description, conn);
			disability.createDisability();
			List<Disability> listOfDisability = Disability.getAllDisability(conn);
			request.setAttribute("listOfDisability", listOfDisability);
			request.getRequestDispatcher("/Disabilities.jsp").forward(request, response);
			
		}else if (action.equals("dodeletedisability")){
			int disabilityId = Integer.parseInt(request.getParameter("disabilityid"));
			Disability.deleteDisability(conn, disabilityId);
			List<Disability> listOfDisability = Disability.getAllDisability(conn);
			request.setAttribute("listOfDisability", listOfDisability);
			request.getRequestDispatcher("/Disabilities.jsp").forward(request, response);
		}else if (action.equals("doupdatedisability")){
			String name = request.getParameter("disabilityname");
			int typeId = Integer.parseInt(request.getParameter("disabilitytype"));
			String description = request.getParameter("description");
			int id = Integer.parseInt(request.getParameter("disabilityid"));
			Disability disability = new Disability(id, name, typeId, description , conn);
			disability.updateDisability();
			List<Disability> listOfDisability = Disability.getAllDisability(conn);
			request.setAttribute("listOfDisability", listOfDisability);
			request.getRequestDispatcher("/Disabilities.jsp").forward(request, response);
		}else if (action.equals("docreatepatient")){
			String patientName = request.getParameter("patientname");
			String patientMidname = request.getParameter("patientmidname");
			String patientLastName = request.getParameter("patientlastname");
			String sex = request.getParameter("sex");
			int iq = Integer.parseInt(request.getParameter("iq"));
			Date birthdate = Date.valueOf(request.getParameter("birthdate"));
			String telephone = request.getParameter("telephone");
			int maritalStatusId = Integer.parseInt(request.getParameter("maritalstatus"));
			int groupHomeId = Integer.parseInt(request.getParameter("grouphome"));
			int currentlyServedById = Integer.parseInt(request.getParameter("currentlyservedby"));
			int ethnicityId = Integer.parseInt(request.getParameter("ethnicity"));
			int clientGuardianId = Integer.parseInt(request.getParameter("clientguardian"));
			Patient patient = new Patient(patientName, patientMidname, patientLastName, sex, iq, birthdate, telephone, maritalStatusId, groupHomeId, currentlyServedById, ethnicityId, clientGuardianId, conn);
			patient.createPatient();
			List<Patient> listOfPatient = Patient.getPatientPanelList(conn);
			request.setAttribute("listOfPatient", listOfPatient);
			request.getRequestDispatcher("/Patients.jsp").forward(request, response);
		}else if(action.equals("dodeletepatient")){
			String logNumber = request.getParameter("patientlognumber");
			Patient.deletePatient(conn, logNumber);
			List<Patient> listOfPatient = Patient.getPatientPanelList(conn);
			request.setAttribute("listOfPatient", listOfPatient);
			request.getRequestDispatcher("/Patients.jsp").forward(request, response);
		}else if (action.equals("doupdatepatient")){
			String logNumber = request.getParameter("lognumber");
			String patientName = request.getParameter("patientname");
			String patientMidname = request.getParameter("patientmidname");
			String patientLastName = request.getParameter("patientlastname");
			String sex = request.getParameter("sex");
			int iq = Integer.parseInt(request.getParameter("iq"));
			Date birthdate = Date.valueOf(request.getParameter("birthdate"));
			String telephone = request.getParameter("telephone");
			int maritalStatusId = Integer.parseInt(request.getParameter("maritalstatus"));
			int groupHomeId = Integer.parseInt(request.getParameter("grouphome"));
			int currentlyServedById = Integer.parseInt(request.getParameter("currentlyservedby"));
			int ethnicityId = Integer.parseInt(request.getParameter("ethnicity"));
			int clientGuardianId = Integer.parseInt(request.getParameter("clientguardian"));
			Patient patient = new Patient(logNumber, patientName, patientMidname, patientLastName, sex, iq, birthdate, telephone, maritalStatusId, groupHomeId, currentlyServedById, ethnicityId, clientGuardianId, conn);
			patient.updatePatient();
			List<Patient> listOfPatient = Patient.getPatientPanelList(conn);
			request.setAttribute("listOfPatient", listOfPatient);
			request.getRequestDispatcher("/Patients.jsp").forward(request, response);
		}else if (action.equals("dochangepassword")){
			//change password
			String oldPassword = request.getParameter("oldpassword");
			String newPassword = request.getParameter("newpassword");
			String newPassword2 = request.getParameter("newpassword2");
			if(!newPassword.equals(newPassword2)){
				request.setAttribute("message", "The repeated new passwords doesn't match with each other.");
				request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
			}else{
				String login = (String)session.getAttribute("account");
				User user = new User(login, oldPassword, conn);
				try {
					List<String> list = user.login1();
					if(list.size()!=0){
						user.changePassword(newPassword);
						request.setAttribute("message", "Please login again with your new password.");
						request.getRequestDispatcher("index.jsp").forward(request, response);
					}else{
						request.setAttribute("message", "The old password is not correct.");
						request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}
		}else if (action.equals("docreatehomegroup")){
			String name = request.getParameter("homegroupname");
			String address = request.getParameter("address");
			String description = request.getParameter("description");
			int healthCareOrgId = Integer.parseInt(request.getParameter("healthcareorg"));
			GroupHome groupHome = new GroupHome(name,address, description, healthCareOrgId, conn);
			groupHome.create();
			List<GroupHome> listOfGroupHome = GroupHome.getGroupHomeList(conn);
			request.setAttribute("listOfGroupHome", listOfGroupHome);
			request.getRequestDispatcher("/HomeGroups.jsp").forward(request, response);
		}else if(action.equals("dodeletegrouphome")){
			int id = Integer.parseInt(request.getParameter("grouphomeid"));
			GroupHome.delete(conn, id);
			List<GroupHome> listOfGroupHome = GroupHome.getGroupHomeList(conn);
			request.setAttribute("listOfGroupHome", listOfGroupHome);
			request.getRequestDispatcher("/HomeGroups.jsp").forward(request, response);
		}else if(action.equals("doupdatehomegroup")){
			String name = request.getParameter("homegroupname");
			String address = request.getParameter("address");
			int status = Integer.parseInt(request.getParameter("status"));
			String description = request.getParameter("description");
			int healthCareOrgId = Integer.parseInt(request.getParameter("healthcareorg"));
			int id = Integer.parseInt(request.getParameter("grouphomeid"));
			GroupHome groupHome = new GroupHome(id, status, name,description, address, healthCareOrgId, conn);
			groupHome.update();
			List<GroupHome> listOfGroupHome = GroupHome.getGroupHomeList(conn);
			request.setAttribute("listOfGroupHome", listOfGroupHome);
			request.getRequestDispatcher("/HomeGroups.jsp").forward(request, response);
		}else if (action.equals("dodeleteuser")){
			int id = Integer.parseInt(request.getParameter("userid"));
			User.delete(conn, id);
			List<User> listOfUsers = User.getStaffMembers(conn, 1);
			request.setAttribute("listOfUsers", listOfUsers);
			request.getRequestDispatcher("/Users.jsp").forward(request, response);
		}else if (action.equals("doupdateuser")){
			String email = request.getParameter("username");
			String telephone = request.getParameter("telephone");
			String firstName = request.getParameter("firstname");
			String lastName = request.getParameter("lastname");
			String sex = request.getParameter("sex");
			int maritalStatus = Integer.parseInt(request.getParameter("maritalstatus"));
			String ssn = request.getParameter("ssn");
			Date birthdate = Date.valueOf(request.getParameter("birthdate"));
			String address = request.getParameter("address");
			int userType = Integer.parseInt(request.getParameter("usertype"));
			User user = new User(email, userType, firstName, lastName, ssn, telephone, birthdate, maritalStatus, address, sex, conn);
			user.update();
			List<User> listOfUsers = User.getStaffMembers(conn, 1);
			request.setAttribute("listOfUsers", listOfUsers);
			request.getRequestDispatcher("/Users.jsp").forward(request, response);
		}
		else {
			out.println("unrecognised action");
		}

		try {
			conn.close();
		} catch (SQLException e) {
			throw new ServletException();
		}

	}

}

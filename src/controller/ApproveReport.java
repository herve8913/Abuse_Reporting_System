package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

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
import bean.FrequencyOfAbuse;
import bean.Patient;
import bean.Relationship;
import bean.TypeOfAbuse;
import bean.TypeOfService;
import bean.User;

/**
 * Servlet implementation class ApproveReport
 */
@WebServlet(description = "a controller used to handle report approval action", urlPatterns = { "/ApproveReport" })
public class ApproveReport extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private DataSource ds;
    private HttpSession session;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ApproveReport() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		ds = Utils.getDataSource();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String action = request.getParameter("action");

		if (action == null) {
			request.setAttribute("message", "");
			request.getRequestDispatcher("/index.jsp").forward(request,
					response);

		} else if (action.equals("approveabusereport")) {
			Connection conn = null;
			try {
				conn = ds.getConnection();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			session = request.getSession();
			int userType = (Integer) session.getAttribute("userType");
			if (userType == Utils.SUPERVISOR) {
				List<AbuseReport> listOfSupervisorReport = AbuseReport
						.supervisorApprovalView(conn, Utils.SUBMITED);
				request.setAttribute("listOfSupervisorReport",
						listOfSupervisorReport);
				session.setAttribute("submittedreport",
						listOfSupervisorReport.size());
				List<AbuseReport> listOfApproveReport = AbuseReport
						.supervisorApprovalView(conn, Utils.APPROVED);
				request.setAttribute("listOfApproveReport", listOfApproveReport);
				request.getRequestDispatcher("/ApproveAbuseReportViewPage.jsp")
						.forward(request, response);
			}
		} else if (action.equals("approvalpage")) {
			Connection conn = null;
			try {
				conn = ds.getConnection();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			int reportId = Integer.parseInt(request.getParameter("reportId"));
			AbuseReport abuseReport = AbuseReport.approvalAbuseReport(conn,
					reportId);
			request.setAttribute("abuseReport", abuseReport);
			System.out.println("patient id: "
					+ abuseReport.getAllegedVictimPatientId());
			List<Relationship> listOfRelationship = Relationship
					.getRelationshipList(conn);
			request.setAttribute("listOfRelationship", listOfRelationship);
			List<Patient> listOfAllPatient = Patient.getAllPatient(conn);
			request.setAttribute("listOfAllPatient", listOfAllPatient);
			List<User> listStaffMembers = User.getStaffMembers(conn, 3);
			request.setAttribute("listStaffMembers", listStaffMembers);
			List<TypeOfService> listOfService = TypeOfService
					.getListOfService(conn);
			request.setAttribute("listOfService", listOfService);
			List<FrequencyOfAbuse> listOfFrequency = FrequencyOfAbuse
					.getFrequencyOfAbuse(conn);
			request.setAttribute("listOfFrequency", listOfFrequency);
			List<TypeOfAbuse> listOfAbuseType = TypeOfAbuse
					.getAbuseTypeList(conn);
			request.setAttribute("listOfAbuseType", listOfAbuseType);
			List<CommunicationNeed> listOfComNeed = CommunicationNeed
					.getListOfComNeed(conn);
			request.setAttribute("listOfComNeed", listOfComNeed);
			request.getRequestDispatcher("/ApproveAbuseReportApprovePage.jsp")
					.forward(request, response);

		} else if (action.equals("approveletter")) {
			int reportId = Integer.parseInt(request.getParameter("reportId"));
			int status = Integer.parseInt(request.getParameter("sta"));
			Connection conn = null;
			try {
				conn = ds.getConnection();
				AbuseReport abuseReport = new AbuseReport(conn);
				abuseReport.approveLetter(reportId, status);

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			List<AbuseReport> listOfAbuseReport = AbuseReport
					.userAbuseReportView(
							(Integer) session.getAttribute("userType"),
							(Integer) session.getAttribute("userId"), conn);
			session.setAttribute("userAbuseReportView", listOfAbuseReport);
			request.getRequestDispatcher(
					"/ApproveReport?action=approveabusereport").forward(request,
					response);
		} 
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
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
		if (action.equals("doapprovereport")) {
			int caseType;
			AbuseReport abuseReport;

			int id = Integer.parseInt(request.getParameter("reporterId"));
			User user = new User(id, conn);
			user.setUserInfo();
			String mandated = request.getParameter("mandated");
			String reporterRelationToVictim = request
					.getParameter("relationship");

			if (request.getParameter("radio1").equals("Patient")) {
				System.out.println("patient");
				caseType = 1;
				int allegedVictimPatientId = Integer.parseInt(request
						.getParameter("allegedVictimPatient"));
				// Patient victim = new Patient(allegedVictimPatientId,conn);
				// victim.setPatientInfo();
				abuseReport = new AbuseReport(id, allegedVictimPatientId, conn);
				abuseReport.setVictimPatientGuardian();
				Patient patient = new Patient(allegedVictimPatientId, conn);
				patient.setPatientInfo(1);
				abuseReport.setCurrentlyServedById(patient
						.getCurrentlyServedById());
				abuseReport.setCurrentlyServedByComment(CurrentlyServedBy
						.getCurrentlyServedBy(patient.getCurrentlyServedById(),
								conn));

			} else {
				System.out.println("staff");
				caseType = 3;
				int allegedVictimStaffId = Integer.parseInt(request
						.getParameter("allegedVictimStaff"));
				User victim = new User(allegedVictimStaffId, conn);
				victim.setUserInfo();
				abuseReport = new AbuseReport(id, conn);
				abuseReport.setAllegedVictimAddress(victim.getUserAddress());
				abuseReport.setAllegedVictimDatebirth(victim.getBirthday());
				abuseReport.setAllegedVictimMaritalStatusId(victim
						.getMaritalStatusId());
				abuseReport.setAllegedVictimStaffId(victim.getId());
				abuseReport.setAllegedVictimName(victim.getUserName() + " "
						+ victim.getUserLastName());
				abuseReport.setAllegedVictimTelephone(victim.getTelephone());
				abuseReport.setAllegedVictimSex(victim.getSex());

			}
			if (request.getParameter("radio2").equals("Staff")) {
				System.out.println("Abuser Staff");
				if (request.getParameter("radio1").equals("Staff")) {
					request.setAttribute("message",
							"Staff cannot be the victim and abuser at the same time");
					request.getRequestDispatcher(
							"/CreateAbuseReportCreatePage.jsp").forward(
							request, response);
				}

				int abuserStaffId = Integer.parseInt(request
						.getParameter("allegedAbuserStaff"));
				User abuser = new User(abuserStaffId, conn);
				abuser.setUserInfo();
				abuseReport.setAllegedAbuserStaffId(abuser.getId());
				abuseReport.setAllegedAbuserAddress(abuser.getUserAddress());
				abuseReport.setAllegedAbuserDatebirth(abuser.getBirthday());
				abuseReport.setAllegedAbuserName(abuser.getUserName() + " "
						+ abuser.getUserLastName());
				abuseReport.setAllegedAbuserSocialSecurity(abuser
						.getSocialSecurity());
				abuseReport.setAllegedAbuserTelephone(abuser.getTelephone());
			} else {
				int abuserPatientId = Integer.parseInt(request
						.getParameter("allegedAbuserPatient"));
				if (request.getParameter("radio1").equals("Patient")) {
					caseType = 2;
					abuseReport.setAbuserPatientGuardian2(abuserPatientId);
				} else {
					abuseReport.setAbuserPatientGuardian(abuserPatientId);
					Patient patient = new Patient(abuserPatientId, conn);
					patient.setPatientInfo(1);
					abuseReport.setCurrentlyServedById(patient
							.getCurrentlyServedById());
					abuseReport.setCurrentlyServedByComment(CurrentlyServedBy
							.getCurrentlyServedBy(
									patient.getCurrentlyServedById(), conn));

				}
			}

			abuseReport.setMandated(mandated);
			abuseReport
					.setReporterRelationshipToVictim(reporterRelationToVictim);
			String abuserRelationship = request.getParameter("relationship2");
			String collateralContacts = request
					.getParameter("collateralcontacts");
			String typeOfService = request.getParameter("typeofservice");
			String communicationNeeds = request
					.getParameter("communicationneeds");
			if (communicationNeeds.equals("Other")) {
				communicationNeeds = request.getParameter("textinputcomneed");
			}
			abuseReport.setAllegedAbuserRelationship(abuserRelationship);
			abuseReport.setCollateralContactsNotification(collateralContacts);
			abuseReport.setTypeOfServiceComment(typeOfService);
			abuseReport.setCommunicationNeed(communicationNeeds);

			// Abuse Information
			String frequencyOfAbuse = request.getParameter("frequencyofabuse");
			abuseReport.setFrequencyOfAbuse(frequencyOfAbuse);
			abuseReport.setIsVictimAware(request.getParameter("awareofreport"));
			String typeOfAbuse = request.getParameter("typesofabuse");
			if (typeOfAbuse == null) {
				// user should check at least one checkbox
			}
			if (typeOfAbuse.equals("Other")) {
				typeOfAbuse = request.getParameter("textinputabusetype");
			}
			abuseReport.setTypeOfAbuseReport(typeOfAbuse);
			abuseReport.setDescriptionAllegedReport(request
					.getParameter("descriptionallegedabuse"));
			abuseReport.setDescriptionLevelRisk(request
					.getParameter("descriptionlevelrisk"));
			abuseReport.setDescriptionResultingInjuries(request
					.getParameter("resultinginjuries"));
			abuseReport.setDescriptionWitnesses(request
					.getParameter("witnesses"));
			abuseReport.setDescriptionCaregiverRelationship(request
					.getParameter("caregiverrelationship"));

			String oralReport = request.getParameter("Hotline");
			if (oralReport.equals("Yes")) {
				abuseReport.setOralReportFilled(oralReport);
				abuseReport.setOralReportFilledComment(request
						.getParameter("oralreportcomment"));
			} else {
				abuseReport.setOralReportFilled(oralReport);
			}

			String riskToInvestigator = request.getParameter("Risk");
			if (riskToInvestigator.equals("Yes")) {
				abuseReport.setRiskToInvestigator(riskToInvestigator);
				abuseReport.setRiskToInvestigatorComment(request
						.getParameter("risktoinvestigatorcomment"));
			} else {
				abuseReport.setRiskToInvestigator(riskToInvestigator);
			}
			if (request.getParameter("approve") != null) {
				System.out.println("approve");
				abuseReport.setStatus(3);
				abuseReport.updateAbuseReport(caseType,
						Integer.parseInt(request.getParameter("reportId")));
				List<AbuseReport> listOfSupervisorReport = AbuseReport
						.supervisorApprovalView(conn, 2);
				request.setAttribute("listOfSupervisorReport",
						listOfSupervisorReport);
				session.setAttribute("submittedreport",
						listOfSupervisorReport.size());
				List<AbuseReport> listOfApproveReport = AbuseReport
						.supervisorApprovalView(conn, 3);
				request.setAttribute("listOfApproveReport", listOfApproveReport);
				List<AbuseReport> listOfAbuseReport = AbuseReport
						.userAbuseReportView(
								(Integer) session.getAttribute("userType"),
								(Integer) session.getAttribute("userId"), conn);
				session.setAttribute("userAbuseReportView", listOfAbuseReport);
				request.getRequestDispatcher("/ApproveAbuseReportViewPage.jsp")
						.forward(request, response);
			} else if (request.getParameter("save") != null) {
				System.out.println("save");
				abuseReport.setStatus(2);
				abuseReport.updateAbuseReport(caseType,
						Integer.parseInt(request.getParameter("reportId")));
				List<AbuseReport> listOfSupervisorReport = AbuseReport
						.supervisorApprovalView(conn, 2);
				request.setAttribute("listOfSupervisorReport",
						listOfSupervisorReport);
				session.setAttribute("submittedreport",
						listOfSupervisorReport.size());
				List<AbuseReport> listOfApproveReport = AbuseReport
						.supervisorApprovalView(conn, 3);
				request.setAttribute("listOfApproveReport", listOfApproveReport);
				List<AbuseReport> listOfAbuseReport = AbuseReport
						.userAbuseReportView(
								(Integer) session.getAttribute("userType"),
								(Integer) session.getAttribute("userId"), conn);
				session.setAttribute("userAbuseReportView", listOfAbuseReport);
				request.getRequestDispatcher("/ApproveAbuseReportViewPage.jsp")
						.forward(request, response);
			}
		} else {
			out.println("unrecognised action");
		}
	}

}

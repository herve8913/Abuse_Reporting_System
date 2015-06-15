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
		ds = Utils.getDataSource();
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
		} else if (action.equals("logout")) {
			request.setAttribute("message", "");
			request.getRequestDispatcher("/index.jsp").forward(request,
					response);

		} else if (action.equals("hrc")) {
			Connection conn = null;
			try {
				conn = ds.getConnection();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			List<AbuseReport> listOfApproveReport = AbuseReport
					.supervisorApprovalView(conn, 5);
			request.setAttribute("listOfApproveReport", listOfApproveReport);
			request.getRequestDispatcher("/HumanRightsComittee.jsp").forward(
					request, response);
		} else if (action.equals("viewabusereportpage")) {
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
			request.getRequestDispatcher("/CreateAbuseReportViewSingle.jsp")
					.forward(request, response);
		} else if (action.equals("track")) {
			Connection conn = null;
			try {
				conn = ds.getConnection();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			List<AbuseReport> listOfApproveReport = AbuseReport
					.supervisorApprovalView(conn, 3);
			request.setAttribute("listOfApproveReport", listOfApproveReport);
			request.getRequestDispatcher("/TrackReports.jsp").forward(request,
					response);
		} else {
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

		if (action.equals("dologin")) { // login action starts
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			// store email in session
			session = request.getSession();
			session.setAttribute("email", email);
			// set the email to request attribute, set password to empty
			request.setAttribute("email", email);
			request.setAttribute("password", "");

			User user = new User(email, password, conn);

			try {
				// scan the database to find the user matching the account info.
				List<String> list = user.login1();
				if (list.size() != 0) {
					request.setAttribute("email", email);
					session.setAttribute("userName", list.get(0));
					int userId = Integer.parseInt(list.get(5));
					session.setAttribute("userId", userId);
					int userType = Integer.parseInt(list.get(6));
					session.setAttribute("userType", userType);
					session.setAttribute("account", list.get(2));

					if (userType == Utils.HRC_USER) {
						// HRC
						System.out.println(userType + "hello");
						// get the abuse report for supervisor approving
						List<AbuseReport> listOfApproveReport = AbuseReport
								.supervisorApprovalView(conn,
										Utils.DECISION_LETTER);
						request.setAttribute("listOfApproveReport",
								listOfApproveReport);
						request.getRequestDispatcher("/HumanRightsComittee.jsp")
								.forward(request, response);

					} else if (userType == Utils.ADMIN) {
						List<User> listOfUsers = User.getStaffMembers(conn,
								Utils.ADMIN);
						request.setAttribute("listOfUsers", listOfUsers);
						request.getRequestDispatcher("/Users.jsp").forward(
								request, response);

					} else {
						// get all abuse report
						List<AbuseReport> listOfAbuseReport = AbuseReport
								.userAbuseReportView(userType, userId, conn);
						System.out.println(listOfAbuseReport.size());
						session.setAttribute("userAbuseReportView",
								listOfAbuseReport);
						// get the number of submitted report
						List<AbuseReport> listOfSupervisorReport = AbuseReport
								.supervisorApprovalView(conn, Utils.SUBMITED);
						session.setAttribute("submittedreport",
								listOfSupervisorReport.size());
						request.getRequestDispatcher(
								"/CreateAbuseReportViewPage.jsp").forward(
								request, response);
					}
				} else {
					// remain on the login page
					request.setAttribute("message",
							" The username or password is invalid. Please check them. ");
					request.getRequestDispatcher("/index.jsp").forward(request,
							response);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (action.equals("dosearch")) {
			// search drug info
			String drugName = request.getParameter("drugName");
			request.setAttribute("drugName", drugName);
			Drug drug = new Drug(drugName, conn);

			request.setAttribute("message", drug.getSearchResult());
			request.getRequestDispatcher("/pages/searchsuccess.jsp").forward(
					request, response);
		} else if (action.equals("dosendemail")) {
			// send email to get password
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
		} else if (action.equals("dodelete")) {
			// delete abuse report
			String logNumber = request.getParameter("lognumber");
			String src = request.getParameter("src");
			AbuseReport.deleteAbuseReport(logNumber, conn);
			if (src.equals("createviewpage")) {
				int userType = (Integer) session.getAttribute("userType");
				int userId = (Integer) session.getAttribute("userId");
				List<AbuseReport> listOfAbuseReport = AbuseReport
						.userAbuseReportView(userType, userId, conn);
				session.setAttribute("userAbuseReportView", listOfAbuseReport);
				request.getRequestDispatcher("/CreateAbuseReportViewPage.jsp")
						.forward(request, response);
			} else if (src.equals("approvepage")) {
				List<AbuseReport> listOfSupervisorReport = AbuseReport
						.supervisorApprovalView(conn, 2);
				request.setAttribute("listOfSupervisorReport",
						listOfSupervisorReport);
				session.setAttribute("submittedreport",
						listOfSupervisorReport.size());
				List<AbuseReport> listOfApproveReport = AbuseReport
						.supervisorApprovalView(conn, 3);
				request.setAttribute("listOfApproveReport", listOfApproveReport);
				request.getRequestDispatcher("/ApproveAbuseReportViewPage.jsp")
						.forward(request, response);
			}

		} else if (action.equals("upload")) {
			int id = (Integer) request.getAttribute("id");
			int typeOfLetter = (Integer) request.getAttribute("typeofletter");
			String fileName = (String) request.getAttribute("filename");
			System.out.println("controller upload");
			if (id != 0 && typeOfLetter != 0 && fileName != null) {
				AbuseReport abuseReport = new AbuseReport(conn);
				abuseReport.uploadFile(typeOfLetter, id, fileName);

			}
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
		} else if (action.equals("dochangepassword")) {
			// change password
			String oldPassword = request.getParameter("oldpassword");
			String newPassword = request.getParameter("newpassword");
			String newPassword2 = request.getParameter("newpassword2");
			if (!newPassword.equals(newPassword2)) {
				request.setAttribute("message",
						"The repeated new passwords doesn't match with each other.");
				request.getRequestDispatcher("ChangePassword.jsp").forward(
						request, response);
			} else {
				String login = (String) session.getAttribute("account");
				User user = new User(login, oldPassword, conn);
				try {
					List<String> list = user.login1();
					if (list.size() != 0) {
						user.changePassword(newPassword);
						request.setAttribute("message",
								"Please login again with your new password.");
						request.getRequestDispatcher("index.jsp").forward(
								request, response);
					} else {
						request.setAttribute("message",
								"The old password is not correct.");
						request.getRequestDispatcher("ChangePassword.jsp")
								.forward(request, response);
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

			}
		} else {
			out.println("unrecognised action");
		}

		try {
			conn.close();
		} catch (SQLException e) {
			throw new ServletException();
		}

	}

}

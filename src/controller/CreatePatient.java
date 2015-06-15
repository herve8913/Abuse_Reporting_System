package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.Servlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import bean.CurrentlyServedBy;
import bean.Ethnicity;
import bean.GroupHome;
import bean.MaritalStatus;
import bean.Patient;
import bean.User;

/**
 * Servlet implementation class CreatePatient
 */
@WebServlet(description = "the controller used to manipulate the patients accounts", urlPatterns = { "/CreatePatient" })
public class CreatePatient extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DataSource ds;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CreatePatient() {
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
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String action = request.getParameter("action");

		if (action == null) {
			request.setAttribute("message", "");
			request.getRequestDispatcher("/index.jsp").forward(request,
					response);

		} else if (action.equals("patient")) {

			Connection conn = null;
			try {
				conn = ds.getConnection();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			List<Patient> listOfPatient = Patient.getPatientPanelList(conn);
			request.setAttribute("listOfPatient", listOfPatient);
			request.getRequestDispatcher("/Patients.jsp").forward(request,
					response);
		} else if (action.equals("newpatient")) {
			Connection conn = null;
			try {
				conn = ds.getConnection();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			List<MaritalStatus> listOfMaritalStatus = MaritalStatus
					.getMaritalStatus(conn);
			request.setAttribute("listOfMaritalStatus", listOfMaritalStatus);
			List<GroupHome> listOfGroupHome = GroupHome.getGroupHomeList(conn);
			request.setAttribute("listOfGroupHome", listOfGroupHome);
			List<CurrentlyServedBy> listOfCurrentlyServed = CurrentlyServedBy
					.getServedList(conn);
			request.setAttribute("listOfCurrentlyServed", listOfCurrentlyServed);
			List<User> listOfClientGuardian = User.getStaffMembers(conn,
					Utils.STAFF);
			request.setAttribute("listOfClientGuardian", listOfClientGuardian);
			List<Ethnicity> listOfEthnicity = Ethnicity.getEthnicityList(conn);
			request.setAttribute("listOfEthnicity", listOfEthnicity);
			request.getRequestDispatcher("/CreatePatient.jsp").forward(request,
					response);

		} else if (action.equals("updatepatient")) {
			Connection conn = null;
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
			List<MaritalStatus> listOfMaritalStatus = MaritalStatus
					.getMaritalStatus(conn);
			request.setAttribute("listOfMaritalStatus", listOfMaritalStatus);
			List<GroupHome> listOfGroupHome = GroupHome.getGroupHomeList(conn);
			request.setAttribute("listOfGroupHome", listOfGroupHome);
			List<CurrentlyServedBy> listOfCurrentlyServed = CurrentlyServedBy
					.getServedList(conn);
			request.setAttribute("listOfCurrentlyServed", listOfCurrentlyServed);
			List<User> listOfClientGuardian = User.getStaffMembers(conn, 3);
			request.setAttribute("listOfClientGuardian", listOfClientGuardian);
			List<Ethnicity> listOfEthnicity = Ethnicity.getEthnicityList(conn);
			request.setAttribute("listOfEthnicity", listOfEthnicity);
			request.getRequestDispatcher("/UpdatePatient.jsp").forward(request,
					response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
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
		if (action.equals("docreatepatient")) {
			String patientName = request.getParameter("patientname");
			String patientMidname = request.getParameter("patientmidname");
			String patientLastName = request.getParameter("patientlastname");
			String sex = request.getParameter("sex");
			int iq = Integer.parseInt(request.getParameter("iq"));
			Date birthdate = Date.valueOf(request.getParameter("birthdate"));
			String telephone = request.getParameter("telephone");
			int maritalStatusId = Integer.parseInt(request
					.getParameter("maritalstatus"));
			int groupHomeId = Integer.parseInt(request
					.getParameter("grouphome"));
			int currentlyServedById = Integer.parseInt(request
					.getParameter("currentlyservedby"));
			int ethnicityId = Integer.parseInt(request
					.getParameter("ethnicity"));
			int clientGuardianId = Integer.parseInt(request
					.getParameter("clientguardian"));
			Patient patient = new Patient(patientName, patientMidname,
					patientLastName, sex, iq, birthdate, telephone,
					maritalStatusId, groupHomeId, currentlyServedById,
					ethnicityId, clientGuardianId, conn);
			patient.createPatient();
			List<Patient> listOfPatient = Patient.getPatientPanelList(conn);
			request.setAttribute("listOfPatient", listOfPatient);
			request.getRequestDispatcher("/Patients.jsp").forward(request,
					response);
		} else if (action.equals("dodeletepatient")) {
			String logNumber = request.getParameter("patientlognumber");
			Patient.deletePatient(conn, logNumber);
			List<Patient> listOfPatient = Patient.getPatientPanelList(conn);
			request.setAttribute("listOfPatient", listOfPatient);
			request.getRequestDispatcher("/Patients.jsp").forward(request,
					response);
		} else if (action.equals("doupdatepatient")) {
			String logNumber = request.getParameter("lognumber");
			String patientName = request.getParameter("patientname");
			String patientMidname = request.getParameter("patientmidname");
			String patientLastName = request.getParameter("patientlastname");
			String sex = request.getParameter("sex");
			int iq = Integer.parseInt(request.getParameter("iq"));
			Date birthdate = Date.valueOf(request.getParameter("birthdate"));
			String telephone = request.getParameter("telephone");
			int maritalStatusId = Integer.parseInt(request
					.getParameter("maritalstatus"));
			int groupHomeId = Integer.parseInt(request
					.getParameter("grouphome"));
			int currentlyServedById = Integer.parseInt(request
					.getParameter("currentlyservedby"));
			int ethnicityId = Integer.parseInt(request
					.getParameter("ethnicity"));
			int clientGuardianId = Integer.parseInt(request
					.getParameter("clientguardian"));
			Patient patient = new Patient(logNumber, patientName,
					patientMidname, patientLastName, sex, iq, birthdate,
					telephone, maritalStatusId, groupHomeId,
					currentlyServedById, ethnicityId, clientGuardianId, conn);
			patient.updatePatient();
			List<Patient> listOfPatient = Patient.getPatientPanelList(conn);
			request.setAttribute("listOfPatient", listOfPatient);
			request.getRequestDispatcher("/Patients.jsp").forward(request,
					response);
		} else {
			out.println("unrecognised action");
		}
	}

}

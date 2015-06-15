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

import bean.MaritalStatus;
import bean.User;

/**
 * Servlet implementation class CreateUser
 */
@WebServlet(description = "the controller used to manipulate the users accounts", urlPatterns = { "/CreateUser" })
public class CreateUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DataSource ds;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CreateUser() {
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
		String action = request.getParameter("action");

		if (action == null) {
			request.setAttribute("message", "");
			request.getRequestDispatcher("/index.jsp").forward(request,
					response);

		} else if (action.equals("user")) {
			Connection conn = null;
			try {
				conn = ds.getConnection();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			List<User> listOfUsers = User.getStaffMembers(conn, 1);
			request.setAttribute("listOfUsers", listOfUsers);
			request.getRequestDispatcher("/Users.jsp").forward(request,
					response);

		} else if (action.equals("newuser")) {
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
			request.getRequestDispatcher("/CreateUser.jsp").forward(request,
					response);
		} else if (action.equals("updateuser")) {
			Connection conn = null;
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
			List<MaritalStatus> listOfMaritalStatus = MaritalStatus
					.getMaritalStatus(conn);
			request.setAttribute("listOfMaritalStatus", listOfMaritalStatus);
			request.getRequestDispatcher("/UpdateUser.jsp").forward(request,
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
		if (action.equals("docreateuser")) { // create user action starts
			// get user info from the webpage
			String email = request.getParameter("username");
			String password = request.getParameter("password");
			String repeatpassword = request.getParameter("repeatpassword");
			String telephone = request.getParameter("telephone");
			String firstName = request.getParameter("firstname");
			String lastName = request.getParameter("lastname");
			String sex = request.getParameter("sex");
			int maritalStatus = Integer.parseInt(request
					.getParameter("maritalstatus"));
			String ssn = request.getParameter("ssn");
			System.out.println(request.getParameter("birthdate"));
			Date birthdate = Date.valueOf(request.getParameter("birthdate"));
			String address = request.getParameter("address");
			int userType = Integer.parseInt(request.getParameter("usertype"));

			request.setAttribute("username", email);
			request.setAttribute("telephone", telephone);
			request.setAttribute("firstname", firstName);
			request.setAttribute("lastname", lastName);
			request.setAttribute("sex", sex);
			request.setAttribute("maritalstatus", maritalStatus);
			request.setAttribute("ssn", ssn);
			request.setAttribute("birthdate", birthdate);
			request.setAttribute("address", address);
			request.setAttribute("usertype", userType);
			request.setAttribute("message", "");

			if (!password.equals(repeatpassword)) { // check if the two
													// passwords match
				request.setAttribute("message", "check your passowrd");
				List<MaritalStatus> listOfMaritalStatus = MaritalStatus
						.getMaritalStatus(conn);
				request.setAttribute("listOfMaritalStatus", listOfMaritalStatus);
				request.getRequestDispatcher("/CreateUser.jsp").forward(
						request, response);
			} else {
				User user = new User(email, password, conn);

				if (!user.validate()) {
					// Password or email address has wrong format.
					request.setAttribute("message", user.getMessage());
					List<MaritalStatus> listOfMaritalStatus = MaritalStatus
							.getMaritalStatus(conn);
					request.setAttribute("listOfMaritalStatus",
							listOfMaritalStatus);
					request.getRequestDispatcher("/CreateUser.jsp").forward(
							request, response);
				} else {
					try {
						if (user.exists()) {
							// This email address already exists in the user
							// database.
							request.setAttribute("message",
									"An account with this email address already exists");
							List<MaritalStatus> listOfMaritalStatus = MaritalStatus
									.getMaritalStatus(conn);
							request.setAttribute("listOfMaritalStatus",
									listOfMaritalStatus);
							request.getRequestDispatcher("/CreateUser.jsp")
									.forward(request, response);
						} else {
							// We create the account.
							user.setBirthday(birthdate);
							user.setMaritalStatusId(maritalStatus);
							user.setSex(sex);
							user.setTelephone(telephone);
							user.setUserAddress(address);
							user.setSocialSecurity(ssn);
							user.setUserName(firstName);
							user.setUserLastName(lastName);
							user.setUserType(userType);
							// run create() to add a new user account to
							// database
							user.create();
							List<User> listOfUsers = User.getStaffMembers(conn,
									1);
							request.setAttribute("listOfUsers", listOfUsers);
							request.getRequestDispatcher("/Users.jsp").forward(
									request, response);
						}
					} catch (SQLException e) {

						request.getRequestDispatcher("/pages/error.jsp")
								.forward(request, response);
					}
				}

			}
		} else if (action.equals("dodeleteuser")) {
			int id = Integer.parseInt(request.getParameter("userid"));
			User.delete(conn, id);
			List<User> listOfUsers = User.getStaffMembers(conn, 1);
			request.setAttribute("listOfUsers", listOfUsers);
			request.getRequestDispatcher("/Users.jsp").forward(request,
					response);
		} else if (action.equals("doupdateuser")) {
			String email = request.getParameter("username");
			String telephone = request.getParameter("telephone");
			String firstName = request.getParameter("firstname");
			String lastName = request.getParameter("lastname");
			String sex = request.getParameter("sex");
			int maritalStatus = Integer.parseInt(request
					.getParameter("maritalstatus"));
			String ssn = request.getParameter("ssn");
			Date birthdate = Date.valueOf(request.getParameter("birthdate"));
			String address = request.getParameter("address");
			int userType = Integer.parseInt(request.getParameter("usertype"));
			User user = new User(email, userType, firstName, lastName, ssn,
					telephone, birthdate, maritalStatus, address, sex, conn);
			user.update();
			List<User> listOfUsers = User.getStaffMembers(conn, 1);
			request.setAttribute("listOfUsers", listOfUsers);
			request.getRequestDispatcher("/Users.jsp").forward(request,
					response);
		} else {
			out.println("unrecognised action");
		}
	}

}

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
import javax.sql.DataSource;

import bean.GroupHome;
import bean.HealthCareOrg;

/**
 * Servlet implementation class CreateHomeGroup
 */
@WebServlet(description = "a controller used to manipulate the home groups", urlPatterns = { "/CreateHomeGroup" })
public class CreateHomeGroup extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private DataSource ds;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateHomeGroup() {
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
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String action = request.getParameter("action");

		if (action == null) {
			request.setAttribute("message", "");
			request.getRequestDispatcher("/index.jsp").forward(request,
					response);

		} else if (action.equals("homegroup")) {
			Connection conn = null;
			try {
				conn = ds.getConnection();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			List<GroupHome> listOfGroupHome = GroupHome.getGroupHomeList(conn);
			request.setAttribute("listOfGroupHome", listOfGroupHome);
			request.getRequestDispatcher("/HomeGroups.jsp").forward(request,
					response);
		} else if (action.equals("newgrouphome")) {
			Connection conn = null;
			try {
				conn = ds.getConnection();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			List<HealthCareOrg> listOfHealthCare = HealthCareOrg
					.getHealthList(conn);
			request.setAttribute("listOfHealthCare", listOfHealthCare);
			request.getRequestDispatcher("/CreateHomeGroup.jsp").forward(
					request, response);
		} else if (action.equals("updategrouphome")) {
			Connection conn = null;
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
			List<HealthCareOrg> listOfHealthCare = HealthCareOrg
					.getHealthList(conn);
			request.setAttribute("listOfHealthCare", listOfHealthCare);
			request.getRequestDispatcher("/UpdateGroupHome.jsp").forward(
					request, response);

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
		if (action.equals("docreatehomegroup")) {
			String name = request.getParameter("homegroupname");
			String address = request.getParameter("address");
			String description = request.getParameter("description");
			int healthCareOrgId = Integer.parseInt(request
					.getParameter("healthcareorg"));
			GroupHome groupHome = new GroupHome(name, address, description,
					healthCareOrgId, conn);
			groupHome.create();
			List<GroupHome> listOfGroupHome = GroupHome.getGroupHomeList(conn);
			request.setAttribute("listOfGroupHome", listOfGroupHome);
			request.getRequestDispatcher("/HomeGroups.jsp").forward(request,
					response);
		} else if (action.equals("dodeletegrouphome")) {
			int id = Integer.parseInt(request.getParameter("grouphomeid"));
			GroupHome.delete(conn, id);
			List<GroupHome> listOfGroupHome = GroupHome.getGroupHomeList(conn);
			request.setAttribute("listOfGroupHome", listOfGroupHome);
			request.getRequestDispatcher("/HomeGroups.jsp").forward(request,
					response);
		} else if (action.equals("doupdatehomegroup")) {
			String name = request.getParameter("homegroupname");
			String address = request.getParameter("address");
			int status = Integer.parseInt(request.getParameter("status"));
			String description = request.getParameter("description");
			int healthCareOrgId = Integer.parseInt(request
					.getParameter("healthcareorg"));
			int id = Integer.parseInt(request.getParameter("grouphomeid"));
			GroupHome groupHome = new GroupHome(id, status, name, description,
					address, healthCareOrgId, conn);
			groupHome.update();
			List<GroupHome> listOfGroupHome = GroupHome.getGroupHomeList(conn);
			request.setAttribute("listOfGroupHome", listOfGroupHome);
			request.getRequestDispatcher("/HomeGroups.jsp").forward(request,
					response);
		} else {
			out.println("unrecognised action");
		}
	}

}

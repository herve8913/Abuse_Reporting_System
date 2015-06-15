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

import bean.Disability;
import bean.DisabilityType;

/**
 * Servlet implementation class CreateDisability
 */
@WebServlet(description = "a controller used to manipulate disability", urlPatterns = { "/CreateDisability" })
public class CreateDisability extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private DataSource ds;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateDisability() {
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

		} else if (action.equals("disability")) {
			Connection conn = null;
			try {
				conn = ds.getConnection();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			List<Disability> listOfDisability = Disability
					.getAllDisability(conn);
			request.setAttribute("listOfDisability", listOfDisability);
			request.getRequestDispatcher("/Disabilities.jsp").forward(request,
					response);
		} else if (action.equals("newdisability")) {
			Connection conn = null;
			try {
				conn = ds.getConnection();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			List<DisabilityType> listOfDisabilityType = DisabilityType
					.getDisabilityType(conn);
			request.setAttribute("listOfDisabilityType", listOfDisabilityType);
			request.getRequestDispatcher("/CreateDisability.jsp").forward(
					request, response);
		} else if (action.equals("updatedisability")) {
			Connection conn = null;
			try {
				conn = ds.getConnection();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			int disabilityId = Integer.parseInt(request
					.getParameter("disabilityId"));
			Disability disability = new Disability(disabilityId, conn);
			disability.search();
			request.setAttribute("disability", disability);
			List<DisabilityType> listOfDisabilityType = DisabilityType
					.getDisabilityType(conn);
			request.setAttribute("listOfDisabilityType", listOfDisabilityType);
			request.getRequestDispatcher("/UpdateDisability.jsp").forward(
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
		if (action.equals("docreatedisability")) {
			String name = request.getParameter("disabilityname");
			int typeId = Integer.parseInt(request
					.getParameter("disabilitytype"));
			String description = request.getParameter("description");
			Disability disability = new Disability(name, typeId, description,
					conn);
			disability.createDisability();
			List<Disability> listOfDisability = Disability
					.getAllDisability(conn);
			request.setAttribute("listOfDisability", listOfDisability);
			request.getRequestDispatcher("/Disabilities.jsp").forward(request,
					response);
		} else if (action.equals("dodeletedisability")) {
			int disabilityId = Integer.parseInt(request
					.getParameter("disabilityid"));
			Disability.deleteDisability(conn, disabilityId);
			List<Disability> listOfDisability = Disability
					.getAllDisability(conn);
			request.setAttribute("listOfDisability", listOfDisability);
			request.getRequestDispatcher("/Disabilities.jsp").forward(request,
					response);
		} else if (action.equals("doupdatedisability")) {
			String name = request.getParameter("disabilityname");
			int typeId = Integer.parseInt(request
					.getParameter("disabilitytype"));
			String description = request.getParameter("description");
			int id = Integer.parseInt(request.getParameter("disabilityid"));
			Disability disability = new Disability(id, name, typeId,
					description, conn);
			disability.updateDisability();
			List<Disability> listOfDisability = Disability
					.getAllDisability(conn);
			request.setAttribute("listOfDisability", listOfDisability);
			request.getRequestDispatcher("/Disabilities.jsp").forward(request,
					response);
		} else {
			out.println("unrecognised action");
		}
	}

}

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

import bean.Drug;

/**
 * Servlet implementation class CreateDrug
 */
@WebServlet(description = "a controller used to manipulate drugs info", urlPatterns = { "/CreateDrug" })
public class CreateDrug extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private DataSource ds;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateDrug() {
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

		} else if (action.equals("drug")) {
			Connection conn = null;
			try {
				conn = ds.getConnection();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			List<Drug> listOfDrugs = Drug.getAllDrugs(conn);
			request.setAttribute("listOfDrugs", listOfDrugs);
			request.getRequestDispatcher("/Drugs.jsp").forward(request,
					response);
		} else if (action.equals("newdrug")) {
			Connection conn = null;
			try {
				conn = ds.getConnection();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.getRequestDispatcher("/CreateDrug.jsp").forward(request,
					response);
		} else if (action.equals("updatedrug")) {
			Connection conn = null;
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
			request.getRequestDispatcher("/UpdateDrug.jsp").forward(request,
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
		if (action.equals("docreatedrug")) {
			// create drug action starts
			String drugName = request.getParameter("drugname");
			String descriptionText = request.getParameter("description");

			Drug drug = new Drug(drugName, descriptionText, conn);

			if (drug.exist()) {
				// already exist
				request.setAttribute("message",
						"This drug has already been registered");
				request.getRequestDispatcher("/CreateDrug.jsp").forward(
						request, response);
			} else {
				// register the drug
				drug.register();
				List<Drug> listOfDrugs = Drug.getAllDrugs(conn);
				request.setAttribute("listOfDrugs", listOfDrugs);
				request.getRequestDispatcher("/Drugs.jsp").forward(request,
						response);
			}

		} else if (action.equals("dodeletedrug")) {
			// delete drug action starts
			int id = Integer.parseInt(request.getParameter("drugid"));
			Drug.deleter(conn, id);
			List<Drug> listOfDrugs = Drug.getAllDrugs(conn);
			request.setAttribute("listOfDrugs", listOfDrugs);
			request.getRequestDispatcher("/Drugs.jsp").forward(request,
					response);

		} else if (action.equals("doupdatedrug")) {
			// update drug info
			String drugName = request.getParameter("drugname");
			String descriptionText = request.getParameter("description");
			request.setAttribute("drugname", drugName);
			request.setAttribute("description", descriptionText);

			Drug drug = new Drug(drugName, descriptionText, conn);

			drug.update();
			List<Drug> listOfDrugs = Drug.getAllDrugs(conn);
			request.setAttribute("listOfDrugs", listOfDrugs);
			request.getRequestDispatcher("/Drugs.jsp").forward(request,
					response);

		} else {
			out.println("unrecognised action");
		}
	}

}

package controller;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.sql.DataSource;

public class Utils {
	
	//user type
	public static final int ADMIN = 1;
	public static final int SUPERVISOR = 2;
	public static final int STAFF = 3;
	public static final int HRC_USER = 4;
	
	//abuse report status
	public static final int UNSUBMITED = 1;
	public static final int SUBMITED = 2;
	public static final int APPROVED = 3;
	public static final int DISPOSITION_LETTER = 4;
	public static final int DECISION_LETTER = 5;
	public static final int APPEAL_LETTER = 6;
	
	//data source
	private static DataSource ds = null;
	
	
	public static DataSource getDataSource(){
		if (ds == null){
			try {
				InitialContext initContext = new InitialContext();

				ds = (DataSource) initContext
						.lookup("java:/comp/env/jdbc/abusereport");

				System.out.println("datasource");
			} catch (NamingException e) {
				System.out.println("ds");
			}
			if (ds == null) {
				System.out.println("dsnull");
			}
		}
		return ds;
	}
}

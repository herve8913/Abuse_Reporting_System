package uploadFile;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import bean.AbuseReport;

/**
 * Servlet to handle File upload request from Client
 * 
 */
@WebServlet("/upload")
public class FileUploadHandler extends HttpServlet {
    private final String UPLOAD_DIRECTORY = "D:/workspace/Workplace2/DatabaseTest/WebContent/AbuseReportFiles";
    
    @Override
	public void init(ServletConfig config) throws ServletException {
    	
	}



	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
		 int id=0;
		 int typeOfLetter=0;
		 String fileName=null;
		 
        //process only if its multipart content
        if(ServletFileUpload.isMultipartContent(request)){
        	
            try {
            	String name=null;
                List<FileItem> multiparts = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
              
                for(FileItem item : multiparts){
                    if(!item.isFormField()){
                        name = new File(item.getName()).getName();
                        item.write( new File(UPLOAD_DIRECTORY + File.separator + name));
                        fileName=item.getName();
                    }else {
                    	String fieldName= item.getFieldName();
                    	if(fieldName.equals("reportId")){
                    	id = Integer.parseInt(item.getString());
                    	}else if(fieldName.equals("typeofletter")){
                    		typeOfLetter = Integer.parseInt(item.getString());
                    	}
                    	
                    	System.out.println("reportid: "+id+" "+"typeletter: "+ typeOfLetter);
                    }
                }
           
               //File uploaded successfully
                System.out.println("id: "+id +"typeofletter: "+typeOfLetter+"filename: "+fileName);
                request.setAttribute("id", id);
                request.setAttribute("typeofletter", typeOfLetter);
                request.setAttribute("filename", fileName);
                request.getRequestDispatcher("/Controller?action=upload").forward(request, response);
             
                
            } catch (Exception ex) {
            	ex.printStackTrace();
            }          
         
        }
    }
  
}



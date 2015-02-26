<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="author" content="CS509 Group1">
    <meta name="keywords" content="Abuse,Report,DDS">
    <title>Abuse Report System</title>
    <link rel="shortcut icon" href="img/icon.ico">
    <!-- Bootstrap CSS-->
    <link rel="stylesheet" href="css/bootstrap.css">
  </head>
  <body>
  <!------------------------------------------- Navigation Bar -------------------------------------------------------------->
		<div class="navbar navbar-default navbar-fixed-top" role="navigation">
      <div class="container">
      	<div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="<%= response.encodeUrl(request.getContextPath() + "/Controller?action=hrc") %>">Abuse Report System for HRC</a>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
        	<li class="dropdown">
          	  <a href="#" class="dropdown-toggle" data-toggle="dropdown" ><span class="glyphicon glyphicon-user"></span>Hi, <%=session.getAttribute("userName")%><b class="caret"></b></a>
          	  <ul class="dropdown-menu">
                <li><a href="ChangePasswordHRC.jsp">Change Password</a></li>
                <li><a href="index.jsp">Log Out</a></li>
              </ul>
            </li>
          </ul>
          <ul class="nav navbar-nav">
                <li><a href="<%= response.encodeUrl(request.getContextPath() + "/Controller?action=hrc") %>">View Abuse Reports &nbsp;</a></li>
            <li class="active"><a href="DocumentsHRC.jsp">Documents</a></li>
            <li><a href="HelpHRC.jsp">Help</a></li>
          
          </ul>
         
        </div><!--/.nav-collapse -->
      </div>
    </div>  
  <!------------------------------------------- Nevigation Bar End-------------------------------------------------------------->
    <div class="container" style="padding-top:80px">
<div class="container">
    <div class="row">
        <div class="col-xs-12" style="padding:0px">
            <h3 class="text-left">
                Documents
            </h3> 
           <h4>Reporting Forms</h4>
          <hr />
          <a class="titlelink" href="http://www.mass.gov/dppc/docs/form-19c-reporting.pdf">Abuse Reporting Form (PDF)</a>
          <a class="doc_link" href="http://www.mass.gov/dppc/docs/form-19c-reporting.pdf">
          <img src="img/icon_doc_pdf.png" /></a>  
        </div>
     </div>
    </div>
    </div> 
    <script src="js/jquery-1.11.0.js"></script>
    <script src="js/bootstrap.js"></script>
  </body>
</html>
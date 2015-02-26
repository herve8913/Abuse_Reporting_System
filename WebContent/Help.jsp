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
	<%int userType = (Integer)session.getAttribute("userType"); %>
	<div class="navbar navbar-default navbar-fixed-top" role="navigation">
      <div class="container">
      	<div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <%if(userType==1){ %>
          <a class="navbar-brand" href="<%=response.encodeURL(request.getContextPath()+"/Controller?action=user") %>">Abuse Report System</a><%}else{ %>
          <a class="navbar-brand" href="CreateAbuseReportViewPage.jsp">Abuse Report System</a><%} %>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
        	<li class="dropdown">
          	  <a href="#" class="dropdown-toggle" data-toggle="dropdown" ><span class="glyphicon glyphicon-user"></span>Hi, <%= session.getAttribute("userName") %><b class="caret"></b></a>
          	  <ul class="dropdown-menu">
                <li><a href="ChangePassword.jsp">Change Password</a></li>
                <li><a href="<%=response.encodeURL(request.getContextPath()+"/Controller?action=logout") %>">Log Out</a></li>
              </ul>
            </li>
          </ul>
          <ul class="nav navbar-nav">
          <%if(userType==2) {%>
            <li class="dropdown">
            	<a href="#" class="dropdown-toggle" data-toggle="dropdown">Report Abuse &nbsp;<span class="badge"><%=session.getAttribute("submittedreport") %></span><b class="caret"></b></a>
            <ul class="dropdown-menu">
                <li><a href="CreateAbuseReportViewPage.jsp">Create Abuse Report</a></li>
                <li ><a href="<%= response.encodeUrl(request.getContextPath() + "/Controller?action=approveabusereport") %>">Approve Abuse Reports &nbsp;<span class="badge"><%=session.getAttribute("submittedreport") %></span></a></li>
              </ul><%}else if (userType==3){ %>
              <li><a href="CreateAbuseReportViewPage.jsp">Create Abuse Report</a></li><%} %>
              <%if(userType==2){ %>
            <li><a href="<%= response.encodeUrl(request.getContextPath() + "/Controller?action=track") %>">Track Reports</a></li><%} %>
            <li><a href="Documents.jsp">Documents</a></li>
            <li class="active"><a href="Help.jsp">Help</a></li>
            <%if(userType==1){%>
            <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Admin Panel<b class="caret"></b></a>
            <ul class="dropdown-menu">
                <li ><a href="<%= response.encodeUrl(request.getContextPath() + "/Controller?action=user") %>">Users</a></li>
                <li ><a href="<%= response.encodeUrl(request.getContextPath() + "/Controller?action=patient") %>">Patients</a></li>
                <li ><a href="<%= response.encodeUrl(request.getContextPath() + "/Controller?action=homegroup") %>">Home Groups</a></li>
                <li ><a href="<%= response.encodeUrl(request.getContextPath() + "/Controller?action=disability") %>">Disabilities</a></li>
                <li ><a href="<%= response.encodeUrl(request.getContextPath() + "/Controller?action=drug") %>">Drugs</a></li>
              </ul>
            </li><%} %>
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
                Help
            </h3> 
          <h4>If you would like to make a report of abuse or neglect, please call DPPC's Hotline: 1-800-426-9009 V/TTY</h4>
          <hr />
          <p><b>For all Other Inquiries, Please Contact</b></p>
          <p>The Disabled Persons Protection Commission (DPPC)
          <br clear="none" />300 Granite Street, Suite 404<br clear="none" />
          Braintree, MA 02184<br clear="none" />
          Phone: 617-727-6465<br clear="none" />
          888-822-0350 V/TTY<br clear="none" />
          Fax: 617-727-6469</p>
          <p>The Disabled Persons Protection Commission (DPPC) welcomes questions, comments and suggestions. To safeguard your privacy, please do not include confidential information such as your Social Security number(s) in the email. If you choose to disregard this warning, please be aware that the Massachusetts Disabled Persons Protection Commission is not responsible if confidential information which you sent to this email address is accessed by third parties.</p><p>To submit general questions, comments and suggestions, please complete the following form.</p>
          <table bgcolor="#FF8F3B" border="0" cellpadding="5" cellspacing="0" width="100%">
          <tbody><tr><td colspan="1" rowspan="1">
          <table border="0" cellpadding="5" cellspacing="0" summary="table with info on how to file an abuse or neglect report" width="100%"><thead>
          <tr><th align="center" bgcolor="#E6E6F3" colspan="1" id="tbl328id0_0" rowspan="1" scope="col">
          <strong>Do Not Fill Out This Form if You Want to Report Abuse or Neglect!</strong>
          </th></tr></thead><tbody><tr></tr></tbody></table></td></tr></tbody></table><hr />
          <p>We appreciate your comments, suggestions and questions. If you are looking for more information about a specific topic, have a suggestion on on how to improve this site, or if you have a question we can help with, please complete the form below. DPPC staff will respond to you in a timely manner.</p>
          <script src="http://www.mass.gov/eohhs/scripts/hhs-feedback.js" type="text/javascript">/**//**//**//**//**//**/</script> 
          <form action="http://www.mass.gov/cgi-bin/massgovmail.cgi" enctype="application/x-www-form-urlencoded" method="post" onsubmit="return formValidator()">
          <input name="file" type="hidden" value="/dppc/forms/dppc-feedback.txt" />
          <input name="success" type="hidden" value="http://mass.gov/dppc/utility/feedback-successful.html" /> 
          <table border="1" bordercolor="#BDC7DE" cellpadding="2" cellspacing="0" summary="layout table" width="98%">
          <tbody><tr><td colspan="1" rowspan="1"><table bgcolor="#EFEFEF" border="0" width="100%"><tbody><tr></br></tr><tr valign="top">
          <th align="right" colspan="1" rowspan="1" width="20%"><label for="name" style="padding-left:10px;">Name</label>:</th><td colspan="1" rowspan="1" width="80%">
          <input id="name" name="name" style="margin-bottom:5px;" size="35" title="Enter your name." type="text" /></td></tr><tr valign="top">
          <th align="right" colspan="1" rowspan="1" width="20%"><label for="email" style="padding-left:10px;">Email</label>:</th><td colspan="1" rowspan="1" width="80%">
          <input id="email" name="email" style="margin-bottom:5px;" size="35" title="Enter your email address." type="text" />
          </td></tr><tr valign="top"><th align="right" colspan="1" rowspan="1"><label for="phone" style="padding-left:10px;">Telephone</label>:</th>
          <td colspan="1" rowspan="1"><input id="phone" name="phone" style="margin-bottom:5px;" size="35" title="Enter your phone number." type="text" /></td>
          </tr><tr valign="top"><th align="right" colspan="1" rowspan="1" width="20%"><label for="subject" style="padding-left:10px;">Subject</label>:</th>
          <td colspan="1" rowspan="1" width="80%"><input id="subject" name="subject" style="margin-bottom:5px;" size="35" title="Enter the subject." type="text" /></td>
          </tr><tr valign="top"><th align="right" colspan="1" rowspan="1" width="20%"><label for="comments" style="padding-left:10px;">Comments</label>:</th>
          <td colspan="1" rowspan="1" width="80%"><textarea cols="50" id="comments" name="comments" style="margin-bottom:5px;" rows="6" title="Enter your comments."></textarea> 
          <br clear="none" /><label for="verificiationtext">*To help us filter spam, please type the <strong>four digit current year</strong>:</label>
          <br clear="none" /> <input id="verificationtext" maxlength="4" name="required-verificationtext" type="text" />
          <br clear="none" /><br clear="none" /> <input name="Submit" type="submit" class="btn btn-success" style="margin-bottom:8px;" value="Send" />
          <input name="reset" type="reset" class="btn btn-default" style="margin-bottom:8px;" value="Clear" /></td></tr></tbody></table></td></tr></tbody></table></form>
          </br>
          </div>
          </div>
        </div>
      </div>

    <script src="js/jquery-1.11.0.js"></script>
    <script src="js/bootstrap.js"></script>
  </body>
</html>
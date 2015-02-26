<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
            <li class="dropdown active">
            	<a href="#" class="dropdown-toggle" data-toggle="dropdown">Report Abuse &nbsp;<span class="badge"><%=session.getAttribute("submittedreport") %></span><b class="caret"></b></a>
            <ul class="dropdown-menu">
                <li><a href="CreateAbuseReportViewPage.jsp">Create Abuse Report</a></li>
                <li ><a href="<%= response.encodeUrl(request.getContextPath() + "/Controller?action=approveabusereport") %>">Approve Abuse Reports &nbsp;<span class="badge"><%=session.getAttribute("submittedreport") %></span></a></li>
              </ul><%}else if (userType==3){ %>
              <li><a href="CreateAbuseReportViewPage.jsp">Create Abuse Report</a></li><%} %>
              <%if(userType==2){ %>
            <li><a href="<%= response.encodeUrl(request.getContextPath() + "/Controller?action=track") %>">Track Reports</a></li><%} %>
            <li><a href="Documents.jsp">Documents</a></li>
            <li><a href="Help.jsp">Help</a></li>
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
    <%@page import="java.util.List,bean.*" %>
    <%List<MaritalStatus> listOfMaritalStatus = (List<MaritalStatus>) request.getAttribute("listOfMaritalStatus"); %>
    <%User user = (User) request.getAttribute("user"); %>
    <div class="container" style="padding-top:80px">
<div class="container">
    <div class="row">
        <div class="col-xs-6" style="padding:0px">
            <h3 class="text-left">
                Users
            </h3> 
        </div>
        
      </div>
      <div class="row">
      	  <form  name="frmForm" class="form-horizontal" method="post" action="<%= response.encodeUrl(request.getContextPath() + "/Controller?action=doupdateuser") %>">
			<fieldset>
			<input type="hidden" name="username" value="<%=user.getEmail() %>" />
			<legend>New User   <font color="red"> <c:out value="${message}" /></font></legend> 
      					<!-- Text input-->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="username">User Name</label>  
				  <div class="col-md-4">
				  <p><%=user.getEmail() %></p>
				  </div>
				</div>
				
				<!-- Text input-->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="firstname">First Name</label>  
				  <div class="col-md-4">
				  <input id="firstname" name="firstname" type="text" placeholder="firstname" value="<%=user.getUserName() %>" class="form-control input-md" required>
				  </div>
				</div>
				
				<!-- Text input-->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="lastname">Last Name</label>  
				  <div class="col-md-4">
				  <input id="lastname" name="lastname" type="text" placeholder="lastname" value="<%=user.getUserLastName() %>" class="form-control input-md" required>
				  </div>
				</div>
				
				<!-- Multiple Radios (inline) -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="radios">User Type</label>
				  <div class="col-md-4"> 
				    <label class="radio-inline" for="radios-0">
				      <input type="radio" name="usertype" id="radios-0" value="2" <c:if test="${user.userType==2}">checked</c:if> required>
				      Supervisor
				    </label> 
				    <label class="radio-inline" for="radios-1">
				      <input type="radio" name="usertype" id="radios-1" value="3" <c:if test="${user.userType==3}">checked</c:if> >
				      Staff
				    </label>
				    <label class="radio-inline" for="radios-2">
				      <input type="radio" name="usertype" id="radios-2" value="4" <c:if test="${user.userType==4}">checked</c:if> >
				      Human Rights Committee
				    </label>
				  </div>
				</div>
				
				<!-- Multiple Radios (inline) -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="radios">Sex</label>
				  <div class="col-md-4"> 
				    <label class="radio-inline" for="radios0">
				      <input type="radio" name="sex" id="radios0" value="M"  <c:if test='${user.sex=="M"}'>checked</c:if> required>
				      Male
				    </label> 
				    <label class="radio-inline" for="radios1">
				      <input type="radio" name="sex" id="radios1" value="F" <c:if test='${user.sex=="F"}'>checked</c:if> >
				      Female
				    </label>
				  </div>
				</div>
				
				<!-- Select Basic -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="maritalstatus">Marital Status</label>
				  <div class="col-md-4">
				    <select id="maritalstatus" name="maritalstatus" class="form-control">
				      <%for(MaritalStatus maritalStatus : listOfMaritalStatus) {%><option value="<%=maritalStatus.getId()%>" <%if(maritalStatus.getId()==user.getMaritalStatusId()){ %>selected<%} %> ><%=maritalStatus.getMasterDataName() %></option><%} %>
				    </select>
				  </div>
				</div>
				
				
				<!-- Text input-->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="ssn">Social Security Number</label>  
				  <div class="col-md-4">
				  <input id="ssn" name="ssn" type="text" placeholder="ssn" value="<%=user.getSocialSecurity() %>" class="form-control input-md">
				  </div>
				</div>
				
				<!-- Text input-->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="telephone">Telephone</label>  
				  <div class="col-md-4">
				  <input id="telephone" name="telephone" type="text" placeholder="telephone" value="<%=user.getTelephone() %>" class="form-control input-md">
				  </div>
				</div>
				
				<!-- Text input-->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="birthdate">DOB</label>  
				  <div class="col-md-4">
				  <input id="birthdate" name="birthdate" type="text" placeholder="yyyy-mm-dd" value="<%=user.getBirthday() %>" class="form-control input-md">
				  </div>
				</div>
				
				<!-- Textarea -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="address">Address</label>
				  <div class="col-md-4">                     
				    <textarea class="form-control" id="address" name="address"><%=user.getUserAddress() %></textarea>
				  </div>
				</div>
				<!-- Button (Double) -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="save"></label>
				  <div class="col-md-8">
				<a href="<%= response.encodeUrl(request.getContextPath() + "/Controller?action=user") %>" id="cancel" name="cancel" class="btn btn-default">Cancel</a>
				<input type="submit" value="Update" class="btn btn-success"></input>
				</div>
				</div>
				</fieldset>
				</form>
    </div>
    </div> 
    <script src="js/jquery-1.11.0.js"></script>
    <script src="js/bootstrap.js"></script>
  </body>
</html>
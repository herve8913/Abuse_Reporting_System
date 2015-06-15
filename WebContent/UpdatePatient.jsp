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
          <a class="navbar-brand" href="<%=response.encodeURL(request.getContextPath()+"/CreateUser?action=user") %>">Abuse Report System</a><%}else{ %>
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
                <li ><a href="<%= response.encodeUrl(request.getContextPath() + "/ApproveReport?action=approveabusereport") %>">Approve Abuse Reports &nbsp;<span class="badge"><%=session.getAttribute("submittedreport") %></span></a></li>
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
                <li ><a href="<%= response.encodeUrl(request.getContextPath() + "/CreateUser?action=user") %>">Users</a></li>
                <li class="active"><a href="<%= response.encodeUrl(request.getContextPath() + "/CreatePatient?action=patient") %>">Patients</a></li>
                <li ><a href="<%= response.encodeUrl(request.getContextPath() + "/CreateHomeGroup?action=homegroup") %>">Home Groups</a></li>
                <li ><a href="<%= response.encodeUrl(request.getContextPath() + "/CreateDisability?action=disability") %>">Disabilities</a></li>
                <li ><a href="<%= response.encodeUrl(request.getContextPath() + "/CreateDrug?action=drug") %>">Drugs</a></li>
              </ul>
            </li><%} %>
          </ul>

        </div><!--/.nav-collapse -->
      </div>
    </div>  
  <!------------------------------------------- Nevigation Bar End-------------------------------------------------------------->
    <%@page import="java.util.List,bean.*" %>
    <%List<MaritalStatus> listOfMaritalStatus = (List<MaritalStatus>) request.getAttribute("listOfMaritalStatus"); %>
    <%List<GroupHome> listOfGroupHome = (List<GroupHome>) request.getAttribute("listOfGroupHome"); %>
    <%List<CurrentlyServedBy> listOfCurrentlyServed = (List<CurrentlyServedBy>) request.getAttribute("listOfCurrentlyServed"); %>
    <%List<User> listOfClientGuardian = (List<User>)request.getAttribute("listOfClientGuardian"); %>
    <%List<Ethnicity> listOfEthnicity = (List<Ethnicity>) request.getAttribute("listOfEthnicity"); %>
    <%Patient patient = (Patient)request.getAttribute("patient"); %>
    <div class="container" style="padding-top:80px">
<div class="container">
    <div class="row">
        <div class="col-xs-6" style="padding:0px">
            <h3 class="text-left">
                Patient
            </h3> 
        </div>
        
      </div>
      <div class="row">
      	  <form  name="frmForm" class="form-horizontal" method="post" action="<%= response.encodeUrl(request.getContextPath() + "/CreatePatient?action=doupdatepatient") %>">
			<fieldset>
			<input type="hidden" name="lognumber" value="<%=patient.getLogNumber() %>" >
			<legend>New Patient   <font color="red"> <c:out value="${message}" /></font></legend> 
      					<!-- Text input-->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="patientname">Patient Name</label>  
				  <div class="col-md-4">
				  <input id="patientname" name="patientname" type="text" placeholder="patient name" value="<%=patient.getPatientName() %>" class="form-control input-md" required>
				  </div>
				</div>
				
				<!-- Text input-->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="patientmidname">Patient Mid Name</label>  
				  <div class="col-md-4">
				  <input id="patientmidname" name="patientmidname" type="text" placeholder="patient mid name" value="<%=patient.getPatientMidname() %>" class="form-control input-md" required>
				  </div>
				</div>
				
				<!-- Text input-->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="patientlastname">Patient Last Name</label>  
				  <div class="col-md-4">
				  <input id="patientlastname" name="patientlastname" type="text" placeholder="patient last name" value="<%=patient.getPatientLastName() %>" class="form-control input-md" required>
				  </div>
				</div>
				
				<!-- Multiple Radios (inline) -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="radios">Sex</label>
				  <div class="col-md-4"> 
				    <label class="radio-inline" for="radios0">
				      <input type="radio" name="sex" id="radios0" value="M" <%if(patient.getSex().equals("M")){%>checked<%} %> required>
				      Male
				    </label> 
				    <label class="radio-inline" for="radios1">
				      <input type="radio" name="sex" id="radios1" value="F" <%if(patient.getSex().equals("F")){%>checked<%} %>>
				      Female
				    </label>
				  </div>
				</div>
				
				<!-- Text input-->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="iq">Patient IQ</label>  
				  <div class="col-md-4">
				  <input id="iq" name="iq" type="text" placeholder="IQ" value="<%=patient.getIq() %>" class="form-control input-md" required>
				  </div>
				</div>
				
				<!-- Text input-->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="birthdate">Patient Birthdate</label>  
				  <div class="col-md-4">
				  <input id="birthdate" name="birthdate" type="text" placeholder="birthdate" value="<%=patient.getBirthdate() %>" class="form-control input-md" required>
				  </div>
				</div>
				
				<!-- Text input-->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="telephone">Patient Telephone</label>  
				  <div class="col-md-4">
				  <input id="telephone" name="telephone" type="text" placeholder="telephone" value="<%=patient.getTelephone() %>" class="form-control input-md" required>
				  </div>
				</div>
				
				<!-- Select Basic -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="maritalstatus">Marital Status</label>
				  <div class="col-md-4">
				    <select id="maritalstatus" name="maritalstatus" class="form-control">
				      <%for(MaritalStatus maritalStatus : listOfMaritalStatus) {%><option value="<%=maritalStatus.getId()%>" <%if(maritalStatus.getId()==patient.getMaritalStatusId()){ %>selected<%} %> ><%=maritalStatus.getMasterDataName() %></option><%} %>
				    </select>
				  </div>
				</div>
				
				<!-- Select Basic -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="grouphome">Group Home</label>
				  <div class="col-md-4">
				    <select id="grouphome" name="grouphome" class="form-control">
				      <%for(GroupHome groupHome: listOfGroupHome) {%><option value="<%=groupHome.getId()%>" <%if(groupHome.getId()==patient.getGroupHomeId()){%>selected<%}%> ><%=groupHome.getMasterDataName() %></option><%} %>
				    </select>
				  </div>
				</div>
				
				<!-- Select Basic -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="currentlyservedby">Currently Served By</label>
				  <div class="col-md-4">
				    <select id="currentlyservedby" name="currentlyservedby" class="form-control">
				      <%for(CurrentlyServedBy currentlyServedBy: listOfCurrentlyServed) {%><option value="<%=currentlyServedBy.getId()%>" <%if(currentlyServedBy.getId()==patient.getCurrentlyServedById()) {%>selected<%} %> ><%=currentlyServedBy.getMasterDataName()%></option><%} %>
				    </select>
				  </div>
				</div>
				
				<!-- Select Basic -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="ethnicity">Ethnicity</label>
				  <div class="col-md-4">
				    <select id="ethnicity" name="ethnicity" class="form-control">
				      <%for(Ethnicity ethnicity: listOfEthnicity) {%><option value="<%=ethnicity.getId()%>" <%if(ethnicity.getId()==patient.getEthnicityId()){%>selected<%}%> ><%=ethnicity.getMasterDataName() %></option><%} %>
				    </select>
				  </div>
				</div>
				
				<!-- Select Basic -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="clientguardian">Client Guardian</label>
				  <div class="col-md-4">
				    <select id="clientguardian" name="clientguardian" class="form-control">
				      <%for(User guardian: listOfClientGuardian) {%><option value="<%=guardian.getId()%>" <%if(guardian.getId()==patient.getClientGuardianId()){%>selected<%}%> ><%=guardian.getUserName()%> <%=guardian.getUserLastName() %></option><%} %>
				    </select>
				  </div>
				</div>
				
				<!-- Button (Double) -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="save"></label>
				  <div class="col-md-8">
				<a href="<%= response.encodeUrl(request.getContextPath() + "/Controller?action=patient") %>" id="cancel" name="cancel" class="btn btn-default">Cancel</a>
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
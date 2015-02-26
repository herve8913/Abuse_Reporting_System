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
    <%List<HealthCareOrg> listOfHealthCare = (List<HealthCareOrg>)request.getAttribute("listOfHealthCare"); %>
    <%GroupHome groupHome = (GroupHome)request.getAttribute("groupHome"); %>
    <div class="container" style="padding-top:80px">
<div class="container">
    <div class="row">
        <div class="col-xs-6" style="padding:0px">
            <h3 class="text-left">
                Home Group
            </h3> 
        </div>
        
      </div>
      <div class="row">
      	  <form  name="frmForm" class="form-horizontal" method="post" action="<%= response.encodeUrl(request.getContextPath() + "/Controller?action=doupdatehomegroup") %>">
			<fieldset>
			<input type="hidden" name="grouphomeid" value="<%=groupHome.getId() %>" />
			<legend>New Home Group   <font color="red"> <c:out value="${message}" /></font></legend> 
      					<!-- Text input-->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="homegroupname">Home Group Name</label>  
				  <div class="col-md-4">
				  <input id="homegroupname" name="homegroupname" type="text" placeholder="home group name" value="<%=groupHome.getMasterDataName() %>" class="form-control input-md" required>
				  </div>
				</div>
				
				<!-- Multiple Radios (inline) -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="radios">Status</label>
				  <div class="col-md-4"> 
				    <label class="radio-inline" for="radios0">
				      <input type="radio" name="status" id="radios0" value="1"  <c:if test='${groupHome.status==1}'>checked</c:if> required>
				      Active
				    </label> 
				    <label class="radio-inline" for="radios1">
				      <input type="radio" name="status" id="radios1" value="0" <c:if test='${groupHome.status==0}'>checked</c:if> >
				      N/A
				    </label>
				  </div>
				</div>
				
				<!-- Textarea -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="address">Address</label>
				  <div class="col-md-4">                     
				    <textarea class="form-control" id="address" name="address" ><%=groupHome.getAddress() %></textarea>
				  </div>
				</div>
				
				<!-- Select Basic -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="healthcareorg">Health Care Org</label>
				  <div class="col-md-4">
				    <select id="healthcareorg" name="healthcareorg" class="form-control">
				      <%for(HealthCareOrg healthCareOrg: listOfHealthCare) {%><option value="<%=healthCareOrg.getId()%>" <%if(healthCareOrg.getId()==groupHome.getHealthCareOrgId()){%>selected<%}%> ><%=healthCareOrg.getMasterDataName()%></option><%} %>
				    </select>
				  </div>
				</div>
				
				<!-- Textarea -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="description">Description</label>
				  <div class="col-md-4">                     
				    <textarea class="form-control" id="description" name="description" ><%=groupHome.getDescription() %></textarea>
				  </div>
				</div>
				
				
				<!-- Button (Double) -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="save"></label>
				  <div class="col-md-8">
				<a href="<%= response.encodeUrl(request.getContextPath() + "/Controller?action=homegroup") %>" id="cancel" name="cancel" class="btn btn-default">Cancel</a>
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
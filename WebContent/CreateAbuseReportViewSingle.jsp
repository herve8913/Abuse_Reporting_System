<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
  <head>
  
  <script> 
var _T = "locked";
var _F = "unlocked";
function lockIt(_P) {
 var _L = document.frmForm.lck.value;
 if (_L==_P) 
   {
   document.frmForm.allegedVictimPatient.disabled=(document.frmForm.lck.value=(_L==_F)?_T:_F)==_F;
   document.frmForm.allegedVictimStaff.disabled=(document.frmForm.lck.value=(_L==_F)?_T:_F)==_T;
   }
 else
 {
 document.frmForm.allegedVictimPatient.disabled=(document.frmForm.lck.value=(_L==_F)?_T:_F)==_T;
   document.frmForm.allegedVictimStaff.disabled=(document.frmForm.lck.value=(_L==_F)?_T:_F)==_F;
}
  
}
function lockIt2(_P) {
	 var _L = document.frmForm.lck2.value;
	 if (_L==_P) 
	   {
	   document.frmForm.allegedAbuserStaff.disabled=(document.frmForm.lck2.value=(_L==_F)?_T:_F)==_F;
	   document.frmForm.allegedAbuserPatient.disabled=(document.frmForm.lck2.value=(_L==_F)?_T:_F)==_T;
	   }
	 else
	 {
	 document.frmForm.allegedAbuserStaff.disabled=(document.frmForm.lck2.value=(_L==_F)?_T:_F)==_T;
	   document.frmForm.allegedAbuserPatient.disabled=(document.frmForm.lck2.value=(_L==_F)?_T:_F)==_F;
	}
	  
	}
function isDis() { return (document.frmForm.lck.value==_T); }
function isDis2() { return (document.frmForm.lck2.value==_T); }
</script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script> <!-- or use local jquery -->
<script src="/js/jqBootstrapValidation.js"></script>
<script>
  $(function () { $("input,select,textarea").not("[type=submit]").jqBootstrapValidation(); } );
</script>
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
          <a class="navbar-brand" href="CreateAbuseReportViewPage.jsp">Abuse Report System</a>
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
                <li class="active"><a href="CreateAbuseReportViewPage.jsp">Create Abuse Report</a></li>
                <li ><a href="<%= response.encodeUrl(request.getContextPath() + "/Controller?action=approveabusereport") %>">Approve Abuse Reports &nbsp;<span class="badge"><%=session.getAttribute("submittedreport") %></span></a></li>
              </ul><%}else if (userType==3){ %>
              <li class="active"><a href="CreateAbuseReportViewPage.jsp">Create Abuse Report</a></li><%} %>
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
   <%@page import="bean.*" %>
   <%AbuseReport abuseReport = (AbuseReport)request.getAttribute("abuseReport"); %>
    <div class="container" style="padding-top:80px">
	  <div class="container">
		<div class="row">
          <div class="col-xs-6" style="padding:0px">
            <h3 class="text-left">
                View Abuse Report: <%=abuseReport.getLogNumber() %>
            </h3> 
          </div>
        </div>
		<div class="row">
      	  <form class="form-horizontal">
			<fieldset>
			<legend>Actions</legend>
			<!-- Action 1 -->
			<div class="form-group">
			  <label class="col-md-4 control-label" for="action1">Action 1: Create Abuse Report</label>
			  <div class="col-md-4">                     
			  <%if(abuseReport.getStatus()>0){ %><span class="glyphicon glyphicon-ok"></span>&nbsp;Finished<%}else{ %><span class="glyphicon glyphicon-remove"></span>&nbsp;Not Finished<%} %>
			  </div>
			</div>

			<!-- Action 2 -->
			<div class="form-group">
			  <label class="col-md-4 control-label" for="action2">Action 2: Submit Abuse Report</label>
			  <div class="col-md-4">                     
				<%if(abuseReport.getStatus()>1){ %><span class="glyphicon glyphicon-ok"></span>&nbsp;Finished  (<%=abuseReport.getSubmittedByStaffDate()%>)<%}else{%><span class="glyphicon glyphicon-remove"></span>&nbsp;Not Finished<%} %>
			  </div>
			</div>

			<!-- Action 3 -->
			<div class="form-group">
			  <label class="col-md-4 control-label" for="action3">Action 3: Approve Abuse Report </label>
			  <div class="col-md-4">                     
				<%if(abuseReport.getStatus()>2){ %><span class="glyphicon glyphicon-ok"></span>&nbsp;Finished  (<%=abuseReport.getApprovedBySupervisorDate()%>)<%}else{ %><span class="glyphicon glyphicon-remove"></span>&nbsp;Not Finished<%} %>
			  </div>
			</div>

			<!-- Action 4 -->
			<div class="form-group">
			  <label class="col-md-4 control-label" for="action4">Action 4: Abuse Investigation </label>
			  <div class="col-md-4">                     
				<%if(abuseReport.getStatus()>3){ %><span class="glyphicon glyphicon-ok"></span>&nbsp;Finished  (<%=abuseReport.getDispositionLetterDate()%>)<%}else{ %><span class="glyphicon glyphicon-remove"></span>&nbsp;Not Finished<%} %>
			  </div>
			</div>

			<!-- Action 5 -->
			<div class="form-group">
			  <label class="col-md-4 control-label" for="action5">Action 5: Issues Decision Letter </label>
			  <div class="col-md-4">                     
				<%if(abuseReport.getStatus()>4){ %><span class="glyphicon glyphicon-ok"></span>&nbsp;Finished  (<%=abuseReport.getDecisionLetterDate()%>)<%}else{ %><span class="glyphicon glyphicon-remove"></span>&nbsp;Not Finished<%} %>
			  </div>
			</div>

			<!-- Action 6 -->
			<div class="form-group">
			  <label class="col-md-4 control-label" for="action6">Action 6: Appeal Decision Letter</label>
			  <div class="col-md-4">                     
				<%if(abuseReport.getStatus()>5){ %><span class="glyphicon glyphicon-ok"></span>&nbsp;Finished  (<%=abuseReport.getAppealLetterDate()%>)<%}else{ %><span class="glyphicon glyphicon-remove"></span>&nbsp;Not Finished<%} %>
			  </div>
			</div>
			
				
			<legend>General Information</legend>
				<!-- Button -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="addrepoter">Repoter</label>
				  <div class="col-md-4">
				<p>Name: ***</p>
				<p>Address: <%=abuseReport.getReporterAddress() %></p>
				<p>Daytime telephone: <%=abuseReport.getReporterTelephone() %></p>
				  </div>
				</div>
				
				<!-- Multiple Radios (inline) -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="radios">Is the report mandated?</label>
				  <div class="col-md-4"> 
				    <p><c:if test='${abuseReport.mandated=="Yes"}'>Yes</c:if>
				    <c:if test='${abuseReport.mandated=="No"}'>No</c:if></p>
				  </div>
				</div>
				
				<!-- Select Basic -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="selectbasic">Relationship to Alleged Victim</label>
				  <div class="col-md-4">
				    <p><%=abuseReport.getReporterRelationshipToVictim()%></p>
				  </div>
				</div>
				
				<!-- Button -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="addallegedvictim">Alleged Victim </label>
				  <div class="col-md-4">
				    <p>Name: ***</p>
				    <p>Address: <%=abuseReport.getAllegedVictimAddress() %></p>
				    <p>Telephone: <%=abuseReport.getAllegedVictimTelephone() %></p>
				    <p>Sex: <%=abuseReport.getAllegedVictimSex() %></p>
				    <p>DOB: <%=abuseReport.getAllegedVictimDatebirth()%></p>
				    <p>Age: <%=CalculateAge.getAge(abuseReport.getAllegedVictimDatebirth()) %></p>
				    <p>Marital Status: <%=abuseReport.getMaritalStatus()%></p>
				    <p>Marital Status: <%=abuseReport.getMaritalStatus()%></p>
				  </div>
				</div>
				
				<!-- Button -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="addallegedabuser">Alleged Abuser</label>
				  <div class="col-md-4">
				    <p>Name: ***</p>
				    <p>Home Address: <%=abuseReport.getAllegedAbuserAddress() %></p>
				    <p>Relation to Victim: <%=abuseReport.getAllegedAbuserRelationship() %></p>
				    <p>Social Security: ***</p>
				    <p>DOB: <%=abuseReport.getAllegedAbuserDatebirth() %></p>
				    <p>Telephone: <%=abuseReport.getAllegedAbuserTelephone() %></p>
				  </div>
				</div>
				
				<!-- Button -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="addallegedabuser">Disability</label>
				  <div class="col-md-4">
				    <%for(String disability: abuseReport.getDisabilityList()) {%>
				    <p><%=disability %></p><%} %>
				  </div>
				</div>
				
				<!-- Button -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="addallegedabuser">Communication Needs</label>
				  <div class="col-md-4">
				    <p><%=abuseReport.getCommunicationNeed() %></p>
				  </div>
				</div>
				
				<!-- Button -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="addallegedabuser">Client's Guardian</label>
				  <div class="col-md-4">
				    <p>Name: ***</p>
					<p>Address: <%=abuseReport.getClientGuardianAddress() %></p>
					<p>Relationship to Alleged Victim: <%if(abuseReport.getClientGuardianRelationship()==null){%>Guardian<%}else{%><%=abuseReport.getClientGuardianRelationship()%><%} %></p>
					<p>Telephone: <%=abuseReport.getClientGuardianTelephone() %></p>
				  </div>
				</div>
				
				<!-- Button -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="addallegedabuser">Currently Served By</label>
				  <div class="col-md-4">
				    <p><%=abuseReport.getCurrentlyServedByComment() %></p>
				  </div>
				</div>
				
				<!-- Textarea -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="collateralcontacts">Collateral Contacts or Notifications</label>
				  <div class="col-md-4">                     
				    <p><%=abuseReport.getCollateralContactsNotification() %></p>
				  </div>
				</div>
				
				<!-- Select Basic -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="typeofservice">Type of Service</label>
				  <div class="col-md-4">
				    <p><%=abuseReport.getTypeOfServiceComment()%></p>
				  </div>
				</div>
				
				<!-- Select Basic -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="typeofservice">Client's Ethnicity</label>
				  <div class="col-md-4">
				    <p><%=abuseReport.getEthnicity() %></p>
				  </div>
				</div>
				
				<legend>Abuse Information</legend>
				<!-- Select Basic -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="frequencyofabuse">Frequency of Abuse</label>
				  <div class="col-md-4">
				    <p><%=abuseReport.getFrequencyOfAbuse()%></p>
				  </div>
				</div>
				
				<!-- Text input-->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="dataoflastincident">Date of Last Incident</label>  
				  <div class="col-md-4">
				  <P><%=abuseReport.getDateOfLastIncident() %></P>
				  </div>
				</div>
				
				<!-- Multiple Radios (inline) -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="awareofreport">Is victim aware of report?</label>
				  <div class="col-md-4"> 
				    <p><c:if test='${abuseReport.isVictimAware=="Yes"}'>Yes</c:if>
				    <c:if test='${abuseReport.isVictimAware=="No"}'>No</c:if></p>
				  </div>
				</div>
				
				<!-- Multiple Checkboxes -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="typesofabuse">Types of Abuse</label>
				  <div class="col-md-4">
				  <p><c:out value="${abuseReport.typeOfAbuseReport}"/></p>
				  </div>
				</div>
				<legend>Detailed Description</legend>
				<!-- Textarea -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="textarea">In narrative form, please describe the alleged abuse</label>
				  <div class="col-md-4">                     
				    <p><%=abuseReport.getDescriptionAllegedReport() %></p>
				  </div>
				</div>
				
				<!-- Textarea -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="textarea">Please describe the level of risk to the alleged victim, including his/her current physical and emotional state</label>
				  <div class="col-md-4">                     
				    <p><%=abuseReport.getDescriptionLevelRisk() %></p>
				  </div>
				</div>
				
				<!-- Textarea -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="textarea">Please list any resulting injuries</label>
				  <div class="col-md-4">                     
				    <p><%=abuseReport.getDescriptionResultingInjuries() %></p>
				  </div>
				</div>
				
				<!-- Textarea -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="textarea">Please list witnesses, if any, including daytime phone numbers</label>
				  <div class="col-md-4">                     
				    <p><%=abuseReport.getDescriptionWitnesses() %></p>
				  </div>
				</div>
				
				<!-- Textarea -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="textarea">Please describe caregiver relationship between the alleged abuser and the alleged victim</label>
				  <div class="col-md-4">                     
				    <p><%=abuseReport.getDescriptionCaregiverRelationship() %></p>
				  </div>
				</div>
				
				<!-- Multiple Radios -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="Hotline">Was an oral report filed with the DPPC Hotline?</label>
				  <div class="col-md-4">
				  <p><c:if test='${abuseReport.oralReportFilled=="Yes"}'>Yes <c:out value="${abuseReport.oralReportFilledComment}" /></c:if>
				  <c:if test='${abuseReport.oralReportFilled=="No"}'>No</c:if></p>
				  </div>
				</div>
				
				<!-- Multiple Radios -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="Risk">Is there any risk to the investigator?</label>
				  <div class="col-md-4">
				  <p><c:if test='${abuseReport.riskToInvestigator=="Yes"}'>Yes <c:out value="${abuseReport.riskToInvestigatorComment}" /></c:if>
				  <c:if test='${abuseReport.riskToInvestigator=="No"}'>No </c:if></p>
				  </div>
				</div>
			</fieldset>
			</form>
		</div>
   	 </div> 
   </div> 
           <!-- Modal 1-->
<div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">View Abuse Report</h4>
      </div>
      <div class="modal-body">
 ...
       </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Back</button>
      </div>
    </div>
  </div>
</div>
       <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script src="js/bootstrap.js"></script>
  </body>
</html>
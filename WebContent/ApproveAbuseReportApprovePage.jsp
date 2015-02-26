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
            </li><%}%>
          </ul>

        </div><!--/.nav-collapse -->
      </div>
    </div>  
  <!------------------------------------------- Nevigation Bar End-------------------------------------------------------------->
    <%AbuseReport abuseReport = (AbuseReport)request.getAttribute("abuseReport"); %>
    <div class="container" style="padding-top:80px">
	  <div class="container">
		<div class="row">
          <div class="col-xs-6" style="padding:0px">
            <h3 class="text-left">
                Approve Abuse Report
            </h3> 
          </div>
        </div>
		<div class="row">
      	  <form  name="frmForm" class="form-horizontal" method="post" action="<%= response.encodeUrl(request.getContextPath() + "/Controller?action=doapprovereport") %>">
			<input type="hidden" name="reportId" value="<%=abuseReport.getId() %>" />
			<input type="hidden" name="reporterId" value ="<%=abuseReport.getReporterId() %>" />
			<fieldset>
			<legend>General Information</legend>
				<!-- Button -->
				<%@ page import="java.util.List,bean.*" %>
				
				<div class="form-group">
				  <label class="col-md-4 control-label" for="addrepoter">Reporter</label>
				  <div class="col-md-4">
				<p>Name: <%=abuseReport.getReporterName() %></p>
				<p>Address: <%=abuseReport.getReporterAddress() %></p>
				<p>Daytime telephone: <%=abuseReport.getReporterTelephone() %></p>	
				  </div>
				</div>
				
				<!-- Multiple Radios (inline) -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="radios">Is the report mandated?</label>
				  <div class="col-md-4"> 
				    <label class="radio-inline" for="radios-0">
				      <input type="radio" name="mandated" id="radios-0" value="Yes" required <c:if test='${abuseReport.mandated=="Yes"}'>checked</c:if>>
				      Yes
				    </label> 
				    <label class="radio-inline" for="radios-1">
				      <input type="radio" name="mandated" id="radios-1" value="No" <c:if test='${abuseReport.mandated=="No"}'>checked</c:if>>
				      No
				    </label>
				  </div>
				</div>
				
				<!-- Select Basic -->
				<%List<Relationship> listOfRelationship = (List<Relationship>) request.getAttribute("listOfRelationship"); %>
				<div class="form-group">
				  <label class="col-md-4 control-label" for="selectbasic">Relationship to Alleged Victim</label>
				  <div class="col-md-4">
				    <select id="selectbasic" name="relationship" class="form-control">
				      <%for (Relationship relationship:listOfRelationship){ %><option value="<%=relationship.getMasterDataName()%>" <%if(abuseReport.getReporterRelationshipToVictim().equals(relationship.getMasterDataName())){%>selected<%}%>><%=relationship.getMasterDataName()%></option>
				      <%} %>
				    </select>
				  </div>
				</div>
				
				<!-- Button -->
				<%List<Patient> listOfAllPatient = (List<Patient>) request.getAttribute("listOfAllPatient"); %>
				<div class="form-group">
				
				  <label class="col-md-4 control-label" for="addallegedvictim">Alleged Victim (Patient) <input type=radio value="Patient" <c:if test="${abuseReport.allegedVictimPatientId!=0}">checked</c:if>  onclick="lockIt(_F)"   id=radio1 name=radio1></label>
				  
				  <div class="col-md-4">
				    <select id="selectbasic" name="allegedVictimPatient" class="form-control" onfocus="if (isDis())blur();" <c:if test="${abuseReport.allegedVictimPatientId==0}">disabled</c:if>>
				      <%for (Patient patient:listOfAllPatient){ %><option value="<%= patient.getId()%>" <%if(abuseReport.getAllegedVictimPatientId()==patient.getId()){%>selected<%} %>><%=patient.getPatientName() %> <%=patient.getPatientMidname() %> <%=patient.getPatientLastName() %></option>
				      <%} %>
				    </select>
				  </div>
				</div>
				<%List<User> listStaffMembers = (List<User>)request.getAttribute("listStaffMembers"); %>
				<div class="form-group">
				  <label class="col-md-4 control-label" for="addallegedvictim">Alleged Victim (Staff) <input type=radio value="Staff"  <c:if test="${abuseReport.allegedVictimStaffId!=0}">checked</c:if>  onclick="lockIt(_T)" id=radio1 name=radio1></label>
				  <div class="col-md-4">
				    <select id="selectbasic" name="allegedVictimStaff" class="form-control" onfocus="if (isDis())blur();" <c:if test="${abuseReport.allegedVictimStaffId==0}">disabled</c:if>>
				      <%for (User victimStaff:listStaffMembers){ %><option value="<%= victimStaff.getId()%>" <%if(abuseReport.getAllegedVictimStaffId()==victimStaff.getId()){%>selected<%} %>><%=victimStaff.getUserName() %> <%=victimStaff.getUserLastName() %></option>
				      <%} %>
				    </select>
				  </div>
				</div>
				<input type=hidden name="lck" value="unlocked">
				
				<!-- Button -->
				
				<div class="form-group">
				  <label class="col-md-4 control-label" for="addallegedabuser">Alleged Abuser (Patient) <input type=radio value="Patient"  <c:if test="${abuseReport.allegedAbuserPatientId!=0}">checked</c:if>  onclick="lockIt2(_T)" id=radio2 name=radio2></label>
				  <div class="col-md-4">
				    <select id="selectbasic" name="allegedAbuserPatient" class="form-control" onfocus="if (isDis2())blur();"<c:if test="${abuseReport.allegedAbuserPatientId==0}">disabled</c:if>>
				      <%for (Patient abuserPatient:listOfAllPatient){ %><option value="<%=abuserPatient.getId() %>" <%if(abuseReport.getAllegedAbuserPatientId()==abuserPatient.getId()){%>selected<%} %>><%=abuserPatient.getPatientName() %> <%=abuserPatient.getPatientMidname() %> <%=abuserPatient.getPatientLastName() %></option>
				      <%} %>
				    </select>
				</div>
				</div>
				
				<div class="form-group">
				  <label class="col-md-4 control-label" for="addallegedabuser">Alleged Abuser (Staff) <input type=radio value="Staff"  <c:if test="${abuseReport.allegedAbuserStaffId!=0}">checked</c:if>  onclick="lockIt2(_F)" id=radio2 name=radio2></label>
				  <div class="col-md-4">
				    <select id="selectbasic" name="allegedAbuserStaff" class="form-control" onfocus="if (isDis2())blur();" <c:if test="${abuseReport.allegedAbuserStaffId==0}">disabled</c:if>>
				      <%for (User user:listStaffMembers){ %><option value="<%=user.getId() %>" <%if(abuseReport.getAllegedAbuserStaffId()==user.getId()){%>selected<%} %>><%=user.getUserName() %> <%=user.getUserLastName() %></option>
				      <%} %>
				    </select>
				</div>
				</div>
				<input type=hidden name="lck2" value="unlocked">
				
				<!-- Select Basic -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="selectbasic">Abuser Relationship</label>
				  <div class="col-md-4">
				    <select id="selectbasic" name="relationship2" class="form-control">
				      <%for (Relationship relationship:listOfRelationship){ %><option value="<%=relationship.getMasterDataName()%>" <%if(abuseReport.getAllegedAbuserRelationship().equals(relationship.getMasterDataName())) {%>selected <%} %>><%=relationship.getMasterDataName()%></option>
				      <%} %>
				    </select>
				  </div>
				</div>
				
				<!-- Textarea -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="collateralcontacts">Collateral Contacts or Notifications</label>
				  <div class="col-md-4">                     
				    <textarea class="form-control" id="collateralcontacts" name="collateralcontacts" required><c:out value="${abuseReport.collateralContactsNotification}"/></textarea>
				  </div>
				</div>
				
				<!-- Select Basic -->
				<%List<TypeOfService> listOfService = (List<TypeOfService>)request.getAttribute("listOfService"); %>
				<div class="form-group">
				  <label class="col-md-4 control-label" for="typeofservice">Type of Service</label>
				  <div class="col-md-4">
				    <select id="typeofservice" name="typeofservice" class="form-control">
				      <%for (TypeOfService typeOfService : listOfService){ %><option value="<%=typeOfService.getMasterDataName()%>" <%if(abuseReport.getTypeOfServiceComment().equals(typeOfService.getMasterDataName())){%>selected<%}%>><%=typeOfService.getMasterDataName() %></option>
				      <%} %>
				      
				    </select>
				  </div>
				</div>
				
				<!-- Multiple Checkboxes -->
				<%List<CommunicationNeed> listOfComNeed = (List<CommunicationNeed>) request.getAttribute("listOfComNeed");
				    		int j = 0;%>
				<div class="form-group">
				  <label class="col-md-4 control-label" for="communicationneeds">Communication Needs</label>
				  <div class="col-md-4">
				  
				  <% int band=0; int count=0;
				  for (CommunicationNeed communicationNeed: listOfComNeed){count++; %><div>
				    <label class="radio-inline" for="communicationneeds-<%=j%>">
				     <%if(count==(listOfComNeed.size())){ %>
				     <input type="radio" name="communicationneeds" id="communicationneeds-<%=j++%>" value="<%=communicationNeed.getMasterDataName()%>" 
				    <%if(band!=1)
				    {%> checked <%} %>><%= communicationNeed.getMasterDataName()%>
				    </label>
				    </div>
				    <div><input id="otherCommunicationNeeds" name="textinputcomneed" type="text" placeholder="Other communication needs" class="form-control input-md" <%if(band!=1) {%>value="<%=abuseReport.getCommunicationNeed()%>"<%} %> />
				    </div>
				      
				    <%}else{ %>
				    <input type="radio" name="communicationneeds" id="communicationneeds-<%=j++%>" value="<%=communicationNeed.getMasterDataName()%>" 
				    <%if(abuseReport.getCommunicationNeed().equals(communicationNeed.getMasterDataName()))
				    {%> checked <% band=1;}%>><%= communicationNeed.getMasterDataName()%>
				    </label>
					</div><%} 
					}%>
					
					
					
				</div>				
		
				           				
				<legend>Abuse Information</legend>
				<!-- Select Basic -->
				<%List<FrequencyOfAbuse> listOfFrequency = (List<FrequencyOfAbuse>)request.getAttribute("listOfFrequency"); %>
				<div class="form-group">
				  <label class="col-md-4 control-label" for="frequencyofabuse">Frequency of Abuse</label>
				  <div class="col-md-4">
				    <select id="frequencyofabuse" name="frequencyofabuse" class="form-control">
				      <%for (FrequencyOfAbuse frequencyOfAbuse : listOfFrequency){ %><option value="<%=frequencyOfAbuse.getMasterDataName()%>" <%if(abuseReport.getFrequencyOfAbuse().equals(frequencyOfAbuse.getMasterDataName())) {%>selected<%}%>><%=frequencyOfAbuse.getMasterDataName() %></option>
				      <%} %>
				    </select>
				  </div>
				</div>
				
				
				<!-- Multiple Radios (inline) -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="awareofreport">Is victim aware of report?</label>
				  <div class="col-md-4"> 
				    <label class="radio-inline" for="awareofreport-0">
				      <input type="radio" name="awareofreport" id="awareofreport-0" value="Yes" <c:if test='${abuseReport.isVictimAware=="Yes"}'>checked</c:if>>
				      Yes
				    </label> 
				    <label class="radio-inline" for="awareofreport-1">
				      <input type="radio" name="awareofreport" id="awareofreport-1" value="No" <c:if test='${abuseReport.isVictimAware=="No"}'>checked</c:if>>
				      No
				    </label>
				  </div>
				</div>
				
				<!-- Multiple Checkboxes -->
				<%List<TypeOfAbuse> listOfAbuseType = (List<TypeOfAbuse>) request.getAttribute("listOfAbuseType");
				    		int i = 0;%>
				<div class="form-group">
				  <label class="col-md-4 control-label" for="typesofabuse">Types of Abuse</label>
				  <div class="col-md-4">
				  <c:forEach var="typeofabuse" items="${listOfAbuseType}" varStatus="status" > <div>
				    <label class="radio-inline" for="typesofabuse-<%=i%>">
				    <c:choose> 
				    <c:when test="${status.last}" >
				     <input type="radio" name="typesofabuse" id="typesofabuse-<%=i++%>" value="${typeofabuse.masterDataName}" <c:if test="${detect!=1}"> checked  </c:if> />
				      <c:out value="${typeofabuse.masterDataName}" />(Please Specify)
				      <input id="otherAbuseType" name="textinputabusetype" type="text" placeholder="Other abuse type" class="form-control input-md" <c:if test="${detect!=1}"> value="${abuseReport.typeOfAbuseReport}" </c:if> />
				      </c:when>
				      <c:otherwise>
				      <input type="radio" name="typesofabuse" id="typesofabuse-<%=i++%>" value="${typeofabuse.masterDataName}" <c:if test="${typeofabuse.masterDataName==abuseReport.typeOfAbuseReport}"> checked <c:set scope="page" var="detect" value="1"></c:set> </c:if> >
				      <c:out value="${typeofabuse.masterDataName}" /> 
				    </c:otherwise>
				    </c:choose>
				    </label>
					</div>
					</c:forEach>
					
				  </div>
				</div>
				<legend>Detailed Description</legend>
				<!-- Textarea -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="textarea">In narrative form, please describe the alleged abuse</label>
				  <div class="col-md-4">                     
				    <textarea class="form-control" id="textarea" name="descriptionallegedabuse" required><c:out value="${abuseReport.descriptionAllegedReport}"/></textarea>
				  </div>
				</div>
				
				<!-- Textarea -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="textarea">Please describe the level of risk to the alleged victim, including his/her current physical and emotional state</label>
				  <div class="col-md-4">                     
				    <textarea class="form-control" id="textarea" name="descriptionlevelrisk" required><c:out value="${abuseReport.descriptionLevelRisk}"/></textarea>
				  </div>
				</div>
				
				<!-- Textarea -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="textarea">Please list any resulting injuries</label>
				  <div class="col-md-4">                     
				    <textarea class="form-control" id="textarea" name="resultinginjuries" required><c:out value="${abuseReport.descriptionResultingInjuries}"/></textarea>
				  </div>
				</div>
				
				<!-- Textarea -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="textarea">Please list witnesses, if any, including daytime phone numbers</label>
				  <div class="col-md-4">                     
				    <textarea class="form-control" id="textarea" name="witnesses" required><c:out value="${abuseReport.descriptionWitnesses}"/></textarea>
				  </div>
				</div>
				
				<!-- Textarea -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="textarea">Please describe caregiver relationship between the alleged abuser and the alleged victim</label>
				  <div class="col-md-4">                     
				    <textarea class="form-control" id="textarea" name="caregiverrelationship" required><c:out value="${abuseReport.descriptionCaregiverRelationship}"/></textarea>
				  </div>
				</div>
				
				<!-- Multiple Radios -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="Hotline">Was an oral report filed with the DPPC Hotline?</label>
				  <div class="col-md-4">
				  <div class="radio">
				    <label for="Hotline-0">
				      <input type="radio" name="Hotline" id="Hotline-0" value="Yes" <c:if test='${abuseReport.oralReportFilled=="Yes"}'>checked</c:if>>
				      Yes (Please note date and time of call)
				      <input id="callDateTime" name="oralreportcomment" type="text" placeholder="mm/dd/yyyy hh:mm" class="form-control input-md" value="${abuseReport.oralReportFilledComment}">
				    </label>
					</div>
				  <div class="radio">
				    <label for="Hotline-1">
				      <input type="radio" name="Hotline" id="Hotline-1" value="No" <c:if test='${abuseReport.oralReportFilled=="No"}'>checked</c:if>>
				      No (Please call 800-426-9009 to file an oral report)
				    </label>
					</div>
				  </div>
				</div>
				
				<!-- Multiple Radios -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="Risk">Is there any risk to the investigator?</label>
				  <div class="col-md-4">
				  <div class="radio">
				    <label for="Risk-0">
				      <input type="radio" name="Risk" id="Risk-0" value="Yes" <c:if test='${abuseReport.riskToInvestigator=="Yes"}'>checked</c:if>>
				      Yes (Please specify)
				      <input id="callDateTime" name="risktoinvestigatorcomment" type="text" placeholder="Risk to the investigator" class="form-control input-md" value="${abuseReport.riskToInvestigatorComment}">
				    </label>
					</div>
				  <div class="radio">
				    <label for="Risk-1">
				      <input type="radio" name="Risk" id="Risk-1" value="No" <c:if test='${abuseReport.riskToInvestigator=="No"}'>checked</c:if>>
				      No
				    </label>
					</div>
				  </div>
				</div>
		
				<!-- Button (Double) -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="save"></label>
				  <div class="col-md-8">
				    <a href="CreateAbuseReportViewPage.jsp" id="cancel" name="cancel" class="btn btn-default">Cancel</a>
				    <input id="save" name = "save" type = "submit" value="Save" class="btn btn-primary">
				    <input id="cancel" type="submit" name="approve" value="Approve" class="btn btn-success">
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
        <h4 class="modal-title" id="myModalLabel">Add Reporter</h4>
      </div>
      
      <div class="modal-body">
      <!-- Example Table -->
            <div class="row">
            <form  name="subform1" class="form-horizontal" method="post" action="<%= response.encodeUrl(request.getContextPath() + "/Controller?action=docreatereport") %>">
        <div id="no-more-tables">
            <table class="col-md-12 table-bordered table-striped table-condensed cf" style="padding:0px; width: 100%;">
        		<thead class="cf">
        			<tr>
        				<th>Employee ID</th>
        				<th>Name</th>
        				<th>Address</th>
        				<th>Day Time Phone</th>
        			</tr>
        		</thead>
        		<tbody>
        			<tr>
        				<td data-title="Employee ID"><a href="http://www.example.com/" style="font-weight:bold">12345678</a></td>
        				<td data-title="Name">Aaron</td>
        				<td data-title="Address">24 Trowbridge Rd, Worcester, MA, 01609</td>
        				<td data-title="Day Time Phone">333-444-5555</td>
        			</tr>
        			<tr>
        				<td data-title="Employee ID"><a href="http://www.example.com/" style="font-weight:bold">12345678</a></td>
        				<td data-title="Name">Aaron</td>
        				<td data-title="Address">24 Trowbridge Rd, Worcester, MA, 01609</td>
        				<td data-title="Day Time Phone">333-444-5555</td>
        			</tr>
        			<tr>
        				<td data-title="Employee ID"><a href="http://www.example.com/" style="font-weight:bold">12345678</a></td>
        				<td data-title="Name">Aaron</td>
        				<td data-title="Address">24 Trowbridge Rd, Worcester, MA, 01609</td>
        				<td data-title="Day Time Phone">333-444-5555</td>
        			</tr>
        			<tr>
        				<td data-title="Employee ID"><a href="http://www.example.com/" style="font-weight:bold">12345678</a></td>
        				<td data-title="Name">Aaron</td>
        				<td data-title="Address">24 Trowbridge Rd, Worcester, MA, 01609</td>
        				<td data-title="Day Time Phone">333-444-5555</td>
        			</tr>
        			<tr>
        				<td data-title="Employee ID"><a href="http://www.example.com/" style="font-weight:bold">12345678</a></td>
        				<td data-title="Name">Aaron</td>
        				<td data-title="Address">24 Trowbridge Rd, Worcester, MA, 01609</td>
        				<td data-title="Day Time Phone">333-444-5555</td>
        			</tr>
        			<tr>
        				<td data-title="Employee ID"><a href="http://www.example.com/" style="font-weight:bold">12345678</a></td>
        				<td data-title="Name">Aaron</td>
        				<td data-title="Address">24 Trowbridge Rd, Worcester, MA, 01609</td>
        				<td data-title="Day Time Phone">333-444-5555</td>
        			</tr>
        			<tr>
        				<td data-title="Employee ID"><a href="http://www.example.com/" style="font-weight:bold">12345678</a></td>
        				<td data-title="Name">Aaron</td>
        				<td data-title="Address">24 Trowbridge Rd, Worcester, MA, 01609</td>
        				<td data-title="Day Time Phone">333-444-5555</td>
        			</tr>
        		</tbody>
        	</table>
        </div>
    </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
        <button type="button" class="btn btn-primary">Add</button>
      </div>
    </div>
  </div>
</div>

<!-- Modal 2-->
<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Modal title</h4>
      </div>
      <div class="modal-body">
        ...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
        <button type="button" class="btn btn-primary">Add</button>
      </div>
    </div>
  </div>
</div>

<!-- Modal 3-->
<div class="modal fade" id="myModal3" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Modal title</h4>
      </div>
      <div class="modal-body">
        ...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
        <button type="button" class="btn btn-primary">Add</button>
      </div>
    </div>
  </div>
</div>

<script src="http://code.jquery.com/jquery-latest.js"></script>
    <script src="js/bootstrap.js"></script>
  </body>
</html>
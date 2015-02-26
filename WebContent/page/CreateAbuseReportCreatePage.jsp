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
    <link rel="stylesheet" href="css/bbGrid.css">
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
          <a class="navbar-brand" href="CreateAbuseReportViewPage.jsp">Abuse Report System</a>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
        	<li class="dropdown">
          	  <a href="#" class="dropdown-toggle" data-toggle="dropdown" ><span class="glyphicon glyphicon-user"></span>Hi, <%= session.getAttribute("userName") %><b class="caret"></b></a>
          	  <ul class="dropdown-menu">
                <li><a href="ChangePassword.jsp">Change Password</a></li>
                <li><a href="index.jsp">Log Out</a></li>
              </ul>
            </li>
          </ul>
          <ul class="nav navbar-nav">
            <li class="dropdown active">
            	<a href="#" class="dropdown-toggle" data-toggle="dropdown">Report Abuse &nbsp;<span class="badge">5</span><b class="caret"></b></a>
            <ul class="dropdown-menu">
                <li class="active"><a href="CreateAbuseReportViewPage.jsp">Create Abuse Report</a></li>
                <li ><a href="<%= response.encodeUrl(request.getContextPath() + "/Controller?action=approveabusereport") %>">Approve Abuse Reports &nbsp;<span class="badge">5</span></a></li>
              </ul>
            <li><a href="TrackReports.jsp">Track Reports</a></li>
            <li><a href="Documents.jsp">Documents</a></li>
            <li><a href="Help.jsp">Help</a></li>
            <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Admin Panel<b class="caret"></b></a>
            <ul class="dropdown-menu">
                <li ><a href="Users.jsp">Users</a></li>
                <li ><a href="Patients.jsp">Patients</a></li>
                <li ><a href="HomeGroups.jsp">Home Groups</a></li>
                <li ><a href="Disabilities.jsp">Disabilities</a></li>
                <li ><a href="Drugs.jsp">Drugs</a></li>
              </ul>
            </li>
          </ul>

        </div><!--/.nav-collapse -->
      </div>
    </div>  
  <!------------------------------------------- Nevigation Bar End-------------------------------------------------------------->
    <div class="container" style="padding-top:80px">
	  <div class="container">
		<div class="row">
          <div class="col-xs-6" style="padding:0px">
            <h3 class="text-left">
                New Abuse Report
            </h3> 
          </div>
        </div>
		<div class="row">
      	  <form class="form-horizontal" method="post" action="<%= response.encodeUrl(request.getContextPath() + "/Controller?action=docreatereport") %>">
			<fieldset>
			<legend>General Information</legend>
				<!-- Button -->
				<%@ page import="java.util.List,bean.*" %>
				<%User user1 = (User)request.getAttribute("userInfo"); %>
				<div class="form-group">
				  <label class="col-md-4 control-label" for="addrepoter">Repoter</label>
				  <div class="col-md-4">
				<p>Name: <%=user1.getUserName() %></p>
				<p>Address: <%=user1.getUserAddress() %></p>
				<p>Daytime telephone: <%=user1.getTelephone() %></p>
				  </div>
				</div>

				<!-- Multiple Radios (inline) -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="radios">Is the report mandated?</label>
				  <div class="col-md-4"> 
				    <label class="radio-inline" for="radios-0">
				      <input type="radio" name="mandated" id="radios-0" value="Yes" required>
				      Yes
				    </label> 
				    <label class="radio-inline" for="radios-1">
				      <input type="radio" name="mandated" id="radios-1" value="No">
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
				       <%for (Relationship relationship:listOfRelationship){ %><option value="<%=relationship.getMasterDataName()%>"><%=relationship.getMasterDataName()%></option>
				      <%} %>
				    </select>
				  </div>
				</div>

				<!-- Button -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="addallegedvictim">Alleged Victim </label>
				  <div class="col-md-4">
				    <button type="button" id="addallegedvictim" name="addallegedvictim" class="btn btn-default" data-toggle="modal" data-target="#myModal1"><span class="glyphicon glyphicon-plus"></span>&nbsp;Add</button>
				  </div>
				</div>

				<!-- Button -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="addallegedabuser">Alleged Abuser</label>
				  <div class="col-md-4">
				    <button type="button" id="addallegedabuser" name="addallegedabuser" class="btn btn-default" data-toggle="modal" data-target="#myModal2"><span class="glyphicon glyphicon-plus"></span>&nbsp;Add</button>
				  </div>
				</div>

				<!-- Select Basic -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="selectbasic">Abuser Relationship</label>
				  <div class="col-md-4">
				    <select id="selectbasic" name="relationship2" class="form-control">
				      <%for (Relationship relationship:listOfRelationship){ %><option value="<%=relationship.getMasterDataName()%>"><%=relationship.getMasterDataName()%></option>
				      <%} %>
				    </select>
				  </div>
				</div>
				
				<!-- Textarea -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="collateralcontacts">Collateral Contacts or Notifications</label>
				  <div class="col-md-4">                     
				    <textarea class="form-control" id="collateralcontacts" name="collateralcontacts" required></textarea>
				  </div>
				</div>

				<!-- Select Basic -->
				<%List<TypeOfService> listOfService = (List<TypeOfService>)request.getAttribute("listOfService"); %>
				<div class="form-group">
				  <label class="col-md-4 control-label" for="typeofservice">Type of Service</label>
				  <div class="col-md-4">
				    <select id="typeofservice" name="typeofservice" class="form-control">
				      <%for (TypeOfService typeOfService : listOfService){ %><option value="<%=typeOfService.getMasterDataName()%>"><%=typeOfService.getMasterDataName() %></option>
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
				  <%for (CommunicationNeed communicationNeed: listOfComNeed){ %><div>
				    <label class="radio-inline" for="communicationneeds-<%=j%>">
				      <input type="radio" name="communicationneeds" id="communicationneeds-<%=j++%>" value="<%=communicationNeed.getMasterDataName()%>" required>
				      <%=communicationNeed.getMasterDataName()%> <%if(communicationNeed.getMasterDataName().equals("Other")){ %>(Please Specify)
				      <input id="otherCommunicationNeeds" name="textinputcomneed" type="text" placeholder="Other communication needs" class="form-control input-md"><%} %>
				    </label>
					</div>
					<%} %>
				  </div>
				</div>
				
				<legend>Abuse Information</legend>
				<!-- Select Basic -->
				<%List<FrequencyOfAbuse> listOfFrequency = (List<FrequencyOfAbuse>)request.getAttribute("listOfFrequency"); %>
				<div class="form-group">
				  <label class="col-md-4 control-label" for="frequencyofabuse">Frequency of Abuse</label>
				  <div class="col-md-4">
				    <select id="frequencyofabuse" name="frequencyofabuse" class="form-control">
				      <%for (FrequencyOfAbuse frequencyOfAbuse : listOfFrequency){ %><option value="<%=frequencyOfAbuse.getMasterDataName()%>"><%=frequencyOfAbuse.getMasterDataName() %></option>
				      <%} %>
				    </select>
				  </div>
				</div>


				<!-- Multiple Radios (inline) -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="awareofreport">Is victim aware of report?</label>
				  <div class="col-md-4"> 
				    <label class="radio-inline" for="awareofreport-0">
				      <input type="radio" name="awareofreport" id="awareofreport-0" value="Yes">
				      Yes
				    </label> 
				    <label class="radio-inline" for="awareofreport-1">
				      <input type="radio" name="awareofreport" id="awareofreport-1" value="No">
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
				  <%for (TypeOfAbuse typeOfAbuse : listOfAbuseType){ %><div>
				    <label class="radio-inline" for="typesofabuse-<%=i%>">
				      <input type="radio" name="typesofabuse" id="typesofabuse-<%=i++%>" value="<%=typeOfAbuse.getMasterDataName()%>" required>
				      <%=typeOfAbuse.getMasterDataName() %> <%if(typeOfAbuse.getMasterDataName().equals("Other")){ %>(Please Specify)
				      <input id="otherAbuseType" name="textinputabusetype" type="text" placeholder="Other abuse type" class="form-control input-md"><%} %>
				    </label>
					</div>
					<%} %>
				  </div>
				</div>
				
				<legend>Detailed Description</legend>
				<!-- Textarea -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="textarea">In narrative form, please describe the alleged abuse</label>
				  <div class="col-md-4">                     
				    <textarea class="form-control" id="textarea" name="descriptionallegedabuse" required></textarea>
				  </div>
				</div>

				<!-- Textarea -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="textarea">Please describe the level of risk to the alleged victim, including his/her current physical and emotional state</label>
				  <div class="col-md-4">                     
				    <textarea class="form-control" id="textarea" name="descriptionlevelrisk" required></textarea>
				  </div>
				</div>
				
				<!-- Textarea -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="textarea">Please list any resulting injuries</label>
				  <div class="col-md-4">                     
				    <textarea class="form-control" id="textarea" name="resultinginjuries" required></textarea>
				  </div>
				</div>
				
				<!-- Textarea -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="textarea">Please list witnesses, if any, including daytime phone numbers</label>
				  <div class="col-md-4">                     
				    <textarea class="form-control" id="textarea" name="witnesses" required></textarea>
				  </div>
				</div>
				
				<!-- Textarea -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="textarea">Please describe caregiver relationship between the alleged abuser and the alleged victim</label>
				  <div class="col-md-4">                     
				    <textarea class="form-control" id="textarea" name="caregiverrelationship" required></textarea>
				  </div>
				</div>

				<!-- Multiple Radios -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="Hotline">Was an oral report filed with the DPPC Hotline?</label>
				  <div class="col-md-4">
				  <div class="radio">
				    <label for="Hotline-0">
				      <input type="radio" name="Hotline" id="Hotline-0" value="Yes" checked="checked">
				      Yes (Please note date and time of call)
				      <input id="callDateTime" name="oralreportcomment" type="text" placeholder="mm/dd/yyyy hh:mm" class="form-control input-md">
				    </label>
					</div>
				  <div class="radio">
				    <label for="Hotline-1">
				      <input type="radio" name="Hotline" id="Hotline-1" value="No">
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
				      <input type="radio" name="Risk" id="Risk-0" value="Yes" checked="checked">
				      Yes (Please specify)
				      <input id="callDateTime" name="risktoinvestigatorcomment" type="text" placeholder="Risk to the investigator" class="form-control input-md">
				    </label>
					</div>
				  <div class="radio">
				    <label for="Risk-1">
				      <input type="radio" name="Risk" id="Risk-1" value="No">
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
				    <input id="save" name = "save" type = "submit" value="Save" class="btn btn-primary"  >
				    <input id="cancel" type="submit" name="submit" value="Submit" class="btn btn-success" >
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
        <h4 class="modal-title" id="myModalLabel">Add Victim</h4>
      </div>
      <div class="modal-body">
      <!-- Example Table -->
        <div class="row">
          <div class="col-xs-12" style="padding:0px">
            <ul class="nav nav-tabs">
              <li class="active"><a href="#pane1" data-toggle="tab" ><b>Staffs</b></a></li>
              <li><a href="#pane2" data-toggle="tab"><b>Patients</b></a></li>
            </ul>
          </div>
      <div id="addVictim" class="tab-content">
        <div id="pane1" class="tab-pane active">
          <div class="col-md-12" style="padding:3px">
 	         <input id="filter" type="text" class="form-control" placeholder="Search..." >
		  </div>
        <div id="no-more-tables" style="padding:3px">
            <table class="col-md-12 table-bordered table-striped table-condensed cf table-hover" style="padding:0px; width: 100%;">
            
        		<thead class="cf">
        			<tr>
        				<th>Employee ID</th>
        				<th>Name</th>
        				<th>Address</th>
        				<th>Day Time Phone</th>
        			</tr>
        		</thead>
        		<tbody class="searchable">
        			<tr >
        				<td data-title="Employee ID">12345678</td>
        				<td data-title="Name">Aaron</td>
        				<td data-title="Address">24 Trowbridge Rd, Worcester, MA, 01609</td>
        				<td data-title="Day Time Phone">333-444-5555</td>
        			</tr>
        			<tr >
        				<td data-title="Employee ID">12345678</td>
        				<td data-title="Name">Aaron</td>
        				<td data-title="Address">24 Trowbridge Rd, Worcester, MA, 01609</td>
        				<td data-title="Day Time Phone">333-444-5555</td>
        			</tr>
        			<tr >
        				<td data-title="Employee ID">12345678</td>
        				<td data-title="Name">Aaron</td>
        				<td data-title="Address">24 Trowbridge Rd, Worcester, MA, 01609</td>
        				<td data-title="Day Time Phone">333-444-5555</td>
        			</tr>
        			<tr >
        				<td data-title="Employee ID">12345678</td>
        				<td data-title="Name">Aaron</td>
        				<td data-title="Address">24 Trowbridge Rd, Worcester, MA, 01609</td>
        				<td data-title="Day Time Phone">333-444-5555</td>
        			</tr>
        			<tr >
         				<td data-title="Employee ID">12345678</td>
        				<td data-title="Name">Aaron</td>
        				<td data-title="Address">24 Trowbridge Rd, Worcester, MA, 01609</td>
        				<td data-title="Day Time Phone">333-444-5555</td>
        			</tr>
        			<tr >
        				<td data-title="Employee ID">12345678</td>
        				<td data-title="Name">Aaron</td>
        				<td data-title="Address">24 Trowbridge Rd, Worcester, MA, 01609</td>
        				<td data-title="Day Time Phone">333-444-5555</td>
        			</tr>
        			<tr >
        				<td data-title="Employee ID">12345678</td>
        				<td data-title="Name">Aaron</td>
        				<td data-title="Address">24 Trowbridge Rd, Worcester, MA, 01609</td>
        				<td data-title="Day Time Phone">333-444-5555</td>
        			</tr>
        		</tbody>
        	</table>
        </div>
      </div>
            <div id="pane2" class="tab-pane">
          <div class="col-md-12" style="padding:3px">
 	         <input id="filter2" type="text" class="form-control" placeholder="Search..." >
		  </div>
        <div id="no-more-tables" style="padding:3px">
            <table class="col-md-12 table-bordered table-striped table-condensed cf table-hover" style="padding:0px; width: 100%;">
        		<thead class="cf">
        			<tr>
        				<th>Patient ID</th>
        				<th>Name</th>
        				<th>Address</th>
        				<th>Day Time Phone</th>
        			</tr>
        		</thead>
        		<tbody class="searchable2">
        			<tr data-row-key="1">
        				<td data-title="Patient ID">12345678</td>
        				<td data-title="Name">Aaron</td>
        				<td data-title="Address">24 Trowbridge Rd, Worcester, MA, 01609</td>
        				<td data-title="Day Time Phone">333-444-5555</td>
        			</tr>
        			<tr >
        				<td data-title="Patient ID">12345678</td>
        				<td data-title="Name">Aaron</td>
        				<td data-title="Address">24 Trowbridge Rd, Worcester, MA, 01609</td>
        				<td data-title="Day Time Phone">333-444-5555</td>
        			</tr>
        			<tr >
        				<td data-title="Patient ID">12345678</td>
        				<td data-title="Name">Aaron</td>
        				<td data-title="Address">24 Trowbridge Rd, Worcester, MA, 01609</td>
        				<td data-title="Day Time Phone">333-444-5555</td>
        			</tr>
        			<tr >
        				<td data-title="Patient ID">12345678</td>
        				<td data-title="Name">Aaron</td>
        				<td data-title="Address">24 Trowbridge Rd, Worcester, MA, 01609</td>
        				<td data-title="Day Time Phone">333-444-5555</td>
        			</tr>
        			<tr >
         				<td data-title="Patient ID">12345678</td>
        				<td data-title="Name">Aaron</td>
        				<td data-title="Address">24 Trowbridge Rd, Worcester, MA, 01609</td>
        				<td data-title="Day Time Phone">333-444-5555</td>
        			</tr>
        			<tr >
        				<td data-title="Patient ID">12345678</td>
        				<td data-title="Name">Aaron</td>
        				<td data-title="Address">24 Trowbridge Rd, Worcester, MA, 01609</td>
        				<td data-title="Day Time Phone">333-444-5555</td>
        			</tr>
        			<tr >
        				<td data-title="Patient ID">12345678</td>
        				<td data-title="Name">Aaron</td>
        				<td data-title="Address">24 Trowbridge Rd, Worcester, MA, 01609</td>
        				<td data-title="Day Time Phone">333-444-5555</td>
        			</tr>
        		</tbody>
        	</table>
        </div>
      </div>
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
        <h4 class="modal-title" id="myModalLabel">Add Abuser</h4>
      </div>
      <div class="modal-body">
      <!-- Example Table -->
        <div class="row">
          <div class="col-xs-12" style="padding:0px">
            <ul class="nav nav-tabs">
              <li class="active"><a href="#pane1" data-toggle="tab" ><b>Staffs</b></a></li>
              <li><a href="#pane2" data-toggle="tab"><b>Patients</b></a></li>
            </ul>
          </div>
      <div id="addVictim" class="tab-content">
        <div id="pane1" class="tab-pane active">
          <div class="col-md-12" style="padding:3px">
 	         <input id="filter" type="text" class="form-control" placeholder="Search..." >
		  </div>
        <div id="no-more-tables" style="padding:3px">
            <table class="col-md-12 table-bordered table-striped table-condensed cf table-hover" style="padding:0px; width: 100%;">
            
        		<thead class="cf">
        			<tr>
        				<th>Employee ID</th>
        				<th>Name</th>
        				<th>Address</th>
        				<th>Day Time Phone</th>
        			</tr>
        		</thead>
        		<tbody class="searchable">
        			<tr >
        				<td data-title="Employee ID">12345678</td>
        				<td data-title="Name">Aaron</td>
        				<td data-title="Address">24 Trowbridge Rd, Worcester, MA, 01609</td>
        				<td data-title="Day Time Phone">333-444-5555</td>
        			</tr>
        			<tr >
        				<td data-title="Employee ID">12345678</td>
        				<td data-title="Name">Aaron</td>
        				<td data-title="Address">24 Trowbridge Rd, Worcester, MA, 01609</td>
        				<td data-title="Day Time Phone">333-444-5555</td>
        			</tr>
        			<tr >
        				<td data-title="Employee ID">12345678</td>
        				<td data-title="Name">Aaron</td>
        				<td data-title="Address">24 Trowbridge Rd, Worcester, MA, 01609</td>
        				<td data-title="Day Time Phone">333-444-5555</td>
        			</tr>
        			<tr >
        				<td data-title="Employee ID">12345678</td>
        				<td data-title="Name">Aaron</td>
        				<td data-title="Address">24 Trowbridge Rd, Worcester, MA, 01609</td>
        				<td data-title="Day Time Phone">333-444-5555</td>
        			</tr>
        			<tr >
         				<td data-title="Employee ID">12345678</td>
        				<td data-title="Name">Aaron</td>
        				<td data-title="Address">24 Trowbridge Rd, Worcester, MA, 01609</td>
        				<td data-title="Day Time Phone">333-444-5555</td>
        			</tr>
        			<tr >
        				<td data-title="Employee ID">12345678</td>
        				<td data-title="Name">Aaron</td>
        				<td data-title="Address">24 Trowbridge Rd, Worcester, MA, 01609</td>
        				<td data-title="Day Time Phone">333-444-5555</td>
        			</tr>
        			<tr >
        				<td data-title="Employee ID">12345678</td>
        				<td data-title="Name">Aaron</td>
        				<td data-title="Address">24 Trowbridge Rd, Worcester, MA, 01609</td>
        				<td data-title="Day Time Phone">333-444-5555</td>
        			</tr>
        		</tbody>
        	</table>
        </div>
      </div>
            <div id="pane2" class="tab-pane">
          <div class="col-md-12" style="padding:3px">
 	         <input id="filter2" type="text" class="form-control" placeholder="Search..." >
		  </div>
        <div id="no-more-tables" style="padding:3px">
            <table class="col-md-12 table-bordered table-striped table-condensed cf table-hover" style="padding:0px; width: 100%;">
        		<thead class="cf">
        			<tr>
        				<th>Patient ID</th>
        				<th>Name</th>
        				<th>Address</th>
        				<th>Day Time Phone</th>
        			</tr>
        		</thead>
        		<tbody class="searchable2">
        			<tr data-row-key="1">
        				<td data-title="Patient ID">12345678</td>
        				<td data-title="Name">Aaron</td>
        				<td data-title="Address">24 Trowbridge Rd, Worcester, MA, 01609</td>
        				<td data-title="Day Time Phone">333-444-5555</td>
        			</tr>
        			<tr >
        				<td data-title="Patient ID">12345678</td>
        				<td data-title="Name">Aaron</td>
        				<td data-title="Address">24 Trowbridge Rd, Worcester, MA, 01609</td>
        				<td data-title="Day Time Phone">333-444-5555</td>
        			</tr>
        			<tr >
        				<td data-title="Patient ID">12345678</td>
        				<td data-title="Name">Aaron</td>
        				<td data-title="Address">24 Trowbridge Rd, Worcester, MA, 01609</td>
        				<td data-title="Day Time Phone">333-444-5555</td>
        			</tr>
        			<tr >
        				<td data-title="Patient ID">12345678</td>
        				<td data-title="Name">Aaron</td>
        				<td data-title="Address">24 Trowbridge Rd, Worcester, MA, 01609</td>
        				<td data-title="Day Time Phone">333-444-5555</td>
        			</tr>
        			<tr >
         				<td data-title="Patient ID">12345678</td>
        				<td data-title="Name">Aaron</td>
        				<td data-title="Address">24 Trowbridge Rd, Worcester, MA, 01609</td>
        				<td data-title="Day Time Phone">333-444-5555</td>
        			</tr>
        			<tr >
        				<td data-title="Patient ID">12345678</td>
        				<td data-title="Name">Aaron</td>
        				<td data-title="Address">24 Trowbridge Rd, Worcester, MA, 01609</td>
        				<td data-title="Day Time Phone">333-444-5555</td>
        			</tr>
        			<tr >
        				<td data-title="Patient ID">12345678</td>
        				<td data-title="Name">Aaron</td>
        				<td data-title="Address">24 Trowbridge Rd, Worcester, MA, 01609</td>
        				<td data-title="Day Time Phone">333-444-5555</td>
        			</tr>
        		</tbody>
        	</table>
        </div>
      </div>
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

	<script src="http://code.jquery.com/jquery-latest.js"></script>
    <script src="js/bootstrap.js"></script>
    <script src="js/bbGrid.js"></script>
    <script type='text/javascript'>   
		$(document).ready(function () {

		    (function ($) {

		        $('#filter').keyup(function () {

		            var rex = new RegExp($(this).val(), 'i');
		            $('.searchable tr').hide();
		            $('.searchable tr').filter(function () {
		                return rex.test($(this).text());
		            }).show();

		        })

		    }(jQuery));

		});

		$(document).ready(function () {

		    (function ($) {

		        $('#filter2').keyup(function () {

		            var rex = new RegExp($(this).val(), 'i');
		            $('.searchable2 tr').hide();
		            $('.searchable2 tr').filter(function () {
		                return rex.test($(this).text());
		            }).show();

		        })

		    }(jQuery));

		});

		$(document).ready(function(){
		    $('table.table-striped tbody tr').on('click', function () {
		        $(this).closest('table').find('td').removeClass('bg');
		        $(this).find('td').addClass('bg');
		    });
		});
	</script>
    
  </body>
</html>

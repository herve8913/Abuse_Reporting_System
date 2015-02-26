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
          <a class="navbar-brand" href="CreateAbuseReportViewPage.jsp">Abuse Report System</a>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
        	<li class="dropdown">
          	  <a href="#" class="dropdown-toggle" data-toggle="dropdown" ><span class="glyphicon glyphicon-user"></span>System Admin 1<b class="caret"></b></a>
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
                <li ><a href="ApproveAbuseReportViewPage.jsp">Approve Abuse Reports &nbsp;<span class="badge">5</span></a></li>
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
                Approve Abuse Report: 12345678
            </h3> 
          </div>
        </div>
		<div class="row">
      	  <form class="form-horizontal">
			<fieldset>
			<legend>General Information</legend>
				<!-- Button -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="addrepoter">Repoter</label>
				  <div class="col-md-4">
				<p>Name: Aaron</p>
				<p>Address: 24 Trowbridge Rd, Worcester, MA, 01609</p>
				<p>Daytime telephone: 123-456-789</p>
				<button type="button" id="addallegedvictim" name="addallegedvictim" class="btn btn-default" data-toggle="modal" data-target="#myModal1"><span class="glyphicon glyphicon-cog"></span>&nbsp;Change</button>
				  </div>
				</div>
				
				<!-- Multiple Radios (inline) -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="radios">Is the report mandated?</label>
				  <div class="col-md-4"> 
				    <label class="radio-inline" for="radios-0">
				      <input type="radio" name="radios" id="radios-0" value="1">
				      Yes
				    </label> 
				    <label class="radio-inline" for="radios-1">
				      <input type="radio" name="radios" id="radios-1" value="2">
				      No
				    </label>
				  </div>
				</div>
				
				<!-- Select Basic -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="selectbasic">Relationship to Alleged Victim</label>
				  <div class="col-md-4">
				    <select id="selectbasic" name="selectbasic" class="form-control">
				      <option value="1">Supervisor</option>
				      <option value="2">Colleague</option>
				    </select>
				  </div>
				</div>
				
				<!-- Button -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="addallegedvictim">Alleged Victim </label>
				  <div class="col-md-4">
				    <button type="button" id="addallegedvictim" name="addallegedvictim" class="btn btn-default" data-toggle="modal" data-target="#myModal2"><span class="glyphicon glyphicon-plus"></span>&nbsp;Add</button>
				  </div>
				</div>
				
				<!-- Button -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="addallegedabuser">Alleged Abuser</label>
				  <div class="col-md-4">
				    <button type="button" id="addallegedabuser" name="addallegedabuser" class="btn btn-default" data-toggle="modal" data-target="#myModal3"><span class="glyphicon glyphicon-plus"></span>&nbsp;Add</button>
				  </div>
				</div>
				
				<!-- Textarea -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="collateralcontacts">Collateral Contacts or Notifications</label>
				  <div class="col-md-4">                     
				    <textarea class="form-control" id="collateralcontacts" name="collateralcontacts"></textarea>
				  </div>
				</div>
				
				<!-- Select Basic -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="typeofservice">Type of Service</label>
				  <div class="col-md-4">
				    <select id="typeofservice" name="typeofservice" class="form-control">
				      <option value="1">Institutional</option>
				      <option value="2">Residential</option>
				      <option value="3">Day Program</option>
				      <option value="4">Case Management</option>
				      <option value="5">Service Coordination</option>
				      <option value="6">Foster / Spec. Home Care</option>
				      <option value="7">Respite</option>
				      <option value="8">Other</option>
				    </select>
				  </div>
				</div>
				<legend>Abuse Information</legend>
				<!-- Select Basic -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="frequencyofabuse">Frequency of Abuse</label>
				  <div class="col-md-4">
				    <select id="frequencyofabuse" name="frequencyofabuse" class="form-control">
				      <option value="1">Daily</option>
				      <option value="2">Weekly</option>
				      <option value="3">Episodic</option>
				      <option value="4">Increasing</option>
				      <option value="5">Decreasing</option>
				      <option value="6">Constant</option>
				      <option value="7">Unknown</option>
				    </select>
				  </div>
				</div>
				
				<!-- Text input-->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="dataoflastincident">Date of Last Incident</label>  
				  <div class="col-md-4">
				  <input id="dataoflastincident" name="dataoflastincident" type="text" placeholder="mm/dd/yyyy" class="form-control input-md">
				    
				  </div>
				</div>
				
				<!-- Multiple Radios (inline) -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="awareofreport">Is victim aware of report?</label>
				  <div class="col-md-4"> 
				    <label class="radio-inline" for="awareofreport-0">
				      <input type="radio" name="awareofreport" id="awareofreport-0" value="1">
				      Yes
				    </label> 
				    <label class="radio-inline" for="awareofreport-1">
				      <input type="radio" name="awareofreport" id="awareofreport-1" value="2">
				      No
				    </label>
				  </div>
				</div>
				
				<!-- Multiple Checkboxes -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="typesofabuse">Types of Abuse</label>
				  <div class="col-md-4">
				  <div class="checkbox">
				    <label for="typesofabuse-0">
				      <input type="checkbox" name="typesofabuse" id="typesofabuse-0" value="1">
				      Physical
				    </label>
					</div>
				  <div class="checkbox">
				    <label for="typesofabuse-1">
				      <input type="checkbox" name="typesofabuse" id="typesofabuse-1" value="2">
				      Sexual
				    </label>
					</div>
				  <div class="checkbox">
				    <label for="typesofabuse-2">
				      <input type="checkbox" name="typesofabuse" id="typesofabuse-2" value="3">
				      Emotional
				    </label>
					</div>
				  <div class="checkbox">
				    <label for="typesofabuse-3">
				      <input type="checkbox" name="typesofabuse" id="typesofabuse-3" value="4">
				      Omission
				    </label>
					</div>
				  <div class="checkbox">
				    <label for="typesofabuse-4">
				      <input type="checkbox" name="typesofabuse" id="typesofabuse-4" value="5">
				      Other (Please specify)
				    <input id="otherAbuseType" name="textinput" type="text" placeholder="Other abuse type" class="form-control input-md">
				    </label>
					</div>
				  </div>
				</div>
				<legend>Detailed Description</legend>
				<!-- Textarea -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="textarea">In narrative form, please describe the alleged abuse</label>
				  <div class="col-md-4">                     
				    <textarea class="form-control" id="textarea" name="textarea"></textarea>
				  </div>
				</div>
				
				<!-- Textarea -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="textarea">Please describe the level of risk to the alleged victim, including his/her current physical and emotional state</label>
				  <div class="col-md-4">                     
				    <textarea class="form-control" id="textarea" name="textarea"></textarea>
				  </div>
				</div>
				
				<!-- Textarea -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="textarea">Please list any resulting injuries</label>
				  <div class="col-md-4">                     
				    <textarea class="form-control" id="textarea" name="textarea"></textarea>
				  </div>
				</div>
				
				<!-- Textarea -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="textarea">Please list witnesses, if any, including daytime phone numbers</label>
				  <div class="col-md-4">                     
				    <textarea class="form-control" id="textarea" name="textarea"></textarea>
				  </div>
				</div>
				
				<!-- Textarea -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="textarea">Please describe caregiver relationship between the alleged abuser and the alleged victim</label>
				  <div class="col-md-4">                     
				    <textarea class="form-control" id="textarea" name="textarea"></textarea>
				  </div>
				</div>
				
				<!-- Multiple Radios -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="Hotline">Was an oral report filed with the DPPC Hotline?</label>
				  <div class="col-md-4">
				  <div class="radio">
				    <label for="Hotline-0">
				      <input type="radio" name="Hotline" id="Hotline-0" value="1" checked="checked">
				      Yes (Please note date and time of call)
				      <input id="callDateTime" name="textinput" type="text" placeholder="mm/dd/yyyy hh:mm" class="form-control input-md">
				    </label>
					</div>
				  <div class="radio">
				    <label for="Hotline-1">
				      <input type="radio" name="Hotline" id="Hotline-1" value="2">
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
				      <input type="radio" name="Risk" id="Risk-0" value="1" checked="checked">
				      Yes (Please specify)
				      <input id="callDateTime" name="textinput" type="text" placeholder="Risk to the investigator" class="form-control input-md">
				    </label>
					</div>
				  <div class="radio">
				    <label for="Risk-1">
				      <input type="radio" name="Risk" id="Risk-1" value="2">
				      No
				    </label>
					</div>
				  </div>
				</div>
		
				<!-- Button (Double) -->
				<div class="form-group">
				  <label class="col-md-4 control-label" for="save"></label>
				  <div class="col-md-8">
				    <a href="ApproveAbuseReportViewPage.jsp" id="cancel" name="cancel" class="btn btn-default">Cancel</a>
				    <a href="ApproveAbuseReportViewPage.jsp" id="save" name="save" class="btn btn-primary">Save</a>
				    <a href="ApproveAbuseReportViewPage.jsp" id="approve" name="approve" class="btn btn-success">Approval</a>
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
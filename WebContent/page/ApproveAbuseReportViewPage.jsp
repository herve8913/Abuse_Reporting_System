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
                <li ><a href="CreateAbuseReportViewPage.jsp">Create Abuse Report</a></li>
                <li class="active"><a href="ApproveAbuseReportViewPage.jsp">Approve Abuse Reports &nbsp;<span class="badge">5</span></a></li>
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
        <div class="col-xs-12" style="padding:0px">
            <ul class="nav nav-tabs">
    <li class="active"><a href="#pane1" data-toggle="tab" ><b>Submitted Abuse Reports</b>&nbsp;<span class="badge">5</span></a></li>
    <li><a href="#pane2" data-toggle="tab"><b>Approved Abuse Reports</b></a></li>
  </ul>
        </div>
        
      </div>
      <div id="submittedReports" class="tab-content">
      <div id="pane1" class="tab-pane active">
      <br>
        <div id="no-more-tables">
            <table class="col-md-12 table-bordered table-striped table-condensed cf" style="padding:0px; width: 100%;">
        		<thead class="cf">
        			<tr>
        				<th>Abuse Report No.</th>
        				<th>Reporter</th>
        				<th>Status</th>
        				<th>Actions</th>
        				<th>Due Date</th>
        				<th>Operations</th>
        			</tr>
        		</thead>
        		<tbody>
        			<tr>
        				<td data-title="Abuse Report No."><a href="http://www.example.com/" style="font-weight:bold">12345678</a></td>
        				<td data-title="Reporter">Aaron</td>
        				<td data-title="Status">Submitted</td>
        				<td data-title="Actions">
							<div class="progress">
 							<div class="progress-bar" role="progressbar" aria-valuenow="4" aria-valuemin="0" aria-valuemax="8" style="width:50%">4/8</div>
							</div>
        				</td>
        				<td data-title="Due Date">03/12/2014</td>
        				<td data-title="Operations">
        				<div>
					       <button type="button" id="rejectAbuseReport" name="RejectAbuseReport" class="btn btn-danger btn-xs" data-toggle="modal" data-target="#myModal1"><span class="glyphicon glyphicon-remove"></span>&nbsp;Reject</button>
						   <a id="button" class="btn btn-success btn-xs" href="ApproveAbuseReportApprovePage.jsp"><i class="glyphicon glyphicon-ok"></i>&nbsp;Approve</a>						
						</div>
						</td>
        			</tr>
        			        			<tr>
        				<td data-title="Abuse Report No."><a href="http://www.example.com/" style="font-weight:bold">12345678</a></td>
        				<td data-title="Reporter">Aaron</td>
        				<td data-title="Status">Submitted</td>
        				<td data-title="Actions">
							<div class="progress">
 							<div class="progress-bar" role="progressbar" aria-valuenow="4" aria-valuemin="0" aria-valuemax="8" style="width:50%">4/8</div>
							</div>
        				</td>
        				<td data-title="Due Date">03/12/2014</td>
        				<td data-title="Operations">
        				<div>
					       <button type="button" id="rejectAbuseReport" name="RejectAbuseReport" class="btn btn-danger btn-xs" data-toggle="modal" data-target="#myModal1"><span class="glyphicon glyphicon-remove"></span>&nbsp;Reject</button>
						   <a id="button" class="btn btn-success btn-xs" href="ApproveAbuseReportApprovePage.jsp"><i class="glyphicon glyphicon-ok"></i>&nbsp;Approve</a>
						</div>
						</td>
        			</tr>
        			        			<tr>
        				<td data-title="Abuse Report No."><a href="http://www.example.com/" style="font-weight:bold">12345678</a></td>
        				<td data-title="Reporter">Aaron</td>
        				<td data-title="Status">Submitted</td>
        				<td data-title="Actions">
							<div class="progress">
 							<div class="progress-bar" role="progressbar" aria-valuenow="4" aria-valuemin="0" aria-valuemax="8" style="width:50%">4/8</div>
							</div>
        				</td>
        				<td data-title="Due Date">03/12/2014</td>
        				<td data-title="Operations">
        				<div>
					       <button type="button" id="rejectAbuseReport" name="RejectAbuseReport" class="btn btn-danger btn-xs" data-toggle="modal" data-target="#myModal1"><span class="glyphicon glyphicon-remove"></span>&nbsp;Reject</button>
						   <a id="button" class="btn btn-success btn-xs" href="ApproveAbuseReportApprovePage.jsp"><i class="glyphicon glyphicon-ok"></i>&nbsp;Approve</a>
						</div>
						</td>
        			</tr>
        			        			<tr>
        				<td data-title="Abuse Report No."><a href="http://www.example.com/" style="font-weight:bold">12345678</a></td>
        				<td data-title="Reporter">Aaron</td>
        				<td data-title="Status">Submitted</td>
        				<td data-title="Actions">
							<div class="progress">
 							<div class="progress-bar" role="progressbar" aria-valuenow="4" aria-valuemin="0" aria-valuemax="8" style="width:50%">4/8</div>
							</div>
        				</td>
        				<td data-title="Due Date">03/12/2014</td>
        				<td data-title="Operations">
        				<div>
					       <button type="button" id="rejectAbuseReport" name="RejectAbuseReport" class="btn btn-danger btn-xs" data-toggle="modal" data-target="#myModal1"><span class="glyphicon glyphicon-remove"></span>&nbsp;Reject</button>
						   <a id="button" class="btn btn-success btn-xs" href="ApproveAbuseReportApprovePage.jsp"><i class="glyphicon glyphicon-ok"></i>&nbsp;Approve</a>
						</div>
						</td>
        			</tr>
        			        			<tr>
        				<td data-title="Abuse Report No."><a href="http://www.example.com/" style="font-weight:bold">12345678</a></td>
        				<td data-title="Reporter">Aaron</td>
        				<td data-title="Status">Submitted</td>
        				<td data-title="Actions">
							<div class="progress">
 							<div class="progress-bar" role="progressbar" aria-valuenow="4" aria-valuemin="0" aria-valuemax="8" style="width:50%">4/8</div>
							</div>
        				</td>
        				<td data-title="Due Date">03/12/2014</td>
        				<td data-title="Operations">
        				<div>
					       <button type="button" id="rejectAbuseReport" name="RejectAbuseReport" class="btn btn-danger btn-xs" data-toggle="modal" data-target="#myModal1"><span class="glyphicon glyphicon-remove"></span>&nbsp;Reject</button>
						   <a id="button" class="btn btn-success btn-xs" href="ApproveAbuseReportApprovePage.jsp"><i class="glyphicon glyphicon-ok"></i>&nbsp;Approve</a>
						</div>
						</td>
        			</tr>
        		</tbody>
        	</table>
        </div>
      </div>
          <div id="pane2" class="tab-pane">
          <br>
        <div id="no-more-tables">
            <table class="col-md-12 table-bordered table-striped table-condensed cf" style="padding:0px; width: 100%;">
        		<thead class="cf">
        			<tr>
        				<th>Abuse Report No.</th>
        				<th>Reporter</th>
        				<th>Status</th>
        				<th>Actions</th>
        				<th>Due Date</th>
        			</tr>
        		</thead>
        		<tbody>
        			<tr>
        				<td data-title="Abuse Report No."><a href="http://www.example.com/" style="font-weight:bold">12345678</a></td>
        				<td data-title="Reporter">Aaron</td>
        				<td data-title="Status">Approved</td>
        				<td data-title="Actions">
							<div class="progress">
 							<div class="progress-bar" role="progressbar" aria-valuenow="4" aria-valuemin="0" aria-valuemax="8" style="width:50%">4/8</div>
							</div>
        				</td>
        				<td data-title="Due Date">03/12/2014</td>
        			</tr>
        			<tr>
        				<td data-title="Abuse Report No."><a href="http://www.example.com/" style="font-weight:bold">12345678</a></td>
        				<td data-title="Reporter">Aaron</td>
        				<td data-title="Status">Approved</td>
        				<td data-title="Actions">
							<div class="progress">
 							<div class="progress-bar" role="progressbar" aria-valuenow="4" aria-valuemin="0" aria-valuemax="8" style="width:50%">4/8</div>
							</div>
        				</td>
        				<td data-title="Due Date">03/12/2014</td>
        			</tr>
        			<tr>
        				<td data-title="Abuse Report No."><a href="http://www.example.com/" style="font-weight:bold">12345678</a></td>
        				<td data-title="Reporter">Aaron</td>
        				<td data-title="Status">Approved</td>
        				<td data-title="Actions">
							<div class="progress">
 							<div class="progress-bar" role="progressbar" aria-valuenow="4" aria-valuemin="0" aria-valuemax="8" style="width:50%">4/8</div>
							</div>
        				</td>
        				<td data-title="Due Date">03/12/2014</td>
        			</tr>
        			<tr>
        				<td data-title="Abuse Report No."><a href="http://www.example.com/" style="font-weight:bold">12345678</a></td>
        				<td data-title="Reporter">Aaron</td>
        				<td data-title="Status">Approved</td>
        				<td data-title="Actions">
							<div class="progress">
 							<div class="progress-bar" role="progressbar" aria-valuenow="4" aria-valuemin="0" aria-valuemax="8" style="width:50%">4/8</div>
							</div>
        				</td>
        				<td data-title="Due Date">03/12/2014</td>
        			</tr>
        			<tr>
        				<td data-title="Abuse Report No."><a href="http://www.example.com/" style="font-weight:bold">12345678</a></td>
        				<td data-title="Reporter">Aaron</td>
        				<td data-title="Status">Approved</td>
        				<td data-title="Actions">
							<div class="progress">
 							<div class="progress-bar" role="progressbar" aria-valuenow="4" aria-valuemin="0" aria-valuemax="8" style="width:50%">4/8</div>
							</div>
        				</td>
        				<td data-title="Due Date">03/12/2014</td>
        			</tr>
        			<tr>
        				<td data-title="Abuse Report No."><a href="http://www.example.com/" style="font-weight:bold">12345678</a></td>
        				<td data-title="Reporter">Aaron</td>
        				<td data-title="Status">Approved</td>
        				<td data-title="Actions">
							<div class="progress">
 							<div class="progress-bar" role="progressbar" aria-valuenow="4" aria-valuemin="0" aria-valuemax="8" style="width:50%">4/8</div>
							</div>
        				</td>
        				<td data-title="Due Date">03/12/2014</td>
        			</tr>
        			<tr>
        				<td data-title="Abuse Report No."><a href="http://www.example.com/" style="font-weight:bold">12345678</a></td>
        				<td data-title="Reporter">Aaron</td>
        				<td data-title="Status">Approved</td>
        				<td data-title="Actions">
							<div class="progress">
 							<div class="progress-bar" role="progressbar" aria-valuenow="4" aria-valuemin="0" aria-valuemax="8" style="width:50%">4/8</div>
							</div>
        				</td>
        				<td data-title="Due Date">03/12/2014</td>
        			</tr>
        			<tr>
        				<td data-title="Abuse Report No."><a href="http://www.example.com/" style="font-weight:bold">12345678</a></td>
        				<td data-title="Reporter">Aaron</td>
        				<td data-title="Status">Approved</td>
        				<td data-title="Actions">
							<div class="progress">
 							<div class="progress-bar" role="progressbar" aria-valuenow="4" aria-valuemin="0" aria-valuemax="8" style="width:50%">4/8</div>
							</div>
        				</td>
        				<td data-title="Due Date">03/12/2014</td>
        			</tr>
        		</tbody>
        	</table>
        </div>
      </div>
    </div>
   </div> 
    </div> 
        <!-- Modal 1-->
<div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Confirmation</h4>
      </div>
      <div class="modal-body">
      <h4><span class="glyphicon glyphicon-warning-sign"></span>&nbsp;Are you sure you want to reject abuse report: <b>12345678</b> ?</h4>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
        <button type="button" class="btn btn-primary">Yes</button>
      </div>
    </div>
  </div>
</div>
    <script src="js/jquery-1.11.0.js"></script>
    <script src="js/bootstrap.js"></script>
  </body>
</html>
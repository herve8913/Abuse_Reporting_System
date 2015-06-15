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
            <li class="dropdown">
            	<a href="#" class="dropdown-toggle" data-toggle="dropdown">Report Abuse &nbsp;<span class="badge"><%=session.getAttribute("submittedreport") %></span><b class="caret"></b></a>
            <ul class="dropdown-menu">
                <li><a href="CreateAbuseReportViewPage.jsp">Create Abuse Report</a></li>
                <li ><a href="<%= response.encodeUrl(request.getContextPath() + "/ApproveReport?action=approveabusereport") %>">Approve Abuse Reports &nbsp;<span class="badge"><%=session.getAttribute("submittedreport") %></span></a></li>
              </ul><%}else if (userType==3){ %>
              <li><a href="CreateAbuseReportViewPage.jsp">Create Abuse Report</a></li><%} %>
              <%if(userType==2){ %>
            <li class="active" ><a href="<%= response.encodeUrl(request.getContextPath() + "/Controller?action=track") %>">Track Reports</a></li><%} %>
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
    <%@page import="java.util.List, bean.*" %>
    <div class="container" style="padding-top:80px">
<div class="container">
<div class="row">
        <div class="col-xs-12" style="padding:0px">
            <h3 class="text-left">
                Track Abuse Reports
            </h3> 
        </div>
      </div>
    <div class="row">
        <div class="col-md-8" style="padding:3px">
        </div>
        <div class="col-md-4" style="padding:3px">
 			 <input id="filter" type="text" class="form-control" placeholder="Search..." >
		</div>
          <%List<AbuseReport> listOfApproveReport = (List<AbuseReport>) request.getAttribute("listOfApproveReport"); %>
          <br>
        <div id="no-more-tables">
            <table class="col-md-12 table-bordered table-striped table-condensed cf" style="padding:0px; width: 100%;">
        		<thead class="cf">
        			<tr>
        				<th>Abuse Report No.</th>
        				<th>Disposition Letter</th>
        				<th>Decision Letter</th>
        				<th>Appeal Letter</th>
        				<th>Reporter</th>
        				<th>Actions</th>
        				<th>Due Date</th>
        			</tr>
        		</thead>
        		<tbody class="searchable" >
        			<%
        			for (AbuseReport abuseReport:listOfApproveReport){ %><tr>
        				<td data-title="Abuse Report No."><a href="<%= response.encodeUrl(request.getContextPath() + "/Controller?action=viewabusereportpage&&reportId="+abuseReport.getId()) %>" style="font-weight:bold"><%=abuseReport.getLogNumber() %></a></td>
        				<%if(abuseReport.getStatus()==3) {%><td data-title="Disposition Letter"></td>
        				<%} else if(abuseReport.getStatus()>3){%>
        				<td><a href="<%= response.encodeUrl(request.getContextPath() + "/AbuseReportFiles/"+abuseReport.getDispositionLetter()) %>" style="font-weight:bold" target="_blank"><%=abuseReport.getDispositionLetter() %></a></td>
        				<%} %>
        				
        				<%if(abuseReport.getStatus()<=4){ %><td data-title="Decision Letter"></td>      			
        				<%}else if(abuseReport.getStatus()>4){ %>
        				<td><a href="<%= response.encodeUrl(request.getContextPath() + "/AbuseReportFiles/"+abuseReport.getDecisionLetter()) %>" style="font-weight:bold" target="_blank"><%=abuseReport.getDecisionLetter() %></a></td>
        				<%}%>
        				
        				<%if (abuseReport.getStatus()==5) {%><td></td><%} 
        				else if (abuseReport.getStatus()>5){%>
        				<td><a href="<%= response.encodeUrl(request.getContextPath() + "/AbuseReportFiles/"+abuseReport.getAppealLetter()) %>" style="font-weight:bold" target="_blank"><%=abuseReport.getAppealLetter() %></a></td>
        				
        				<%} else if (abuseReport.getStatus()<5) {%>
        				<td></td>
        				<%} %>
        				<td data-title="Reporter"><%=abuseReport.getReporterName() %></td>
        				<td data-title="Actions">
							<div class="progress">
 							<div class="progress-bar" role="progressbar" aria-valuenow="<%=abuseReport.getStatus() %>" aria-valuemin="0" aria-valuemax="6" style="width:<%=(abuseReport.getStatus()/(double)6)*100%>%"><%=abuseReport.getStatus() %>/6</div>
							</div>
        				</td>
        				<td data-title="Due Date"><%if(abuseReport.getDueDate()!=null){%><%=abuseReport.getDueDate()%><%} %></td>
        			</tr>
        			<%} %>
        			
        		</tbody>
        	</table>
        </div>
        </div>
      </div>
    </div>
   </div> 
    </div> 
     
              <!-- Modal 2-->
<div class="modal fade" id="uploaddisposition" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Add Disposition Letter</h4>
      </div>
      <form class="form-horizontal" method="post" action="<%= response.encodeUrl(request.getContextPath() + "/upload") %>" enctype="multipart/form-data">
	  <input type="hidden" name="reportId" id="reportId" value="" />
      <input type="hidden" name="typeofletter" value="1" />
      <fieldset>
      <div class="modal-body">
      <b>Please choose a local file to add:</b></br></br>                   
			    <input id="filebutton3" name="action5" class="input-file" type="file">
       </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
        <input type="submit" class="btn btn-primary" value="Upload"></input>
      </div>
      </fieldset>
      </form>
    </div>
  </div>
</div>

           <!-- Modal 3-->
<div class="modal fade" id="uploaddecision" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Add Decision Letter</h4>
      </div>
      <form class="form-horizontal" method="post" action="<%= response.encodeUrl(request.getContextPath() + "/upload") %>" enctype="multipart/form-data">
	  <input type="hidden" name="reportId" id="reportId2" value="" />
      <input type="hidden" name="typeofletter" value="2" />
      <fieldset>
      <div class="modal-body">
      <b>Please choose a local file to add:</b></br></br>                   
			    <input id="filebutton3" name="action5" class="input-file" type="file">
       </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
        <input type="submit" class="btn btn-primary" value="Upload"></input>
      </div>
      </fieldset>
      </form>
    </div>
  </div>
</div>
   
        <!-- Modal 4-->
<div class="modal fade" id="uploadappeal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Add Appeal Letter</h4>
      </div>
      <form class="form-horizontal" method="post" action="<%= response.encodeUrl(request.getContextPath() + "/upload") %>" enctype="multipart/form-data">
	  <input type="hidden" name="reportId" id="reportId3" value="" />
      <input type="hidden" name="typeofletter" value="3" />
      <fieldset>
      <div class="modal-body">
      <b>Please choose a local file to add:</b></br></br>                   
			    <input id="filebutton3" name="action5" class="input-file" type="file">
       </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
        <input type="submit" class="btn btn-primary" value="Upload"></input>
      </div>
      </fieldset>
      </form>
    </div>
  </div>
</div>
    <script type='text/javascript' src="js/jquery-1.11.0.js"></script>
    <script type='text/javascript' src="js/bootstrap.js"></script>
    
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

		$('.table-hover tr').click(function() {
		    var rowId = $(this).data("rowKey");
		    alert(rowId);
		});
</script>

 <script type='text/javascript'>   
 $(document).ready(function(){
	   $(".disposition").click(function(){ // Click to only happen on disposition links
	     $("#reportId").val($(this).data('id'));
	     $('#uploaddisposition').modal('show');
	   });
	});
 </script>
 <script type='text/javascript'>   
 $(document).ready(function(){
	   $(".decision").click(function(){ // Click to only happen on disposition links
	     $("#reportId2").val($(this).data('id'));
	     $('#uploaddecision').modal('show');
	   });
	});
 </script>
 <script type='text/javascript'>   
 $(document).ready(function(){
	   $(".appeal").click(function(){ // Click to only happen on disposition links
	     $("#reportId3").val($(this).data('id'));
	     $('#uploadappeal').modal('show');
	   });
	});
 </script>
  </body>
</html>>
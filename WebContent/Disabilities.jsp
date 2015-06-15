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
            <li class="dropdown active">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Admin Panel<b class="caret"></b></a>
            <ul class="dropdown-menu">
                <li ><a href="<%= response.encodeUrl(request.getContextPath() + "/CreateUser?action=user") %>">Users</a></li>
                <li ><a href="<%= response.encodeUrl(request.getContextPath() + "/CreatePatient?action=patient") %>">Patients</a></li>
                <li ><a href="<%= response.encodeUrl(request.getContextPath() + "/CreateHomeGroup?action=homegroup") %>">Home Groups</a></li>
                <li class="active"><a href="<%= response.encodeUrl(request.getContextPath() + "/CreateDisability?action=disability") %>">Disabilities</a></li>
                <li ><a href="<%= response.encodeUrl(request.getContextPath() + "/CreateDrug?action=drug") %>">Drugs</a></li>
              </ul>
            </li><%} %>
          </ul>

        </div><!--/.nav-collapse -->
      </div>
    </div>  
  <!------------------------------------------- Nevigation Bar End-------------------------------------------------------------->
<%@page import="java.util.List,bean.*" %>
<%List<Disability> listOfDisability = (List<Disability>) request.getAttribute("listOfDisability");%>
    <div class="container" style="padding-top:80px">
<div class="container">
    <div class="row">
        <div class="col-xs-6" style="padding:0px">
            <h3 class="text-left">
                Disabilities
            </h3> 
        </div>
        <div class="col-xs-6" style="padding:0px">
            <h3 class="text-right">
            </h3> 
        </div>
      </div>
      <div class="row">
      	  <div class="col-md-8" style="padding:3px">
      	  <a id="btn-create" type="button" class="btn btn-primary" href="<%= response.encodeUrl(request.getContextPath() + "/CreateDisability?action=newdisability") %>"><i class="glyphicon glyphicon-plus"></i>&nbsp;New Disability</a>
        </div>
        <div class="col-md-4" style="padding:3px">
 			 <input id="filter" type="text" class="form-control" placeholder="Search..." >
		</div>
        <div id="no-more-tables" style="padding:3px"> 		               
            <table class="col-md-12 table-bordered table-striped table-condensed cf " style="padding:0px; width: 100%;">
        		<thead class="cf">
        			<tr>
        				<th>Disability ID</th>
        				<th>Status</th>
        				<th>Disability Name</th>
        				<th>Disability Description</th>
        				<th>Disability Type</th>
        				<th>Operations</th>
        			</tr>
        		</thead>
        		<tbody class="searchable">
        			<%int i=0;
        			for(Disability disability: listOfDisability) {i++;%><tr >
        				<td data-title="Disability ID"><%=disability.getId()%></td>
        				<td data-title="Status"><%=disability.getStatus() %></td>
        				<td data-title="Disability Name"><%=disability.getName()%></td>
        				<td data-title="Disability Description"><%=disability.getDescription()%></td>
        				<td data-title="Disability Type"><%=disability.getType()%></td>
        				<td data-title="Operations">
        				<div>
					    <button type="button" id="deleteAbuseReport" name="DeleteAbuseReport" class="btn btn-danger btn-xs" data-toggle="modal" data-target="#myModal<%=i%>"><span class="glyphicon glyphicon-trash"></span>&nbsp;Delete</button>
						<a id="button" class="btn btn-primary btn-xs" href="<%= response.encodeUrl(request.getContextPath() + "/CreateDisability?action=updatedisability&disabilityId="+disability.getId()) %>"><i class="glyphicon glyphicon-cog"></i>&nbsp;Modify</a>
						</div>
						</td>
        			</tr><%} %>
        			        			
        		</tbody>
        	</table>
        </div>
    </div>
</div>  
    </div> 
	<!-- Modal 1-->
    <%int j=0;
    for(Disability disability:listOfDisability){ j++;%>
<div class="modal fade" id="myModal<%=j %>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
  <form method="post" action="<%= response.encodeUrl(request.getContextPath() + "/CreateDisability?action=dodeletedisability") %>">
  <input type= "hidden" name="disabilityid" value="<%=disability.getId()%>"></input>
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">Confirmation</h4>
      </div>
      <div class="modal-body">
      <h4><span class="glyphicon glyphicon-exclamation-sign"></span>&nbsp;Are you sure you want to delete the Disability: <b><%=disability.getName()%></b> ?</h4>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
        <input type="submit" value= "Yes" class="btn btn-primary"></input>
      </div>
    </div>
    </form>
  </div>
</div><%} %>    
    
    <script src="js/jquery-1.11.0.js"></script>
    <script src="js/bootstrap.js"></script>
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
    
  </body>
</html>
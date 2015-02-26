<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>

<style  type="text/css">

#content { position: relative;}

#login {
	position: relative;
	top: 80px;
}

.align-right {
	text-align: right;
}

table {
	border: 1px solid gray;
	padding: 20px;
	background-color: #CCCCFF;
}

.login-error {
	font-size: 16px;
	font-weight: bold;
	font-color: red;
}


</style>

</head>
<body>

<center>

<div id="login">

<h3>Search</h3>

<form method="post" action="<%= response.encodeUrl(request.getContextPath() + "/Controller?action=dosearch") %>">

<input type="hidden" name="action" value="dosearch" />

<table>

<tr><td class="align-right">Drug name: </td><td><input type="text" name="drugName" value="<%= request.getAttribute("drugName") %>"/></td></tr>
<tr><td class="align-right" colspan="2"><input type="submit" value="Search"/></td></tr>

</table>

<p class="login-error"><%= request.getAttribute("message") %></p>

</form>

</div>


</center>


</body>
</html>
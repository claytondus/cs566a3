<!doctype html>

<html>
<head>
	<cfoutput><title>CS566: #rc.pagetitle#<cfif session.secret> (SECRET)</cfif></title></cfoutput>
	<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
	<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" rel="stylesheet" crossorigin="anonymous">
</head>

<body>
<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="#">CS566</a>
    </div>
    <ul class="nav navbar-nav">
      <li><a href="/">Home</a></li>
      <li><a href="/user/register">Register</a></li>
      <li><a href="/user/login">Login</a></li>
			<cfif session.user neq "">
      	<li><a href="/message/add">Add Message</a></li>
      	<li><a href="/message/list">List Messages</a></li>
      	<li><a href="/user/logout">Logout</a></li>
      </cfif>
    </ul>
  </div>
</nav>

<div class="container">
	<cfoutput>
	<cfif rc.keyExists('warning')>
		<div class="alert alert-danger">
			#rc.warning#
		</div>
	</cfif>
	<cfif rc.keyExists('success')>
		<div class="alert alert-success">
			#rc.success#
		</div>
	</cfif>

	<h1>#rc.pagetitle#<cfif session.secret> (SECRET)</cfif></h1>
  #body#
	</cfoutput>
</div>

</body>

</html>

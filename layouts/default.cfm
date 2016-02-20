<!doctype html>

<html>
<head>
	<title>CS566:</title>
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
      <li><a href="/message/list">List Messages</a></li>
      <li><a href="/message/add">Add Message</a></li>
      <cfif session.user neq "">
	<li><a href="/user/logout">Logout</a></li>
      </cfif>
    </ul>
  </div>
</nav>
  
<div class="container">
  <cfoutput>#body#</cfoutput>
</div>
</body>

</html>

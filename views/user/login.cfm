<cfif session.user eq "">
	<form name="login" method="POST">
		<div class="form-group">
			<label>Username<input type="text" name="username" class="form-control"/></label>
		</div>
		<div class="form-group">
			<label>Password<input type="password" name="password" class="form-control"/></label>
		</div>
		<input type="submit" class="btn btn-default" name="submit" value="Login"/>
	</form>
<cfelse>
	<h4><cfoutput>Welcome #session.user#!</cfoutput></h4>
</cfif>

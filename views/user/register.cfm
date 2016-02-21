<cfif rc.method eq "GET">
	<form name="register" method="POST">
		<div class="form-group">
			<label>Username<input type="text" name="username" class="form-control"/></label>
		</div>
		<div class="form-group">
			<label>Password<input type="password" name="password" class="form-control"/></label>
		</div>
		<div class="form-group">
			<label>Confirm<input type="password" name="password_confirm" class="form-control"/></label>
		</div>
		<input class="btn btn-default" type="submit" name="submit" value="Register"/>
	</form>
<cfelse>
	<a href="/user/login">Login</a>
</cfif>

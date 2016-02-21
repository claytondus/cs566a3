<cfif session.user neq "">
  <form name="create-message" method="POST">
  	<div class="form-group">
  		<label>Title<input type="text" name="title" class="form-control"/></label>
  	</div>
  	<div class="form-group">
  		<label>Message<textarea name="message" rows="10" cols="40" class="form-control"></textarea></label>
  	</div>
  	<input class="btn btn-default" type="submit" name="submit" value="Submit"/>
  </form>
</cfif>

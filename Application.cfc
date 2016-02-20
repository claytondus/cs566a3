component extends=framework.one {


	function onSessionStart() {
		param name="session.user" default="";
		param name="session.knock" default="";
	}
}


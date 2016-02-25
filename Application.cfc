component extends=framework.one {

	this.datasources.cs566 = {
		class: "org.h2.Driver",
		connectionString: "jdbc:h2:/tmp/cdavi151/cs566;MODE=MySQL"
	};

	function setupApplication() {
		query name="setupDb" datasource="cs566" {
			echo("CREATE TABLE IF NOT EXISTS Users(id INT IDENTITY, username VARCHAR(255), hash VARCHAR(255));")
			echo("CREATE TABLE IF NOT EXISTS Messages(id INT IDENTITY, username VARCHAR(255), title VARCHAR(1024), message VARCHAR(4096), secret BOOL);")
		}
	}

	function before(struct rc) {
		param name="application.knockPages" default="#{"0":"/user/register","1":"/user/login","2":"/message/add","3":"/message/list"}#";
		param name="session.user" default="";
		param name="session.knockSequence" default="#[-1,-1,-1,-1]#";
		param name="session.knockHistory" default="#[-2,-2,-2,-2]#";
		param name="session.secret" default=0;
		param name="rc.pagetitle" default="";
		param name="rc.method" default=cgi.request_method;
		rc.knockResult = processKnock();
	}

	function processKnock() {
		var result = [];
		result.append("Entering process fn");
		if(session.user neq "" and session.secret neq 1) {
			result.append("User is logged in and not secret");
			appendHistory();
			if (session.knockSequence.equals(session.knockHistory)) {
				result.append("Entering secret mode");
				session.secret = 1;
			}
		}
		return result;
	}

	function appendHistory() {
		var actionId = application.knockPages.findValue(cgi.path_info);
		session.actionId = actionId;
		if (actionId.len() eq 0) {
			return;
		}
		session.knockHistory.deleteAt(1);
		session.knockHistory.append(actionId[1].Key);
	}

}

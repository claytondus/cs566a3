component extends=framework.one {

	this.datasources.cs566 = {
		class: "org.h2.Driver",
		connectionString: "jdbc:h2:/tmp/cdavi151/cs566;MODE=MySQL"
	};

	variables.framework.reloadApplicationOnEveryRequest = true;

	function setupApplication() {
		query name="setupDb" datasource="cs566" {
			//echo("DROP TABLE IF EXISTS Users;")
			//echo("DROP TABLE IF EXISTS Messages;");
			echo("CREATE TABLE IF NOT EXISTS Users(id INT IDENTITY, username VARCHAR(255), hash VARCHAR(255));")
			echo("CREATE TABLE IF NOT EXISTS Messages(id INT IDENTITY, username VARCHAR(255), title VARCHAR(1024), message VARCHAR(4096), secret BOOL);")
		}
	}

	function before(struct rc) {
		param name="session.user" default="";
		param name="session.knockSequence" default="";
		param name="session.knockStep" default=1;
		param name="session.secret" default=0;
		param name="rc.pagetitle" default="";
		param name="rc.method" default=cgi.request_method;
	}


}

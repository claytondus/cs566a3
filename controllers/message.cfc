component extends="baseCtrl"{

  function init(fw) {
    variables.fw = fw;
    return this;
  }

  function before(struct rc) {
    if(session.user eq "") {
      rc.warning = "You must be logged in.";
    }
  }

  function add(struct rc) {
    if(rc.method eq "GET") {
      rc.knockResult = processKnock(2);
    }
    rc.pagetitle = "Add Message";
    if (rc.method eq "POST") {
      query name="rc.add" datasource="cs566" {
        echo("INSERT INTO Messages SET message = ");
        queryparam value=esapiEncode('html',rc.message);
        echo(", title = ");
        queryparam value=esapiEncode('html',rc.title);
        echo(", username = ");
        queryparam value=session.user;
        echo(", secret = ");
        queryparam value=session.secret cfsqltype="CF_SQL_BOOLEAN";
      }
      location url="/message/list" addtoken="no";
    }
  }

  function list(struct rc) {
    if(rc.method eq "GET") {
      rc.knockResult = processKnock(3);
    }
    rc.pagetitle = "List Messages";
    if(session.user neq "") {
      query name="rc.messages" datasource="cs566" {
        echo("select * from messages where secret = ");
        queryparam value=session.secret cfsqltype="CF_SQL_BOOLEAN";
        echo(";");
      }
    }

  }
}

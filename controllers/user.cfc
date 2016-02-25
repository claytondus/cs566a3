component {

  function init(fw) {
    variables.fw = fw;
    return this;
  }

  function register(struct rc) {
    rc.pagetitle = "Register User";
    if(rc.method eq "POST") {
      query name="checkName" datasource="cs566" {
        echo("select * from Users where username = ");
        queryparam value=rc.username;
      }
      if (checkName.recordCount gt 0) {
        rc.warning = "Username "&rc.username&" already exists.";
        return;
      }
      if (rc.password neq rc.password_confirm) {
        rc.warning = "Passwords must match.";
        return;
      }
      query name="register" datasource="cs566" {
        echo("insert into Users set username = ");
        queryparam value=rc.username;
        echo(", hash = ");
        queryparam value=hash(rc.password,"sha-512");
      }
      rc.success = "User "&rc.username&" registered.  You may now log in.";
    }
  }

  function login(struct rc) {
    rc.pagetitle = "Login";
    if(rc.method eq "POST") {
      rc.hash = hash(rc.password,"sha-512");
      query name="checkPassword" datasource="cs566" {
        echo("select * from Users where username = ");
        queryparam value=rc.username;
        echo(" AND hash = ");
        queryparam value=rc.hash;
      }
      if(checkPassword.recordCount eq 0) {
        rc.warning = "Username and/or password is not correct.";
        return;
      }
      session.user = rc.username;
      rc.knockPointers = left(hash(rc.username, "md5"),4);
      rc.knockSequence = [];
      loop index="i" from="1" to="4" {
        rc.knockSequence[i] = inputBaseN(mid(rc.knockPointers, i, 1), 16) % 4;
      }
      session.knockSequence = rc.knockSequence;
    }

  }

  function logout(struct rc) {
    session.user = "";
    session.secret = 0;
    session.knockSequence = [-1,-1,-1,-1];
    session.knockHistory = [-2,-2,-2,-2];
  }

}

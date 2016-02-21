component {
  function processKnock(actionId) {
    var result = [];
    result.append("Entering process fn");
    if(session.user neq "" and session.secret neq 1) {
      result.append("User is logged in and not secret");
      if(session.knockStep gt 2) {
        if((session.knockSequence[session.knockStep-1] eq session.knockSequence[session.knockStep]) and (session.knockSequence[session.knockStep-1] eq actionId)) {
          result.append("Staying on same step");
          return result;
        }
      }
      if (actionId eq session.knockSequence[session.knockStep]) {
        result.append("Incrementing knockStep");
        session.knockStep++;
      }
      else {
        result.append("Resetting knockStep, action="&actionId&", sequence="&session.knockSequence[session.knockStep]);
        session.knockStep = 1;
      }
      if (session.knockStep eq 5) {
        result.append("Entering secret mode");
        session.secret = 1;
        session.knockStep = 1;
      }
    }
    return result;
  }
}

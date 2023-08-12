/*********************************************************************************************************
	Copyright: © 2015-2023 Ozan Nurettin Süel (Sicherheitsschmiede)                                        
	License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.  
	Authors: Ozan Nurettin Süel (Sicherheitsschmiede)                                                      
**********************************************************************************************************/
module uim.servers.classes.controllers.actions.login;

import uim.servers;
@safe:

class DLoginActionController : DActionController {
  mixin(ControllerThis!("LoginActionController"));

  override void initialize(Json configSettings = Json(null)) {
    super.initialize(configSettings); 

    /* this
    //.nextUrl("/login2") 
      .addChecks(DatabaseHasLoginsCheck, DatabaseHasSessionsCheck); */ 
  }

  override bool beforeResponse(STRINGAA options = null) {
    debug writeln("x1x");
    debug writeln(moduleName!DLoginActionController~":DLoginActionController("~this.name~")::beforeResponse");
    if (!super.beforeResponse(options)) { return false; }
    debug writeln(options);

    // Delete old Session
    if (this.request.session) this.response.terminateSession();
    string httpSessionId = options.get("httpSessionId", null);     
    if (hasSession(httpSessionId)) {
      removeSession(httpSessionId);
    }
    options.remove("httpSessionId");     
        
    // httpSession missing, create new one
    debug writeln(moduleName!DLoginActionController~":DLoginActionController::beforeResponse -> Read httpSession");
    auto httpSession = this.response.startSession();

    auto mySession = new DSession(httpSession);
    addSession(httpSession.id, mySession);
    options["httpSessionId"] = httpSession.id;

    // Create login and session object 
    mySession.lastAccessedOn = toTimestamp(now());
    mySession.accountName = options.get("accountName", null);
    mySession.host = options.get("host", null);
    mySession.loginId = to!string(uniform(0, 1024));
    mySession.logonMode = false;
    debug writeln(mySession.debugInfo);
    debug writeln(moduleName!DLoginActionController~":DLoginActionController("~this.name~")::beforeResponse -> New login entity");
    
    /* if (auto myTenant = (entityBase ? entityBase.tenant("systems") : null)) {
      this.logins = myTenant["system_logins"];

      auto login = this.logins.createFromTemplate;
      login.lastAccessedOn = lastAccessedOn;
      
      auto accountName = options.get("accountName", "");
      login["accountName"] = accountName;    
      this.logins.insertOne(login);
      this.session.login = this.logins.findOne(login.id);
      if (!this.session.login) {
        debug writeln("No session.login for id ", login.id);
        return false; 
      }

      debug writeln(moduleName!DLoginActionController~":DLoginActionController::beforeResponse -> New session entity");
      auto session = this.sessions.createFromTemplate;
      session.lastAccessedOn = lastAccessedOn;
      session["loginId"] = login.id;    
      this.sessions.insertOne(session);
      this.session.session = this.sessions.findOne(session.id);
      if (!this.session.session) // debug writeln("No session.session for id ", session.id);

      debug writeln(moduleName!DLoginActionController~":DLoginActionController::beforeResponse -> Go to login2");
      options["redirect"] = "/login2?loginId="~this.session.login.id.toString; 
      debug writeln(this.session.debugInfo); 
    } */

    options["redirect"] = "/login2?loginId="~mySession.loginId; 
    return true;
  }
}
mixin(ControllerCalls!("LoginActionController"));

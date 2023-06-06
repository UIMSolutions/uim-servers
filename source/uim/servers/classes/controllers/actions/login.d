/*********************************************************************************************************
	Copyright: © 2015-2023 Ozan Nurettin Süel (Sicherheitsschmiede)                                        
	License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.  
	Authors: Ozan Nurettin Süel (Sicherheitsschmiede)                                                      
**********************************************************************************************************/
module uim.servers.classes.controllers.actions.login;

import uim.servers;
@safe:

class DLoginActionController : DSystemActionController {
  mixin(ControllerThis!("LoginActionController"));

  override void initialize(Json configSettings = Json(null)) {
    super.initialize(configSettings); 

    this
    //.nextUrl("/login2") 
    .checks([DatabaseHasLoginsCheck, DatabaseHasSessionsCheck]); 
  }

  override void beforeResponse(STRINGAA options = null) {
    debug writeln(moduleName!DLoginActionController~":DLoginActionController("~this.name~")::beforeResponse");
    super.beforeResponse(options);    
    if (hasError || "redirect" in options) { return; }

    debug writeln("0");
    // New Session
    if (this.request.session) this.response.terminateSession();
    string appSessionId = options.get("appSessionId", "");     
    if (appSessionId in appSessions) appSessions.remove(appSessionId);
    options.remove("appSessionId");     
        
    debug writeln("1");
    // appSession missing, create new one
    debug writeln(moduleName!DLoginActionController~":DLoginActionController::beforeResponse -> Read httpSession");
    auto httpSession = this.response.startSession();
    appSessions[httpSession.id] = new DMVCSession(httpSession);
    options["appSessionId"] = httpSession.id;

    debug writeln("2");
    // Create login and session object 
    this.session(appSessions[httpSession.id]);
    auto lastAccessedOn = toTimestamp(now());
    debug writeln(moduleName!DLoginActionController~":DLoginActionController("~this.name~")::beforeResponse -> New login entity");
    
    if (auto myTenant = (database ? database["systems"] : null)) {
      this.logins = myTenant["system_logins"];

      auto login = this.logins.createFromTemplate;
      login.lastAccessedOn = lastAccessedOn;
      
      auto accountName = options.get("accountName", "");
      login["accountName"] = accountName;    
      this.logins.insertOne(login);
      this.session.login = this.logins.findOne(login.id);
      if (!this.session.login) {
        debug writeln("No session.login for id ", login.id);
        return; 
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
    }
  }
}
mixin(ControllerCalls!("LoginActionController"));

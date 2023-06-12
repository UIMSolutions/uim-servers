/*********************************************************************************************************
	Copyright: © 2015-2023 Ozan Nurettin Süel (Sicherheitsschmiede)                                        
	License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.  
	Authors: Ozan Nurettin Süel (Sicherheitsschmiede)                                                      
**********************************************************************************************************/
module uim.servers.classes.controllers.components.checks.sessions.session;

import uim.servers;
@safe:

class DSessionHasSessionCheck : DSessionExistsCheck {
  mixin(ControllerComponentThis!("SessionHasSessionCheck"));

  override void initialize(Json configSettings = Json(null)) {
    super.initialize(configSettings);

    this
    .redirectUrl("/login");
  }
  
  override bool execute(STRINGAA options = null) {
    debug writeln(moduleName!DSessionHasSessionCheck~":DSessionHasSessionCheck::execute");
    if (!super.execute(options)) { return false; }

    auto myController = cast(DController)manager;
    auto mySessionManager = myController.sessionManager;

    auto session = getInternalSession(options).session;
    if (!session) { // session missing 
      this.error("appsession_session_missing");
      return false; 
    }

    return true;
  }
}
mixin(ControllerComponentCalls!("SessionHasSessionCheck"));

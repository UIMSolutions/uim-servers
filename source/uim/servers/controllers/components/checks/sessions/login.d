/*********************************************************************************************************
	Copyright: © 2015-2023 Ozan Nurettin Süel (Sicherheitsschmiede)                                        
	License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.  
	Authors: Ozan Nurettin Süel (Sicherheitsschmiede)                                                      
**********************************************************************************************************/
module uim.servers.controllers.checks.sessions.login;

@safe:
import uim.servers;

class DSessionHasLoginCheck : DSessionExistsCheck {
  mixin(ControllerComponentThis!("SessionHasLoginCheck"));

  override void initialize(Json configSettings = Json(null)) {
    super.initialize(configSettings);

    this
    .redirectUrl("/login");
  }
  
  override bool execute(STRINGAA options = null) {
    debug writeln(moduleName!DSessionHasLoginCheck~":DSessionHasLoginCheck::check");
    if (!super.execute(options)) { return false; }

    auto login = getSession(options).login;
    if (!login) { // login missing 
      this.error("appsession_login_missing");
      return false; 
    }

    debug writeln(moduleName!DSessionHasLoginCheck~":DSessionHasLoginCheck::check -> session.login found -> ", login.id);
    return true;
  }
}
mixin(ControllerComponentCalls!("SessionHasLoginCheck"));
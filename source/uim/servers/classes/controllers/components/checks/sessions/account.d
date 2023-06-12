/*********************************************************************************************************
	Copyright: © 2015-2023 Ozan Nurettin Süel (Sicherheitsschmiede)                                        
	License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.  
	Authors: Ozan Nurettin Süel (Sicherheitsschmiede)                                                      
**********************************************************************************************************/
module uim.servers.classes.controllers.components.checks.sessions.account;

import uim.servers;
@safe:

class DSessionHasAccountCheck : DSessionExistsCheck {
  mixin(ControllerComponentThis!("SessionHasAccountCheck"));

  override void initialize(Json configSettings = Json(null)) {
    super.initialize(configSettings);

    this
      .redirectUrl("/error?account_missing");
  }

  override bool execute(STRINGAA options = null) {    
    debug writeln(moduleName!DSessionHasAccountCheck~":DSessionHasAccountCheck::execute");
    if (!super.execute(options)) { return false; } 

    auto session = getInternalSession(options);
    if (!session.account) { // account missing 
      this.error("Account Missing");
      return false;
    }

    return true;
  }
}
mixin(ControllerComponentCalls!("SessionHasAccountCheck"));

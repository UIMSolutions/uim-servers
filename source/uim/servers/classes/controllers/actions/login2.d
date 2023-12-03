/*********************************************************************************************************
	Copyright: © 2015-2023 Ozan Nurettin Süel (Sicherheitsschmiede)                                        
	License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.  
	Authors: Ozan Nurettin Süel (Sicherheitsschmiede)                                                      
**********************************************************************************************************/
module uim.servers.classes.controllers.actions.login2;

import uim.servers;
@safe:

class DLogin2ActionController : DActionController {
  mixin(ControllerThis!("Login2ActionController"));

  override void initialize(Json configSettings = Json(null)) {
    super.initialize(configSettings); 

    this
      .addChecks(
        HasSessionCheck
/*         SessionHasLoginCheck, // AppSession checks
        RequestHasPasswordCheck, // Request checks
        DatabaseHasPasswordsCheck */
      );
  }
  
  override bool beforeResponse(STRINGAA options = null) {
    debug writeln(moduleName!DLogin2ActionController~":DLogin2ActionController("~this.name~")::beforeResponse");
    if (!super.beforeResponse(options)) { 
      return false; 
    }
    debug writeln(options);

    if (auto mySession = getSession(this, this.request, options)) {
      debug writeln("AccountName: ", mySession.accountName);
      debug writeln("loginPW: ", options.get("loginPW", null));

      if (mySession.accountName == "test" && options.get("loginPW", null) == "test") {
        mySession.logonMode = true;
      } 
    }
    else {
      this.response.terminateSession;
    }
    options["redirect"] = "/"; 

    return true; 
  }
}
mixin(ControllerCalls!("Login2ActionController"));
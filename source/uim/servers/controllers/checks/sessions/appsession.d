/*********************************************************************************************************
	Copyright: © 2015-2023 Ozan Nurettin Süel (Sicherheitsschmiede)                                        
	License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.  
	Authors: Ozan Nurettin Süel (Sicherheitsschmiede)                                                      
**********************************************************************************************************/
module uim.mvc.controllers.checks.appsessions.appsession;

@safe:
import uim.mvc;

class DSessionExistsCheck : DControllerCheck {
  mixin(ControllerComponentThis!("SessionExistsCheck"));

  override void initialize(Json configSettings = Json(null)) {
    super.initialize(configSettings);

    this
    .redirectUrl("/account");
  }

  override bool execute(STRINGAA options = null) {    
    debug writeln(moduleName!DSessionExistsCheck~":DSessionExistsCheck::check");

    if (auto appSession = getSession(options)) {
      return true;
    } else { // appsession missing 
      this.error("appsession_missing");
      return false; 
    }
  }
}
mixin(ControllerComponentCalls!("SessionExistsCheck"));

///
unittest {
  auto check = new DSessionExistsCheck;
  assert(check.name == "SessionExistsCheck");
}

/*********************************************************************************************************
	Copyright: © 2015-2023 Ozan Nurettin Süel (Sicherheitsschmiede)                                        
	License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.  
	Authors: Ozan Nurettin Süel (Sicherheitsschmiede)                                                      
**********************************************************************************************************/
module uim.servers.controllers.actions.signup;

@safe:
import uim.servers;

class DSignUpActionController : DSystemActionController {
  mixin(ControllerThis!("SignUpActionController"));

  override void initialize(Json configSettings = Json(null)) {
    super.initialize(configSettings); 

  }

  override void beforeResponse(STRINGAA options = null) {
    debug writeln(moduleName!DSignUpActionController~":DSignUpActionController("~this.name~")::beforeResponse");
    super.beforeResponse(options);    
    if (hasError || "redirect" in options) { return; }

  }
}
mixin(ControllerCalls!("SignUpActionController"));

/*********************************************************************************************************
	Copyright: © 2015-2023 Ozan Nurettin Süel (Sicherheitsschmiede)                                        
	License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.  
	Authors: Ozan Nurettin Süel (Sicherheitsschmiede)                                                      
**********************************************************************************************************/
module uim.servers.controllers.pages.signup;

import uim.servers;
@safe:

class DSignUpPageController : DPageController {
  mixin(ControllerThis!("SignUpPageController"));

override void initialize(Json configSettings = Json(null)) {
    debugMethodCall(moduleName!DSignUpPageController~"::DSignUpPageController("~this.name~"):initialize");   
    super.initialize(configSettings);

    this
      .title("Sign Up")
      .view(SignUpView(this));   
  }

  override void beforeResponse(STRINGAA options = null) {
    debugMethodCall(moduleName!DSignUpPageController~":DSignUpPageController("~this.name~")::beforeResponse");
    super.beforeResponse(options);
    if (hasError || "redirect" in options) { return; }
  }
}
mixin(ControllerCalls!("SignUpPageController"));

version(test_uim_mvc) { unittest {
    writeln("--- Tests in ", __MODULE__, "/", __LINE__);
		testPageController(new DSignUpPageController); 

    writeln("--- Tests in ", __MODULE__, "/", __LINE__);
		testPageController(SignUpPageController); 
}}
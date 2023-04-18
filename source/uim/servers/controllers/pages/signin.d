/*********************************************************************************************************
	Copyright: © 2015-2023 Ozan Nurettin Süel (Sicherheitsschmiede)                                        
	License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.  
	Authors: Ozan Nurettin Süel (Sicherheitsschmiede)                                                      
**********************************************************************************************************/
module uim.servers.controllers.pages.signin;

@safe:
import uim.servers;

class DSignInPageController : DPageController {
  mixin(ControllerThis!("SignInPageController"));

override void initialize(Json configSettings = Json(null)) {
    debugMethodCall(moduleName!DSignInPageController~"::DSignInPageController("~this.name~"):initialize");   
    super.initialize(configSettings);

    this
      .title("Sign In")
      .view(SignInView(this));   
  }

  override void beforeResponse(STRINGAA options = null) {
    debugMethodCall(moduleName!DSignInPageController~":DSignInPageController("~this.name~")::beforeResponse");
    super.beforeResponse(options);
    if (hasError || "redirect" in options) { return; }
  }
}
mixin(ControllerCalls!("SignInPageController"));

version(test_uim_mvc) { unittest {
    writeln("--- Tests in ", __MODULE__, "/", __LINE__);
		testPageController(new DSignInPageController); 

    writeln("--- Tests in ", __MODULE__, "/", __LINE__);
		testPageController(SignInPageController); 
}}
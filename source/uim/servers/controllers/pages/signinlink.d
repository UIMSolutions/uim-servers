/*********************************************************************************************************
	Copyright: © 2015-2023 Ozan Nurettin Süel (Sicherheitsschmiede)                                        
	License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.  
	Authors: Ozan Nurettin Süel (Sicherheitsschmiede)                                                      
**********************************************************************************************************/
module uim.servers.controllers.pages.signinlink;

@safe:
import uim.servers;

class DSignInLinkPageController : DPageController {
  mixin(ControllerThis!("SignInLinkPageController"));

override void initialize(Json configSettings = Json(null)) {
    debugMethodCall(moduleName!DSignInLinkPageController~"::DSignInLinkPageController("~this.name~"):initialize");   
    super.initialize(configSettings);

    this
      .title("Sign In Link")
      .view(SignInLinkView(this));   
  }

  override void beforeResponse(STRINGAA options = null) {
    debugMethodCall(moduleName!DSignInLinkPageController~":DSignInLinkPageController("~this.name~")::beforeResponse");
    super.beforeResponse(options);
    if (hasError || "redirect" in options) { return; }
  }
}
mixin(ControllerCalls!("SignInLinkPageController"));

version(test_uim_mvc) { unittest {
    writeln("--- Tests in ", __MODULE__, "/", __LINE__);
		testPageController(new DSignInLinkPageController); 

    writeln("--- Tests in ", __MODULE__, "/", __LINE__);
		testPageController(SignInLinkPageController); 
}}
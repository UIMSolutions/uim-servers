/*********************************************************************************************************
	Copyright: © 2015-2023 Ozan Nurettin Süel (Sicherheitsschmiede)                                        
	License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.  
	Authors: Ozan Nurettin Süel (Sicherheitsschmiede)                                                      
**********************************************************************************************************/
module uim.servers.classes.controllers.pages.signinlink;

import uim.servers;
@safe:

class DSignInLinkPageController : DPageController {
  mixin(ControllerThis!("SignInLinkPageController"));

override bool initialize(IData[string] configSettings = null) {
    debugMethodCall(moduleName!DSignInLinkPageController~"::DSignInLinkPageController("~this.name~"):initialize");   
    super.initialize(configSettings);

    this
      .title("Sign In Link")
      .view(SignInLinkView(this));   
  }
}
mixin(ControllerCalls!("SignInLinkPageController"));

version(test_uim_mvc) { unittest {
    writeln("--- Tests in ", __MODULE__, "/", __LINE__);
		testPageController(new DSignInLinkPageController); 

    writeln("--- Tests in ", __MODULE__, "/", __LINE__);
		testPageController(SignInLinkPageController); 
}}
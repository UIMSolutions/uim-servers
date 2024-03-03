/*********************************************************************************************************
	Copyright: © 2015-2023 Ozan Nurettin Süel (Sicherheitsschmiede)                                        
	License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.  
	Authors: Ozan Nurettin Süel (Sicherheitsschmiede)                                                      
**********************************************************************************************************/
module uim.servers.classes.controllers.pages.signin;

import uim.servers;
@safe:

class DSignInPageController : DPageController {
  mixin(ControllerThis!("SignInPageController"));

override bool initialize(IData[string] configSettings = null) {
    debugMethodCall(moduleName!DSignInPageController~"::DSignInPageController("~this.name~"):initialize");   
    super.initialize(configSettings);

    this
      .title("Sign In")
      .view(SignInView(this));   
  }
}
mixin(ControllerCalls!("SignInPageController"));

version(test_uim_mvc) { unittest {
    writeln("--- Tests in ", __MODULE__, "/", __LINE__);
		testPageController(new DSignInPageController); 

    writeln("--- Tests in ", __MODULE__, "/", __LINE__);
		testPageController(SignInPageController); 
}}
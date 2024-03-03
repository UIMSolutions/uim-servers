/*********************************************************************************************************
	Copyright: © 2015-2023 Ozan Nurettin Süel (Sicherheitsschmiede)                                        
	License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.  
	Authors: Ozan Nurettin Süel (Sicherheitsschmiede)                                                      
**********************************************************************************************************/
module uim.servers.classes.controllers.pages.logout;

import uim.servers;
@safe:

class DLogoutPageController : DPageController {  
  mixin(ControllerThis!("LogoutPageController"));

  override bool initialize(IData[string] configSettings = null) {
    super.initialize(configSettings); 

    this
      .parameter("pageTitle",  "Abmeldung erfolgreich")
      .parameter("pageBreadcrumbs", 
`<ol class="breadcrumb" aria-label="breadcrumbs">
  <li class="breadcrumb-item"><a href="#">Start</a></li>
  <li class="breadcrumb-item active" aria-current="page"><a href="#">Abmeldung</a></li>
</ol>`)
      .title("Abmeldung");

    this
      .view(LogoutView);
  }

  override bool beforeResponse(STRINGAA options = null) {
    debug writeln(moduleName!DLogoutPageController~":DLogoutPageController("~this.name~")::beforeResponse");
    if (!super.beforeResponse(options)) { 
      return false; 
    }
    debug writeln(options);

    if (manager) {
      if (this.request && this.request.session) {
        manager.removeSession(this.request.session.id);
      }
      else { 
        manager.removeSession(options.get("httpSessionId", null));
      }
    }
    this.response.terminateSession();

    return true;
  }
}
mixin(ControllerCalls!("LogoutPageController"));

version(test_uim_mvc) { unittest {
    writeln("--- Tests in ", __MODULE__, "/", __LINE__);
		testPageController(new DLogoutPageController); 

    writeln("--- Tests in ", __MODULE__, "/", __LINE__);
		testPageController(LogoutPageController); 
}}
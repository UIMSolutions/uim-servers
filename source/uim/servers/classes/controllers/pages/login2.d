/*********************************************************************************************************
	Copyright: © 2015-2023 Ozan Nurettin Süel (Sicherheitsschmiede)                                        
	License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.  
	Authors: Ozan Nurettin Süel (Sicherheitsschmiede)                                                      
**********************************************************************************************************/
module uim.servers.classes.controllers.pages.login2;

import uim.servers;
@safe:

class DLogin2PageController : DPageController {
  mixin(ControllerThis!("Login2PageController"));

  override void initialize(Json configSettings = Json(null)) {
    super.initialize(configSettings);

    this
      .title("Anmeldung (Passwort)")
  /*     .scripts(`
        window.addEventListener('load', (event) => {
          document.getElementById("loginForm").addEventListener("submit", event => {
            event.preventDefault();
            login("loginForm");
          })
        });`) */
        .parameter("pageTitle", "Anmeldung")
        .parameter("pageBreadcrumbs", 
  `<ol class="breadcrumb" aria-label="breadcrumbs">
    <li class="breadcrumb-item"><a href="#">Start</a></li>
    <li class="breadcrumb-item active" aria-current="page"><a href="#">Anmeldung (Passwort)</a></li>
  </ol>`)
        .title("Anmeldung (Passwort)")
        .view(Login2View(this));
      
    this.scripts.addLinks(
        "/js/apps/app.js",   
        "/js/apps/login2.js");   

    this
      .addChecks(HasHTTPSessionCheck);
  }

  override bool beforeResponse(STRINGAA options = null) {
    debug writeln(moduleName!DLogin2PageController~":DLogin2PageController("~this.name~")::beforeResponse");
    if (!super.beforeResponse(options)) { 
      return false; 
    }

    if (auto mySession = getSession(this, this.request, options)) {
      debug writeln(mySession.debugInfo);
    }
    debug writeln(moduleName!DLoginActionController~":DLoginActionController("~this.name~")::beforeResponse -> New login entity");

    return true;
  }
}
mixin(ControllerCalls!("Login2PageController"));

version(test_uim_mvc) { unittest {
    writeln("--- Tests in ", __MODULE__, "/", __LINE__);
		testPageController(new DLogin2PageController); 

    writeln("--- Tests in ", __MODULE__, "/", __LINE__);
		testPageController(Login2PageController); 
}}
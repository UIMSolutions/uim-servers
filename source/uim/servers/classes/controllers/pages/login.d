/*********************************************************************************************************
	Copyright: © 2015-2023 Ozan Nurettin Süel (Sicherheitsschmiede)                                        
	License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.  
	Authors: Ozan Nurettin Süel (Sicherheitsschmiede)                                                      
**********************************************************************************************************/
module uim.servers.classes.controllers.pages.login;

import uim.servers;

@safe:
class DLoginPageController : DPageController {
  mixin(ControllerThis!("LoginPageController"));

override bool initialize(IData[string] configSettings = null) {
    debugMethodCall(moduleName!DLoginPageController~"::DLoginPageController("~this.name~"):initialize");   
    super.initialize(configSettings);

    this
    .title("Anmeldung (Kennung)")
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
  <li class="breadcrumb-item active" aria-current="page"><a href="#">Anmeldung (Kennung)</a></li>
</ol>`)
      .title("Anmeldung (Kennung)")
      .view(LoginView(this))
      .scripts.addLinks(
        "/js/apps/app.js",   
        "/js/apps/login.js");   
  }
}
mixin(ControllerCalls!("LoginPageController"));

version(test_uim_mvc) { unittest {
  writeln("--- Tests in ", __MODULE__, "/", __LINE__);
  testPageController(new DLoginPageController); 

  writeln("--- Tests in ", __MODULE__, "/", __LINE__);
  testPageController(LoginPageController); 
}}
/*********************************************************************************************************
	Copyright: © 2015-2023 Ozan Nurettin Süel (Sicherheitsschmiede)                                        
	License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.  
	Authors: Ozan Nurettin Süel (Sicherheitsschmiede)                                                      
**********************************************************************************************************/
module uim.servers.controllers.pages.lostpw;

@safe:
import uim.servers;

class DAPPLostPasswordPageController : DPageController {
  mixin(ControllerThis!("APPLostPasswordPageController"));

override void initialize(Json configSettings = Json(null)) {
    super.initialize(configSettings);

    this
      .parameter("pageTitle", "Passwort vergessen?")
      .parameter("pageBreadcrumbs",`<ol class="breadcrumb" aria-label="breadcrumbs">
  <li class="breadcrumb-item"><a href="#">Start</a></li>
  <li class="breadcrumb-item active" aria-current="page"><a href="#">Passwort vergessen</a></li>
</ol>`)
      .title("Passwort vergessen")
      .view(APPLostPasswordView(this));
  }
}
mixin(ControllerCalls!("APPLostPasswordPageController"));

version(test_uim_mvc) { unittest {
    writeln("--- Tests in ", __MODULE__, "/", __LINE__);
		testPageController(new DAPPLostPasswordPageController); 

    writeln("--- Tests in ", __MODULE__, "/", __LINE__);
		testPageController(APPLostPasswordPageController); 
}}
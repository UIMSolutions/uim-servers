/*********************************************************************************************************
	Copyright: © 2015-2023 Ozan Nurettin Süel (Sicherheitsschmiede)                                        
	License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.  
	Authors: Ozan Nurettin Süel (Sicherheitsschmiede)                                                      
**********************************************************************************************************/
module uim.servers.controllers.pages.userprofile;

@safe:
import uim.servers;

class DAPPUserProfilePageController : DPageController {
  mixin(ControllerThis!("APPUserProfilePageController"));

override void initialize(Json configSettings = Json(null)) {
    super.initialize(configSettings);

    this
      .parameter("pageTitle", "Registrierung")
      .parameter("pageBreadcrumbs", `<ol class="breadcrumb" aria-label="breadcrumbs">
  <li class="breadcrumb-item"><a href="#">Start</a></li>
  <li class="breadcrumb-item active" aria-current="page"><a href="#">Registrierung</a></li>
</ol>`)
      .title("Registrierung");
  }
}
mixin(ControllerCalls!("APPUserProfilePageController"));

version(test_uim_servers) { unittest {
    writeln("--- Tests in ", __MODULE__, "/", __LINE__);
		testPageController(new DAPPUserProfilePageController); 

    writeln("--- Tests in ", __MODULE__, "/", __LINE__);
		testPageController(APPUserProfilePageController); 
}}
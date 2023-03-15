/*********************************************************************************************************
	Copyright: © 2015-2023 Ozan Nurettin Süel (Sicherheitsschmiede)                                        
	License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.  
	Authors: Ozan Nurettin Süel (Sicherheitsschmiede)                                                      
**********************************************************************************************************/
module uim.apps.controllers.pages.logout;

@safe:
import uim.apps;

class DAPPLogoutPageController : DPageController {  
  mixin(ControllerThis!("APPLogoutPageController"));

  override void initialize(Json configSettings = Json(null)) {
    super.initialize(configSettings); 

    this
      .parameter("pageTitle",  "Abmeldung erfolgreich")
      .parameter("pageBreadcrumbs", `<ol class="breadcrumb" aria-label="breadcrumbs">
  <li class="breadcrumb-item"><a href="#">Start</a></li>
  <li class="breadcrumb-item active" aria-current="page"><a href="#">Abmeldung</a></li>
</ol>`)
      .title("Abmeldung");
  }
}
mixin(ControllerCalls!("APPLogoutPageController"));

version(test_uim_mvc) { unittest {
    writeln("--- Tests in ", __MODULE__, "/", __LINE__);
		testPageController(new DAPPLogoutPageController); 

    writeln("--- Tests in ", __MODULE__, "/", __LINE__);
		testPageController(APPLogoutPageController); 
}}
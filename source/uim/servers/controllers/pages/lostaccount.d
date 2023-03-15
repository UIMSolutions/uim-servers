/*********************************************************************************************************
	Copyright: © 2015-2023 Ozan Nurettin Süel (Sicherheitsschmiede)                                        
	License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.  
	Authors: Ozan Nurettin Süel (Sicherheitsschmiede)                                                      
**********************************************************************************************************/
module uim.apps.controllers.pages.lostaccount;

@safe:
import uim.apps;

class DAPPLostAccountPageController : DPageController {
  mixin(ControllerThis!("APPLostAccountPageController"));

override void initialize(Json configSettings = Json(null)) {
    super.initialize(configSettings);
    
    this
      .parameter("pageTitle", "Kennung vergessen?")
      .parameter("pageBreadcrumbs", `<ol class="breadcrumb" aria-label="breadcrumbs">
  <li class="breadcrumb-item"><a href="#">Start</a></li>
  <li class="breadcrumb-item active" aria-current="page"><a href="#">Kennung vergessen</a></li>
</ol>`)
      .title("Kennung vergessen")
      .view(
        APPLostAccountView(this));
  }
}
mixin(ControllerCalls!("APPLostAccountPageController"));

version(test_uim_mvc) { unittest {
    writeln("--- Tests in ", __MODULE__, "/", __LINE__);
		testPageController(new DAPPLostAccountPageController); 

    writeln("--- Tests in ", __MODULE__, "/", __LINE__);
		testPageController(APPLostAccountPageController); 
}}
/*********************************************************************************************************
	Copyright: © 2015-2023 Ozan Nurettin Süel (Sicherheitsschmiede)                                        
	License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.  
	Authors: Ozan Nurettin Süel, mailto:ons@sicherheitsschmiede.de                                                      
**********************************************************************************************************/
module uim.servers.controllers.pages.page;

import uim.servers;
@safe:

class DSRVPageController : DPageController {
  mixin(ControllerThis!("SRVPageController"));

  mixin(OProperty!("IServer", "server"));

	// #region Layout
    @property override ILayout layout() { 
      debugMethodCall(moduleName!DSRVPageController~":DSRVPageController("~this.name~")::layout()");
      return _layout 
        ? _layout
        : (this.server 
          ? this.server.layout 
          : null)
        ; 
    }
	// #endregion Layout

  override void beforeResponse(STRINGAA options = null) {
    debugMethodCall(moduleName!DSRVPageController~":DSRVPageController("~this.name~")::beforeResponse");
    super.beforeResponse(options);

    this.session = getAppSession(options);
    // ?? TODO if (appSession) { this.site(session.site); }
    //     if (hasError || "redirect" in options) { return; }
  }    

  override string stringResponse(string[string] options = null) {
    debugMethodCall(moduleName!DSRVPageController~":DSRVPageController("~name~")::stringResponse");
    super.stringResponse(options);
    // if (hasError) { return null; }

    string myRenderedView = view ? view.render(options) : "";
    return this.layout 
      ? this.layout.render(this, myRenderedView)  
      : myRenderedView;  
  }

  override DH5Obj[] pageContent(STRINGAA reqParameters) { 
    debugMethodCall(moduleName!DSRVPageController~":DSRVPageController("~this.name~")::pageContent");
    // auto result = form ? form.toH5(reqParameters) : null;

    // debug writeln("return result pageContent(STRINGAA reqParameters)");
    // return result;
    return null; 
  }

  override void jsCode(STRINGAA options = null) {
    debugMethodCall(moduleName!DSRVPageController~":DSRVPageController::jsCode");
    string appSessionId = _request && _request.session ? _request.session.id : options.get("appSessionId", "");
    auto appSession = getAppSession(options);

    if (appSession && viewMode == ViewModes.JS) 
      addToPageScript(options, 
        setSessionStorage(["sessionId": (appSession.session ? appSession.session.id.toString : ""), "siteId": (appSession.site ? appSession.site.id.toString : "")]));
  }

  override void afterResponse(STRINGAA options = null) {
    debugMethodCall(moduleName!DSRVPageController~":DSRVPageController::afterResponse");
    super.afterResponse(options);
  }  
}
mixin(ControllerCalls!("SRVPageController"));

version(test_uim_mvc) { unittest {
  assert(ServerPageController);
}}

/*********************************************************************************************************
	copyright: © 2015-2023 ozan nurettin süel (sicherheitsschmiede)                                        
	license: subject to the terms of the apache 2.0 license, as written in the included license.txt file.  
	authors: ozan nurettin süel (sicherheitsschmiede)                                                      
**********************************************************************************************************/
module uim.servers.classes.servers.server;

import uim.servers;
@safe:

class DServer : DMVCObject, IServer, IRequestHandler, IControllerManager, ISessionManager, IAppManager, IViewManager, IRouteManager {
	this() { super(); }
  this(string aName) { this().name(aName); }
  this(string aName, string aRootPath) { this(aName).rootPath(aRootPath); }

  mixin(TProperty!("IEntityBase", "entityBase"));

  // #region controllerContainer
  mixin(TProperty!("DControllerContainer", "controllerContainer"));
  mixin ControllerManagerTemplate;

  mixin(TProperty!("DSessionContainer", "sessionContainer"));
  mixin SessionManagerTemplate;

  mixin(TProperty!("DLayoutContainer", "layoutContainer"));
  mixin LayoutManagerTemplate;

  mixin(TProperty!("DViewContainer", "viewContainer"));
  mixin ViewManagerTemplate;

  mixin(TProperty!("DAppContainer", "appContainer"));
  mixin AppManagerTemplate;

  mixin RouteManagerTemplate;

  override void initialize(Json configSettings = Json(null)) {
    super.initialize(configSettings);

/*     securityOptions(SRVSecurityOptions);
    securityController(SRVSecurityController); */
    
    this.controllerContainer(ControllerContainer);
    this.sessionContainer(SessionContainer);
    this.layoutContainer(LayoutContainer);
    this.viewContainer(ViewContainer);
    this.appContainer(AppContainer);
  }


// #region parameters
    mixin(MVCParameter!("rootPath"));
    mixin(OProperty!("DServer", "manager"));
  // #endregion parameters

  // Application data 
  mixin(OProperty!("UUID", "id"));
  mixin(OProperty!("size_t", "versionNumber"));

  // Main Containers - Allways first
  mixin(OProperty!("DMVCLinkContainer", "links"));
  mixin(OProperty!("DMVCMetaContainer", "metas"));
  mixin(OProperty!("DScriptContainer", "scripts"));
  mixin(OProperty!("DStyleContainer",  "styles"));
  
  mixin(OProperty!("DSRVSecurityController", "securityController")); 
  mixin(OProperty!("DSRVSecurityOptions", "securityOptions"));
  O securityOptions(this O)(bool[string] newOptions) { this.securityOptions(SRVSecurityOptions(newOptions)); return cast(O)this; }  

  /* override void afterInsertObj(DH5AppObj appObject) {
    super.afterInsertObj(appObject);

    if (auto page = cast(DSRVApi)appObject) {
      if (!page.securityController) page.securityController(securityController.copy.page(page));
      if (!page.securityOptions) page.securityOptions(securityOptions.copy);
    }
  } */

  deprecated("Next edition") {
    O registerRouter(this O)(URLRouter router) {
      debugMethodCall(moduleName!DServer~":DServer("~this.name~")::register(this O)(URLRouter router)");

      debug writeln("Link Path '%s'".format(rootPath~"*"));
      if (rootPath.length > 0) router.any(rootPath, &this.request);
      router.any(rootPath~"*", &this.request);
      return cast(O)this;
    }
  }

  // #region Request Handling
    void request(HTTPServerRequest newRequest, HTTPServerResponse newResponse) {
      request(newRequest, newResponse, null); 
    }

    void request(HTTPServerRequest newRequest, HTTPServerResponse newResponse, string[string] options) {
      debugMethodCall(moduleName!DServer~":DServer("~this.name~")::request(req, res, requestParameters)");

      writeln("rootPath = '%s'".format(this.rootPath));
      writeln("newRequest.fullURL = '%s'".format(newRequest.fullURL));
      writeln("newRequest.rootDir = '%s'".format(newRequest.rootDir));
      writeln("newRequest.path    = '%s'".format(newRequest.path));
      writeln("newRequest.path.length = '%s'".format(newRequest.path.length));

      writeln(routePaths);
      auto myPath = options.get("path", newRequest.path);
      writeln("myPath = '%s'".format(myPath));

      auto myRoutePath = myPath;
      if (myPath.indexOf(rootPath) == 0) {
        myRoutePath = myPath[rootPath.length..$];
        foreach(myRoute; this.routesWithMethod(newRequest.method)) {
          if (myRoute.path == myRoutePath) {
            debug writeln("Found server route");

            myRoute.controller.request(newRequest, newResponse, options);
            return;
          }
        }
      }

      debug writeln("Searching for app...%s".format(apps.length));

      if (myRoutePath.length == 0) myRoutePath = "/";
      if (myRoutePath.length > 0) {
        if (myRoutePath[0] != '/') myRoutePath = "/"~myRoutePath;
      }
      foreach(myApp; apps.filter!(a => a !is null).array) {  
        auto appPath = correctAppPath(myApp.rootPath);

        if (myRoutePath.indexOf(appPath) == 0 || (myRoutePath~"/").indexOf(appPath) == 0) {
          debug writeln("Found App %s".format(myApp.name));

          auto myOptions = options.dup;
          myOptions["path"] = myRoutePath;
          myApp.request(newRequest, newResponse, myOptions);
          return;
        }
      }
    }
  // #endregion 
}
auto Server() { return new DServer(); }
auto Server(string aName) { return new DServer(aName); }
auto Server(string aName, string aRootPath) { new DServer(aName, aRootPath); }

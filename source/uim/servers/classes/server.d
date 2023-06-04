/*********************************************************************************************************
	copyright: © 2015-2023 ozan nurettin süel (sicherheitsschmiede)                                        
	license: subject to the terms of the apache 2.0 license, as written in the included license.txt file.  
	authors: ozan nurettin süel (sicherheitsschmiede)                                                      
**********************************************************************************************************/
module uim.servers.classes.server;

import uim.servers;
@safe:

class DServer : DMVCObject, IServer, IRequestHandler  {
	this() { super(); 
    this
    .securityOptions(SRVSecurityOptions)
    .securityController(SRVSecurityController); }

// #region parameters
    mixin(MVCParameter!("rootPath"));
  // #endregion parameters

  // Application data 
  mixin(OProperty!("UUID", "id"));
  mixin(OProperty!("size_t", "versionNumber"));

  // Interfaces
  mixin(OProperty!("DETBBase", "database"));

  protected ILayout _layout;
	@property O layout(this O)(ILayout newlayout) { 
    _layout = newlayout; 
    return cast(O)this; }
  
  ILayout layout() {
    debugMethodCall(moduleName!DServer~":DServer("~this.name~")::layout()");
    return _layout;
  }

  mixin(OProperty!("DRoute[HTTPMethod][string]", "routes"));

  // Main Containers - Allways first
  mixin(OProperty!("DMVCLinkContainer", "links"));
  mixin(OProperty!("DMVCMetaContainer", "metas"));
  mixin(OProperty!("DScriptContainer", "scripts"));
  mixin(OProperty!("DStyleContainer",  "styles"));
  
  mixin(OProperty!("DSRVSecurityController", "securityController")); 
  mixin(OProperty!("DSRVSecurityOptions", "securityOptions"));
  mixin(OProperty!("DApp[]", "apps"));
  O securityOptions(this O)(bool[string] newOptions) { this.securityOptions(SRVSecurityOptions(newOptions)); return cast(O)this; }  

  auto routesPaths() {
    return _routes.keys; 
  }

  auto routesAtPath(string path) {
    debug writeln("Get routes at '%s'".format(path));
    return _routes.get(path, null); 
  }

  auto route(string path, HTTPMethod method) {
    debug writeln("Get route at '%s' and '%s'".format(path, method));
    if (auto routesAtPath = _routes.get(path, null)) {
      return routesAtPath.get(method, null);
    } 
    return null;
  }

  O addRoute(this O)(DRoute newRoute) {
    debug writeln("Adding route at '%s'".format(newRoute.path));
    if (newRoute) {
      DRoute[HTTPMethod] routesAtPath = _routes.get(newRoute.path, null);
      routesAtPath[newRoute.method] = newRoute;

      if (auto myController = cast(DSRVPageController)newRoute.controller) {
        myController.server(this);
      }

      _routes[newRoute.path] = routesAtPath;
    }
    return cast(O)this; }

  /* override void afterInsertObj(DH5AppObj appObject) {
    super.afterInsertObj(appObject);

    if (auto page = cast(DSRVApi)appObject) {
      if (!page.securityController) page.securityController(securityController.copy.page(page));
      if (!page.securityOptions) page.securityOptions(securityOptions.copy);
    }
  } */

  deprecated("Next edition") {
    O register(this O)(URLRouter router) {
      debugMethodCall(moduleName!DServer~":DServer("~this.name~")::register(this O)(URLRouter router)");

      debug writeln("Link Path '%s'".format(rootPath~"*"));
      if (rootPath.length > 0) router.any(rootPath, &this.request);
      router.any(rootPath~"*", &this.request);
      return cast(O)this;
    }
  }

  // #region App Management
    O registerApps(this O)(DApp[] someApps...) {
      this.registerApps(someApps.dup);
      return cast(O)this;
    }

    O registerApps(this O)(DApp[] someApps) {
      someApps.each!(a => a.server(this)); // Owner is server
      this.apps(this.apps~someApps);
      return cast(O)this;
    }
  // #endregion

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

      writeln(routesPaths);
      auto myPath = rootPath.length > 0 ? newRequest.path[rootPath.length..$] : newRequest.path;
      writeln("myPath = '%s'".format(myPath));
      if (auto myRoute = route(myPath, newRequest.method)) {
        debug writeln("Found route");

        myRoute.controller.request(newRequest, newResponse, options);
      }
      else {
        foreach(myApp; apps) {
          if (myApp && (myPath >= myApp.rootPath) && (myPath.indexOf(myApp.rootPath) == 0)) {
            debug writeln("Found App %s".format(myApp.name));

            auto myOptions = options.dup;
            myOptions["path"] = myPath;
            myApp.request(newRequest, newResponse, myOptions);
          }
        }
      }
    }
  // #endregion 
}
auto Server() { return new DServer(); }
auto Server(string aName) { return Server.name(aName); }
auto Server(string aName, string aRootPath) { return Server(aName).rootPath(aRootPath); }
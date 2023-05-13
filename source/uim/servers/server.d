/*********************************************************************************************************
	copyright: © 2015-2023 ozan nurettin süel (sicherheitsschmiede)                                        
	license: subject to the terms of the apache 2.0 license, as written in the included license.txt file.  
	authors: ozan nurettin süel (sicherheitsschmiede)                                                      
**********************************************************************************************************/
module uim.servers.server;

import uim.servers;
@safe:

class DServer : DApplication, IServer  {
	this() { super(); 
    this
    .securityOptions(SRVSecurityOptions)
    .securityController(SRVSecurityController); }

  mixin(OProperty!("DSRVSecurityController", "securityController")); 
  mixin(OProperty!("DSRVSecurityOptions", "securityOptions"));
  mixin(OProperty!("DApplication[]", "apps"));
  O securityOptions(this O)(bool[string] newOptions) { this.securityOptions(SRVSecurityOptions(newOptions)); return cast(O)this; }  

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
    O registerApps(this O)(DApplication[] someApps...) {
      this.registerApps(someApps);
      return cast(O)this;
    }

    O registerApps(this O)(DApplication[] someApps) {
      this.apps(this.apps~someApps);
      return cast(O)this;
    }
  // #endregion

  // #region Request Handling
    override void request(HTTPServerRequest newRequest, HTTPServerResponse newResponse) {
      request(newRequest, newResponse, null); 
    }

    override void request(HTTPServerRequest newRequest, HTTPServerResponse newResponse, string[string] options) {
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
            myApp.request(newRequest, newResponse, options);
          }
        }
      }
    }
  // #endregion 
}
auto Server() { return new DServer(); }
auto Server(string aName) { return Server.name(aName); }
auto Server(string aName, string aRootPath) { return Server(aName).rootPath(aRootPath); }

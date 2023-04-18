/*********************************************************************************************************
	copyright: © 2015-2023 ozan nurettin süel (sicherheitsschmiede)                                        
	license: subject to the terms of the apache 2.0 license, as written in the included license.txt file.  
	authors: ozan nurettin süel (sicherheitsschmiede)                                                      
**********************************************************************************************************/
module uim.servers.server;

@safe:
import uim.servers;

class DServer : DApplication, IServer  {
	this() { super(); 
    this
    .securityOptions(SRVSecurityOptions)
    .securityController(SRVSecurityController); }

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

  override void request(HTTPServerRequest newRequest, HTTPServerResponse newResponse) {
    request(newRequest, newResponse, null); 
  }

  override void request(HTTPServerRequest newRequest, HTTPServerResponse newResponse, string[string] options) {
		debugMethodCall(moduleName!DServer~":DServer("~this.name~")::request(req, res, requestParameters)");

    writeln("rootPath = '%s'".format(this.rootPath));
    writeln("newRequest.fullURL = '%s'".format(newRequest.fullURL));
    writeln("newRequest.rootDir = '%s'".format(newRequest.rootDir));
    writeln("newRequest.path    = '%s'".format(newRequest.path));

    writeln(routesPaths);
    if (newRequest.path.length >= rootPath.length) {
      auto myPath = newRequest.path; // [rootPath.length..$];
      writeln("myPath = '%s'".format(myPath));
      if (auto myRoute = route(myPath, newRequest.method)) {
        debug writeln("Found route");

        myRoute.controller.request(newRequest, newResponse, options);
      }
    } 
  }
}
auto Server() { return new DServer(); }
auto Server(string aName) { return Server.name(aName); }
auto Server(string aName, string aRootPath) { return Server(aName).rootPath(aRootPath); }

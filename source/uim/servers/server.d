module uim.servers.server;

@safe:
import uim.servers;

class DSRVServer : DAPPApplication {
	this() { super(); 
    this
    .securityOptions(SRVSecurityOptions)
    .securityController(SRVSecurityController); }

  mixin(SProperty!("DSRVSecurityController", "securityController")); 
  mixin(SProperty!("DSRVSecurityOptions", "securityOptions"));
  O securityOptions(this O)(bool[string] newOptions) { this.securityOptions(SRVSecurityOptions(newOptions)); return cast(O)this; }  

  /* override void afterInsertObj(DH5AppObj appObject) {
    super.afterInsertObj(appObject);

    if (auto page = cast(DSRVApi)appObject) {
      if (!page.securityController) page.securityController(securityController.copy.page(page));
      if (!page.securityOptions) page.securityOptions(securityOptions.copy);
    }
  } */
}
auto SRVServer() { return new DSRVServer(); }
auto SRVServer(string aName) { return SRVServer.name(aName); }
auto SRVServer(string aName, string aRootPath) { return SRVServer(aName).rootPath(aRootPath); }

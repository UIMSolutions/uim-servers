module uim.servers.server;

@safe:
import uim.servers;

class DServer : DApplication {
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
auto Server() { return new DServer(); }
auto Server(string aName) { return Server.name(aName); }
auto Server(string aName, string aRootPath) { return Server(aName).rootPath(aRootPath); }

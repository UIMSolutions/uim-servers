module uim.servers.securities.security;

import uim.servers;
@safe:

class DSRVSecurityController : DController {
  this() { super(); }

  /* override Json run(STRINGAA parameters) {
    auto json = super.run(parameters);
   */ 
    /* if (page) {
      debug writeln("has page");
      auto srvSession = page.hasGlobalSession ? page.globalSession : readOrCreateSession(page._request, page._response);
      page.hasGlobalSession(true);

      debug writeln("Session -> ", srvSession ? srvSession.id : "'null'");

      debug writeln("Init values");
      page.loginId = "";
      page.login = Json(null);
      page.sessionId = "";
      page.session = Json(null);
      page.siteId = "";
      page.site = Json(null);

      debug writeln("login required ?");
      if (page.securityOptions.required("login")) {
        debug writeln("login required");
        page.loginId = readLoginId(page._request, parameters);
        if (page.loginId.empty) {
          debug writeln("No loginId");
          auto e = Json.emptyObject;
          e["code"] = 20;
          e["description"] = "No loginId";
          json["errors"] ~= e;
        }
        json["loginId"] = page.loginId;
        parameters["loginId"] = page.loginId;
        if (srvSession) srvSession.set("loginId", page.loginId);
        debug writeln("LoginId: ", page.loginId.empty ? "null" : page.loginId);
      }

      debug writeln("session required ?");
      if (page.securityOptions.required("session")) {
        debug writeln("session required");
        page.sessionId = readSessionId(page._request, parameters);

        if (page.sessionId.empty) {
          debug writeln("No sessionId");
          auto e = Json.emptyObject;
          e["code"] = 30;
          e["description"] = "No sessionId";
          json["errors"] ~= e;
        }
        json["sessionId"] = page.sessionId;
        parameters["sessionId"] = page.sessionId;
        if (srvSession) srvSession.set("sessionId", page.sessionId);
        debug writeln("sessionId: ", page.sessionId.empty ? "null" : page.sessionId);
      }

      debug writeln("site required ?");
      if (page.securityOptions.required("site")) {
        debug writeln("site required");
        page.siteId = readSiteId(page._request, parameters);
        if (page.siteId.empty)  {
          debug writeln("No siteId");
          auto e = Json.emptyObject;
          e["code"] = 40;
          e["description"] = "No siteId";
          json["errors"] ~= e;
        }
        json["siteId"] = page.siteId;
        parameters["siteId"] = page.siteId;
        if (srvSession) srvSession.set("siteId", page.siteId);
        debug writeln("siteId: ", page.siteId.empty ? "null" : page.siteId);
      }
    }

    if (page) {
      if (page.securityOptions.required("session") && page.sessionId.empty) page._response.redirect("/login"); 
      else if (page.securityOptions.required("site") && page.siteId.empty) page._response.redirect("/sites"); 
    }

    debug writeln("In DSRVSecurityController");
    debug writeln(parameters);
    debug writeln("--------------------------------"); */
/*     return json;
  } */
} 
auto SRVSecurityController() { return new DSRVSecurityController; }
auto SRVSecurityController(DSRVApi myApi) { return SRVSecurityController; } //.api(myApi); }

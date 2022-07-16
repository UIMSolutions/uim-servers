module uim.servers.securities.database;

@safe:
import uim.servers;

// Security Chack using database
class DSRVSecurityControllerDatabase : DSRVSecurityController {
  this() { super(); }
  this(DSRVApi myApi) { this(); } // this.api(myApi); }

  /* override Json run(STRINGAA parameters) {
    auto json = super.run(parameters);

    if (page && page.app && page.database) {
      auto dSource = page.database;

      page.loginId = readLoginId(page._request, parameters);
      page.sessionId = readSessionId(page._request, parameters);
      page.siteId = readSiteId(page._request, parameters);

      if (page.securityOptions.required("session")) {
        if (page.sessionId.empty) {
          if ("sessionId" in page.login) { 
            page.sessionId = page.login["sessionId"].get!string; 
            parameters["sessionId"] = page.sessionId;
          }
        }
        page.session = dSource.findOne("central", "sessions", ["id": page.sessionId]);
        if (page.session == Json(null)) {
          debug writeln("No session");
          auto e = Json.emptyObject;
          e["code"] = 31;
          e["description"] = "No session in database - sessionId:"~page.sessionId;
          json["errors"] ~= e;
        }
        else {
          auto nw = now();
          page.session.remove("_id");
          page.session["modifiedOn"] = toTimestamp(nw);
          page.session["modifiedISO"] = nw.toISOString;
          page.session["lastAccessOn"] = toTimestamp(nw);
          page.session["lastAccessISO"] = nw.toISOString;
          dSource.updateOne("central", "sessions", ["id":page.sessionId], page.session);        
        }
      }

      if (page.securityOptions.required("login")) {
        if (page.loginId.empty) {
          if ("loginId" in page.session) page.loginId = page.session["loginId"].get!string;
          parameters["loginId"] = page.loginId;
        }

        auto login = dSource.findOne("central", "logins", ["id": page.loginId]);
        if (login == Json(null)) {
          debug writeln("No login");
          auto e = Json.emptyObject;
          e["code"] = 21;
          e["description"] = "No login in database - loginId:"~page.loginId;
          json["errors"] ~= e;
        }
        else {
          page.login.remove("_id");
          auto nw = now();
          page.session["modifiedOn"] = toTimestamp(nw);
          page.session["modifiedISO"] = nw.toISOString;
          page.session["lastAccessOn"] = toTimestamp(nw);
          page.session["lastAccessISO"] = nw.toISOString;
          dSource.updateOne("central", "logins", ["id":page.loginId], page.login);        
          if (page.session != Json(null)) {
            page.session["loginId"] = page.siteId;
            page.session["modifiedOn"] = toTimestamp(nw);
            page.session["modifiedISO"] = nw.toISOString;
            page.session["lastAccessOn"] = toTimestamp(nw);
            page.session["lastAccessISO"] = nw.toISOString;
            dSource.updateOne("central", "sessions", ["id":page.sessionId], page.session);        
          }
        }
      }

      if (page.securityOptions.required("site")) {
        if (page.siteId.empty) {
          if ("siteId" in page.session) { 
            page.siteId = page.session["siteId"].get!string;             
            parameters["siteId"] = page.siteId;
          }
        }
        page.site = dSource.findOne("central", "sites", ["id": page.siteId]);
        if (page.site == Json(null)) {
          debug writeln("No site");
          auto e = Json.emptyObject;
          e["code"] = 31;
          e["description"] = "No site in database - siteId:"~page.siteId;
          json["errors"] ~= e;
        }
        else {
          page.siteName = page.site.name;
          page.site.remove("_id");
          auto nw = now();
          page.session["modifiedOn"] = toTimestamp(nw);
          page.session["modifiedISO"] = nw.toISOString;
          page.session["lastAccessOn"] = toTimestamp(nw);
          page.session["lastAccessISO"] = nw.toISOString;
          dSource.updateOne("central", "sites", ["id": page.siteId], page.site);        
          if (page.session != Json(null)) {
            page.session["siteId"] = page.siteId;
            page.session["modifiedOn"] = toTimestamp(nw);
            page.session["modifiedISO"] = nw.toISOString;
            page.session["lastAccessOn"] = toTimestamp(nw);
            page.session["lastAccessISO"] = nw.toISOString;
            dSource.updateOne("central", "sessions", ["id":page.sessionId], page.session);        
          }
        }
      }
    }
    debug writeln("Return DSRVSecurityControllerDatabase");
    debug writeln(parameters);
    debug writeln("--------------------------------");
    return json; // None; 
  }*/
} 
auto SRVSecurityControllerDatabase() { return new DSRVSecurityControllerDatabase; }
// auto SRVSecurityControllerDatabase(DSRVApi myApi) { return new DSRVSecurityControllerDatabase(myApi); }

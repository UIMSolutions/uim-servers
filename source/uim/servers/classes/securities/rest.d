module uim.servers.classes.securities.rest;

import uim.servers;
@safe:

class DSRVSecurityControllerRest : DController {
  this() { super(); }
  this(DSRVApi myApi) { this(); } // this.api(myApi); }

/*   override Json run(STRINGAA parameters) {
    auto json = super.run(parameters); */

    /* if (page && page.app && page.database) {
      if (page.securityOptions.required("login")) {
        if (page.loginId.empty) return json;

        requestHTTP(parameters.get("httpMode", "")~"://"~parameters.get("Host", "")~"/api/v1/logins?id="~page.loginId,
          (scope req) {
            req.method = HTTPMethod.POST;
            req.writeJsonBody(["loginId": page.loginId]);
          },
          (scope res) {
            auto jsonResponse = parseJsonString(res.bodyReader.readAllUTF8());
            page.login(jsonResponse);
            logInfo("login: %s", page.login);
          }
        );
        if (page.login == Json(null)) {
          debug writeln("No login");
          auto e = Json.emptyObject;
          e["code"] = 21;
          e["description"] = "No login in database - loginId:"~page.loginId;
          json["errors"] ~= e;
        }
      }

      if (page.securityOptions.required("session")) {
        if (page.sessionId.empty) return json; 

        requestHTTP(parameters.get("httpMode", "")~"://"~parameters.get("Host", "")~"/api/v1/sessions?id="~page.sessionId,
          (scope req) {
            req.method = HTTPMethod.POST;
            req.writeJsonBody(["sessionId": page.sessionId]);
          },
          (scope res) {
            auto jsonResponse = parseJsonString(res.bodyReader.readAllUTF8());
            page.session(jsonResponse);
            logInfo("session: %s", page.session);
          }
        );
        if (page.session == Json(null)) {
          debug writeln("No session");
          auto e = Json.emptyObject;
          e["code"] = 31;
          e["description"] = "No session in database - sessionId:"~page.sessionId;
          json["errors"] ~= e;
        }
      }

      if (page.securityOptions.required("site")) {
        if (page.siteId.empty) return json; 

        requestHTTP(parameters.get("httpMode", "")~"://"~parameters.get("Host", "")~"/api/v1/sites?id="~page.siteId,
          (scope req) {
            req.method = HTTPMethod.POST;
            req.writeJsonBody(["siteId": page.siteId]);
          },
          (scope res) {
            auto jsonResponse = parseJsonString(res.bodyReader.readAllUTF8());
            page.site(jsonResponse);
            logInfo("site: %s", page.site);
          }
        );
        if (page.site == Json(null)) {
          debug writeln("No site");
          auto e = Json.emptyObject;
          e["code"] = 31;
          e["description"] = "No site in database - siteId:"~page.siteId;
          json["errors"] ~= e;
        }
      }
    } */
/*     return json; // None;
  } */
} 
auto APPSecurityControllerRest() { return new DSRVSecurityControllerRest; }
// auto APPSecurityControllerRest(DSRVApi myPage) { return new DSRVSecurityControllerRest(myPage); }

/*
requestHTTP(reqParameters.get("httpMode", "")~"://"~reqParameters.get("Host", "")~"/api/v1/sessions?id="~page.sessionId,
          (scope req) {
            req.method = HTTPMethod.POST;
            req.writeJsonBody(["name": "My Name"]);
          },
          (scope res) {
            session(parseJsonString(res.bodyReader.readAllUTF8()));
            logInfo("session: %s", page.session);
          }
        );*/
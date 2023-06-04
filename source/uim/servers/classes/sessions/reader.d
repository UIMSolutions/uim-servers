module uim.servers.classes.sessions.reader;

import uim.servers;
@safe:

class DSRVSessionReader {
  this(DSRVApi api) { _api = api; }

  mixin(OProperty!("DSRVApi", "api"));
  mixin(OProperty!("DSRVSession", "servSession"));

  DSRVSession read(HTTPServerRequest req, STRINGAA reqParameters) {
    debug writeln(moduleName!DSRVSessionReader~":DSRVSessionReader::read");
    DSRVSession srvSession;
    string reqSessionId;
    if (!req) debug writeln(moduleName!DSRVSessionReader~":DSRVSessionReader::read - missing request");
    if (!req.session) { debug writeln(moduleName!DSRVSessionReader~":DSRVSessionReader::read - mising request session"); }
    else {
      debug writeln(moduleName!DSRVSessionReader~":DSRVSessionReader::read - httpSessionId exists");
      reqSessionId = req.session.id;
      srvSession = srvSessions.get(reqSessionId, null); // Existing Session?
    }

    if (!srvSession) debug writeln(moduleName!DSRVSessionReader~":DSRVSessionReader::read - missing srvSession");
    
    debug writeln(moduleName!DSRVSessionReader~":DSRVSessionReader::read - XXXX");

    if (reqSessionId.length > 0) 
      debug writeln(moduleName!DSRVSessionReader~":DSRVSessionReader::read - x1x");
    if (srvSession is null)  
      debug writeln(moduleName!DSRVSessionReader~":DSRVSessionReader::read - x2x");

    if (reqSessionId.length > 0 && srvSession is null) { // httpSession exitsts New Session
      debug writeln(moduleName!DSRVSessionReader~":DSRVSessionReader::read - httpSessionId exists srvSession is missing");
      debug writeln(moduleName!DSRVSessionReader~":DSRVSessionReader::read - Creating new srvSession based on httpSession ", reqSessionId);
      srvSession = SRVSession(req.session);

      debug writeln(moduleName!DSRVSessionReader~":DSRVSessionReader::read - Reading session entities");      
      if (api && api.database) {
        foreach (required; api.requiredChecks) {
          switch(required) {
            case "login": 
              srvSession.login = api.database["central", "logins"].findOne(["id": reqParameters.get("loginId", "")]);
              break;
            case "session":
              srvSession.session = api.database["central", "sessions"].findOne(["id": reqParameters.get("sessionId", "")]);
              break;
            case "site": 
              srvSession.site = api.database["central", "sites"].findOne(["id": reqParameters.get("siteId", "")]);
              break;
            case "account": 
              srvSession.account = api.database["central", "accounts"].findOne(["id": reqParameters.get("accountId", "")]);
              break;
            case "user": 
              srvSession.user = api.database["central", "users"].findOne(["id": reqParameters.get("userId", "")]);
              break;
            default: break;
          }        
        }
      }
    }

    debug writeln("----------------------------------------------------------------------------------------------"); 
    if (srvSession) {
      debug writeln("LoginId = %s\tSessionId = %s\tSiteId = %s".format(
      srvSession.login ? srvSession.login.id.toString : "", 
      srvSession.session ? srvSession.session.id.toString : "", 
      srvSession.site ? srvSession.site.id.toString : ""));

      srvSession.lastAccessedOn = toTimestamp(now);
      reqParameters["reqSessionId"] = reqSessionId;
      srvSessions[reqSessionId] = srvSession;
    }
    else {
      debug writeln("No srvSession");
    } 
    debug writeln("----------------------------------------------------------------------------------------------"); 

    return srvSession;
  }
}
auto SRVSessionReader(DSRVApi api) { return new DSRVSessionReader(api); }
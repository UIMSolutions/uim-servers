module uim.servers.apis.login;

@safe:
import uim.servers;

class DSRVLoginData : DSRVApi {
  this() { super(); }

   /*  debug writeln("DSRVLoginData:toString");

    Json result = Json.emptyObject;

    if (this.app) {
      auto loginId = randomUUID.toString;  
      Json loginToken = Json.emptyObject; 
      loginToken["id"] = loginId;  
      loginToken["peer"] = reqParameters.get("peer", "");
      if (auto ds = database) {
        auto account = ds.findOne("central", "accounts", ["name": reqParameters.get("loginAccount", "")]);
        if (account == Json(null)) 
          loginToken["accountId"] = ""; 
        else 
          loginToken["accountId"] = account["id"];

        loginToken["lastAccessOn"] = toTimestamp(now());
        loginToken["lastAccessDate"] = now.toISOString;

        ds.insertOne("central", "logins", loginToken);  
        result["loginId"] = loginId;
        result["messages"] = Json.emptyArray;
        result["status"] = 201;
      }
    }
    return result.toString.strip(); */
}
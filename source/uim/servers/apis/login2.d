module uim.servers.apis.login2;

@safe:
import uim.servers;

class DSRVLogin2Data : DSRVApi {
  this() { super(); }
  
/*     Json result = Json.emptyObject;
    result["messages"] = Json.emptyArray;

    string accountId;
    string userId;

    auto loginId = reqParameters.get("loginId", "");
    
    if (auto ds = database) {
      auto loginToken = ds.findOne("central", "logins", ["id": loginId]);
      if (loginToken == Json(null)) {
        result["status"] = 401;

        auto message = Json.emptyObject;
        message["status"] = "ERROR";
        message["title"] = "Kennung fehlt";
        message["description"] = "Bitte geben Sie zuerst Ihre Kennung ein. "~
          BS5ButtonLink(["href":"/login"], tablerIcon("login")~" Zur Anmeldung").toString;

        result["messages"] ~= message;
        return result.toString;
      }

      accountId = loginToken["accountId"].get!string;
      auto account = ds.findOne("central", "accounts", ["id":accountId]);
      if (account == Json(null)) { // Unknown account
        result["status"] = 401;

        auto message = Json.emptyObject;
        message["status"] = "ERROR";
        message["title"] = "Kennung oder Passwort";
        message["description"] = "Waren Ihre Eingaben korrekt oder sind Sie bei uns registriert?"~
          BS5ButtonLink(["href":"/login"], tablerIcon("login")~" Zur Anmeldung").toString;

        result["messages"] ~= message;
        return result.toString;        
      }    

      auto password = ds.findOne("central", "passwords", ["accountId":accountId]);
      if (password == Json(null)) { // Unknown password
        result["status"] = 401;

        auto message = Json.emptyObject;
        message["status"] = "ERROR";
        message["title"] = "Kennung oder Passwort";
        message["description"] = "Waren Ihre Eingaben korrekt oder sind Sie bei uns registriert?"~
          BS5ButtonLink(["href":"/login"], tablerIcon("login")~" Zur Anmeldung").toString;

        result["messages"] ~= message;
        return result.toString;        
      }

      if ("loginPW" !in reqParameters) { // Missing password
        result["status"] = 401;

        auto message = Json.emptyObject;
        message["status"] = "ERROR";
        message["title"] = "Kennung oder Passwort";
        message["description"] = "Waren Ihre Eingaben korrekt oder sind Sie bei uns registriert?"~
          BS5ButtonLink(["href":"/login"], tablerIcon("login")~" Zur Anmeldung").toString;

        result["messages"] ~= message;
        return result.toString;  
      }

      if (password["display"] != toHexString(sha512Of(reqParameters.get("loginPW", "")))) { // Wrong password
        debug writeln("Wrong Password -> ", password["display"], 
          " vs. ", toHexString(sha512Of(reqParameters.get("loginPW", ""))));
        result["status"] = 401;

        auto message = Json.emptyObject;
        message["status"] = "ERROR";
        message["title"] = "Kennung oder Passwort";
        message["description"] = "Waren Ihre Eingaben korrekt oder sind Sie bei uns registriert?"~
          BS5ButtonLink(["href":"/login"], tablerIcon("login")~" Zur Anmeldung").toString;

        result["messages"] ~= message;
        return result.toString;  
      }

      userId = account["userId"].get!string;
      debug writeln("Looking for user ", userId);
      auto user = ds.findOne("central", "users", ["id":userId]);
      if (user == Json(null)) { // Unknown account
        debug writeln("user not found");
        result["status"] = 401;

        auto message = Json.emptyObject;
        message["status"] = "ERROR";
        message["title"] = "Benutzer unbekannt";
        message["description"] = "Waren Ihre Eingaben korrekt oder sind Sie noch nicht registriert?"~
          BS5ButtonLink(["href":"/login"], tablerIcon("login")~" Zur Anmeldung").toString;

        result["messages"] ~= message;
        return result.toString;        
      }

      auto responseSession = _response.startSession();
      auto sessionId = randomUUID.toString;
      responseSession.set("loginId", loginId);
      responseSession.set("sessionId", sessionId);

      const myNow = now();
      const myTimestamp = toTimestamp(myNow);
      Json session = Json.emptyObject; 
      session["id"] = sessionId;
      session["createdOn"] = myTimestamp;
      session["createdDateTime"] = myNow.toISOString;
      session["peer"] = reqParameters.get("peer", "");
      session["accountId"] = accountId;
      session["userId"] = userId;
      session["lastAccessedOn"] = myTimestamp;
      session["lastAccessedDate"] = myNow.toISOString;

      debug writeln("sessionToken -> ", session);
      ds.insertOne("central", "sessions", session);  

      result["sessionId"] = sessionId;
      result["status"] = 201;

      return result.toString;
      }
      return "";
  */ 
}
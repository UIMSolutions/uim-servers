module uim.servers.apis.register;

@safe:
import uim.servers;

class DSRVRegisterData : DSRVApi {
  this() { super(); }

  mixin(SProperty!("string", "dbName"));
  mixin(SProperty!("string", "poolName"));


/*     auto result = super.toJson(reqParameters);
    if (result["error"].get!int > 0) return result;
  
    string sessionId;
    if ("sessionId" in result) sessionId = result["sessionId"].get!string;

    return result; */
  
}
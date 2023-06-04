/*********************************************************************************************************
	copyright: © 2015-2023 ozan nurettin süel (sicherheitsschmiede)                                        
	license: subject to the terms of the apache 2.0 license, as written in the included license.txt file.  
	authors: ozan nurettin süel (sicherheitsschmiede)                                                      
**********************************************************************************************************/
module uim.servers.classes.apis.register;

import uim.servers;
@safe:

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
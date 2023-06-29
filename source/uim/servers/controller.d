/*********************************************************************************************************
	copyright: © 2015-2023 ozan nurettin süel (sicherheitsschmiede)                                        
	license: subject to the terms of the apache 2.0 license, as written in the included license.txt file.  
	authors: ozan nurettin süel (sicherheitsschmiede)                                                      
**********************************************************************************************************/
module uim.servers.controller;

import uim.servers;
@safe:

class DSRVController : DController {
  this() {}
  this(DSRVApi myApi) { this(); this.api(myApi); }

  mixin(SProperty!("DSRVApi", "api"));

  Json run(STRINGAA parameters) {
    auto json = Json.emptyObject;
    json["errors"] = Json.emptyArray;
    json["warnings"] = Json.emptyArray;
    json["infos"] = Json.emptyArray;
    json["result"] = Json.emptyObject;

    return json;
  }
}
auto SRVController() { return new DSRVController; }
auto SRVController(DSRVApi myApi) { return new DSRVController(myApi); }

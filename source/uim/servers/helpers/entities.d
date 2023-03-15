/*********************************************************************************************************
	copyright: © 2015-2023 ozan nurettin süel (sicherheitsschmiede)                                        
	license: subject to the terms of the apache 2.0 license, as written in the included license.txt file.  
	authors: ozan nurettin süel (sicherheitsschmiede)                                                      
**********************************************************************************************************/
module uim.servers.helpers.entities;

@safe:
import uim.servers;

string getEntityId(HTTPServerRequest req, STRINGAA reqParameters) {
  return reqParameters.get("entity_id", reqParameters.get("id", ""));
} 
  
string getEntityId(DETBBase database, string sessionId, STRINGAA reqParameters) { 
  if (database) return getEntityId(database["central", "sessions"].findOne(["id":sessionId]).toJson, reqParameters);
  return getEntityId(reqParameters);
} 

string getEntityId(Json sessionToken, STRINGAA reqParameters) {
  if (sessionToken != Json(null)) {
    if ("entityId" in sessionToken) return sessionToken["entityId"].get!string;
  }
  return getEntityId(reqParameters);
} 

string getEntityId(STRINGAA reqParameters) {
  return reqParameters.get("entityId", null);
} 

auto getEntity(DETBBase database, string id) {
  if (database) return database["central", "entities"].findOne(["id":id]);
  return null;
} 

auto getEntity(Json sessionToken, DETBBase database, string id) {
  if ((sessionToken != Json(null)) && ("entityId" in sessionToken)) {
    return database["central", "entities"].findOne(["id":sessionToken["entityId"].get!string]);
  }
  // else if ((result == Json(null)) && (database)) return database.findOne("central", "entities", ["id":id]);
  
  return null;
} 

auto getEntitySites(DETBBase database, string id) {
  DEntity[] sites;
  if (auto entity = getEntity(database, id)) {
    foreach (entityId; entity["sites"].split(";")) {
      if (auto site = getSite(database, UUID(entityId))) sites ~= site;
    }
  } 

  return sites;
} 
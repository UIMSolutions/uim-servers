/*********************************************************************************************************
	copyright: © 2015-2023 ozan nurettin süel (sicherheitsschmiede)                                        
	license: subject to the terms of the apache 2.0 license, as written in the included license.txt file.  
	authors: ozan nurettin süel (sicherheitsschmiede)                                                      
**********************************************************************************************************/
module uim.servers.helpers.entities;

import uim.servers;
@safe:

string getEntityId(HTTPServerRequest req, STRINGAA reqParameters) {
  return reqParameters.get("entity_id", reqParameters.get("id", ""));
} 
  
string getEntityId(DEntityBase entityBase, string sessionId, STRINGAA reqParameters) { 
  if (entityBase) return getEntityId(entityBase.entityTenant("central").entityCollection("sessions").findOne(["id":sessionId]).toJson, reqParameters);
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

auto getEntity(DEntityBase entityBase, string id) {
  if (entityBase) return entityBase.entityTenant("central").entityCollection("entities").findOne(["id":id]);
  return null;
} 

auto getEntity(Json sessionToken, DEntityBase entityBase, string id) {
  if ((sessionToken != Json(null)) && ("entityId" in sessionToken)) {
    return entityBase.entityTenant("central").entityCollection("entities").findOne(["id":sessionToken["entityId"].get!string]);
  }
  // else if ((result.isEmpty) && (database)) return database.findOne("central", "entities", ["id":id]);
  
  return null;
} 

auto getEntitySites(DEntityBase database, string id) {
  // Preconditions
  if (database is null || id.isEmpty) { return null; }

  // Body
  auto entity = getEntity(database, id);
  if (entity is null) { return null; }

  return entity["sites"].split(";")
    .map!(uuid => getSite(database, UUID(uuid)))
    .filter!(s => s !is null) 
    .each!(s => sites ~= s);
} 
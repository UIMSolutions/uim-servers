module uim.servers.helpers.sites;

import uim.servers;
@safe:

string getSiteId(DEntityBase entityBase, string sessionId, STRINGAA reqParameters) { 
  if (entityBase) 
    if (auto dbSession = entityBase.tenant("central").collection("sessions").findOne(["id":reqParameters.get("sessionId", "")]))
      if (dbSession["siteId"].isUUID) return dbSession["siteId"];
  return getSiteId(reqParameters);
} 

string getSiteId(Json sessionToken, STRINGAA reqParameters) {
  if (sessionToken != Json(null)) 
    if ("siteId" in sessionToken) return sessionToken["siteId"].get!string;
  return getSiteId(reqParameters);
} 

string getSiteId(STRINGAA reqParameters) {
  return reqParameters.get("siteId", null); } 

// #region getSite
auto getSite(Json sessionToken, DEntityBase database, string id) {
  if ((sessionToken != Json(null)) && ("siteId" in sessionToken))
    return getSite(database, sessionToken["siteId"].get!string);
  
  return null; }

auto getSite(DEntityBase entityBase, string id) {
  return id.isUUID ?  getSite(entityBase, UUID(id)) : null; } 

auto getSite(DEntityBase entityBase, UUID id) {
  return entityBase ?  entityBase.tenant("central").collection("sites").findOne(id) : null; } 

// #endregion getSite

auto getSiteApps(DEntityBase entityBase, string id) {
  DEntity[] apps;
  if (auto site = getSite(entityBase, id)) 
    foreach (appId; site["apps"].split(";")) 
      if (auto app = getApp(entityBase, appId)) apps ~= app;

  return apps;
} 
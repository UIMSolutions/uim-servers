module uim.servers.helpers.sites;

@safe:
import uim.servers;

string getSiteId(DETBBase database, string sessionId, STRINGAA reqParameters) { 
  if (database) 
    if (auto dbSession = database["central", "sessions"].findOne(["id":reqParameters.get("sessionId", "")]))
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
auto getSite(Json sessionToken, DETBBase database, string id) {
  if ((sessionToken != Json(null)) && ("siteId" in sessionToken))
    return getSite(database, sessionToken["siteId"].get!string);
  
  return null; }

auto getSite(DETBBase database, string id) {
  return id.isUUID ?  getSite(database, UUID(id)) : null; } 

auto getSite(DETBBase database, UUID id) {
  return database ?  database["central", "sites"].findOne(id) : null; } 

// #endregion getSite

auto getSiteApps(DETBBase database, string id) {
  DOOPEntity[] apps;
  if (auto site = getSite(database, id)) 
    foreach (appId; site["apps"].split(";")) 
      if (auto app = getApp(database, appId)) apps ~= app;

  return apps;
} 
module uim.servers.helpers.users;

@safe:
import uim.servers;

/* string getUserId(DETBBase database, string sessionId, STRINGAA reqParameters) { 
  auto dbUser = getUser(database, sessionId);
  if (dbUser) return getUserId(dbUser, reqParameters);
  return getUserId(reqParameters);
} 

string getUserId(Json sessionToken, STRINGAA reqParameters) {
  if (sessionToken != Json(null)) {
    if ("userId" in sessionToken) return sessionToken["userId"].get!string;
  }
  return getUserId(reqParameters);
} 

string getUserId(STRINGAA reqParameters) {
  return reqParameters.get("userId", null);
} 
 */
// #region getUser
auto getUser(Json sessionToken, DETBBase database, string id) {
  DEntity user;

  if (database) {
    if (sessionToken != Json(null) && "userId" in sessionToken) // Try to find user from sessionToken 
      user = getUser(database, sessionToken["userId"].get!string); 
    if (!user && id.isUUID) // Not found user, try again 
      user = getUser(database, id);
  }

  return user;
} 

auto getUser(DETBBase database, string id) {
  return id.isUUID ? getUser(database, UUID(id)) : null;
} 

auto getUser(DETBBase database, UUID id) {
  return database ? database["central", "users"].findOne(id) : null;
} 
// #endregion getUser

auto getUserSites(DETBBase database, string id) {
  DEntity[] dbSites;
  if (auto dbUser = getUser(database, id)) // User in db exists 
    foreach (siteId; dbUser["sites"].split(";")) // For every siteId  
      if (auto dbSite = getSite(database, UUID(siteId))) // If site exists in db 
        dbSites ~= dbSite;

  return dbSites;
} 
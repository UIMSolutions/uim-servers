module uim.servers.helpers.users;

import uim.servers;
@safe:

/* string getUserId(DEntityBase database, string sessionId, STRINGAA reqParameters) { 
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
auto getUser(Json sessionToken, DEntityBase entityBase, string id) {
  DEntity user;

  if (entityBase) {
    if (sessionToken != Json(null) && "userId" in sessionToken) // Try to find user from sessionToken 
      user = getUser(entityBase, sessionToken["userId"].get!string); 
    if (!user && id.isUUID) // Not found user, try again 
      user = getUser(database, id);
  }

  return user;
} 

auto getUser(DEntityBase entityBase, string id) {
  return id.isUUID ? getUser(entityBase, UUID(id)) : null;
} 

auto getUser(DEntityBase entityBase, UUID id) {
  return entityBase ? entityBase["central", "users"].findOne(id) : null;
} 
// #endregion getUser

auto getUserSites(DEntityBase entityBase, string id) {
  DEntity[] dbSites;
  if (auto dbUser = getUser(entityBase, id)) // User in db exists 
    foreach (siteId; dbUser["sites"].split(";")) // For every siteId  
      if (auto dbSite = getSite(entityBase, UUID(siteId))) // If site exists in db 
        dbSites ~= dbSite;

  return dbSites;
} 
module uim.servers.helpers.sessions;

import uim.servers;
@safe:

auto getSessionToken(DEntityBase database, string sessionId) {
  if (database) 
    if (auto session = database["central", "sessions"].findOne(["id": sessionId])) return session.toJson;
  return Json(null);
} 

Json getSessionToken(DEntityBase database, HTTPServerRequest req, STRINGAA reqParameters) {
  return getSessionToken(database, readSessionId(req, reqParameters));
}


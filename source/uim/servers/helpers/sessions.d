module uim.servers.helpers.sessions;

import uim.servers;
@safe:

auto getSessionToken(DETBBase database, string sessionId) {
  if (database) 
    if (auto session = database["central", "sessions"].findOne(["id": sessionId])) return session.toJson;
  return Json(null);
} 

Json getSessionToken(DETBBase database, HTTPServerRequest req, STRINGAA reqParameters) {
  return getSessionToken(database, readSessionId(req, reqParameters));
}


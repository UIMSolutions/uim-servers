module uim.servers.helpers.sessions;

import uim.servers;
@safe:

auto getSessionToken(DEntityBase entityBase, string sessionId) {
  if (entityBase) 
    if (auto session = entityBase.tenant("central").collection("sessions").findOne(["id": sessionId])) return session.toJson;
  return Json(null);
} 

Json getSessionToken(DEntityBase entityBase, HTTPServerRequest req, STRINGAA reqParameters) {
  return getSessionToken(entityBase, readSessionId(req, reqParameters));
}


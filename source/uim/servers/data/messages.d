module uim.servers.data.messages;

import uim.servers;
@safe:

Json messageDeleteSuccess(string entity, string name) {
  Json result = Json.emptyObject;
  result["type"] = "INFO";
  result["title"] = entity~" gelöscht";
  result["description"] = entity~" unter dem Namen '%s' wurde gelöscht.".format(name);
  return result;
}
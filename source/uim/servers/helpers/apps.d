module uim.servers.helpers.apps;

@safe:
import uim.servers;

auto getApp(DETBBase database, string id) {
  if (database) return database["central", "apps"].findOne(["id":id]);
  return null; }
unittest {
  version(uim_servers) {
    // TODO
  }}
 
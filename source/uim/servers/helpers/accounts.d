/*********************************************************************************************************
	copyright: © 2015-2023 ozan nurettin süel (sicherheitsschmiede)                                        
	license: subject to the terms of the apache 2.0 license, as written in the included license.txt file.  
	authors: ozan nurettin süel (sicherheitsschmiede)                                                      
**********************************************************************************************************/
module uim.servers.helpers.accounts;

import uim.servers;
@safe:

auto getAccount(DETBBase database, string id) {
  return database ? database["central", "accounts"].findOne(["id":id]) : null; }
unittest {
  version(uim_servers) {
    // TODO
  }}

auto getAccountPasswords(DETBBase database, string id) {
  auto account = getAccount(database, id);
  if (account) return database["central", "passwords"].findMany(["accountId":account["id"]]);
  return null; } 
unittest {
  version(uim_servers) {
    // TODO
  }}

auto getAccountPasswordActive(DETBBase database, string id) {
  if (auto account = getAccount(database, id)) {
    auto selector = Json.emptyObject;
    selector["accountId"] = account["id"];
    selector["active"] = true;
    return database["central", "passwords"].findOne(selector); } 

  return null; }
unittest {
  version(uim_servers) {
    // TODO
  }}

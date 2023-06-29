/*********************************************************************************************************
	copyright: © 2015-2023 ozan nurettin süel (sicherheitsschmiede)                                        
	license: subject to the terms of the apache 2.0 license, as written in the included license.txt file.  
	authors: ozan nurettin süel (sicherheitsschmiede)                                                      
**********************************************************************************************************/
module uim.servers.helpers.accounts;

import uim.servers;
@safe:

auto getAccount(DEntityBase entityBase, string id) {
  return entityBase ? entityBase.tenant("central").collection("accounts").findOne(["id":id]) : null; 
}

auto getAccountPasswords(DEntityBase entityBase, string id) {
  auto account = getAccount(entityBase, id);
  if (account) return entityBase.tenant("central").collection("passwords").findMany(["accountId":account["id"]]);
  return null; 
} 

auto getAccountPasswordActive(DEntityBase entityBase, string id) {
  if (auto account = getAccount(entityBase, id)) {
    auto selector = Json.emptyObject;
    selector["accountId"] = account["id"];
    selector["active"] = true;
    return entityBase.tenant("central").collection("passwords").findOne(selector); } 

  return null; 
}

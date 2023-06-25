/*********************************************************************************************************
	copyright: © 2015-2023 ozan nurettin süel (sicherheitsschmiede)                                        
	license: subject to the terms of the apache 2.0 license, as written in the included license.txt file.  
	authors: ozan nurettin süel (sicherheitsschmiede)                                                      
**********************************************************************************************************/
module uim.servers.helpers.apps;

import uim.servers;
@safe:

auto getApp(DEntityBase database, string id) {
  if (database) return database["central", "apps"].findOne(["id":id]);
  return null; }
unittest {
  version(uim_servers) {
    // TODO
  }}
 
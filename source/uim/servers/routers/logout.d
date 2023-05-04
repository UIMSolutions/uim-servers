/*********************************************************************************************************
	Copyright: © 2015-2023 Ozan Nurettin Süel (Sicherheitsschmiede)                                        
	License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.  
	Authors: Ozan Nurettin Süel (Sicherheitsschmiede)                                                      
**********************************************************************************************************/
module uim.servers.routers.logout;

import uim.servers;
@safe:

void uimLogout(HTTPServerRequest req, HTTPServerResponse res) {
  debugMethodCall(moduleName!uimLogout~":uimLogout");

  LogoutPageController(thisServer).request(req, res);
}
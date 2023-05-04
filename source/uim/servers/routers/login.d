/*********************************************************************************************************
	Copyright: © 2015-2023 Ozan Nurettin Süel (Sicherheitsschmiede)                                        
	License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.  
	Authors: Ozan Nurettin Süel (Sicherheitsschmiede)                                                      
**********************************************************************************************************/
module uim.servers.routers.login;

import uim.servers;
@safe:

void uimLoginPage(HTTPServerRequest req, HTTPServerResponse res) {
  debugMethodCall(moduleName!uimLoginPage~":uimLoginPage");

  LoginPageController(thisServer).request(req, res);
}

void uimLoginAction(HTTPServerRequest req, HTTPServerResponse res) {
  debugMethodCall(moduleName!uimLoginAction~":uimLoginAction");

  LoginActionController(thisServer).request(req, res);
}
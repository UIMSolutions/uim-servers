/*********************************************************************************************************
	copyright: © 2015-2023 ozan nurettin süel (sicherheitsschmiede)                                        
	license: subject to the terms of the apache 2.0 license, as written in the included license.txt file.  
	authors: ozan nurettin süel (sicherheitsschmiede)                                                      
**********************************************************************************************************/
module uim.servers;

mixin(ImportPhobos!());

public import vibe.d;

mixin ImportUimBase;
@safe:

public { // Web based libraries
  import langs.javascript;
  import uim.html;
  import uim.mvc;
}

mixin(ImportMVC!("uim.servers"));

public {
  import uim.servers.obj;
  import uim.servers.server;

  import uim.servers.apis;
  import uim.servers.caches;
  import uim.servers.data.helpers;
  import uim.servers.data.messages;
  import uim.servers.data.helpers;
  import uim.servers.data.messages;
  import uim.servers.events;
  import uim.servers.forms;
  import uim.servers.helpers;
  import uim.servers.interfaces;
  import uim.servers.layouts;
  import uim.servers.logs;
  import uim.servers.helpers;
  import uim.servers.mixins;
  import uim.servers.securities;
  import uim.servers.sessions;
}

bool notValidSession(string sessionToken, string[string] parameters = null) { return !isValidSession(sessionToken, parameters); }

bool isValidSession(string sessionToken, string[string] parameters = null) {
  if (sessionToken == "demo") return true;
  return false;
}

DSRVSession[string] srvSessions;

// CRUDI router calls
template routerEntityCalls(string callName, string controllerName, string serverApp) {
  const char[] routerEntityCalls = `
void `~callName~`Index(HTTPServerRequest req, HTTPServerResponse res) {
  debugMethodCall(moduleName!`~callName~`Index~":`~callName~`Index");
  `~controllerName~`IndexPageController(`~serverApp~`).request(req, res);
}
void `~callName~`Create(HTTPServerRequest req, HTTPServerResponse res) {
  debugMethodCall(moduleName!`~callName~`Create~":`~callName~`Create");
  `~controllerName~`CreatePageController(`~serverApp~`).request(req, res);
}
void `~callName~`Read(HTTPServerRequest req, HTTPServerResponse res) {
  debugMethodCall(moduleName!`~callName~`Read~":`~callName~`Read");
  `~controllerName~`ReadPageController(`~serverApp~`).request(req, res);
}
void `~callName~`Update(HTTPServerRequest req, HTTPServerResponse res) {
  debugMethodCall(moduleName!`~callName~`Update~":`~callName~`Update");
  `~controllerName~`UpdatePageController(`~serverApp~`).request(req, res);
}
void `~callName~`Delete(HTTPServerRequest req, HTTPServerResponse res) {
  debugMethodCall(moduleName!`~callName~`Delete~":`~callName~`Delete");
  `~controllerName~`DeletePageController(`~serverApp~`).request(req, res);
}
  `;
}

DServer thisServer;
string[size_t] errorMessages;


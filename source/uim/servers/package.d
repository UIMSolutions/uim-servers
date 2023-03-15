module uim.servers;

@safe:
public import std.algorithm;
public import std.digest.sha;
public import std.stdio;
public import std.string;
public import std.uuid;

public import vibe.d;

mixin ImportUimBase;

public { // Web based libraries
  import uim.javascript;
  import uim.html;
  import uim.mvc;
}

public {
  import uim.servers.apis;
  import uim.servers.controllers;
  import uim.servers.data.helpers;
  import uim.servers.data.messages;
  import uim.servers.data.helpers;
  import uim.servers.data.messages;
  import uim.servers.events;
  import uim.servers.server;
  import uim.servers.securities;
  import uim.servers.helpers;
  import uim.servers.mixins;
  import uim.servers.sessions;
  import uim.servers.views;
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

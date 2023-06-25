module uim.servers.mixins;

import uim.servers;
@safe:

public {
  import uim.servers.mixins.config;
  import uim.servers.mixins.server;
  import uim.servers.mixins.sessionmanager;
  import uim.servers.mixins.settings;
}

mixin template ImportDubs() {
  public import vibe.d;
}

mixin template ImportUim() {
  public import uim.core;
  public import uim.oop;
  public import uim.html;
  public import langs.javascript;
  public import uim.bootstrap;
  public import uim.models;
}

template ImportLocal(string name) {
  const char[] ImportLocal = `
//public import servers.`~name~`.apis;
public import servers.`~name~`.components;
//public import servers.`~name~`.layouts;
//public import servers.`~name~`.pages;
  `;
}



template SetHTTP() {
  const char[] SetHTTP = `
  if ((httpMode == "OnlyHttp") || (httpMode == "HttpAndHttps")) {
    auto settings = new HTTPServerSettings;
    settings.port = httpPort;
    settings.bindAddresses = httpAddresses;
    settings.sessionStore = new MemorySessionStore;
    settings.accessLogger = new vibe.http.log.HTTPFileLogger(settings, httpLogFormat, "./logs/"~serverName~"-http-"~now().toISOString~".log");
    listenHTTP(settings, router);
  }
  if ((httpMode == "OnlyHttps") || (httpMode == "HttpAndHttps")) {
    auto settings = new HTTPServerSettings;
    settings.port = httpPort;
    settings.sessionStore = new MemorySessionStore;
    settings.bindAddresses = httpsAddresses;
    settings.accessLogger = new vibe.http.log.HTTPFileLogger(settings, httpsLogFormat, "./logs/"~serverName~"-https-"~now().toISOString~".log");
    settings.tlsContext = createTLSContext(TLSContextKind.server);
    settings.tlsContext.useCertificateChainFile(tlsChain);	
    settings.tlsContext.usePrivateKeyFile(tlsPrivate);
    listenHTTP(settings, router);
  }`;
}

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
module uim.servers.mixins;

@safe:
import uim.servers;

mixin template ImportDubs() {
  public import vibe.d;
}

mixin template ImportUim() {
  public import uim.core;
  public import uim.oop;
  public import uim.html;
  public import uim.javascript;
  public import uim.bootstrap;
  public import uim.entities;
}

template ImportLocal(string name) {
  const char[] ImportLocal = `
//public import servers.`~name~`.apis;
public import servers.`~name~`.components;
//public import servers.`~name~`.layouts;
//public import servers.`~name~`.pages;
  `;
}

mixin template DefaultConfig(string appName, int portHttp = 9000, int portHttps = 9100) {
  // Defaults
  auto configFile = "config.json";
  auto serverName = appName;  
  auto rootPath = "/";
  auto serverMode = "debug";  
  auto httpMode = "OnlyHttp";
  // http
  ushort httpPort = portHttp;
  auto httpAddresses = ["::1", "127.0.0.1"];
  auto httpLogFormat = `{ "app":"`~appName~`", "ipaddress":"%h", "timerequest":"%t", "getrequest":"%r", "statuscode":%s, "sizeresponse":%b, "referer":"%{Referer}i", "useragent":"%{User-Agent}i"}`;
  // https
  ushort httpsPort = portHttps;
  auto httpsAddresses = ["::1", "127.0.0.1"];
  auto httpsLogFormat = `{ "app":"`~appName~`", "ipaddress":"%h", "timerequest":"%t", "getrequest":"%r", "statuscode":%s, "sizeresponse":%b, "referer":"%{Referer}i", "useragent":"%{User-Agent}i"}`;
  auto tlsChain = "";
  auto tlsPrivate = "";
  // Database
  auto dbMode = "mongo";
  auto dbString = "mongodb://127.0.0.1:27018/?safe=true";
  // Logging
  auto logMode = "file";
  auto logPath = "logs";
}

mixin template ReadConfig() {
  void readConfig() {
    Json serverConfig = Json.emptyObject;
    if (configFile.exists) {
      try {
        serverConfig = parseJsonString(readText(configFile)); 

        foreach(kv; serverConfig.byKeyValue) {
          switch(kv.key) {
            // Config general
            case "serverName": serverName = kv.value.get!string; break;
            case "serverMode": serverMode = kv.value.get!string; break;
            case "rootPath": rootPath = kv.value.get!string; break;
            case "httpMode": httpMode = kv.value.get!string; break;
            // Config http
            case "httpPort": httpPort = kv.value.get!ushort; break;
            case "httpAddresses": httpAddresses = null;
              foreach(v; kv.value.get!(Json[])) httpAddresses ~= v.get!string; 
              break;
            case "httpLogFormat": httpLogFormat = kv.value.get!string; break;
            // Config https
            case "httpsPort": httpsPort = kv.value.get!ushort; break;
            case "httpsAddresses": httpsAddresses = null;
              foreach(v; kv.value.get!(Json[])) httpsAddresses ~= v.get!string; 
              break;
            case "httpsLogFormat": httpsLogFormat = kv.value.get!string; break;
            case "tlsChain": tlsChain = kv.value.get!string; break;
            case "tlsPrivate": tlsPrivate = kv.value.get!string; break;
            // Database
            case "dbMode": dbMode = kv.value.get!string; break;
            case "dbString": dbString = kv.value.get!string; break;
            // Logging
            case "logMode": logMode = kv.value.get!string; break;
            case "logPath": logPath = kv.value.get!string; break;
            default: break;
          }
        }
      }
      catch(Exception e) {
        writeln(e);
      }
    }
    if (!logPath.exists) logPath.mkdir;
  }
}

mixin template GetoptConfig() {
  auto helpInformation = std.getopt.getopt(
    args,
    // App or Server specific 
    "serverName",  &serverName,    
    "serverMode",  &serverMode,    
    "rootPath",  &rootPath,    
    // Http - Https
    "httpMode",    &httpMode,      
    //https
    "httpPort", &httpPort,   
    "httpAddresses", &httpAddresses,   
    "httpLogFormat", &httpLogFormat,   
    // Https
    "httpsPort", &httpsPort,   
    "httpsAddresses", &httpsAddresses,   
    "httpsLogFormat", &httpsLogFormat,   
    "tlsChain", &tlsChain,   
    "tlsPrivate", &tlsPrivate,   
    // Database
    "dbMode", &dbMode,   
    "dbString", &dbString,   
    // Loghing
    "logMode", &logMode,   
    "logPath", &logPath   
  );
}

template SetRouterDefault() {
  const char[] SetRouterDefault = `
  auto pathToBaseResources = "../../PUBLIC/";
	router
		.get("/css/*", serveStaticFiles(pathToBaseResources))
		.get("/data/*", serveStaticFiles(pathToBaseResources))
		.get("/lib/*", serveStaticFiles(pathToBaseResources))
		.get("/font/*", serveStaticFiles(pathToBaseResources))
		.get("/img/*", serveStaticFiles(pathToBaseResources))
		.get("/js/*", serveStaticFiles(pathToBaseResources))
		.get("/vue/*", serveStaticFiles(pathToBaseResources))
		.get("/react/*", serveStaticFiles(pathToBaseResources))
		.get("/theme/*", serveStaticFiles(pathToBaseResources))
		.get("/font/*", serveStaticFiles(pathToBaseResources))
		.get("/templ/*", serveStaticFiles(pathToBaseResources))
		.get("/plugin/*", serveStaticFiles(pathToBaseResources))
		.get("/page/*", serveStaticFiles(pathToBaseResources));
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
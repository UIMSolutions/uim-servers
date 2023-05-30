module uim.servers.mixins.config;

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
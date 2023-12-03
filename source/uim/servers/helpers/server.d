module uim.servers.helpers.server;

import uim.servers;
@safe:

void register(URLRouter aRouter, DServer aServer, string[] methods = null) {
  if (!methods) {
    aRouter.any(aServer.rootPath, &(aServer.request));
    return;
  }

  methods.each!(method => addToRouterByMethod(aRouter, aServer, method));
}

void addToRouterByMethod(URLRouter aRouter, DServer aServer, string method) {
  switch(method.strip.toLower) {
    case "delete": 
      aRouter.delete_(aServer.rootPath, &(aServer.request));
      break;      
    case "get": 
      aRouter.get(aServer.rootPath, &(aServer.request));
      break;      
    case "patch": 
      aRouter.patch(aServer.rootPath, &(aServer.request));
      break;      
    case "put": 
      aRouter.put(aServer.rootPath, &(aServer.request));
      break;      
    case "post": 
      aRouter.post(aServer.rootPath, &(aServer.request));
      break;
    default: break;  
  }
}
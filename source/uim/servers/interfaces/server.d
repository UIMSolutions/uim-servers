module uim.servers.interfaces.server;

import uim.servers;
@safe:

interface IServer {
  void request(HTTPServerRequest newRequest, HTTPServerResponse newResponse);  
}
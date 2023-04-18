module uim.servers.interfaces.server;

@safe:
import uim.servers;

interface IServer {
  void request(HTTPServerRequest newRequest, HTTPServerResponse newResponse);  
}
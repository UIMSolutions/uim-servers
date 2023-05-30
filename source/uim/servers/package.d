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
  import uim.apps;
}

mixin(ImportMVC!("uim.servers"));

public {
  import uim.servers.obj;
  import uim.servers.server;

  import uim.servers.apis;
  import uim.servers.caches;
  import uim.servers.classes;
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



DServer thisServer;
string[size_t] errorMessages;


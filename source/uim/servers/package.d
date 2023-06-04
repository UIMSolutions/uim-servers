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

public {
  import uim.servers.obj;

  import uim.servers.classes;
  import uim.servers.helpers;
  import uim.servers.interfaces;
  import uim.servers.mixins;
  import uim.servers.tests;
}

bool notValidSession(string sessionToken, string[string] parameters = null) { return !isValidSession(sessionToken, parameters); }

bool isValidSession(string sessionToken, string[string] parameters = null) {
  if (sessionToken == "demo") return true;
  return false;
}

DSRVSession[string] srvSessions;




DServer thisServer;
string[size_t] errorMessages;


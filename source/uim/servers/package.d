/*********************************************************************************************************
	copyright: © 2015-2023 ozan nurettin süel (sicherheitsschmiede)                                        
	license: subject to the terms of the apache 2.0 license, as written in the included license.txt file.  
	authors: ozan nurettin süel (sicherheitsschmiede)                                                      
**********************************************************************************************************/
module uim.servers;

mixin(ImportPhobos!());

// External Libs
public {
  import vibe.d;
  import vibe.http.session : HttpSession = Session;
}

mixin ImportUimBase;

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

@safe:

bool notValidSession(string sessionToken, string[string] parameters = null) { return !isValidSession(sessionToken, parameters); }

bool isValidSession(string sessionToken, string[string] parameters = null) {
  if (sessionToken == "demo") return true;
  return false;
}

DServer thisServer;
string[size_t] errorMessages;


/*********************************************************************************************************
	Copyright: © 2015-2023 Ozan Nurettin Süel (Sicherheitsschmiede)                                        
	License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.  
	Authors: Ozan Nurettin Süel, mailto:ons@sicherheitsschmiede.de                                                      
**********************************************************************************************************/
module uim.mvc.mixins.sessionmanager;

import uim.mvc;
@safe:

mixin template SessionManagerTemplate() {
  protected DSessionContainer _sessionContainer;

  void sessions(DSessionContainer aContainer) {
    _sessionContainer = aContainer;
  }
  DSessionContainer sessions() {
    return _sessionContainer; 
  }

  ISession session(string[string] options) {
    return sessions(options.get("httpSessionId", null));
  }  
  ISession session(string httpSessionId) {
    if (_sessionContainer) return _sessionContainer[httpSessionId, NullSession];
    return null;
  }

  bool existsSession(ISession aSession) {
    return existsSession(aSession.httpSessionId);
  }
  bool existsSession(string httpSessionId) {
    if (_sessionContainer) return (httpSessionId in _sessionContainer ? true : false);
    return false;
  }

  void addSession(ISession aSession) {
    if (aSession) addSession(aSession.httpSessionId, aSession);
  }
  void addSession(string httpSessionId, ISession aSession) {
    if (_sessionContainer && aSession) _sessionContainer.add(httpSessionId, aSession);
  }
  // Update existing session
  void updateSession(ISession aSession) {
    if (aSession) updateSession(aSession.httpSessionId);
  }
  void updateSession(string httpSessionId, ISession aSession) {
    if (_sessionContainer && existsSession(httpSessionId)) _sessionContainer.update(httpSessionId, aSession);
  }

  // Remove existing session
  void removeSession(ISession aSession) {
    if (aSession) removeSession(aSession.httpSessionId);
  }
  void removeSession(string httpSessionId) {
    if (_sessionContainer && existsSession(httpSessionId)) _sessionContainer.remove(httpSessionId);
  }
}
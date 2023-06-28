/*********************************************************************************************************
	Copyright: © 2015-2023 Ozan Nurettin Süel (Sicherheitsschmiede)                                        
	License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.  
	Authors: Ozan Nurettin Süel, mailto:ons@sicherheitsschmiede.de                                                      
**********************************************************************************************************/
module uim.servers.mixins.appmanager;

import uim.servers;
@safe:

mixin template AppManagerTemplate() {
  protected DAppContainer _appContainer;

  void apps(DAppContainer aContainer) {
    _appContainer = aContainer;
  }
  DAppContainer apps() {
    return _appContainer; 
  }

  IApp app(string[string] options) {
    return apps(options.get("httpAppId", null));
  }  
  IApp app(string httpAppId) {
    if (_appContainer) return _appContainer[httpAppId, NullApp];
    return null;
  }

  bool existsApp(IApp aApp) {
    return existsApp(aApp.httpAppId);
  }
  bool existsApp(string httpAppId) {
    if (_appContainer) return (httpAppId in _appContainer ? true : false);
    return false;
  }

  void addApp(IApp aApp) {
    if (aApp) addApp(aApp.httpAppId, aApp);
  }
  void addApp(string httpAppId, IApp aApp) {
    if (_appContainer && aApp) _appContainer.add(httpAppId, aApp);
  }
  // Update existing app
  void updateApp(IApp aApp) {
    if (aApp) updateApp(aApp.httpAppId);
  }
  void updateApp(string httpAppId, IApp aApp) {
    if (_appContainer && existsApp(httpAppId)) _appContainer.update(httpAppId, aApp);
  }

  // Remove existing app
  void removeApp(IApp aApp) {
    if (aApp) removeApp(aApp.httpAppId);
  }
  void removeApp(string httpAppId) {
    if (_appContainer && existsApp(httpAppId)) _appContainer.remove(httpAppId);
  }
}
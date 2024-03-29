/*********************************************************************************************************
	copyright: © 2015-2023 ozan nurettin süel (sicherheitsschmiede)                                        
	license: subject to the terms of the apache 2.0 license, as written in the included license.txt file.  
	authors: ozan nurettin süel (sicherheitsschmiede)                                                      
**********************************************************************************************************/
module uim.servers.classes.apis.api;

import uim.servers;
@safe:

class DSRVApi : DController {
  mixin(ControllerThis!("SRVApi"));

  override bool initialize(IData[string] configSettings = null) {
    super.initialize(configSettings);

    this
      .mimetype("text/json")
      .siteName("central");
  }

  mixin(SProperty!("string[]", "requiredChecks"));

  mixin(SProperty!("string", "api"));
  mixin(SProperty!("string", "pool"));
  mixin(SProperty!("string", "url"));

  mixin(OProperty!("string", "crudMode"));

  mixin(SProperty!("Session", "globalSession"));
  mixin(SProperty!("bool", "hasGlobalSession"));

  mixin(SProperty!("string", "loginId"));

  mixin(SProperty!("string", "sessionId"));

  mixin(SProperty!("string", "siteId"));
  mixin(SProperty!("Json", "site"));
  mixin(SProperty!("string", "siteName"));
  
  mixin(SProperty!("bool", "userRequired"));
  mixin(SProperty!("Json", "user"));

  mixin(SProperty!("bool", "entityRequired"));  
  mixin(SProperty!("Json", "entity"));  

  mixin(SProperty!("DController", "securityController")); 
  mixin(SProperty!("DSRVSecurityOptions", "securityOptions"));
  O securityOptions(this O)(bool[string] newOptions) { this.securityOptions(APPSecurityOptions(newOptions)); return cast(O)this; }  

  /* override */ Json toJson(STRINGAA reqParameters) {
    auto result = Json.emptyObject; // super.toJson(reqParameters);
    if (result["error"].get!int > 0) return result;

    auto httpSessionId = reqParameters.get("httpSessionId", "");
    auto mySession = manager.session(httpSessionId);
   
    if (!entityBase) { // Database missing
      result["status"] = 409;
      result["lastError"] = 409;

      auto message = Json.emptyObject;
      message["status"] = "ERROR";
      message["title"] = "Keine Datenbank";
      message["description"] = "Keine Datenbank";

      result["messages"] ~= message;
      debug writeln("result => ", result.toString);

      return result; } 

    if (!mySession) { // Session missing
      result["status"] = 409;
      result["lastError"] = 409;

      auto message = Json.emptyObject;
      message["status"] = "ERROR";
      message["title"] = "Keine Session";
      message["description"] = "Keine Session";
      return result; }

    if (!mySession.site) { // Site missing
      result["status"] = 409;
      result["lastError"] = 409;

      auto message = Json.emptyObject;
      message["status"] = "ERROR";
      message["title"] = "Keine Site";
      message["description"] = "Keine Site";
      return result; }      

    auto collection = entityBase[mySession.site.name, pool];
    if (!collection) { // Collection missing
      result["status"] = 409;
      result["lastError"] = 409;

      auto message = Json.emptyObject;
      message["status"] = "ERROR";
      message["title"] = "Keine Datenobjekte";
      message["description"] = "Keine Datenobjekte";

      result["messages"] ~= message;
      debug writeln("result => ", result.toString);

      return result; } 

    switch(crudMode) {
      case "list": 
        return doList(reqParameters);
      case "create": 
        return doCreate(reqParameters);
      case "read": 
        return doRead(reqParameters);
      case "update": 
        return doUpdate(reqParameters);
      case "delete": 
        return doDelete(reqParameters);
      default: 
        result["status"] = 409;
        result["lastError"] = 409;

        auto message = Json.emptyObject;
        message["status"] = "ERROR";
        message["title"] = "Unbekannter CRUD Mode";
        message["description"] = "Unbekannter CRUD Mode";

        result["messages"] ~= message;
        debug writeln("result => ", result.toString);

        return result; 
    }
  }

  Json doList(STRINGAA reqParameters) {
    // debug writeln(StyledString("In "~myApi~"/create:toJson...").setForeground(AnsiColor.green).setBackground(AnsiColor.white));

    auto result = Json.emptyObject; // super.toJson(reqParameters);
    if (result["lastError"].get!size_t > 0) return result;
    
    auto mySessionId = reqParameters.get("sessionId", "");
    auto mySession = manager.session(mySessionId);

    auto entities = entityBase[siteName ? siteName : mySession.site.name, pool].findMany;
    result["entities"] = entities.toJson;

    return result;
  }

  Json doCreate(STRINGAA reqParameters) {
    // debug writeln(StyledString("In "~myApi~"/create:toJson...").setForeground(AnsiColor.green).setBackground(AnsiColor.white));

    auto result = Json.emptyObject; // super.toJson(reqParameters);
    if (result["lastError"].get!size_t > 0) return result;
    
    auto mySessionId = reqParameters.get("sessionId", "");
    auto mySession = manager.session(mySessionId);

    if (auto entity = entityBase ? entityBase[mySession.site.name, pool].createFromTemplate : null) {
      entity.readFromRequest(reqParameters);
          
      // id exists?
      auto id = entity.id.toString;
      if(entityBase[siteName ? siteName : mySession.site.name, pool].count(entity.id)) {
        debug writeln("Found an entity: "); 
        result["status"] = 409;
        result["lastError"] = 409;

        auto message = Json.emptyObject;
        message["status"] = "ERROR";
        message["title"] = "Entity vorhanden";
        message["description"] = "Entity '%s' ist unter der angegebenen Id vorhanden und kann daher nicht angelegt werden.".format(reqParameters.get("entity_name", ""));

        result["entity"] = Json.emptyObject;
        result["messages"] ~= message;
        debug writeln("result => ", result.toString);
        return result;
      }
      debug writeln("Great! Id does not exist ... Looking for name ...");
      result["status"] = 201;

  /*     auto goView = alertLinkView(url, id).toString;        
      auto goEdit = alertLinkEdit(url, id).toString;
      auto goDelete = alertLinkDelete(url, id).toString;
  */
      auto newName = entityBase.uniqueName(siteName ? siteName : mySession.site.name, pool, entity.name); 
      if (newName != name) {
        auto nameMessage = Json.emptyObject;
        nameMessage["status"] = "WARN";
        nameMessage["title"] = "Neuer Name";
        nameMessage["description"] = "Blog unter dem Namen '%s' vorhanden. Neuer Name '%s'.".format(name, newName); //~" "~goView~" "~goEdit~" "~goDelete;
        result["messages"] ~= nameMessage;

        entity.name = newName;            
      }
      entity.name(newName);
      entityBase[siteName ? siteName : mySession.site.name, pool].insertOne(entity);

      auto successMessage = Json.emptyObject;
      successMessage["status"] = "INFO";
      successMessage["title"] = "Blog erstellt.";
      successMessage["description"] = "Blog unter dem Namen '%s' erstellt.".format(entity.name); //~" "~goView~" "~goEdit~" "~goDelete;
      result["messages"] ~= successMessage;
      debug writeln("Entity wird eingefügt");
      
      result["entity"] = entity.toJson;
      debug writeln("result => ", result);
    }
    return result;
  }

  Json doRead(STRINGAA reqParameters) {
    // debug writeln(StyledString("In "~myApi~"/create:toJson...").setForeground(AnsiColor.green).setBackground(AnsiColor.white));

    auto result = Json.emptyObject; // super.toJson(reqParameters);
    if (result["lastError"].get!size_t > 0) return result;
    
    auto mySessionId = reqParameters.get("mySessionId", "");
    auto mySession = manager.session(mySessionId);

    auto id = reqParameters.get("entity_id", reqParameters.get("id", ""));
    DEntity entity = entityBase[mySession.site.name, pool].findOne(["id":id]);
    if (!entity) { // Entity not found :-(
      result["status"] = 409;
      result["lastError"] = 409;
      result["entity"] = Json.emptyObject;

      auto errorMessage = Json.emptyObject;
      errorMessage["type"] = "ERROR";
      errorMessage["title"] = "Blog nicht gefunden.";
      errorMessage["description"] = "Vielleicht wurde der Blog in der Zwischenzeit gelöscht?";
      result["messages"] ~= errorMessage;

      return result;
    }

    // Entity found :-)
    result["status"] = 201;
    result["lastError"] = 0;
    
    auto successMessage = Json.emptyObject;
    successMessage["type"] = "INFO";
    successMessage["title"] = "Entity aktualisiert.";
    successMessage["description"] = "Entity unter dem Namen '%s' erfolgreich aktualisiert.".format(entity.name);
    result["messages"] ~= successMessage;

    debug writeln("Result -> ", result);
    return result;
  }

  Json doUpdate(STRINGAA reqParameters) {
    // debug writeln(StyledString("In "~myApi~"/create:toJson...").setForeground(AnsiColor.green).setBackground(AnsiColor.white));

    auto result = Json.emptyObject; // super.toJson(reqParameters);
    if (result["lastError"].get!size_t > 0) return result;
    
    auto mySessionId = reqParameters.get("mySessionId", "");
    auto mySession = manager.session(mySessionId);

    auto id = reqParameters.get("entity_id", reqParameters.get("id", ""));
    DEntity entity = entityBase[siteName ? siteName : mySession.site.name, pool].findOne(["id":id]);
    
    if (!entity) { // Entity not found :-(
      result["status"] = 409;
      result["lastError"] = 409;
      auto errorMessage = Json.emptyObject;
      errorMessage["status"] = "ERROR";
      errorMessage["title"] = "Entity nicht gefunden.";
      errorMessage["description"] = "Vielleicht wurde die Entity in der Zwischenzeit gelöscht?";
      result["messages"] ~= errorMessage;
      return result;
    }

    // Entity found :-)
    result["status"] = 201;
    result["lastError"] = 0;
    
    // Update entity
    entity.readFromRequest(reqParameters);

    entity.save;
    result["entity"] = entity.toJson;

    auto successMessage = Json.emptyObject;
    successMessage["status"] = "INFO";
    successMessage["title"] = "Blog aktualisiert.";
    successMessage["description"] = "Blog mit dem Namen '%s' aktualisiert.".format(entity.name);
    result["messages"] ~= successMessage;

    // response      
    debug writeln("Result -> ", result);
    return result;
  }

  Json doDelete(STRINGAA reqParameters) {
    // debug writeln(StyledString("In "~myApi~"/create:toJson...").setForeground(AnsiColor.green).setBackground(AnsiColor.white));

    auto result = Json.emptyObject; // super.toJson(reqParameters);
    if (result["lastError"].get!size_t > 0) return result;
    
    auto mySessionId = reqParameters.get("mySessionId", "");
    auto mySession = manager.session(mySessionId);

    auto id = reqParameters.get("entity_id", reqParameters.get("id", ""));
    DEntity entity = entityBase[siteName ? siteName : mySession.site.name, pool].findOne(["id": id]);
    if (!entity) {
      result["status"] = 409;
      result["lastError"] = 409;
      auto errorMessage = Json.emptyObject;
      errorMessage["status"] = "ERROR";
      errorMessage["title"] = "Entity nicht gefunden.";
      errorMessage["description"] = "Vielleicht wurde die Entity in der Zwischenzeit gelöscht?";
      result["messages"] ~= errorMessage;
      return result;
    }

    entityBase[siteName ? siteName : mySession.site.name, pool].removeOne(["id":entity.id.toString]);

    auto successMessage = Json.emptyObject;
    successMessage["type"] = "INFO";
    successMessage["title"] = "Entity gelöscht";
    successMessage["description"] = "Entity unter dem Namen '%s' wurde gelöscht.".format(entity.name);
    result["status"] = 201;
    result["messages"] ~= successMessage;
    return result;
  }
}
mixin(ControllerCalls!("SRVApi"));

unittest {
/* 	assert(SRVApi.name("newName").name == "newName");
	assert(SRVApi.name("oldName").name("newName").name == "newName"); */
}

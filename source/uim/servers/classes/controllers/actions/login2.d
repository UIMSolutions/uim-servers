/*********************************************************************************************************
	Copyright: © 2015-2023 Ozan Nurettin Süel (Sicherheitsschmiede)                                        
	License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.  
	Authors: Ozan Nurettin Süel (Sicherheitsschmiede)                                                      
**********************************************************************************************************/
module uim.servers.classes.controllers.actions.login2;

import uim.servers;
@safe:

class DLogin2ActionController : DSystemActionController {
  mixin(ControllerThis!("Login2ActionController"));

  override void initialize(Json configSettings = Json(null)) {
    super.initialize(configSettings); 

    this
      .checks([
        SessionHasLoginCheck, // AppSession checks
        RequestHasPasswordCheck, // Request checks
        DatabaseHasPasswordsCheck
      ]);
  }
  
  override bool beforeResponse(STRINGAA options = null) {
    debug writeln(moduleName!DLogin2ActionController~":DLogin2ActionController("~this.name~")::beforeResponse");
    if (!super.beforeResponse(options) || hasError || "redirect" in options) { return false; }

    auto account = this.accounts.findOne(["name":this.session.login["accountName"]]);
    if (!account) { this.error("database_account_missing"); return; }
    this.session.account = account;

    auto password = this.passwords.findOne(["accountId": account.id.toString]);
    if (!password) { this.error("database_password_missing"); return; }

    options["redirect"] = "/"; 
    debug writeln(sessionManager.session(options).debugInfo); }
}
mixin(ControllerCalls!("Login2ActionController"));
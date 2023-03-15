module uim.mvc.controllers.checks.appsessions.account;

@safe:
import uim.mvc;

class DSessionHasAccountCheck : DSessionExistsCheck {
  mixin(ControllerComponentThis!("SessionHasAccountCheck"));

  override void initialize(Json configSettings = Json(null)) {
    super.initialize(configSettings);

    this
      .redirectUrl("/error?account_missing");
  }

  override bool execute(STRINGAA options = null) {    
    debug writeln(moduleName!DSessionHasAccountCheck~":DSessionHasAccountCheck::execute");
    if (!super.execute(options)) { return false; } 

    auto session = getSession(options);
    if (!session.account) { // account missing 
      this.error("Account Missing");
      return false;
    }

    return true;
  }
}
mixin(ControllerComponentCalls!("SessionHasAccountCheck"));

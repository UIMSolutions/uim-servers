/*********************************************************************************************************
	Copyright: © 2015-2023 Ozan Nurettin Süel (Sicherheitsschmiede)                                        
	License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.  
	Authors: Ozan Nurettin Süel (Sicherheitsschmiede)                                                      
**********************************************************************************************************/
module uim.mvc.forms.login;

@safe:
import uim.mvc;

class DLoginForm : DForm {
  mixin(ViewComponentThis!("LoginForm"));

  mixin(OProperty!("bool", "showLostAccount"));

  override void initialize(Json configSettings = Json(null)) {
    super.initialize(configSettings);

    this.showLostAccount(true);
  }
  
/*   override DViewComponent copy() {
    return
      (cast(DLoginForm)copy)
      .showLostAccount(this.showLostAccount);
  } */

  override DH5Obj[] toH5(STRINGAA options = null) {
    super.toH5(options);

    return [
      UIMFormCard(["card-md"], ["autocomplete":"off"]).method("post").action("/login_action")( 
        UIMCardBody( 
          H5H2(["card-title", "text-center", "mb-4"], "Anmeldung"),
          H5Div(["mb-3"], 
            H5Label(["form-label"], H5String("Kennung"),
              (showLostAccount ? H5Span(["form-label-description"], 
                H5A(["href":"/lostaccount"], "Kennung vergessen?")) : null)),
            UIMTextInput.id("accountName").name("accountName").placeholder("Bitte die Kennung eingeben")
              .invalidText("Bitte eine gültige Kennung eingeben")
          ),
          H5Div(["form-footer"], 
            BS5ButtonSubmit(["btn-primary w-100"], "Zur Passworteingabe")
          )
        )
      )
    ].toH5;
  }
}
mixin(ViewComponentCalls!("LoginForm","DLoginForm"));

version(test_uim_mvc) { unittest {
  assert(LoginForm);
}}

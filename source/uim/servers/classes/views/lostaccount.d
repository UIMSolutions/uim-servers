/***********************************************************************************************************************
*	Copyright: © 2017-2022 UI Manufaktur UG / 2022 Ozan Nurettin Süel (sicherheitsschmiede)                              *
*	License: Licensed under Apache 2 [https://apache.org/licenses/LICENSE-2.0.txt]                                       *
*	Authors: UI Manufaktur UG Team, Ozan Nurettin Süel (Sicherheitsschmiede)										                         * 
***********************************************************************************************************************/
module uim.servers.classes.views.lostaccount;

import uim.servers;
@safe:

class DLostAccountView : DView {
  mixin(ViewThis!("LostAccountView"));

  override void beforeH5(STRINGAA options = null) { 
    debug writeln(moduleName!DLostAccountView~":DLostAccountView::beforeH5");
    super.beforeH5(options);
  }

  override DH5Obj[] toH5(STRINGAA options = null) {
    super.toH5(options);
    auto rootPath = options.get("rootPath", "/");

    return [H5Div(["container-xl"],
        // pageTitle("Login"),
        BS5Row(["row-cards"],
          BS5Col(["col-md-6"],
            BS5Card
            .header(
              H5H3(["card-title"], "Lost Account"))
            .body_(
              H5Form(["method":"post", "action": rootPath~"login2action"],
                BS5FormGroup(["mb-3"], 
                  BS5FormLabel("Password"),
                  BS5InputPassword(["name":"loginPW", "placeholder":"Bitte das Passwort eingeben"]),
                  H5Small(["form-hint"], "Passwort vergessen?")
                ),
                H5Div(["form-footer"], 
                  BS5ButtonSubmit(["btn-primary"], "Anmelden"))
              )
            )
          )     
        )
      )].toH5;       
  }      
}
mixin(ViewCalls!("LostAccountView"));

version(test_uim_mvc) { unittest {
  assert(LostAccountView);
}}
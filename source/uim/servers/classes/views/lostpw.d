module uim.servers.classes.views.lostpw;

import uim.servers;
@safe:

class DLostPasswordView : DView {
  mixin(ViewThis!("LostAccountView"));

  override void beforeH5(STRINGAA options = null) { 
    debugMethodCall(moduleName!DLostPasswordView~":DLostPasswordView::beforeH5");
    super.beforeH5(options);
    if (hasError) { return; }
  }

  override DH5Obj[] toH5(STRINGAA options = null) {
    super.toH5(options);

    auto rootPath = options.get("rootPath", "/");

    return [
      H5Div(["container-xl"],
        // pageTitle("Login"),
        BS5Row(["row-cards"],
          BS5Col(["col-md-6"],
            UIMCard(
              UIMCardHeader(
                H5H3(["card-title"], "Lost Passwort")),
              UIMCardBody(
                UIMForm.method("post").action(rootPath~"login2action")(
                  BS5FormGroup(["mb-3"], 
                    BS5FormLabel("Password"),
                    UIMPasswordInput.name("loginPW").placeholder("Bitte das Passwort eingeben"),
                    H5Small(["form-hint"], "Passwort vergessen?")
                  ),
                  H5Div(["form-footer"], 
                    BS5ButtonSubmit(["btn-primary"], "Anmelden"))
                )
              )
            )
          )     
        )
      )].toH5;       
  }
}
auto LostPasswordView() { return new DLostPasswordView(); }
auto LostPasswordView(DPageController aController) { return new DLostPasswordView(aController); }

version(test_uim_mvc) { unittest {
  assert(LostPasswordView);
}}
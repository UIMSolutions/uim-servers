/***********************************************************************************************************************
*	Copyright: © 2017-2022 UI Manufaktur UG / 2022 Ozan Nurettin Süel (sicherheitsschmiede)                              *
*	License: Licensed under Apache 2 [https://apache.org/licenses/LICENSE-2.0.txt]                                       *
*	Authors: UI Manufaktur UG Team, Ozan Nurettin Süel (Sicherheitsschmiede)										                         * 
***********************************************************************************************************************/
module uim.servers.classes.views.signup;

import uim.servers;
@safe:

class DSignUpView : DView {
  mixin(ViewThis!("SignUpView"));
  
  override void beforeH5(STRINGAA options = null) {
    debugMethodCall(moduleName!DSignUpView~":DSignUpView::beforeH5");
    this.rootPath(options.get("rootPath", "/"));
  }

  override DH5Obj[] toH5(STRINGAA options = null) {
    debugMethodCall(moduleName!DSignUpView~":DSignUpView::toH5");
    super.toH5(options);

    return [
      H5Div(["page page-center"],
        H5Div(["container container-tight py-4"],
          H5Div(["text-center mb-4"], 
            H5A(["navbar-brand navbar-brand-autodark"], ["href":"."], 
              H5Img(["src":"https://preview.tabler.io/static/logo.svg", "height":"36", "alt":""])
            )
          )~
          SignUpForm.toH5~
          H5Div(["text-center text-muted mt-3"],
            H5String("Already have account? "),
            H5A(["href":"./sign-in.html", "tabindex":"-1"], "Sign in")
          )
        )
      )
    ].toH5;
  }
}
mixin(ViewCalls!("SignUpView", "DSignUpView"));

version(test_uim_mvc) { unittest {
  assert(SignUpView);
}}
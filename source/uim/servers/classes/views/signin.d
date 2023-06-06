/***********************************************************************************************************************
*	Copyright: © 2017-2022 UI Manufaktur UG / 2022 Ozan Nurettin Süel (sicherheitsschmiede)                              *
*	License: Licensed under Apache 2 [https://apache.org/licenses/LICENSE-2.0.txt]                                       *
*	Authors: UI Manufaktur UG Team, Ozan Nurettin Süel (Sicherheitsschmiede)										                         * 
***********************************************************************************************************************/
module uim.servers.views.signin;

import uim.servers;
@safe:

class DSignInView : DView {
  mixin(ViewThis!("SignInView"));
  
  override void beforeH5(STRINGAA options = null) {
    debugMethodCall(moduleName!DSignInView~":DSignInView::beforeH5");
    this.rootPath(options.get("rootPath", "/"));
  }

  override DH5Obj[] toH5(STRINGAA options = null) {
    debugMethodCall(moduleName!DSignInView~":DSignInView::toH5");
    super.toH5(options);

    return [
      H5Div(["page page-center"],
        H5Div(["container container-tight py-4"],
          H5Div(["text-center mb-4"], 
            H5A(["navbar-brand navbar-brand-autodark"], ["href":"."], 
              H5Img(["src":"https://preview.tabler.io/static/logo.svg", "height":"36", "alt":""])
            )
          ),
          H5Div(["card card-md"],
            H5Div(["card-body"],
              H5H2(["h2 text-center mb-4"], "SignIn to your account")~
              SignInForm.toH5
            )
          ),
          H5Div(["text-center text-muted mt-3"],
            H5String("Don't have account yet? "),
            H5A(["href":"./sign-up.html", "tabindex":"-1"], "Sign up")
          )
        )
      )
    ].toH5;
  }
}
mixin(ViewCalls!("SignInView", "DSignInView"));

version(test_uim_mvc) { unittest {
  assert(SignInView);
}}
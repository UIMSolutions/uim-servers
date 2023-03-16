/***********************************************************************************************************************
*	Copyright: © 2017-2022 UI Manufaktur UG / 2022 Ozan Nurettin Süel (sicherheitsschmiede)                              *
*	License: Licensed under Apache 2 [https://apache.org/licenses/LICENSE-2.0.txt]                                       *
*	Authors: UI Manufaktur UG Team, Ozan Nurettin Süel (Sicherheitsschmiede)										                         * 
***********************************************************************************************************************/
module uim.servers.views.signinlink;

@safe:
import uim.servers;

class DSignInLinkView : DView {
  mixin(ViewThis!("SignInLinkView"));
  
  override void beforeH5(STRINGAA options = null) {
    debugMethodCall(moduleName!DSignInLinkView~":DSignInLinkView::beforeH5");
    this.rootPath(options.get("rootPath", "/"));
  }

  override DH5Obj[] toH5(STRINGAA options = null) {
    debugMethodCall(moduleName!DSignInLinkView~":DSignInLinkView::toH5");
    super.toH5(options);
    
    return [
      H5Div(["page page-center"],
        H5Div(["container container-tight py-4"],
          H5Div(["text-center mb-4"], 
            H5A(["navbar-brand navbar-brand-autodark"], ["href":"."], 
              H5Img(["src":"https://preview.tabler.io/static/logo.svg", "height":"36", "alt":""])
            )
          ),
          H5Div(["text-center"],
            H5Div(["my-5"],
              H5H2(["h1"], "Check your inbox"),
              H5P(["fs-h3 text-muted"], "We've sent you a magic link to <strong>support@tabler.io</strong>.<br>Please click the link to confirm your address.")
            ),
            H5Div(["text-center text-muted mt-3"],
              `Can't see the email? Please check the spam folder.<br>Wrong email? Please <a href="#">re-enter your address</a>.`
            )
          )
        )
      )
    ].toH5;
  }
}
mixin(ViewCalls!("SignInLinkView", "DSignInLinkView"));

version(test_uim_mvc) { unittest {
  assert(SignInLinkView);
}}
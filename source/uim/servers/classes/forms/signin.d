/*********************************************************************************************************
	Copyright: © 2015-2023 Ozan Nurettin Süel (Sicherheitsschmiede)                                        
	License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.  
	Authors: Ozan Nurettin Süel (Sicherheitsschmiede)                                                      
**********************************************************************************************************/
module uim.servers.forms.signin;

import uim.servers;
@safe:

class DSignInForm : DForm {
  mixin(ViewComponentThis!("SignInForm"));

  override void initialize(Json configSettings = Json(null)) {
    super.initialize(configSettings);
  }
  
  override DH5Obj[] toH5(STRINGAA options = null) {
    super.toH5(options);

    return [
      H5Form(["action":"./", "method":"get", "autocomplete":"off", "novalidate":""], 
        H5Div(["mb-3"],
          H5Label(["form-label"], "Email address"),
          H5Input(["form-control"], ["type":"email", "placeholder":"your@email.com", "autocomplete":"off"])
        ),
        H5Div(["mb-2"], 
          H5Label(["form-label"], 
            H5String("Password"),
            H5Span(["form-label-description"],
              H5A(["href":"./forgot-password.html"], "I forgot password")
            )
          ),
          H5Div(["input-group input-group-flat"], 
            H5Input(["form-control"], ["type":"password", "placeholder":"Your password", "autocomplete":"off"]),
            H5Span(["input-group-text"],
              H5A(["link-secondary"], ["href":"#", "data-bs-toggle":"tooltip", "aria-label":"Show password", "data-bs-original-title":"Show password"], 
                tablerIcon("eye")
              )
            )
          )
        ),
        H5Div(["mb-2"], 
          H5Label(["form-check"],
            H5Input(["form-check-input"], ["type":"checkbox"]),
            H5Span(["form-check-label"], "Remember me on this device")
          )
        ),
        H5Div(["form-footer"], 
          H5Button(["btn btn-primary w-100"], ["type":"submit"], "Sign in")
        )
      )
    ].toH5;
  }
}
mixin(ViewComponentCalls!("SignInForm","DSignInForm"));

version(test_uim_mvc) { unittest {
  assert(SignInForm);
}}

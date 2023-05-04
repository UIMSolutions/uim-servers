/*********************************************************************************************************
	Copyright: © 2015-2023 Ozan Nurettin Süel (Sicherheitsschmiede)                                        
	License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.  
	Authors: Ozan Nurettin Süel (Sicherheitsschmiede)                                                      
**********************************************************************************************************/
module uim.servers.forms.signup;

import uim.servers;
@safe:

class DSignUpForm : DForm {
  mixin(ViewComponentThis!("SignUpForm"));

  override void initialize(Json configSettings = Json(null)) {
    super.initialize(configSettings);
  }
  
  override DH5Obj[] toH5(STRINGAA options = null) {
    super.toH5(options);

    return [
      H5Form(["card card-md"], ["action":"./", "method":"get", "autocomplete":"off", "novalidate":""], 
        H5Div(["card-body"], 
            H5H2(["card-title text-center mb-4"], "Create new account"),
            H5Div(["mb-3"],
              H5Label(["form-label"], "Name"),
              H5Input(["form-control"], ["type":"text", "placeholder":"Enter name"])
            ),
            H5Div(["mb-3"],
              H5Label(["form-label"], "Email address"),
              H5Input(["form-control"], ["type":"email", "placeholder":"Enter email"])
            ),
            H5Div(["mb-3"],
              H5Label(["form-label"], "Password"),
              H5Div(["input-group input-group-flat"], 
                H5Input(["form-control"], ["type":"password", "placeholder":"Password", "autocomplete":"off"]),
                H5Span(["input-group-text"],
                  H5A(["link-secondary"], ["href":"#", "data-bs-toggle":"tooltip", "aria-label":"Show password", "data-bs-original-title":"Show password"],
                    tablerIcon("eye")
                  )
                )
              )
            ),
            H5Div(["mb-3"],
              H5Label(["form-check"],
                H5Input(["form-check-input"], ["type":"checkbox"]),
                H5Span(["form-check-label"], `Agree the <a href="./terms-of-service.html" tabindex="-1">terms and policy</a>.`)
              )
            ),
            H5Div(["form-footer"], 
              H5Button(["btn btn-primary w-100"], ["type":"submit"], "Create new account")
            )
          )
      )
    ].toH5;
  }
}
mixin(ViewComponentCalls!("SignUpForm","DSignUpForm"));

version(test_uim_mvc) { unittest {
  assert(SignUpForm);
}}

module uim.mvc.views.login2;

@safe:
import uim.mvc;

class DLogin2View : DView {
  mixin(ViewThis!("Login2View"));

  override void beforeH5(STRINGAA options = null) { 
    debugMethodCall(moduleName!DLogin2View~":DLogin2View::beforeH5");
    super.beforeH5(options);
  }

  override DH5Obj[] toH5(STRINGAA options = null) {
    super.toH5(options);

    return [
      H5Div(["container-tight py-4"], 
        BS5Row("messages", ["mt-2 mb-2"]),
        BS5Row("logo", ["text-center"],  
          H5A(["href":"https://www.sicherheitsschmiede.de"], 
            H5Img(["src":"/img/logo.png", "height":"80", "alt":"Sicherheitsschmiede - Sicher im Internet"]))),
        BS5Row("form", MVCLogin2Form.toH5(options)))
    ].toH5;
  }
}
mixin(ViewCalls!("Login2View", "DLogin2View"));

version(test_uim_mvc) { unittest {
  assert(Login2View);
}}
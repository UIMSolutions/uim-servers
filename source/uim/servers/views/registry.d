/*********************************************************************************************************
	Copyright: © 2015-2023 Ozan Nurettin Süel (Sicherheitsschmiede)                                        
	License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.  
	Authors: Ozan Nurettin Süel (Sicherheitsschmiede)                                                      
**********************************************************************************************************/
module uim.mvc.views.registry;

@safe:
import uim.mvc;

class DViewRegistry : DRegistry!DView{
  this() {}

  static DViewRegistry registry; 
}
auto ViewRegistry() { 
  if (!DViewRegistry.registry) {
    DViewRegistry.registry = new DViewRegistry; 
  }
  return 
    DViewRegistry.registry;
}

version(test_uim_mvc) { unittest {
  assert(ViewRegistry.register("mvc/view",  View).paths == ["mvc/view"]);
  assert(ViewRegistry.register("mvc/view2", View).paths.length == 2);
}}
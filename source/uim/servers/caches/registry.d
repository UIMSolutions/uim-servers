/*********************************************************************************************************
	Copyright: © 2015-2023 Ozan Nurettin Süel (Sicherheitsschmiede)                                        
	License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.  
	Authors: Ozan Nurettin Süel (Sicherheitsschmiede)                                                      
**********************************************************************************************************/
module uim.servers.caches.registry;

@safe:
import uim.servers;

class DCacheRegistry : DRegistry!DCache{
  this() {}

  static DCacheRegistry registry; 
}
auto CacheRegistry() { 
  if (!DCacheRegistry.registry) {
    DCacheRegistry.registry = new DCacheRegistry; 
  }
  return 
    DCacheRegistry.registry;
}

version(test_uim_mvc) { unittest {
  assert(CacheRegistry.register("mvc/cache",  Cache).paths == ["mvc/cache"]);
  assert(CacheRegistry.register("mvc/cache2", Cache).paths.length == 2);
}}
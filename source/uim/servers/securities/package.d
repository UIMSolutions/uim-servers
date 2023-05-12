module uim.servers.securities;

import uim.servers;
@safe:

public {
  import uim.servers.securities.database;
  import uim.servers.securities.rest;
  import uim.servers.securities.security;
}

class DSRVSecurityOptions {
  this() {}
  this(bool[string] initOptions) { this(); _options = initOptions; }
  this(string[] requiredOptions...) { this(); requiredOptions.each!(a => _options[a] = true); }
  this(string[] requiredOptions) { this(); requiredOptions.each!(a => _options[a] = true); }

  private bool[string] _options;
  private bool[string] _values;
  bool required(string option) { return _options.get(option, false); }
  O required(this O)(string option, bool isRequired) { _options[option] = isRequired; return cast(O)this; }
  O required(this O)(string[] options...) { this.required(options); return cast(O)this; }
  O required(this O)(string[] options) { options.each!(a => _options[a] = true); return cast(O)this; }

  DSRVSecurityOptions copy() {
    auto result = SRVSecurityOptions(_options);
    return result;
  }
}
auto SRVSecurityOptions() { return new DSRVSecurityOptions; }
auto SRVSecurityOptions(bool[string] initOptions) { return new DSRVSecurityOptions(initOptions); }
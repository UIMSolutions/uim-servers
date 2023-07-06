module uim.servers.mixins.server;

string serverThis(string aName, string className = null) {
  string clName = (className.length > 0 ? className : "D"~aName); 

  return "
    this() {
      super();
      name("~aName~"); className("~clName~")
    }
    this(string aName) {
      this(); name(aName);
    }
  ";
}

template ServerThis(string aName, string className = null) {
  const char[] ServerThis = serverThis(aName, className);
}

string serverCalls(string callName, string className = null) {
  string clName = (className.length > 0 ? className : "D"~callName); 

  return "
    auto " ~callName~ "() { return new "~clName~"(); }
    auto " ~callName~ "(string aName) { return new "~clName~"(aName); }
  ";
}

template ServerCalls(string callName, string className = null) {
  const char[] ServerCalls = serverCalls(callName, className);
}
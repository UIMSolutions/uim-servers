module uim.servers.mixins.server;

template ServerCalls(string shortName) {
  const char[] ServerCalls = `
    auto ` ~shortName~ `() { return new D` ~shortName~ `(); }
    auto ` ~shortName~ `(string aName) { return ` ~shortName~ `.name(aName); }
    auto ` ~shortName~ `(string aName, string aRootPath) { return ` ~shortName~ `(aName).rootPath(aRootPath); }`;
}
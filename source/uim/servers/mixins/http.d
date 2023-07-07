module uim.servers.mixins.http;

template SetHTTP() {
  const char[] SetHTTP = `
  if ((httpMode == "OnlyHttp") || (httpMode == "HttpAndHttps")) {
    auto settings = new HTTPServerSettings;
    settings.port = httpPort;
    settings.bindAddresses = httpAddresses;
    settings.sessionStore = new MemorySessionStore;
    settings.accessLogger = new vibe.http.log.HTTPFileLogger(settings, httpLogFormat, "./logs/"~serverName~"-http-"~now().toISOString~".log");
    listenHTTP(settings, router);
  }
  if ((httpMode == "OnlyHttps") || (httpMode == "HttpAndHttps")) {
    auto settings = new HTTPServerSettings;
    settings.port = httpPort;
    settings.sessionStore = new MemorySessionStore;
    settings.bindAddresses = httpsAddresses;
    settings.accessLogger = new vibe.http.log.HTTPFileLogger(settings, httpsLogFormat, "./logs/"~serverName~"-https-"~now().toISOString~".log");
    settings.tlsContext = createTLSContext(TLSContextKind.server);
    settings.tlsContext.useCertificateChainFile(tlsChain);	
    settings.tlsContext.usePrivateKeyFile(tlsPrivate);
    listenHTTP(settings, router);
  }`;
}
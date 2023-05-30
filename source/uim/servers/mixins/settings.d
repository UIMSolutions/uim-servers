module uim.servers.mixins.settings;

template SetRouterDefault() {
  const char[] SetRouterDefault = `
  auto pathToBaseResources = "../../PUBLIC/";
	router
		.get("/css/*", serveStaticFiles(pathToBaseResources))
		.get("/data/*", serveStaticFiles(pathToBaseResources))
		.get("/lib/*", serveStaticFiles(pathToBaseResources))
		.get("/font/*", serveStaticFiles(pathToBaseResources))
		.get("/img/*", serveStaticFiles(pathToBaseResources))
		.get("/js/*", serveStaticFiles(pathToBaseResources))
		.get("/vue/*", serveStaticFiles(pathToBaseResources))
		.get("/react/*", serveStaticFiles(pathToBaseResources))
		.get("/theme/*", serveStaticFiles(pathToBaseResources))
		.get("/font/*", serveStaticFiles(pathToBaseResources))
		.get("/templ/*", serveStaticFiles(pathToBaseResources))
		.get("/plugin/*", serveStaticFiles(pathToBaseResources))
		.get("/page/*", serveStaticFiles(pathToBaseResources));
  `;
}
module uim.servers.layouts.general;

@safe:
import uim.servers;

class DGeneralLayout : DLayout {
  this() { super(); }

  override void initialize(Json configSettings = Json(null)) {
    debug writeln("Initialize 'GeneralLayout'"); 
    super.initialize(configSettings);
 
    // Default settings
    this
      .name("GeneralLayout"); 
    
    debug writeln("Add navigation"); 
    this
      .navigation(
        /* Navigation.fixedTop(true) */);

    debug writeln("Add footer"); 
    this    
      .footer(
        /* PageFooter */);

    this.PageBody(
      UIMPageBody(
          UIMContainer.size("xl")( 
            // Content here
          )
        )
    );
           
    this.SecondNavbar(
      H5Div(["navbar-expand-md"], 
        H5Div("navbar-menu", ["collapse navbar-collapse"],
            H5Div(["navbar navbar-light"], 
            UIMContainer.size("xl")(
              H5Ul(["navbar-nav"],       
                UIMNavItem( 
                  UIMNavLink.link("./index.html")( 
                    UIMNavLinkIcon(["d-md-none d-lg-inline-block"]).icon("home"),
                    UIMNavLinkTitle.title("Home")
                  )
                ),
                UIMNavItem(["active dropdown"], 
                  UIMNavLink(["dropdown-toggle"], ["href":"#navbar-base", "data-bs-toggle":"dropdown", "data-bs-auto-close":"outside", 
                    "role":"button", "aria-expanded":"false"], 
                    UIMNavLinkIcon(["d-md-none d-lg-inline-block"]).icon("package"),
                    UIMNavLinkTitle.title("Interface")
                  ),
                  UIMDropdownMenu(
                    UIMDropdownMenuColumns( 
                      UIMDropdownMenuColumn( 
                        UIMDropdownItem(["active"]).link("./empty.html")("Empty page"),
                        UIMDropdownItem.link("./accordion.html")("Accordion"),
                        UIMDropdownItem.link("./blank.html")("Blank page"),
                        UIMDropdownItem.link("./buttons.html")("Buttons"),
                        UIMDropdownDropend( 
                          H5A(["dropdown-item dropdown-toggle"], ["href":"#sidebar-cards", "data-bs-toggle":"dropdown", "data-bs-auto-close":"outside", "role":"button", "aria-expanded":"false"], 
                            H5String("Cards"), UIMBadge(["badge-sm bg-green text-uppercase ms-2"], "New")
                          ),
                          UIMDropdownMenu(
                            UIMDropdownItem.link("./cards.html")("Sample cards"),
                            UIMDropdownItem.link("./card-actions.html")( H5String("Card actions"), UIMBadge(["badge-sm bg-green text-uppercase ms-2"], "New")),
                            UIMDropdownItem.link("./cards-masonry.html")("Cards Masonry")
                          )
                        ),
                        UIMDropdownItem.link("./colors.html")("Colors"),
                        UIMDropdownItem.link("./datagrid.html")( 
                          H5String("Data grid"), 
                          UIMBadge(["badge-sm bg-green text-uppercase ms-2"], "New")
                        ),
                        UIMDropdownItem.link("./datatables.html")( 
                          H5String("Datatables"), 
                          UIMBadge(["badge-sm bg-green text-uppercase ms-2"], "New")
                        ),
                        UIMDropdownItem.link("./dropdowns.html")( 
                          "Dropdowns"
                        ),
                        UIMDropdownItem.link("./modals.html")( 
                          "Modals"
                        ),
                        UIMDropdownItem.link("./maps.html")( 
                          "Maps"
                        ),
                        UIMDropdownItem.link("./map-fullsize.html")( 
                          "Map fullsize"
                        ),
                        UIMDropdownItem.link("./maps-vector.html")( 
                          H5String("Vector maps"),
                          UIMBadge(["badge-sm bg-green text-uppercase ms-2"], "New")
                        ),
                        UIMDropdownItem.link("./navigation.html")( 
                          "Navigation"
                        ),
                        UIMDropdownItem.link("./charts.html")( 
                          "Charts"
                        )
                      ),
                      UIMDropdownMenuColumn( 
                        UIMDropdownItem.link("./pagination.html")( 
                          tablerIcon("pie-chart")~" Pagination"
                        ),
                        UIMDropdownItem.link("./placeholder.html")( 
                          "Placeholder"
                        ),
                        UIMDropdownItem.link("./tabs.html")( 
                          "Tabs"
                        ),
                        UIMDropdownItem.link("./tables.html")( 
                          "Tables"
                        ),
                        UIMDropdownItem.link("./carousel.html")( 
                          H5String("Carousel")~UIMBadge(["badge-sm bg-green text-uppercase ms-2"], "New")
                        ),
                        UIMDropdownItem.link("./lists.html")( 
                          "Lists"
                        ),
                        UIMDropdownItem.link("./typography.html")( 
                          "Typography"
                        ),
                        UIMDropdownItem.link("./offcanvas.html")( 
                          "Offcanvas"
                        ),
                        UIMDropdownItem.link("./markdown.html")( 
                          "Markdown"
                        ),
                        UIMDropdownItem.link("./dropzone.html")( 
                          H5String("Dropzone")~
                          UIMBadge(["badge-sm bg-green text-uppercase ms-2"], "New")
                        ),
                        UIMDropdownItem.link("./lightbox.html")( 
                          H5String("Lightbox")~UIMBadge(["badge-sm bg-green text-uppercase ms-2"], "New")
                        ),
                        UIMDropdownItem.link("./tinymce.html")( 
                          H5String("TinyMCE"),
                          UIMBadge(["badge-sm bg-green text-uppercase ms-2"], "New")
                        ),
                        UIMDropdownItem.link("./inline-player.html")( 
                          H5String("Inline player")~
                          UIMBadge(["badge-sm bg-green text-uppercase ms-2"], "New")
                        ),
                        UIMDropdownDropend( 
                          H5A(["dropdown-item dropdown-toggle"], ["href":"#sidebar-authentication", "data-bs-toggle":"dropdown", "data-bs-auto-close":"outside",
                            "role":"button", "aria-expanded":"false"], 
                            "Authentication"
                          ),
                          UIMDropdownMenu(
                            UIMDropdownItem.link("./sign-in.html")( 
                              "Sign in"
                            ),
                            UIMDropdownItem.link("./sign-in-illustration.html")( 
                              "Sign in with illustration"
                            ),
                            UIMDropdownItem.link("./sign-in-cover.html")( 
                              "Sign in with cover"
                            ),
                            UIMDropdownItem.link("./sign-up.html")( 
                              "Sign up"
                            ),
                            UIMDropdownItem.link("./forgot-password.html")( 
                              "Forgot password"
                            ),
                            UIMDropdownItem.link("./terms-of-service.html")( 
                              "Terms of service"
                            ),
                            UIMDropdownItem.link("./auth-lock.html")( 
                              "Lock screen"
                            )
                          )
                        ),
                        UIMDropdownDropend( 
                          H5A(["dropdown-item dropdown-toggle"], ["href":"#sidebar-error", "data-bs-toggle":"dropdown", "data-bs-auto-close":"outside", 
                            "role":"button", "aria-expanded":"false"], 
                            tablerIcon("file-minus")~" Error pages"
                          ),
                          UIMDropdownMenu(
                            UIMDropdownItem.link("./error-404.html")( 
                              "404 page"
                            ),
                            UIMDropdownItem.link("./error-500.html")( 
                              "500 page"
                            ),
                            UIMDropdownItem.link("./error-maintenance.html")( 
                              "Maintenance page"
                            )
                          )
                        )
                      )
                    )
                  )
                ),
                UIMNavItem( 
                  UIMNavLink.link("./form-elements.html")(
                    UIMNavLinkIcon(["d-md-none d-lg-inline-block"]).icon("checkbox"),
                    UIMNavLinkTitle.title("Form elements")
                  )
                ),
                UIMNavItem(["dropdown"], 
                  UIMNavLink(["dropdown-toggle"], ["href":"#navbar-extra", "data-bs-toggle":"dropdown", "data-bs-auto-close":"outside", 
                    "role":"button", "aria-expanded":"false"], 
                    UIMNavLinkIcon(["d-md-none d-lg-inline-block"]).icon("star"),
                    UIMNavLinkTitle.title("Extra")
                  ),
                  UIMDropdownMenu(
                    UIMDropdownMenuColumns( 
                      UIMDropdownMenuColumn( 
                        UIMDropdownItem.link("./activity.html")( 
                          "Activity"
                        ),
                        UIMDropdownItem.link("./gallery.html")( 
                          "Gallery"
                        ),
                        UIMDropdownItem.link("./invoice.html")( 
                          "Invoice"
                        ),
                        UIMDropdownItem.link("./search-results.html")( 
                          " Search results"
                        ),
                        UIMDropdownItem.link("./pricing.html")( 
                          "Pricing cards"
                        ),
                        UIMDropdownItem.link("./pricing-table.html")( 
                          "Pricing table"
                        ),
                        UIMDropdownItem.link("./faq.html")( 
                          H5String("FAQ"), 
                          UIMBadge(["badge-sm bg-green text-uppercase ms-2"], "New")
                        ),
                        UIMDropdownItem.link("./users.html")( 
                          "Users"
                        ),
                        UIMDropdownItem.link("./license.html")( 
                          "License"
                        )
                      ),
                      UIMDropdownMenuColumn( 
                        UIMDropdownItem.link("./logs.html")( 
                          H5String("Logs"),
                          UIMBadge(["badge-sm bg-green text-uppercase ms-2"], "New")
                        ),
                        UIMDropdownItem.link("./music.html")( 
                          "Music"
                        ),
                        UIMDropdownItem.link("./tasks.html")( 
                          H5String("Tasks"),
                          UIMBadge(["badge-sm bg-green text-uppercase ms-2"], "New")
                        ),
                        UIMDropdownItem.link("./uptime.html")( 
                          "Uptime monitor"
                        ),
                        UIMDropdownItem.link("./widgets.html")( 
                          "Widgets"
                        ),
                        UIMDropdownItem.link("./wizard.html")( 
                          "Wizard"
                        ),
                        UIMDropdownItem.link("./settings.html")( 
                          H5String("Settings"),
                          UIMBadge(["badge-sm bg-green text-uppercase ms-2"], "New")
                        ),
                        UIMDropdownItem.link("./job-listing.html")( 
                          H5String("Job listing"), 
                          UIMBadge(["badge-sm bg-green text-uppercase ms-2"], "New")
                        )
                      )
                    )
                  )
                ),
                UIMNavItem(["dropdown"], 
                  UIMNavLink(["dropdown-toggle"], ["href":"#navbar-layout", "data-bs-toggle":"dropdown", "data-bs-auto-close":"outside", "role":"button", "aria-expanded":"false"], 
                    UIMNavLinkIcon(["d-md-none d-lg-inline-block"]).icon("layout-2"),
                    UIMNavLinkTitle.title("Layout")
                  ),
                  UIMDropdownMenu(
                    UIMDropdownMenuColumns( 
                      UIMDropdownMenuColumn( 
                        UIMDropdownItem.link("./layout-horizontal.html")("Horizontal"),
                        UIMDropdownItem.link("./layout-boxed.html")( 
                          H5String("Boxed"), UIMBadge(["badge-sm bg-green text-uppercase ms-2"], "New")
                        ),
                        UIMDropdownItem.link("./layout-vertical.html")("Vertical"),
                        UIMDropdownItem.link("./layout-vertical-transparent.html")("Vertical transparent"),
                        UIMDropdownItem.link("./layout-vertical-right.html")("Right vertical"),
                        UIMDropdownItem.link("./layout-condensed.html")("Condensed"),
                        UIMDropdownItem.link("./layout-combo.html")("Combined" )
                      ),
                      UIMDropdownMenuColumn( 
                        UIMDropdownItem.link("./layout-navbar-dark.html")("Navbar dark"),
                        UIMDropdownItem.link("./layout-navbar-sticky.html")("Navbar sticky"),
                        UIMDropdownItem.link("./layout-navbar-overlap.html")("Navbar overlap"),
                        UIMDropdownItem.link("./layout-rtl.html")("RTL mode"),
                        UIMDropdownItem.link("./layout-fluid.html")("Fluid"),
                        UIMDropdownItem.link("./layout-fluid-vertical.html")("Fluid vertical")
                      )
                    )
                  )
                ),
                UIMNavItem( 
                  UIMNavLink.link("./icons.html")( 
                    UIMNavLinkIcon(["d-md-none d-lg-inline-block"]).icon("ghost"),
                    UIMNavLinkTitle.title("2681 icons")
                  )
                ),
                UIMNavItem(["dropdown"], 
                  UIMNavLink(["dropdown-toggle"], ["href":"#navbar-help", "data-bs-toggle":"dropdown", "data-bs-auto-close":"outside", "role":"button", "aria-expanded":"false"], 
                    UIMNavLinkIcon(["d-md-none d-lg-inline-block"]).icon("lifebuoy"),
                    UIMNavLinkTitle.title("Help")
                  ),
                  UIMDropdownMenu(
                    UIMDropdownItem.link("./docs/index.html")("Documentation"),
                    UIMDropdownItem.link("./changelog.html")("Changelog"),
                    UIMDropdownItem(["target":"_blank", "rel":"noopener"], "Source code").link("https://github.com/tabler/tabler"),
                    UIMDropdownItem(["text-pink"], ["target":"_blank", "rel":"noopener"]).link("https://github.com/sponsors/codecalm")(tablerIcon("heart")~" Sponsor project!")
                  )
                )
              ),
              H5Div(["my-2 my-md-0 flex-grow-1 flex-md-grow-0 order-first order-md-last"], 
                H5Form(["action":"./", "method":"get", "autocomplete":"off", "novalidate":""], 
                  UIMInputIcon( 
                    UIMInputAddon.icon("search"),
                    UIMTextInput(["value":"", "placeholder":"Search…", "aria-label":"Search in website"]) 
                  )
                )
              )
            )
          )
        )
      )
    );

    this.MainNavbar(
      H5Header(["navbar navbar-expand-md navbar-light d-print-none"], 
        UIMContainer.size("xl")( 
          H5Button(["navbar-toggler"], ["type":"button", "data-bs-toggle":"collapse", "data-bs-target":"#navbar-menu"], H5Span(["navbar-toggler-icon"])),
          UIMNavbarNav(["flex-row order-md-first"], 
            H5Div(["d-none d-md-flex"], 
              UIMNavLink(["px-0 hide-theme-dark"], ["href":"?theme=dark", "data-bs-toggle":"tooltip", "data-bs-placement":"bottom", "aria-label":"Enable dark mode"], 
                tablerIcon("moon")),                
              UIMNavLink(["px-0 hide-theme-light"], ["href":"?theme=light", "data-bs-toggle":"tooltip", "data-bs-placement":"bottom", "aria-label":"Enable light mode"], 
                tablerIcon("sun")),
              UIMNavItem(["dropdown d-none d-md-flex me-3"], 
                UIMNavLink(["px-0"], ["href":"#", "data-bs-toggle":"dropdown", "tabindex":"-1", "aria-label":"Show notifications"], 
                  H5String(tablerIcon("bell")), UIMBadge(["bg-red"])),
                H5Div(["dropdown-menu dropdown-menu-arrow dropdown-menu-end dropdown-menu-card"], 
                  UIMCard(
                    H5Div(["card-header"], 
                      H5H3(["card-title"], "Last updates")),
                    H5Div(["list-group list-group-flush list-group-hoverable"], 
                      H5Div(["list-group-item"], 
                        UIMRow(["align-items-center"], 
                          UIMCol.sizes("auto")( H5Span(["status-dot status-dot-animated bg-red d-block"])),
                          H5Div(["col text-truncate"], 
                            H5A(["text-body d-block"], ["href":"#"], "Example 1"),
                            H5Div(["d-block text-muted text-truncate mt-n1"], 
                              "Change deprecated html tags to text decoration classes (#29604)"
                            )
                          ),
                          UIMCol.sizes("auto")( 
                            H5A(["list-group-item-actions"], ["href":"#"], 
                              tablerIcon("star")
                            )
                          )
                        )
                      ),
                      H5Div(["list-group-item"], 
                        UIMRow(["align-items-center"], 
                          UIMCol.sizes("auto")( H5Span(["status-dot d-block"])),
                          H5Div(["col text-truncate"], 
                            H5A(["text-body d-block"], ["href":"#"], "Example 2"),
                            H5Div(["d-block text-muted text-truncate mt-n1"], 
                              "justify-content:between ⇒ justify-content:space-between (#29734)"
                            )
                          ),
                          UIMCol.sizes("auto")( 
                            H5A(["list-group-item-actions show"], ["href":"#"], tablerIcon("star"))
                          )
                        )
                      ),
                      H5Div(["list-group-item"], 
                        UIMRow(["align-items-center"], 
                          UIMCol.sizes("auto")( H5Span(["status-dot d-block"])),
                          H5Div(["col text-truncate"], 
                            H5A(["text-body d-block"], ["href":"#"], "Example 3"),
                            H5Div(["d-block text-muted text-truncate mt-n1"], 
                              "Update change-version.js (#29736)"
                            )
                          ),
                          UIMCol.sizes("auto")( 
                            H5A(["list-group-item-actions"], ["href":"#"], 
                              tablerIcon("star")
                            )
                          )
                        )
                      ),
                      H5Div(["list-group-item"], 
                        UIMRow(["align-items-center"], 
                          UIMCol.sizes("auto")( H5Span(["status-dot status-dot-animated bg-green d-block"])),
                          UIMCol(["text-truncate"], 
                            H5A(["text-body d-block"], ["href":"#"], "Example 4"),
                            H5Div(["d-block text-muted text-truncate mt-n1"], 
                              "Regenerate package-lock.json (#29730)"
                            )
                          ),
                          UIMCol.sizes("auto")( 
                            H5A(["list-group-item-actions"], ["href":"#"], tablerIcon("star"))
                          )
                        )
                      )
                    )
                  )
                )
              )
            ),
            UIMNavItem(["dropdown"], 
              UIMNavLink(["d-flex lh-1 text-reset p-0"], ["data-bs-toggle":"dropdown", "href":"#", "aria-label":"Open user menu", "aria-expanded":"false"], 
                UIMAvatar(["avatar-sm"], ["style":"background-image: url(./static/avatars/000m.jpg)"]),
                H5Div(["d-none d-xl-block ps-2"], 
                  H5Div("Paweł Kuna"), H5Div(["mt-1 small text-muted"], "UI Designer")
                )
              ),
              H5Div(["dropdown-menu dropdown-menu-end dropdown-menu-arrow"], 
                UIMDropdownItem.link("#")("Status"),
                UIMDropdownItem.link("#")("Profile"),
                UIMDropdownItem.link("#")("Feedback"),
                UIMDropdownDivider,
                UIMDropdownItem.link("./settings.html")("Settings"),
                UIMDropdownItem.link("./sign-in.html")("Logout")
              )
            )
          ),
          H5H1(["navbar-brand navbar-brand-autodark d-none-navbar-horizontal pe-0 pe-md-3"], 
            H5A(["href":"."], 
              H5Img(["navbar-brand-image"], ["src":"./static/logo.svg", "width":"110", "height":"32", "alt":"Tabler"])
            )
          ),
          UIMNavbarNav(["flex-row order-md-last"], 
            H5Div(["d-none d-md-flex"], 
              UIMNavLink(["px-0 hide-theme-dark"], ["href":"?theme=dark", "data-bs-toggle":"tooltip", "data-bs-placement":"bottom", "aria-label":"Enable dark mode"], 
                tablerIcon("moon")),                
              UIMNavLink(["px-0 hide-theme-light"], ["href":"?theme=light", "data-bs-toggle":"tooltip", "data-bs-placement":"bottom", "aria-label":"Enable light mode"], 
                tablerIcon("sun")),
              UIMNavItem(["dropdown d-none d-md-flex me-3"], 
                UIMNavLink(["px-0"], ["href":"#", "data-bs-toggle":"dropdown", "tabindex":"-1", "aria-label":"Show notifications"], 
                  H5String(tablerIcon("bell")), UIMBadge(["bg-red"])),
                H5Div(["dropdown-menu dropdown-menu-arrow dropdown-menu-end dropdown-menu-card"], 
                  UIMCard(
                    UIMCardHeader( 
                      H5H3(["card-title"], "Last updates")),
                    H5Div(["list-group list-group-flush list-group-hoverable"], 
                      H5Div(["list-group-item"], 
                        UIMRow(["align-items-center"], 
                          UIMCol.sizes("auto")( H5Span(["status-dot status-dot-animated bg-red d-block"])),
                          H5Div(["col text-truncate"], 
                            H5A(["text-body d-block"], ["href":"#"], "Example 1"),
                            H5Div(["d-block text-muted text-truncate mt-n1"], 
                              "Change deprecated html tags to text decoration classes (#29604)"
                            )
                          ),
                          UIMCol.sizes("auto")( 
                            H5A(["list-group-item-actions"], ["href":"#"], 
                              tablerIcon("star")
                            )
                          )
                        )
                      ),
                      H5Div(["list-group-item"], 
                        UIMRow(["align-items-center"], 
                          UIMCol.sizes("auto")( H5Span(["status-dot d-block"])),
                          H5Div(["col text-truncate"], 
                            H5A(["text-body d-block"], ["href":"#"], "Example 2"),
                            H5Div(["d-block text-muted text-truncate mt-n1"], 
                              "justify-content:between ⇒ justify-content:space-between (#29734)"
                            )
                          ),
                          UIMCol.sizes("auto")( 
                            H5A(["list-group-item-actions show"], ["href":"#"], tablerIcon("star"))
                          )
                        )
                      ),
                      H5Div(["list-group-item"], 
                        UIMRow(["align-items-center"], 
                          UIMCol.sizes("auto")( H5Span(["status-dot d-block"])),
                          H5Div(["col text-truncate"], 
                            H5A(["text-body d-block"], ["href":"#"], "Example 3"),
                            H5Div(["d-block text-muted text-truncate mt-n1"], 
                              "Update change-version.js (#29736)"
                            )
                          ),
                          UIMCol.sizes("auto")( 
                            H5A(["list-group-item-actions"], ["href":"#"], 
                              tablerIcon("star")
                            )
                          )
                        )
                      ),
                      H5Div(["list-group-item"], 
                        UIMRow(["align-items-center"], 
                          UIMCol.sizes("auto")( H5Span(["status-dot status-dot-animated bg-green d-block"])),
                          H5Div(["col text-truncate"], 
                            H5A(["text-body d-block"], ["href":"#"], "Example 4"),
                            H5Div(["d-block text-muted text-truncate mt-n1"], 
                              "Regenerate package-lock.json (#29730)"
                            )
                          ),
                          UIMCol.sizes("auto")( 
                            H5A(["list-group-item-actions"], ["href":"#"], tablerIcon("star"))
                          )
                        )
                      )
                    )
                  )
                )
              )
            ),
            UIMNavItem(["dropdown"], 
              UIMNavLink(["d-flex lh-1 text-reset p-0"], ["data-bs-toggle":"dropdown", "href":"#", "aria-label":"Open user menu", "aria-expanded":"false"], 
                H5Span(["avatar avatar-sm"], ["style":"background-image: url(./static/avatars/000m.jpg)"]),
                H5Div(["d-none d-xl-block ps-2"], 
                  H5Div("Paweł Kuna"), H5Div(["mt-1 small text-muted"], "UI Designer")
                )
              ),
              H5Div(["dropdown-menu dropdown-menu-end dropdown-menu-arrow"], 
                UIMDropdownItem.link("#")("Status"),
                UIMDropdownItem.link("#")("Profile"),
                UIMDropdownItem.link("#")("Feedback"),
                UIMDropdownDivider,
                UIMDropdownItem.link("./settings.html")("Settings"),
                UIMDropdownItem.link("./sign-in.html")("Logout")
              )
            )
          )
        )
      )      
    );

    /* this.Footer(
      UIMFooter.transparent(true)( 
        UIMContainer.size("xl")( 
          UIMRow(["text-center align-items-center flex-row-reverse"], 
            H5Div(["col-lg-auto ms-lg-auto"], 
              H5Ul(["list-inline list-inline-dots mb-0"], 
                H5Li(["list-inline-item"], H5A(["link-secondary"], ["href":"./docs/index.html"], "Documentation")),
                H5Li(["list-inline-item"], H5A(["link-secondary"], ["href":"./license.html"], "License")),
                H5Li(["list-inline-item"], H5A(["link-secondary"], ["href":"https://github.com/tabler/tabler", "target":"_blank", "rel":"noopener"], "Source code")),
                H5Li(["list-inline-item"], 
                  H5A(["link-secondary"], ["href":"https://github.com/sponsors/codecalm", "target":"_blank", "rel":"noopener"], 
                    tablerIcon("heart")~" Sponsor"
                  )
                )
              )
            ),
            H5Div(["col-12 col-lg-auto mt-3 mt-lg-0"], 
              H5Ul(["list-inline list-inline-dots mb-0"], 
                H5Li(["list-inline-item"], 
                  H5String("Copyright © 2022"),
                  H5A(["link-secondary"], ["href":"."], "Tabler"),.
                  H5String(" All rights reserved.")
                ),
                H5Li(["list-inline-item"], 
                  "Generated 2022-09-24 09:54 UTC"
                )
              )
            )
          )
        )
      )
    ); */
  }

  mixin(OProperty!("DH5Obj", "PageHeader"));
  mixin(OProperty!("DH5Obj", "PageBody"));
  /* mixin(OProperty!("DH5Obj", "Footer")); */
  mixin(OProperty!("DH5Obj", "SecondNavbar"));
  mixin(OProperty!("DH5Obj", "MainNavbar"));

	override string render(IPageController controller, string content, STRINGAA options = null) { 
		debugMethodCall(moduleName!DGeneralLayout~":DGeneralLayout("~this.name~")::render(DPageController controller, string content, STRINGAA options = null)");
		super.render(controller, content, options);

		if (application) {
      debug writeln("Found application");
			options["rootPath"] = application.rootPath;      
			foreach(k,v; application.parameters) if (k !in options) options[k] = v; }

		// creating HTML page
		auto myHtml = H5Html
		.attributes("lang", options.get("lang", "en")).attributes("dir", options.get("dir", "ltr"));
		
    // Head part of HTML
    auto headContent = 
      (options.get("title", null) ? "<title>" ~ options.get("title", null) ~ "</title>":null)~
		  (myMetas.asString~options.get("metas", null))~
		  (myLinks.asString~options.get("links", null))~
		  ("link" in options ? options["link"] : null)~
		  (myStyles.asString~options.get("styles", null))~
		  ("style" in options ? H5Style(options["style"]).toString : null);

    auto myHead = H5Head(headClasses, headAttributes, headContent);

		// Body part of HTML
		auto bodyContent = 
      UIMPage( 
        MainNavbar,
        SecondNavbar,
        UIMPageWrapper( 
          PageHeader,
          UIMPageBody( 
            UIMContainer.size("xl")( 
              (this.layout ?  this.layout.render(controller, content, options) : content)
            )
          ),
          /* Footer */
        )
      ).toString~
      (myScripts.asString~options.get("script", null));

		auto myBody = H5Body(bodyClasses, bodyAttributes, bodyContent);

    debug writeln(myHtml
      .head(myHead)
      .body_(myBody)
      .toString);

    return myHtml
      .head(myHead)
      .body_(myBody)
      .toString;
	}
  // #endregion render
}
auto GeneralLayout() { return new DGeneralLayout; }
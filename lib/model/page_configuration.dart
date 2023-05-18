class PageConfiguration {
  final bool unknown;
  final bool register;
  final bool? loggedIn;
  final String? qouteId;

  PageConfiguration.splash()
      : unknown = false,
        register = false,
        loggedIn = null,
        qouteId = null;
  PageConfiguration.login()
      : unknown = false,
        register = false,
        loggedIn = false,
        qouteId = null;

  PageConfiguration.register()
      : unknown = false,
        register = true,
        loggedIn = false,
        qouteId = null;

  PageConfiguration.home()
      : unknown = false,
        register = false,
        loggedIn = true,
        qouteId = null;

  PageConfiguration.detailQuote(String id)
      : unknown = false,
        register = false,
        loggedIn = true,
        qouteId = id;

  PageConfiguration.unknown()
      : unknown = true,
        register = false,
        loggedIn = null,
        qouteId = null;

  bool get isSplashPage =>
      unknown == false &&
      register == false &&
      loggedIn == null &&
      qouteId == null;

  bool get isLoginPage =>
      unknown == false &&
      register == false &&
      loggedIn == false &&
      qouteId == null;

  bool get isRegisterPage =>
      unknown == false &&
      register == true &&
      loggedIn == false &&
      qouteId == null;

  bool get isHomePage =>
      unknown == false &&
      register == false &&
      loggedIn == true &&
      qouteId == null;
  bool get isDetailPage =>
      unknown == false &&
      register == false &&
      loggedIn == true &&
      qouteId != null;

  bool get isUnknownPage =>
      unknown == true &&
      register == false &&
      loggedIn == null &&
      qouteId == null;
}

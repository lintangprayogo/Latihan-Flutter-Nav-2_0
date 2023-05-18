import 'package:flutter/material.dart';
import 'package:latihan_navigation_version_dua/db/auth_repository.dart';
import 'package:latihan_navigation_version_dua/model/page_configuration.dart';
import 'package:latihan_navigation_version_dua/model/qoute.dart';
import 'package:latihan_navigation_version_dua/screen/login_screen.dart';
import 'package:latihan_navigation_version_dua/screen/qoute_detail_screen.dart';
import 'package:latihan_navigation_version_dua/screen/qoute_list_screen.dart';
import 'package:latihan_navigation_version_dua/screen/register_screen.dart';
import 'package:latihan_navigation_version_dua/screen/splash_screen.dart';

class MyRouterDelegate extends RouterDelegate<PageConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;
  final AuthRepository authRepository;

  MyRouterDelegate(
    this.authRepository,
  ) : _navigatorKey = GlobalKey<NavigatorState>() {
    _init();
  }

  _init() async {
    isLoggedIn = await authRepository.isLoggedIn();
    notifyListeners();
  }

  List<Page> historyStack = [];
  bool? isLoggedIn;
  bool isRegister = false;
  String? selectedQuote;
  bool? isUnknown;

  List<Page> get _splashStack => const [MaterialPage(child: SplashScreen())];

  List<Page> get _loggedInStack => [
        MaterialPage(
          key: const ValueKey("QuotesListPage"),
          child: QuotesListScreen(
            quotes: quotes,
            onTapped: (String quoteId) {
              selectedQuote = quoteId;
              notifyListeners();
            },
            onLogout: () {
              isLoggedIn = false;
              notifyListeners();
            },
          ),
        ),
        if (selectedQuote != null)
          MaterialPage(
            key: ValueKey(selectedQuote),
            child: QuoteDetailsScreen(
              quoteId: selectedQuote!,
            ),
          ),
      ];

  List<Page> get _loggedOutStack => [
        MaterialPage(
          key: const ValueKey("LoginPage"),
          child: LoginScreen(
            onLogin: () {
              isLoggedIn = true;
              notifyListeners();
            },
            onRegister: () {
              isRegister = true;
              notifyListeners();
            },
          ),
        ),
        if (isRegister == true)
          MaterialPage(
            key: const ValueKey("RegisterPage"),
            child: RegisterScreen(
              onLogin: () {
                isLoggedIn = true;
                notifyListeners();
              },
              onRegister: () {
                isRegister = false;
                notifyListeners();
              },
            ),
          ),
      ];

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn == null) {
      historyStack = _splashStack;
    } else if (isLoggedIn == true) {
      historyStack = _loggedInStack;
    } else {
      historyStack = _loggedOutStack;
    }

    return Navigator(
        key: navigatorKey,
        pages: historyStack,
        onPopPage: (route, result) {
          final didPop = route.didPop(result);
          if (!didPop) {
            return false;
          }

          isRegister = false;
          selectedQuote = null;
          notifyListeners();

          return true;
        });
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  Future<void> setNewRoutePath(configuration) async {
    if (configuration.isUnknownPage) {
      isUnknown = true;
      isRegister = false;
    } else if (configuration.isRegisterPage) {
      isRegister = true;
    } else if (configuration.isHomePage ||
        configuration.isLoginPage ||
        configuration.isSplashPage) {
      isUnknown = false;
      selectedQuote = null;
      isRegister = false;
    } else if (configuration.isDetailPage) {
      isUnknown = false;
      isRegister = false;
      selectedQuote = configuration.qouteId.toString();
    } else {
      print(' Could not set new route');
    }

    notifyListeners();
  }

  @override
  PageConfiguration? get currentConfiguration {
    if (isLoggedIn == null) {
      return PageConfiguration.splash();
    } else if (isRegister == true) {
      return PageConfiguration.register();
    } else if (isLoggedIn == false) {
      return PageConfiguration.login();
    } else if (isUnknown == true) {
      return PageConfiguration.unknown();
    } else if (selectedQuote == null) {
      PageConfiguration.home();
    } else if (selectedQuote != null) {
      return PageConfiguration.detailQuote(selectedQuote ?? "");
    } else {
      return PageConfiguration.unknown();
    }
  }
}

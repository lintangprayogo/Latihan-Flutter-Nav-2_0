import 'package:flutter/material.dart';
import 'package:latihan_navigation_version_dua/db/auth_repository.dart';
import 'package:latihan_navigation_version_dua/provider/auth_provider.dart';
import 'package:latihan_navigation_version_dua/routes/router_delegate.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const QuotesApp());
}

class QuotesApp extends StatefulWidget {
  const QuotesApp({Key? key}) : super(key: key);

  @override
  State<QuotesApp> createState() => _QuotesAppState();
}

class _QuotesAppState extends State<QuotesApp> {
  late MyRouterDelegate myRouterDelegate;
  late AuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    final authRepository = AuthRepository();

    myRouterDelegate = MyRouterDelegate(authRepository);

    authProvider = AuthProvider(authRepository);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => authProvider,
      child: MaterialApp(
          title: 'Quotes App',
          home: Router(
            routerDelegate: myRouterDelegate,
            backButtonDispatcher: RootBackButtonDispatcher(),
          )),
    );
  }
}

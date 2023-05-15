import 'package:flutter/material.dart';
import 'package:latihan_navigation_version_dua/model/qoute.dart';
import 'package:latihan_navigation_version_dua/screen/form_screen.dart';
import 'package:latihan_navigation_version_dua/screen/qoute_detail_screen.dart';
import 'package:latihan_navigation_version_dua/screen/qoute_list_screen.dart';

class MyRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;

  MyRouterDelegate() : _navigatorKey = GlobalKey<NavigatorState>();
  String? selectedQuote;
  bool isForm = false;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
            key: const ValueKey("QoutesListPage"),
            child: QuotesListScreen(
              quotes: quotes,
              onTapped: (id) {
                selectedQuote = id;
                notifyListeners();
              },
              toFormScreen: () {
                isForm = true;
                notifyListeners();
              },
            )),
        if (selectedQuote != null)
          MaterialPage(
              key: ValueKey("QuoteDetailsPage-$selectedQuote"),
              child: QuoteDetailsScreen(
                quoteId: selectedQuote!,
              )),
        if (isForm)
          MaterialPage(child: FormScreen(onSend: () {
            isForm = false;
            notifyListeners();
          }))
      ],
      onPopPage: (route, result) {
        final didPop = route.didPop(result);
        if (!didPop) {
          return false;
        }
        selectedQuote = null;
        isForm = false;

        notifyListeners();
        return true;
      },
    );
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  Future<void> setNewRoutePath(configuration) async {}
}

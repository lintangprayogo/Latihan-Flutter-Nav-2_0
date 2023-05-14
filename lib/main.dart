import 'package:flutter/material.dart';
import 'package:latihan_navigation_version_dua/model/qoute.dart';
import 'package:latihan_navigation_version_dua/screen/qoute_detail_screen.dart';
import 'package:latihan_navigation_version_dua/screen/qoute_list_screen.dart';

void main() {
  runApp(const QuotesApp());
}

class QuotesApp extends StatefulWidget {
  const QuotesApp({Key? key}) : super(key: key);

  @override
  State<QuotesApp> createState() => _QuotesAppState();
}

class _QuotesAppState extends State<QuotesApp> {
  String? selectedQuote;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quotes App',
      home: Navigator(
        pages: [
          MaterialPage(
              key: const ValueKey("QoutesListPage"),
              child: QuotesListScreen(
                quotes: quotes,
                onTapped: (id) {
                  setState(() {
                    selectedQuote = id;
                  });
                },
              )),
          if (selectedQuote != null)
            MaterialPage(
                key: ValueKey("QuoteDetailsPage-$selectedQuote"),
                child: QuoteDetailsScreen(
                  quoteId: selectedQuote!,
                ))
        ],
        onPopPage: (route, result) {
          final didPop = route.didPop(result);
          if (!didPop) {
            return false;
          }
          setState(() {
            selectedQuote = null;
          });
          return true;
        },
      ),
    );
  }
}

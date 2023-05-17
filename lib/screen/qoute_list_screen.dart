import 'package:flutter/material.dart';
import 'package:latihan_navigation_version_dua/model/qoute.dart';
import 'package:latihan_navigation_version_dua/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class QuotesListScreen extends StatelessWidget {
  final List<Quote> quotes;
  final Function(String) onTapped;
  final Function() onLogout;

  const QuotesListScreen(
      {Key? key,
      required this.quotes,
      required this.onTapped,
      required this.onLogout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authWatch = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Quotes App"),
      ),
      body: ListView(
        children: [
          for (var quote in quotes)
            ListTile(
              title: Text(quote.author),
              subtitle: Text(quote.quote),
              isThreeLine: true,
              onTap: () {
                onTapped(quote.id);
              },
            )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          tooltip: "Logout",
          onPressed: () async {
            final authRead = context.read<AuthProvider>();
            final result = await authRead.logout();
            if (result) onLogout();
          },
          child: authWatch.isLoadingLogout
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : const Icon(Icons.logout)),
    );
  }
}

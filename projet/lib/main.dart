import 'package:flutter/material.dart';
import 'package:projet/pages/AuthProvider.dart';
import 'package:projet/pages/login_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: MaterialApp(
        title: 'Food App',
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginPage(),
          // Add other routes as needed
        },
      ),
    );
  }
}

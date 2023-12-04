import 'package:flutter/material.dart';
import 'package:projet/pages/AuthProvider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Simulate a login process
            Provider.of<AuthProvider>(context, listen: false).login();
          },
          child: Text('Login'),
        ),
      ),
    );
  }
}

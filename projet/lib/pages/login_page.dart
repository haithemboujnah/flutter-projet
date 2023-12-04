import 'package:flutter/material.dart';
import 'package:projet/models/User.dart';
import 'package:provider/provider.dart';

import 'AuthProvider.dart';
import 'DatabaseHelper.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();

    if (username.isNotEmpty && password.isNotEmpty) {
      final DatabaseHelper dbHelper = DatabaseHelper();
      await dbHelper.initDatabase();

      final User? user = await dbHelper.getUserByUsername(username);

      if (user != null) {
        if (user.password == password) {
          if (user.isAdmin) {
            // Admin login
            Provider.of<AuthProvider>(context, listen: false).login();
            Navigator.pushReplacementNamed(context, '/admin_home');
          } else {
            // Visitor login
            Provider.of<AuthProvider>(context, listen: false).login();
            Navigator.pushReplacementNamed(context, '/visitor_home');
          }
        } else {
          // Incorrect password
          _showErrorDialog('Login Failed', 'Incorrect password.');
        }
      } else {
        // User not found
        _showErrorDialog('Login Failed', 'User not found. Please sign up or check your credentials.');
      }
    } else {
      // Username or password is empty
      _showErrorDialog('Login Failed', 'Please enter both username and password.');
    }
  }


  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

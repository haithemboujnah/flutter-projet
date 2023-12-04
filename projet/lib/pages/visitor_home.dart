import 'package:flutter/material.dart';

class VisitorHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visitor Home'),
      ),
      body: Center(
        child: Text('Welcome, Visitor!'),
      ),
    );
  }
}

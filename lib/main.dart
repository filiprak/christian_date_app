import 'package:flutter/material.dart';
import 'package:christian_date_app/pages/login/login_page.dart';
import 'theme.dart' as theme;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme.themeData,
      home: LoginPage(),
    );
  }
}

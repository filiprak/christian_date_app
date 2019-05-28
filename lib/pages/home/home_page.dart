import 'package:christian_date_app/pages/login/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  static String tag = 'forgot-password-page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final logo = SizedBox(
        child: Padding(
          padding: EdgeInsets.only(left: 48.0, right: 48.0),
          child: Image.asset('assets/logo_center.png', fit: BoxFit.cover),
        )
    );

    final back = FlatButton(
      child: Text('Wróć do logowania'),
      onPressed: () {
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => LoginPage()),
        );
      },
    );

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            back,
          ],
        ),
      ),
    );
  }
}

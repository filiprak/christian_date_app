import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SearchPage extends StatefulWidget {
  static String tag = 'search-page';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final logo = SizedBox(
        child: Padding(
          padding: EdgeInsets.only(left: 48.0, right: 48.0),
          child: Image.asset('assets/logo_center.png', fit: BoxFit.cover),
        )
    );

    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
          ],
        ),
      ),
    );
  }
}

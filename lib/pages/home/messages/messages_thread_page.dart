import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MessagesThreadPage extends StatefulWidget {
  static String tag = 'messages-page';

  @override
  _MessagesThreadPageState createState() => _MessagesThreadPageState();
}

class _MessagesThreadPageState extends State<MessagesThreadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            Center(child: Text('message 1')),
            Center(child: Text('message 2')),
            Center(child: Text('message 3')),
            Center(child: Text('message 4')),
          ],
        ),
      ),
    );
  }
}

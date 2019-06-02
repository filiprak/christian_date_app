import 'package:flutter/material.dart';


class Dialogs {
  static info(BuildContext context, {Map<String, dynamic> params : const {}}) {

    final actions = <Widget>[
      FlatButton(
        child: Text('OK'),
        onPressed: () {
          Navigator.pop(context);
        },
      )
    ];

    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: Text(params.containsKey('title') ? params['title'] : 'Informacja'),
          actions: actions,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(params.containsKey('content') ? params['content'] : '')
              ],
            ),
          ),
        );
      }
    );
  }

  static error(BuildContext context, {Map<String, dynamic> params : const {}}) {
    final actions = <Widget>[
      FlatButton(
        child: Text('OK'),
        onPressed: () {
          Navigator.pop(context);
        },
      )
    ];

    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: Text(params.containsKey('title') ? params['title'] : 'Wystąpił błąd'),
            actions: actions,
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(params.containsKey('content') ? params['content'] : '')
                ],
              ),
            ),
          );
        }
    );
  }

  static loading(BuildContext context, {Map<String, dynamic> params : const {}}) {

    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            content: SingleChildScrollView(
              padding: EdgeInsets.all(5.0),
              child: ListBody(
                children: <Widget>[
                  Center(
                    child: CircularProgressIndicator(),
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}
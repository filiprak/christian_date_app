import 'package:christian_date_app/state/appState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:redux/redux.dart';

class NewsSinglePage extends StatefulWidget {
  static String tag = 'news-single-page';

  @override
  _NewsSinglePageState createState() => _NewsSinglePageState();
}

class _NewsSinglePageState extends State<NewsSinglePage> {

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Store<AppState>>(
        converter: (store) => store,
        builder: (context, store) {
          return Scaffold();
        });
  }
}

import 'package:christian_date_app/state/actions/actions.dart';
import 'package:christian_date_app/state/appState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:redux/redux.dart';

class UsersSinglePage extends StatefulWidget {
  static String tag = 'news-single-page';
  final int userId;

  UsersSinglePage(this.userId);

  @override
  _UsersSinglePageState createState() => _UsersSinglePageState(this.userId);
}

class _UsersSinglePageState extends State<UsersSinglePage> {

  final int userId;

  _UsersSinglePageState(this.userId);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Store<AppState>>(
        converter: (store) => store,
        builder: (context, store) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              title: Text('Użytkownik: ' + userId.toString()),
              leading: IconButton(icon:Icon(Icons.arrow_back),
                  onPressed:() => store.dispatch(NavigatePopAction())
              ),
            ),
            body: Text('@todo'),
          );
        });
  }
}

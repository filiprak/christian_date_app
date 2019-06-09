import 'package:christian_date_app/state/actions/actions.dart';
import 'package:christian_date_app/state/appState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:redux/redux.dart';

class NewsSinglePage extends StatefulWidget {
  static String tag = 'news-single-page';
  final int activityId;

  NewsSinglePage(this.activityId);

  @override
  _NewsSinglePageState createState() => _NewsSinglePageState(this.activityId);
}

class _NewsSinglePageState extends State<NewsSinglePage> {

  final int activityId;

  _NewsSinglePageState(this.activityId);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Store<AppState>>(
        converter: (store) => store,
        builder: (context, store) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              title: Text('Aktywność: ' + activityId.toString()),
              leading: IconButton(icon:Icon(Icons.arrow_back),
                  onPressed:() => store.dispatch(NavigatePopAction())
              ),
            ),
            body: Text('@todo'),
          );
        });
  }
}

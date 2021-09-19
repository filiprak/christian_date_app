import 'package:christian_date_app/state/actions/actions.dart';
import 'package:christian_date_app/state/appState.dart';
import 'package:christian_date_app/state/models/userModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:redux/redux.dart';

class UsersSinglePage extends StatefulWidget {
  static String tag = 'user-single-page';
  final UserModel user;

  UsersSinglePage(this.user);

  @override
  _UsersSinglePageState createState() => _UsersSinglePageState(this.user);
}

class _UsersSinglePageState extends State<UsersSinglePage> {

  final UserModel user;

  _UsersSinglePageState(this.user);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Store<AppState>>(
        converter: (store) => store,
        builder: (context, store) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              title: Text(user.name + (user.xProfile.age != null ? ', ' + user.xProfile.age.toString() : '')),
              leading: IconButton(icon:Icon(Icons.arrow_back),
                  onPressed:() => store.dispatch(NavigatePopAction())
              ),
            ),
            body: ListView(
              children: <Widget>[
                Image.network(user.avatar),
                if (user.xProfile.about != null && user.xProfile.about.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
                        child: Text(
                          'O mnie',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
                        child: Html(
                          data: user.xProfile.about,
                          defaultTextStyle: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ]
                  ),
                if (user.xProfile.city != null && user.xProfile.city.isNotEmpty)
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
                          child: Text(
                            'Lokalizacja',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[400],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
                          child: Html(
                            data: user.xProfile.city + (user.xProfile.district != null ? ', ' + user.xProfile.district : ''),
                            defaultTextStyle: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ]
                  )
              ],
            )
          );
        });
  }
}

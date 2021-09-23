import 'package:christian_date_app/components/dialogs.dart';
import 'package:christian_date_app/state/actions/actions.dart';
import 'package:christian_date_app/state/actions/asyncActions.dart';
import 'package:christian_date_app/state/actions/asyncMessageActions.dart';
import 'package:christian_date_app/state/actions/messageActions.dart';
import 'package:christian_date_app/state/appState.dart';
import 'package:christian_date_app/state/models/privateMessageModel.dart';
import 'package:christian_date_app/state/models/userModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:redux/redux.dart';

class UserProfilePage extends StatefulWidget {
  static String tag = 'user-profile-page';
  final UserModel user;

  UserProfilePage(this.user);

  @override
  _UserProfilePageState createState() => _UserProfilePageState(this.user);
}

class _UserProfilePageState extends State<UserProfilePage> {

  final UserModel user;
  final _sendTextController = TextEditingController(text: '');

  _UserProfilePageState(this.user);

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
            body: Column(
              children: [
                Flexible(
                  child: ListView(
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
                  ),
                ),
                if (user.id != store.state.loggedUser.id)
                  Row(
                    children: <Widget>[
                      Flexible(
                          child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _sendTextController,
                                keyboardType: TextInputType.multiline,
                                minLines: 1,
                                maxLines: 5,
                                maxLength: 2048,
                                autofocus: false,
                                decoration: InputDecoration(
                                    counterText: '',
                                    hintText: 'Napisz coś',
                                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(24.0)
                                    )
                                ),
                              )
                          )
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 8.0),
                        child: store.state.messagesState.sendingMessage ? Container(
                          width: 48.0,
                          child: Center(
                            child: SizedBox(
                              width: 24.0,
                              height: 24.0,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ) : IconButton(
                          color: Theme.of(context).primaryColor,
                          icon: Icon(Icons.send),
                          onPressed: store.state.messagesState.sendingMessage ? null : () {
                            if (_sendTextController.text.length > 0) {
                              store.dispatch(SendMessageAction(null, _sendTextController.text, recipients: [user.id]).thunk(context));
                              _sendTextController.text = '';
                            } else {
                              store.dispatch(ShowModalDialogAction().thunk(Dialogs.error(context, params: {
                                'title': '',
                                'content': 'Wiadomość nie może być pusta'
                              })));
                            }
                          },
                        ),
                      )
                    ],
                  ),
              ],
            )
          );
        });
  }
}

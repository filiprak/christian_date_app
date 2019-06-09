import 'package:christian_date_app/components/dialogs.dart';
import 'package:christian_date_app/state/actions/actions.dart';
import 'package:christian_date_app/state/actions/asyncActions.dart';
import 'package:christian_date_app/state/appState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class NewsPostPage extends StatefulWidget {
  static String tag = 'news-post-page';

  @override
  _NewsPostPageState createState() => _NewsPostPageState();
}

class _NewsPostPageState extends State<NewsPostPage> {

  final contentController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Store<AppState>>(
        converter: (store) => store,
        builder: (context, store) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              title: Text('Nowy post'),
              leading: IconButton(icon:Icon(Icons.arrow_back),
                onPressed:() => store.dispatch(NavigatePopAction())
              ),
            ),
            body: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 10.0),
                      child: CircleAvatar(
                        radius: 20.0,
                        backgroundImage: store.state.loggedUser != null ? NetworkImage(store.state.loggedUser.avatar['48']) : null,
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(store.state.loggedUser != null ? store.state.loggedUser.name : '',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(store.state.loggedUser != null ? store.state.loggedUser.username : '',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ),
                        )
                      ),
                      MaterialButton(
                        child: Text('Opublikuj'),
                        shape: BeveledRectangleBorder(),
                        padding: EdgeInsets.all(16.0),
                        onPressed: store.state.loading ? null : () {
                          if (contentController.text.trim().length > 0) {
                            store.dispatch(PublishNewPostAction(contentController.text.trim()).thunk(context));
                          } else {
                            store.dispatch(ShowModalDialogAction().thunk(Dialogs.error(context,
                              params: {
                                'content': 'Proszę wpisać treść postu'
                              })));
                          }
                        }
                      ),
                  ],
                ),
                Divider(height: 1.0),
                Expanded(
                  child: Container(
                    height: 100.0,
                    child: TextFormField(
                      maxLines: null,
                      controller: contentController,
                      style: TextStyle(
                        fontSize: 22,
                      ),
                      autofocus: false,
                      decoration: InputDecoration(
                        hintText: 'Co słychać ?',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(12.0)
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

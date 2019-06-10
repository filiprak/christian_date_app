import 'package:christian_date_app/components/dialogs.dart';
import 'package:christian_date_app/state/actions/actions.dart';
import 'package:christian_date_app/state/actions/asyncActions.dart';
import 'package:christian_date_app/state/actions/asyncMessageActions.dart';
import 'package:christian_date_app/state/appState.dart';
import 'package:christian_date_app/state/models/privateMessageModel.dart';
import 'package:christian_date_app/state/models/threadModel.dart';
import 'package:christian_date_app/state/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/services.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:redux/redux.dart';

class MessagesThreadPage extends StatefulWidget {
  static String tag = 'messages-thread-page';

  final ThreadModel thread;

  MessagesThreadPage(this.thread);

  @override
  _MessagesThreadPageState createState() =>
      _MessagesThreadPageState(this.thread);
}

class _MessagesThreadPageState extends State<MessagesThreadPage> {
  final ThreadModel thread;

  final Map<int, bool> _showTitle = Map<int, bool>();

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (!store.state.messagesState.hasMessages(thread.id)) {
      store.dispatch(FetchCurrentThreadMessagesChunkAction(0,
          store.state.messagesState.messagesPerLoad,
          thread.id,
          'replace').thunk(context));
    }
    _scrollController.addListener(() {
      if (_scrollController.position.pixels > _scrollController.position.maxScrollExtent - 5) {
        print(_scrollController.position.pixels);
        if (!store.state.messagesState.currentThreadLoading && !store.state.messagesState.allLoaded(thread.id)) {
          store.dispatch(FetchCurrentThreadMessagesChunkAction(
              store.state.messagesState.messagesCount(thread.id), store.state.messagesState.messagesPerLoad, thread.id, 'append')
              .thunk(context));
        }
      }
    });
  }

  _MessagesThreadPageState(this.thread);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Store<AppState>>(
      converter: (store) => store,
        builder: (context, store) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Text(thread.recipient.displayName.toString()),
            leading: IconButton(icon:Icon(Icons.arrow_back),
              onPressed:() => store.dispatch(NavigatePopAction())
            ),
          ),
          body: Column(
            children: <Widget>[
              Flexible(
                child: ListView.builder(
                  reverse: true,
                  controller: _scrollController,
                  itemCount: store.state.messagesState.currentThreadLoading ?
                          store.state.messagesState.messagesCount(thread.id) + 1 :
                          store.state.messagesState.messagesCount(thread.id),
                  itemBuilder: (context, index) {

                    if (store.state.messagesState.currentThreadLoading &&
                        index >= store.state.messagesState.messagesCount(thread.id)) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.all(24.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    PrivateMessageModel _model = store.state.messagesState.getMessage(thread.id, index);

                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 12.0),
                        onLongPress: () {
                          Clipboard.setData(new ClipboardData(text: _model.message));
                          store.dispatch(ShowModalDialogAction().thunk(Dialogs.info(context, params: {
                            'title': '',
                            'content': 'Skopiowano wiadomość do schowka !',
                          })));
                        },
                        onTap: () {
                          this.setState(() {
                            if (_showTitle.containsKey(_model.id)) {
                              _showTitle[_model.id] = !_showTitle[_model.id];
                            } else {
                              _showTitle[_model.id] = true;
                            }
                          });
                        },
                        leading: _model.self ? SizedBox(width: 80.0) : CircleAvatar(
                          radius: 15,
                          backgroundImage: thread.recipient.avatar != null ? NetworkImage(thread.recipient.avatar) : null,
                        ),
                        trailing: null,
                        subtitle: Column(
                          children: <Widget>[
                            _showTitle.containsKey(_model.id) && _showTitle[_model.id] ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text('Tytuł: ', style: TextStyle(
                                  fontWeight: FontWeight.bold
                                )),
                                Text(_model.subject),
                              ],
                            ) : Row(),
                            Padding(
                              padding: EdgeInsets.only(top: 4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Flexible(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: _model.self ? Theme.of(context).primaryColorLight : Colors.grey[300],
                                          borderRadius: BorderRadius.circular(24.0)
                                      ),
                                      padding: EdgeInsets.all(16.0),
                                      child: Text(_model.message, style: TextStyle(
                                        fontSize: 16,
                                        color: _model.self ? Colors.white70 : Theme.of(context).textTheme.body1.color
                                      )),
                                    ),
                                    fit: FlexFit.loose,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    timeago.format(_model.date),
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              ))
                          ],
                        ),
                    );
                  },
                ),
              ),
              Divider(height: 0.0),
              Row(
                children: <Widget>[
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: 'Napisz coś',
                            contentPadding: EdgeInsets.all(12.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0)
                            )
                        ),
                      )
                    )
                  ),
                  Flexible(
                    child: MaterialButton(
                      onPressed: () {

                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      }
    );
  }
}

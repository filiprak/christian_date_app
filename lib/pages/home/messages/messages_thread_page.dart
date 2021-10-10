import 'package:christian_date_app/components/dialogs.dart';
import 'package:christian_date_app/state/actions/actions.dart';
import 'package:christian_date_app/state/actions/asyncActions.dart';
import 'package:christian_date_app/state/actions/asyncMessageActions.dart';
import 'package:christian_date_app/state/actions/messageActions.dart';
import 'package:christian_date_app/state/appState.dart';
import 'package:christian_date_app/state/models/privateMessageModel.dart';
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

  final _sendTextController = TextEditingController(text: '');
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    store.dispatch(FetchCurrentThreadMessagesChunkAction(0,
        store.state.messagesState.messagesPerLoad,
        thread.id,
        'replace').thunk(context));

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
            title: Text(thread.recipients[0].displayName.toString()),
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
                          backgroundImage: thread.recipients[0].avatar != null ? NetworkImage(thread.recipients[0].avatar) : null,
                        ),
                        trailing: null,
                        subtitle: Column(
                          children: <Widget>[
                            _showTitle.containsKey(_model.id) && _showTitle[_model.id] ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Flexible(
                                  child: Text(_model.subject,
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ) : Row(),
                            Padding(
                              padding: EdgeInsets.only(top: 4.0),
                              child: Row(
                                mainAxisAlignment: _model.self ? MainAxisAlignment.end : MainAxisAlignment.start,
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
                                        color: _model.self ? Colors.white : Theme.of(context).textTheme.body1.color
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
                                mainAxisAlignment: _model.self ? MainAxisAlignment.end : MainAxisAlignment.start,
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
                          store.dispatch(UpdateMessagesAction(thread.id, [
                            PrivateMessageModel.fromJson({
                              'id': null,
                              'thread_id': thread.id,
                              'sender_id': store.state.loggedUser.id,
                              'subject': '',
                              'message': _sendTextController.text,
                              'date_sent': DateTime.now().toUtc().toString(),
                              'self': true,
                            })
                          ], 'prepend'));
                          store.dispatch(SendMessageAction(thread.id, _sendTextController.text).thunk(context));
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
          ),
        );
      }
    );
  }
}

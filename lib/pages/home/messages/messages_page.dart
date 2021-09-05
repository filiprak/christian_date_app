import 'package:christian_date_app/state/actions/actions.dart';
import 'package:christian_date_app/state/appState.dart';
import 'package:christian_date_app/state/models/threadModel.dart';
import 'package:christian_date_app/state/models/userModel.dart';
import 'package:christian_date_app/state/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:christian_date_app/state/actions/asyncActions.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:badges/badges.dart';
import 'package:redux/redux.dart';

import 'messages_thread_page.dart';


class MessagesPage extends StatefulWidget {
  static String tag = 'messages-page';

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
                    new GlobalKey<RefreshIndicatorState>();

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    print('initState MessagesPage');

    store.dispatch(FetchMessageThreadsChunkAction(1, store.state.threadsPerLoad, 'replace').thunk(context));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 30) {
        if (!store.state.loadingThreads && !store.state.allThreadsLoaded) {
          store.dispatch(FetchMessageThreadsChunkAction(
              store.state.messageThreads.length, store.state.threadsPerLoad, 'append')
              .thunk(context));
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Store<AppState>>(
        converter: (store) => store,
        builder: (context, store) {
          return Scaffold(
              body: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Szukaj',
                              contentPadding: EdgeInsets.all(12.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0)
                              )
                            ),
                          )
                        )
                      ),
                    ],
                  ),
                  Divider(height: 0.0),
                  Flexible(
                    child: RefreshIndicator(
                      key: _refreshIndicatorKey,
                      onRefresh: () {
                          store.dispatch(FetchMessageThreadsChunkAction(
                              1, store.state.threadsPerLoad, 'replace')
                              .thunk(context));
                          return Future.delayed(const Duration(seconds: 1));
                      },
                      child: ListView.separated(
                        separatorBuilder: (context, index) => Divider(
                          height: 1.0,
                        ),
                        controller: _scrollController,
                        itemCount: store.state.loadingThreads
                            ? store.state.messageThreads.length + 1
                            : store.state.messageThreads.length,
                        itemBuilder: (context, index) {
                          if (index < store.state.messageThreads.length) {
                            ThreadModel _model = store.state.messageThreads[index];
                            UserModel participant = store.state.messageThreadParticipants[_model.participants.first];

                            return ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 12.0),
                              onTap: () {
                                store.dispatch(NavigatePushPageAction(MessagesThreadPage(_model)));
                              },
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundImage: participant != null && participant.avatar != null
                                    ? NetworkImage(store.state.messageThreadParticipants[_model.participants.first].avatar)
                                    : null,
                              ),
                              trailing: _model.unreadCount > 0 ? Badge(
                                elevation: 0.0,
                                badgeColor: Theme.of(context).primaryColorLight,
                                padding: EdgeInsets.all(6.0),
                                badgeContent: Text(
                                  _model.unreadCount > 9 ? '9+' : _model.unreadCount.toString(),
                                  style: TextStyle(
                                    color: Colors.white70
                                  ),
                                ),
                              ) : null,
                              title: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      _model.participants
                                        .map((participant) => store.state.messageThreadParticipants.containsKey(participant) ? store.state.messageThreadParticipants[participant].name : 'Usunięty użytkownik')
                                        .toList()
                                        .join(", "),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: _model.unreadCount > 0 ? FontWeight.bold : FontWeight.normal
                                      ),
                                    )
                                  ),
                                ],
                              ),
                              subtitle: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(top: 4.0),
                                    child: Row(
                                      children: <Widget>[
                                        Flexible(
                                          child: Html(
                                            data: _model.excerpt
                                          )
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 8.0),
                                    child: Row(
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
                          } else {
                            return Center(
                              child: Padding(
                                  child: CircularProgressIndicator(),
                                  padding: EdgeInsets.all(24.0)),
                            );
                          }
                        },
                      ),
                    ),
                  )
                ],
              ));
        });
  }
}

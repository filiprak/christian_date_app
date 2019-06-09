import 'package:christian_date_app/state/appState.dart';
import 'package:christian_date_app/state/models/threadModel.dart';
import 'package:christian_date_app/state/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:christian_date_app/state/actions/asyncActions.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:badges/badges.dart';
import 'package:redux/redux.dart';


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

    if (store.state.messageThreads.isEmpty) {
      store.dispatch(FetchMessageThreadsChunkAction(1, store.state.threadsPerLoad, 'replace').thunk(context));
    }

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 30) {
        if (!store.state.loadingThreads && !store.state.allThreadsLoaded) {
          int page = store.state.messageThreads.length ~/ store.state.threadsPerLoad + 1;
          store.dispatch(FetchMessageThreadsChunkAction(
              page, store.state.threadsPerLoad, 'append')
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
                        return Future<Null>(() {
                          store.dispatch(FetchMessageThreadsChunkAction(
                              1, store.state.threadsPerLoad, 'replace')
                              .thunk(context));
                        });
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

                            return ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 12.0),
                              onTap: () {
                                /*store.dispatch(
                                    NavigatePushPageAction(NewsSinglePage(_model.id)));*/
                              },
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundImage: _model.recipient.avatar != null
                                    ? NetworkImage(_model.recipient.avatar)
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
                                    child: Text(_model.recipient.exists() ? _model.recipient.displayName : '',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold
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
                                            child: Text(_model.lastMessage.message,
                                                overflow: TextOverflow.ellipsis
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
                                          timeago.format(_model.lastMessage.date),
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

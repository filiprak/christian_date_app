import 'package:christian_date_app/state/actions/asyncActions.dart';
import 'package:christian_date_app/state/appState.dart';
import 'package:christian_date_app/state/models/activityModel.dart';
import 'package:christian_date_app/state/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:redux/redux.dart';

class NewsPage extends StatefulWidget {
  static String tag = 'news-page';

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels > _scrollController.position.maxScrollExtent - 30) {
        if (!store.state.loadingActivities) {
          int page = store.state.activities.length ~/ store.state.activitiesPerLoad + 1;
          store.dispatch(FetchActivitiesChunkAction(page, store.state.activitiesPerLoad, 'append').thunk(context));
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
            body: RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: () {
                return Future<Null>(() {
                  store.dispatch(FetchActivitiesChunkAction(1, store.state.activitiesPerLoad, 'replace').thunk(context));
                });
              },
              child: ListView.builder(
                controller: _scrollController,
                itemCount: store.state.loadingActivities
                    ? store.state.activities.length + 1
                    : store.state.activities.length,
                itemBuilder: (context, index) {
                  if (index < store.state.activities.length) {
                    ActivityModel _model = store.state.activities[index];

                    return Column(
                      children: <Widget>[
                        Divider(
                          height: 12.0,
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundImage: _model.avatar != null
                                ? NetworkImage(_model.avatar)
                                : null,
                          ),
                          title: Row(
                            children: <Widget>[
                              Flexible(
                                child: Html(
                                  data: _model.action,
                                  defaultTextStyle: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey
                                  ),
                                ),
                              ),
                            ],
                          ),
                          subtitle: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: _model.content.length > 0 ? 8.0 : 0.0),
                                child: Html(
                                  data: _model.content,
                                  defaultTextStyle: TextStyle(
                                    color: Theme.of(context).textTheme.body1.color,
                                    fontSize: 13,
                                  ),
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
                                )
                              )
                            ],
                          )
                        ),
                      ],
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
          );
        });
  }
}

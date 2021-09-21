import 'package:christian_date_app/state/actions/actions.dart';
import 'package:christian_date_app/state/actions/asyncActions.dart';
import 'package:christian_date_app/state/appState.dart';
import 'package:christian_date_app/state/models/userModel.dart';
import 'package:christian_date_app/state/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'user_profile_page.dart';

class UsersPage extends StatefulWidget {
  static String tag = 'users-page';

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    store.dispatch(FetchUsersChunkAction(1, store.state.usersPerLoad, 'replace').thunk(context));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 30) {
        if (!store.state.loadingUsers) {
          int page = store.state.users.length ~/ store.state.usersPerLoad + 1;
          store.dispatch(FetchUsersChunkAction(
                  page, store.state.usersPerLoad, 'append')
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
              Flexible(
                child: RefreshIndicator(
                  key: _refreshIndicatorKey,
                  onRefresh: () {
                    return Future<Null>(() {
                      store.dispatch(FetchUsersChunkAction(
                              1, store.state.usersPerLoad, 'replace')
                          .thunk(context));
                    });
                  },
                  child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      controller: _scrollController,
                      itemCount: store.state.loadingUsers
                          ? store.state.users.length + 1
                          : store.state.users.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (index < store.state.users.length) {
                          UserModel _model = store.state.users[index];
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  store.dispatch(NavigatePushPageAction(UserProfilePage(_model)));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5.0),
                                  child: CircleAvatar(
                                    radius: 45,
                                    backgroundImage: _model.avatar != null
                                        ? NetworkImage(_model.avatar)
                                        : null,
                                  ),
                                ),
                              ),
                              Text(
                                _model.name + ', ' + _model.xProfile.age.toString(),
                                overflow: TextOverflow.ellipsis,
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
                      }
                  ),
                ),
              )
            ],
          ));
        });
  }
}

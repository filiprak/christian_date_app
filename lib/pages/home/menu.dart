import 'package:christian_date_app/state/actions/asyncActions.dart';
import 'package:christian_date_app/state/appState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Store<AppState>>(
        converter: (store) => store,
        builder: (context, store) {
          return ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: new Text('Raja'),
                accountEmail: new Text('testemail@test.com'),
                currentAccountPicture: new CircleAvatar(
                  backgroundImage: new NetworkImage('http://i.pravatar.cc/300'),
                ),
              ),
              new ListTile(
                leading: Icon(Icons.exit_to_app),
                title: new Text('Logout'),
                onTap: () {
                  store.dispatch(LogoutAction().logout());
                },
              ),
            ],
          );
        }
      );
  }
}

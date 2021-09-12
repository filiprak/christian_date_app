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

          var content = <Widget>[];

          if (store.state.loggedUser.username != '') {
            content = <Widget>[
              new UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/background.jpg'),
                    fit: BoxFit.fitHeight
                  )
                ),
                accountName: new Text(store.state.loggedUser.name),
                accountEmail: new Text(store.state.loggedUser.username),
                currentAccountPicture: new CircleAvatar(
                  backgroundImage: new NetworkImage(store.state.loggedUser.avatar),
                ),
              ),
              new ListTile(
                leading: Icon(Icons.exit_to_app),
                title: new Text('Logout'),
                onTap: () {
                  store.dispatch(LogoutAction().logout());
                },
              ),
            ];
          }

          return ListView(
            children: content
          );
        }
      );
  }
}

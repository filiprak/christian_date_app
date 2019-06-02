import 'package:christian_date_app/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:christian_date_app/pages/login/login_page.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'state/appState.dart';
import 'state/reducers/appReducer.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'state/middlewares/navigationMiddleware.dart';
import 'state/navigatorKey.dart';
import 'theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  final Store<AppState> store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: [thunkMiddleware, navigationMiddleware]
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: StoreConnector<AppState, Store<AppState>>(
        converter: (store) => store,
        builder: (context, store) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            title: 'Christian Date App',
            theme: themeData,
            home: store.state.loginModel.authenticated ? HomePage() : LoginPage(),
          );
        }
      )
    );
  }
}

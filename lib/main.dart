import 'package:christian_date_app/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:christian_date_app/pages/login/login_page.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'state/appState.dart';
import 'state/reducers/appReducer.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'theme.dart' as theme;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  final Store<AppState> store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: [thunkMiddleware]
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
            title: 'Christian Date App',
            theme: theme.themeData,
            home: store.state.loginModel.authenticated ? HomePage() : LoginPage(),
          );
        }
      )
    );
  }
}

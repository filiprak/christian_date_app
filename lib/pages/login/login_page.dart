import 'package:christian_date_app/state/actions/asyncActions.dart';
import 'package:christian_date_app/state/appState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'forgot_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final usernameController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');

  final _loginForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final logo = SizedBox(
        child: Padding(
      padding: EdgeInsets.only(left: 48.0, right: 48.0),
      child: Image.asset('assets/logo_center.png', fit: BoxFit.cover),
    ));

    final username = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: usernameController,
      decoration: InputDecoration(
        hintText: 'Nazwa użytkownika',
        border: OutlineInputBorder(),
        fillColor: Colors.white,
        filled: true,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Wpisz nazwę użytkownika';
        }
      },
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: passwordController,
      decoration: InputDecoration(
        hintText: 'Hasło',
        border: OutlineInputBorder(),
        fillColor: Colors.white,
        filled: true,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Wpisz hasło';
        }
      },
    );

    final submit = StoreConnector<AppState, Store<AppState>>(
        converter: (store) => store,
        builder: (context, store) {
          return Material(
            child: MaterialButton(
                color: store.state.loading ? Colors.blue : Colors.white70,
                child: Text('Logowanie'),
                padding: EdgeInsets.all(16.0),
                onPressed: store.state.loading ? null : () {
                  if (_loginForm.currentState.validate()) {
                    store.dispatch(LoginWithPasswordAction({
                    'username': usernameController.text,
                    'password': passwordController.text,
                    }).loginWithPassword());
                  }
                }),
          );
        });

    final register = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        child: MaterialButton(
            color: Colors.black87,
            textColor: Colors.white,
            child: Text('Utwórz konto'),
            padding: EdgeInsets.all(16.0),
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => RegisterPage()),
              );
            }),
      ),
    );

    final forgot = FlatButton(
      child: Text('Zapomniałeś hasła ?'),
      onPressed: () {
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => ForgotPasswordPage()),
        );
      },
    );

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            Form(
              key: _loginForm,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  username,
                  SizedBox(height: 8.0),
                  password,
                  SizedBox(height: 24.0),
                  submit,
                ],
              ),
            ),
            forgot,
            SizedBox(height: 24.0),
            register,
          ],
        ),
      ),
    );
  }
}

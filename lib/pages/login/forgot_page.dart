import 'package:christian_date_app/state/actions/actions.dart';
import 'package:christian_date_app/state/appState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class ForgotPasswordPage extends StatefulWidget {
  static String tag = 'forgot-password-page';

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    final logo = SizedBox(
      child: Padding(
      padding: EdgeInsets.only(left: 48.0, right: 48.0),
      child: Image.asset('assets/logo_center.png', fit: BoxFit.cover),
    ));

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: '',
      decoration: InputDecoration(
        hintText: 'Adres e-mail',
        border: OutlineInputBorder(),
        fillColor: Colors.white,
        filled: true,
      ),
    );

    final submit = Material(
      child: MaterialButton(
          color: Colors.white70,
          child: Text('Wyślij dane'),
          padding: EdgeInsets.all(16.0),
          onPressed: () {}),
    );

    final back = StoreConnector<AppState, Store<AppState>>(
        converter: (store) => store,
        builder: (context, store) {
          return FlatButton(
            textColor: Colors.white70,
            child: Text('Wróć do logowania'),
            onPressed: () {
              store.dispatch(NavigatePopAction());
            },
          );
        });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.fitHeight
          )
        ),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              logo,
              SizedBox(height: 48.0),
              email,
              SizedBox(height: 25.0),
              submit,
              SizedBox(height: 24.0),
              back,
            ],
          ),
        ),
      ),
    );
  }
}

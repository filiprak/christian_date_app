import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final logo = SizedBox(
        child: Padding(
      padding: EdgeInsets.only(left: 48.0, right: 48.0),
      child: Image.asset('assets/logo_center.png', fit: BoxFit.cover),
    ));

    final quote = SizedBox(
        child: Padding(
      padding: EdgeInsets.only(left: 8.0, right: 8.0),
      child: Image.asset('assets/quote.png', fit: BoxFit.cover),
    ));

    final quoteParams = SizedBox(
        child: Padding(
      padding: EdgeInsets.only(left: 8.0, right: 8.0),
      child: Image.asset('assets/quote_params.png', fit: BoxFit.none),
    ));

    final username = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      initialValue: '',
      decoration: InputDecoration(
        hintText: 'Nazwa użytkownika',
        border: OutlineInputBorder(),
        fillColor: Colors.white,
        filled: true,
      ),
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      initialValue: '',
      decoration: InputDecoration(
        hintText: 'Hasło',
        border: OutlineInputBorder(),
        fillColor: Colors.white,
        filled: true,
      ),
    );

    final submit = Material(
      child: MaterialButton(
          color: Colors.white70,
          child: Text('Logowanie'),
          padding: EdgeInsets.all(16.0),
          onPressed: () {}),
    );

    final register = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        child: MaterialButton(
            color: Colors.black87,
            textColor: Colors.white,
            child: Text('Utwórz konto'),
            padding: EdgeInsets.all(16.0),
            onPressed: () {}),
      ),
    );

    final forgot = FlatButton(
      child: Text('Zapomniałeś hasła ?'),
      onPressed: () {},
    );

    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            username,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            submit,
            forgot,
            SizedBox(height: 24.0),
            register,
          ],
        ),
      ),
    );
  }
}

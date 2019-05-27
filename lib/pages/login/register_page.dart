import 'package:flutter/material.dart';


class RegisterPage extends StatefulWidget {
  static String tag = 'register-page';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final logo = SizedBox(
        child: Padding(
          padding: EdgeInsets.only(left: 48.0, right: 48.0),
          child: Image.asset('assets/logo_center.png', fit: BoxFit.cover),
        )
    );

    final fullname = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      initialValue: '',
      decoration: InputDecoration(
        hintText: 'Imię i nazwisko',
        border: OutlineInputBorder(),
        fillColor: Colors.white,
        filled: true,
      ),
    );

    final username = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      initialValue: '',
      decoration: InputDecoration(
        hintText: 'Nazwa użytkownika / Nick',
        border: OutlineInputBorder(),
        fillColor: Colors.white,
        filled: true,
      ),
    );

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

    final passwordConfirm = TextFormField(
      autofocus: false,
      obscureText: true,
      initialValue: '',
      decoration: InputDecoration(
        hintText: 'Powtórz Hasło',
        border: OutlineInputBorder(),
        fillColor: Colors.white,
        filled: true,
      ),
    );

    final submit = Material(
      child: MaterialButton(
          color: Colors.white70,
          child: Text('Utwórz moje konto'),
          padding: EdgeInsets.all(16.0),
          onPressed: () {}),
    );

    final back = FlatButton(
      child: Text('Wróć do logowania'),
      onPressed: () {
        Navigator.pop(context);
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
            fullname,
            SizedBox(height: 8.0),
            username,
            SizedBox(height: 8.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 8.0),
            passwordConfirm,
            SizedBox(height: 25.0),
            submit,
            SizedBox(height: 24.0),
            back,
          ],
        ),
      ),
    );
  }
}

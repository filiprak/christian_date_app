import 'dart:ui';

import 'package:christian_date_app/pages/home/edit_my_profile_page.dart';
import 'package:christian_date_app/pages/home/users/user_profile_page.dart';
import 'package:christian_date_app/state/actions/actions.dart';
import 'package:christian_date_app/state/appState.dart';
import 'package:christian_date_app/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';


class MyProfilePage extends StatefulWidget {
  static String tag = 'my-profile-page';

  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  Widget _buildButton(
      String text, void Function() onPressed, IconData iconData) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          MaterialButton(
            onPressed: onPressed,
            color: ThemeColors.primary,
            textColor: Colors.white,
            child: Icon(
              iconData,
              size: 24,
            ),
            padding: EdgeInsets.all(16),
            shape: CircleBorder(),
          ),
          Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(text,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                textAlign: TextAlign.center,
              )
          )
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Store<AppState>>(
        converter: (store) => store,
        builder: (context, store) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      store.dispatch(NavigatePushPageAction(
                          UserProfilePage(store.state.loggedUser)));
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 80,
                          backgroundImage: store.state.loggedUser.avatar != null
                              ? NetworkImage(store.state.loggedUser.avatar)
                              : null,
                        ),
                        Text(
                            store.state.loggedUser.name + ', ' +
                                store.state.loggedUser.xProfile.age.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 25,
                            )
                        )
                      ],
                    )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildButton("Edytuj", () {
                        store.dispatch(NavigatePushPageAction(
                            EditMyProfilePage(store.state.loggedUser)));
                      }, Icons.edit),
                      _buildButton("Dodaj\nZdjęcia", () {}, Icons.camera_alt),
                      _buildButton("Ustawienia", () {}, Icons.settings)
                    ],
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}

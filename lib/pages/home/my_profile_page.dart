import 'package:christian_date_app/pages/home/users/user_profile_page.dart';
import 'package:christian_date_app/state/actions/actions.dart';
import 'package:christian_date_app/state/appState.dart';
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
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Store<AppState>>(
        converter: (store) => store,
        builder: (context, store) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      store.dispatch(NavigatePushPageAction(
                          UserProfilePage(store.state.loggedUser)));
                    },
                    child: Container(
                      padding: EdgeInsets.all(5.0),
                      child: CircleAvatar(
                        radius: 80,
                        backgroundImage: store.state.loggedUser.avatar != null
                            ? NetworkImage(store.state.loggedUser.avatar)
                            : null,
                      ),
                    ),
                  ),
                  Text(
                      store.state.loggedUser.name + ', ' +
                          store.state.loggedUser.xProfile.age.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 25,
                      )
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}

import 'package:christian_date_app/api/client.dart';
import 'package:christian_date_app/pages/home/home_page.dart';
import 'package:christian_date_app/pages/login/login_page.dart';
import 'package:christian_date_app/state/models/loginModel.dart';
import 'package:christian_date_app/state/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:christian_date_app/components/dialogs.dart';

import '../appState.dart';
import 'actions.dart';

class LoginWithPasswordAction {
  final Map<String, String> credentials;

  LoginWithPasswordAction(this.credentials);

  ThunkAction<AppState> thunk(BuildContext context) {
    return (Store<AppState> store) async {
      try {
        store.dispatch(SetLoadingAction(true));
        store.dispatch(ShowModalDialogAction().thunk(Dialogs.loading(context)));
        final response = await api.getJwtToken(credentials);

        LoginModel loginModel;

        if (!response['error']) {
          loginModel = LoginModel(
            response['token'],
            response['username'],
            response['email'],
            true,
          );
        } else {
          loginModel = LoginModel(
            null,
            null,
            null,
            false,
          );
        }

        store.dispatch(UpdateLoginModelAction(loginModel));
        store.dispatch(NavigatePopAction());

        if (loginModel.authenticated) {
          store.dispatch(NavigateReplacePageAction(HomePage()));
        } else {
          store.dispatch(ShowModalDialogAction().thunk(
              Dialogs.error(context, params: {
            'content': 'Nieprawidłowa nazwa użytkownika lub hasło'
          })));
        }
      } catch (_) {
        store.dispatch(NavigatePopAction());
        store.dispatch(ShowModalDialogAction().thunk(Dialogs.error(context,
            params: {
              'content':
                  'Ups... Coś poszło nie tak, sprawdź połączenie z internetem.'
            })));
      } finally {
        store.dispatch(SetLoadingAction(false));
      }
    };
  }
}

class LogoutAction {
  ThunkAction<AppState> logout() {
    return (Store<AppState> store) {
      store.dispatch(UpdateLoginModelAction(LoginModel(
        null,
        null,
        null,
        false,
      )));
      store.dispatch(NavigateReplacePageAction(LoginPage()));
    };
  }
}

class ShowModalDialogAction {
  ThunkAction<AppState> thunk(Future<dynamic> dialog) {
    return (Store<AppState> store) async {
      await dialog;
    };
  }
}

class FetchCurrentUserDataAction {
  ThunkAction<AppState> thunk(BuildContext context) {
    return (Store<AppState> store) async {
      //try {
        final response = await api.getCurrentUserData();

        if (!response['error']) {
          UserModel userModel = UserModel.fromJson(response);
          store.dispatch(UpdateCurrentUserModelAction(userModel));
        }
//
//      } catch (_) {
//        store.dispatch(ShowModalDialogAction().thunk(Dialogs.error(context,
//            params: {
//              'content':
//              'Ups... Coś poszło nie tak, sprawdź połączenie z internetem.'
//            })));
//      }
    };
  }
}
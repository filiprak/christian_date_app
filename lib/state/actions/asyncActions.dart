import 'package:christian_date_app/api/client.dart';
import 'package:christian_date_app/state/models/loginModel.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../appState.dart';
import 'actions.dart';


class LoginWithPasswordAction {
  final Map<String, String> credentials;

  LoginWithPasswordAction(this.credentials);

  ThunkAction<AppState> loginWithPassword() {

    return (Store<AppState> store) async {

      store.dispatch(SetLoadingAction(true));
      final response = await api.getJwtToken(credentials);
      store.dispatch(SetLoadingAction(false));

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
    };

  }
}

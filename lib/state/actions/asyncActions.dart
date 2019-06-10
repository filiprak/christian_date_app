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
        store.dispatch(SetLoadingAction(true, 'login'));
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
        store.dispatch(SetLoadingAction(false, 'login'));
      }
    };
  }
}

class LogoutAction {
  ThunkAction<AppState> logout() {
    return (Store<AppState> store) {
      store.dispatch(ResetStateAction());
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
      try {
        final response = await api.getCurrentUserData();

        if (!response['error']) {
          UserModel userModel = UserModel.fromJson(response);
          store.dispatch(UpdateCurrentUserModelAction(userModel));
        }

      } catch (error) {
        print('Error in FetchCurrentUserDataAction: ');
        print(error);
      }
    };
  }
}

class FetchActivitiesChunkAction {
  final int page;
  final int perPage;
  final String type;

  FetchActivitiesChunkAction(this.page, this.perPage, this.type);

  ThunkAction<AppState> thunk(BuildContext context) {
    return (Store<AppState> store) async {
      try {
        store.dispatch(SetLoadingAction(true, 'news'));
        final response = await api.getActivities({
          'per_page': perPage.toString(),
          'page': page.toString(),
          'with_avatar': 'true',
        });

        if (!response['error']) {
          store.dispatch(UpdateActivitiesAction(type, response['activities']));
        }

      } catch (error) {
        print('Error in FetchActivitiesChunkAction: ');
        print(error);
      } finally {
        store.dispatch(SetLoadingAction(false, 'news'));
      }
    };
  }
}

class PublishNewPostAction {
  final String content;

  PublishNewPostAction(this.content);

  ThunkAction<AppState> thunk(BuildContext context) {
    return (Store<AppState> store) async {
      try {
        store.dispatch(ShowModalDialogAction().thunk(Dialogs.loading(context)));
        final response = await api.createActivity(content);
        store.dispatch(NavigatePopAction());

        if (!response['error']) {
          store.dispatch(FetchActivitiesChunkAction(1, store.state.activitiesPerLoad, 'replace').thunk(context));
        } else {
          store.dispatch(ShowModalDialogAction().thunk(Dialogs.error(context,
            params: {
              'content': 'Ups... Coś poszło nie tak, nie udało się opublikować postu.'
            })));
        }

      } catch (error) {
        store.dispatch(NavigatePopAction());
        print('Error in PublishNewPostAction: ');
        print(error);

        store.dispatch(ShowModalDialogAction().thunk(Dialogs.error(context,
            params: {
              'content': 'Ups... Coś poszło nie tak, sprawdź połączenie z internetem.'
            })));
      }
    };
  }
}

class FetchMessageThreadsChunkAction {
  final int offset;
  final int limit;
  final String type;

  FetchMessageThreadsChunkAction(this.offset, this.limit, this.type);

  ThunkAction<AppState> thunk(BuildContext context) {
    return (Store<AppState> store) async {
      try {
        store.dispatch(SetLoadingAction(true, 'threads'));
        final response = await api.getMessageThreads({
          'offset': offset.toString(),
          'limit': limit.toString(),
        });

        if (!response['error']) {
          bool allLoaded = response['count'] < response['limit'];
          store.dispatch(UpdateMessageThreadsAction(type, response['threads'], allLoaded: allLoaded));
        }

      } catch (error) {
        print('Error in FetchMessageThreadsChunkAction: ');
        print(error);
      } finally {
        store.dispatch(SetLoadingAction(false, 'threads'));
      }
    };
  }
}

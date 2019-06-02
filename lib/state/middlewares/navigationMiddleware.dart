import 'package:christian_date_app/state/actions/actions.dart';
import 'package:flutter/cupertino.dart';
import 'package:redux/redux.dart';

import '../appState.dart';
import '../navigatorKey.dart';

void navigationMiddleware(
  Store<AppState> store,
  dynamic action,
  NextDispatcher next,
) {
  next(action);

  if (action is NavigateReplacePageAction) {
    navigatorKey.currentState.pushReplacement(new CupertinoPageRoute(builder: (context) {
      return action.page;
    }));
  } else if (action is NavigatePushPageAction) {
    navigatorKey.currentState.push(new CupertinoPageRoute(builder: (context) {
      return action.page;
    }));
  } else if (action is NavigatePopAction) {
    if (navigatorKey.currentState.canPop()) {
      navigatorKey.currentState.pop();
    }
  }
}

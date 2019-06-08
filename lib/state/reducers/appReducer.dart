import '../appState.dart';
import '../actions/actions.dart';

AppState appReducer(AppState state, action) {
  if (action is UpdateLoginModelAction) {
    state.loginModel = action.newModel;

  } else if (action is UpdateCurrentUserModelAction) {
    state.loggedUser = action.newModel;

  } else if (action is UpdateActivitiesAction) {
    if (action.type == 'replace') {
      state.activities = action.activities;
    } else if (action.type == 'append') {
      state.activities.addAll(action.activities);
    } else if (action.type == 'prepend') {
      state.activities.insertAll(0, action.activities);
    }

  } else if (action is SetLoadingAction) {
    if (action.what == 'login') {
      state.loading = action.loading;
    } else if (action.what == 'news') {
      state.loadingActivities = action.loading;
    } else if (action.what == 'messages') {
      state.loadingActivities = action.loading;
    } //...

} else if (action is ResetStateAction) {
    state = AppState.initial();
  }

  return state;
}

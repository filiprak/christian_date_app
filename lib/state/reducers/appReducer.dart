import '../appState.dart';
import '../actions/actions.dart';
import 'messageReducer.dart';


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

  } else if (action is UpdateMessageThreadsAction) {
    if (action.type == 'replace') {
      state.messageThreads = action.threads;
    } else if (action.type == 'append') {
      state.messageThreads.addAll(action.threads);
    } else if (action.type == 'prepend') {
      state.messageThreads.insertAll(0, action.threads);
    }
    state.allThreadsLoaded = action.allLoaded;

  } else if (action is UpdateUsersAction) {
    if (action.type == 'replace') {
      state.users = action.users;
    } else if (action.type == 'append') {
      state.users.addAll(action.users);
    } else if (action.type == 'prepend') {
      state.users.insertAll(0, action.users);
    }

  } else if (action is SetLoadingAction) {
    if (action.what == 'login') {
      state.loading = action.loading;
    } else if (action.what == 'news') {
      state.loadingActivities = action.loading;
    } else if (action.what == 'messages') {
      state.loadingActivities = action.loading;
    } else if (action.what == 'threads') {
      state.loadingThreads = action.loading;
    } else if (action.what == 'users') {
      state.loadingUsers = action.loading;
    } //...

  } else if (action is ResetStateAction) {
    state = AppState.initial();
  } else {
    state.messagesState = messageReducer(state.messagesState, action);
  }

  return state;
}

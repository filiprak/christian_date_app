import '../appState.dart';
import '../actions/actions.dart';

AppState appReducer(AppState state, action) {
  if (action is UpdateLoginModelAction) {
    state.loginModel = action.newModel;
    return state;

  } else if (action is UpdateCurrentUserModelAction) {
    state.loggedUser = action.newModel;
    return state;

  } else if (action is SetLoadingAction) {
    state.loading = action.loading;
    return state;
  }

  return state;
}

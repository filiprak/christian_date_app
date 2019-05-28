import 'models/loginModel.dart';

class AppState {

  LoginModel loginModel;

  bool loading = false;

  AppState() {
    this.loginModel = LoginModel(null, null, null, false);
    this.loading = false;
  }

  factory AppState.initial() => AppState();
}

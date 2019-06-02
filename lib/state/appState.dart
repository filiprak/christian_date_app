import 'models/loginModel.dart';
import 'models/userModel.dart';

class AppState {

  LoginModel loginModel;
  UserModel loggedUser;

  bool loading = false;

  AppState() {
    this.loginModel = LoginModel(null, null, null, false);
    this.loggedUser = null;
    this.loading = false;
  }

  factory AppState.initial() => AppState();
}

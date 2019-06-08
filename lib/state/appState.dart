import 'models/activityModel.dart';
import 'models/loginModel.dart';
import 'models/userModel.dart';

class AppState {

  LoginModel loginModel;
  UserModel loggedUser;

  List<ActivityModel> activities;
  bool loadingActivities = false;
  int activitiesPerLoad = 10;

  bool loading = false;

  AppState() {
    this.loginModel = LoginModel(null, null, null, false);
    this.loggedUser = null;

    this.activities = List<ActivityModel>();
    this.loadingActivities = false;

    this.loading = false;
  }

  factory AppState.initial() => AppState();
}

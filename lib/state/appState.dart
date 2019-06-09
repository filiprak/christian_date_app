import 'models/activityModel.dart';
import 'models/loginModel.dart';
import 'models/threadModel.dart';
import 'models/userModel.dart';

class AppState {

  LoginModel loginModel;
  UserModel loggedUser;

  // activities
  List<ActivityModel> activities;
  bool loadingActivities = false;
  int activitiesPerLoad = 10;

  // messages
  List<ThreadModel> messageThreads;
  bool loadingThreads = false;
  int threadsPerLoad = 10;
  bool allThreadsLoaded = false;

  bool loading = false;

  AppState() {
    this.loginModel = LoginModel(null, null, null, false);
    this.loggedUser = null;

    // activities
    this.activities = List<ActivityModel>();
    this.loadingActivities = false;
    this.activitiesPerLoad = 10;

    // messages
    this.messageThreads = List<ThreadModel>();
    this.loadingThreads = false;
    this.threadsPerLoad = 10;
    this.allThreadsLoaded = false;

    this.loading = false;
  }

  factory AppState.initial() => AppState();
}

import 'messagesState.dart';
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
  int threadsPerLoad = 15;
  bool allThreadsLoaded = false;
  MessagesState messagesState;

  bool loading = false;

  AppState() {
    this.loginModel = LoginModel(null, null, false);
    this.loggedUser = UserModel();

    // activities
    this.activities = List<ActivityModel>();
    this.loadingActivities = false;
    this.activitiesPerLoad = 10;

    // messages
    this.messageThreads = List<ThreadModel>();
    this.loadingThreads = false;
    this.threadsPerLoad = 10;
    this.allThreadsLoaded = false;
    this.messagesState = MessagesState.initial();

    this.loading = false;
  }

  factory AppState.initial() => AppState();
}

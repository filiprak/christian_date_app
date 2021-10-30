import 'package:christian_date_app/state/models/xProfileFieldModel.dart';

import 'messagesState.dart';
import 'models/activityModel.dart';
import 'models/loginModel.dart';
import 'models/threadModel.dart';
import 'models/userModel.dart';
import 'models/xProfileGroupModel.dart';

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

  // users
  List<UserModel> users = [];
  List<XProfileFieldModel> xProfileFields = [];
  List<XProfileGroupModel> xProfileGroups = [];
  bool loadingUsers = false;
  int usersPerLoad = 15;

  bool loading = false;

  AppState() {
    this.loginModel = LoginModel(null, null, false);
    this.loggedUser = UserModel();

    // activities
    this.activities = [];
    this.loadingActivities = false;
    this.activitiesPerLoad = 10;

    // messages
    this.messageThreads = [];
    this.loadingThreads = false;
    this.threadsPerLoad = 10;
    this.allThreadsLoaded = false;
    this.messagesState = MessagesState.initial();

    this.loading = false;
  }

  factory AppState.initial() => AppState();
}

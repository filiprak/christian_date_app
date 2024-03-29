import 'package:christian_date_app/state/models/activityModel.dart';
import 'package:christian_date_app/state/models/loginModel.dart';
import 'package:christian_date_app/state/models/threadModel.dart';
import 'package:christian_date_app/state/models/userModel.dart';
import 'package:christian_date_app/state/models/xProfileFieldModel.dart';
import 'package:christian_date_app/state/models/xProfileGroupModel.dart';


class UpdateLoginModelAction {
  final LoginModel newModel;

  UpdateLoginModelAction(this.newModel);
}

class UpdateCurrentUserModelAction {
  final UserModel newModel;

  UpdateCurrentUserModelAction(this.newModel);
}

class UpdateXProfileFieldsAction {
  final List<XProfileFieldModel> newModel;

  UpdateXProfileFieldsAction(this.newModel);
}

class UpdateXProfileGroupsAction {
  final List<XProfileGroupModel> newModel;

  UpdateXProfileGroupsAction(this.newModel);
}

class UpdateUsersAction {
  final String type;
  final List<UserModel> users;

  UpdateUsersAction(this.type, this.users);
}

class UpdateActivitiesAction {
  final String type;
  final List<ActivityModel> activities;

  UpdateActivitiesAction(this.type, this.activities);
}

class UpdateMessageThreadsAction {
  final String type;
  final List<ThreadModel> threads;
  final bool allLoaded;

  UpdateMessageThreadsAction(this.type, this.threads, { this.allLoaded = false });
}

class SetLoadingAction {
  final String what;
  final bool loading;

  SetLoadingAction(this.loading, this.what);
}

class NavigatePushPageAction {
  final dynamic page;

  NavigatePushPageAction(this.page);
}

class NavigateReplacePageAction {
  final dynamic page;

  NavigateReplacePageAction(this.page);
}

class NavigatePopAction {}

class ResetStateAction {}

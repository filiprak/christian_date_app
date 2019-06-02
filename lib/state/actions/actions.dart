import 'package:christian_date_app/state/models/loginModel.dart';
import 'package:christian_date_app/state/models/userModel.dart';


class UpdateLoginModelAction {
  final LoginModel newModel;

  UpdateLoginModelAction(this.newModel);
}

class UpdateCurrentUserModelAction {
  final UserModel newModel;

  UpdateCurrentUserModelAction(this.newModel);
}

class SetLoadingAction {
  final bool loading;

  SetLoadingAction(this.loading);
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

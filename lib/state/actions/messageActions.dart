import 'package:christian_date_app/state/models/privateMessageModel.dart';

class SetLoadingMessagesAction {
  final String what;
  final bool loading;

  SetLoadingMessagesAction(this.loading, this.what);
}

class UpdateMessagesAction {
  final int threadId;
  final String type;
  final List<PrivateMessageModel> messages;
  final bool allLoaded;

  UpdateMessagesAction(this.threadId, this.messages, this.type, { this.allLoaded = false });
}

class SetSendingMessageAction {
  final bool sending;

  SetSendingMessageAction(this.sending);
}

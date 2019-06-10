import 'models/privateMessageModel.dart';


class MessagesState {

  // thread id -> messages list map
  Map<int, List<PrivateMessageModel>> privateMessages;
  Map<int, bool> allMessagesLoaded;

  int messagesPerLoad = 10;

  bool currentThreadLoading = false;

  MessagesState() {
    this.privateMessages = Map<int, List<PrivateMessageModel>>();
    this.allMessagesLoaded = Map<int, bool>();

    this.messagesPerLoad = 10;

    this.currentThreadLoading = false;
  }

  bool hasMessages(threadId) {
    return privateMessages.containsKey(threadId) && privateMessages[threadId].isNotEmpty;
  }

  int messagesCount(threadId) {
    return privateMessages.containsKey(threadId) ? privateMessages[threadId].length : 0;
  }

  bool allLoaded(threadId) {
    if (!allMessagesLoaded.containsKey(threadId)) {
      allMessagesLoaded[threadId] = false;
    }
    return allMessagesLoaded[threadId];
  }

  PrivateMessageModel getMessage(threadId, index) {
    if (privateMessages.containsKey(threadId)) {
      if (index < messagesCount(threadId)) {
        return privateMessages[threadId][index];
      }
    }
    return null;
  }

  factory MessagesState.initial() => MessagesState();
}

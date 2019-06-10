import 'package:christian_date_app/state/actions/messageActions.dart';

import '../messagesState.dart';


MessagesState messageReducer(MessagesState state, action) {

  if (action is SetLoadingMessagesAction) {
    if (action.what == 'currentThread') {
      state.currentThreadLoading = action.loading;
    }

  } else if (action is UpdateMessagesAction) {
    if (action.type == 'replace') {
      state.privateMessages[action.threadId] = action.messages;
    } else if (action.type == 'append') {
      state.privateMessages[action.threadId].addAll(action.messages);
    } else if (action.type == 'prepend') {
      state.privateMessages[action.threadId].insertAll(0, action.messages);
    }

    state.allMessagesLoaded[action.threadId] = action.allLoaded;
  }

  return state;
}

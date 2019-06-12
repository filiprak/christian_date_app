import 'package:christian_date_app/api/client.dart';
import 'package:christian_date_app/components/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../appState.dart';
import 'asyncActions.dart';
import 'messageActions.dart';


class FetchCurrentThreadMessagesChunkAction {
  final int offset;
  final int limit;
  final String type;
  final int threadId;

  FetchCurrentThreadMessagesChunkAction(this.offset, this.limit, this.threadId, this.type);

  ThunkAction<AppState> thunk(BuildContext context) {
    return (Store<AppState> store) async {
      try {
        store.dispatch(SetLoadingMessagesAction(true, 'currentThread'));
        final response = await api.getMessages({
          'offset': offset.toString(),
          'limit': limit.toString(),
          'thread_id': threadId.toString(),
        });

        if (!response['error']) {
          bool allLoaded = response['count'] < response['limit'];
          store.dispatch(UpdateMessagesAction(threadId, response['messages'], type, allLoaded: allLoaded));
        }

      } catch (error) {
        print('Error in FetchCurrentThreadMessagesChunkAction: ');
        print(error);
      } finally {
        store.dispatch(SetLoadingMessagesAction(false, 'currentThread'));
      }
    };
  }
}

class SendMessageAction {
  final int threadId;
  final String subject;
  final String content;
  final List<int> recipients;

  SendMessageAction(this.threadId, this.content, { this.subject, this.recipients });

  ThunkAction<AppState> thunk(BuildContext context) {
    return (Store<AppState> store) async {
      try {

        var args = <String, dynamic>{
          'thread_id': this.threadId.toString(),
          'content': this.content,
        };

        if (this.recipients != null) {
          args['recipients'] = this.recipients;
        }

        store.dispatch(SetSendingMessageAction(true));
        final response = await api.sendMessage(args);

        if (!response['error']) {
          store.dispatch(FetchCurrentThreadMessagesChunkAction(
            0,
            store.state.messagesState.messagesPerLoad,
            threadId,
            'replace',
          ).thunk(context));

        } else {
          store.dispatch(ShowModalDialogAction().thunk(Dialogs.error(context,
              params: {
                'content': 'Nie udało się wysłać wiadomości, spróbuj ponownie później.'
              })));
        }

      } catch (error) {
        print('Error in FetchCurrentThreadMessagesChunkAction: ');
        print(error);
        store.dispatch(ShowModalDialogAction().thunk(Dialogs.error(context,
            params: {
              'content': 'Nie udało się wysłać wiadomości, sprawdź połączenie z internetem.'
            })));
      } finally {
        store.dispatch(SetSendingMessageAction(false));
      }
    };
  }
}

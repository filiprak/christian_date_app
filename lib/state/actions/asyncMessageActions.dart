import 'package:christian_date_app/api/client.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../appState.dart';
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

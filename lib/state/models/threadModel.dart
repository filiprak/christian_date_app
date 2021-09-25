import 'package:christian_date_app/state/models/privateMessageModel.dart';
import 'package:christian_date_app/state/models/recipientModel.dart';


class ThreadModel {

  int id;
  int unreadCount;
  String lastMessage;
  String excerpt;
  DateTime date;
  Set<int> participants;

  ThreadModel.fromJson(Map<String, dynamic> json, loggedUserId)
      : id = json['id'],
        unreadCount = json['unread_count'],
        lastMessage = json['message']['rendered'],
        excerpt = json['excerpt']['rendered'],
        date = DateTime.tryParse(json['date']),
        participants = {} {
    json['sender_ids'].entries.forEach((senderId) => participants.add(senderId.value));
    json['recipients'].entries.forEach((recipient) => participants.add(recipient.value['user_id']));
    participants.remove(loggedUserId);
  }
}
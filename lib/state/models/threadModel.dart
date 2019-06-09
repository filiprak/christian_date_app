import 'package:christian_date_app/state/models/privateMessageModel.dart';
import 'package:christian_date_app/state/models/recipientModel.dart';


class ThreadModel {

  int id;
  int unreadCount;
  bool senderOnly;
  bool isDeleted;
  PrivateMessageModel lastMessage;
  RecipientModel recipient;

  ThreadModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        unreadCount = json['unread_count'],
        senderOnly = json['sender_only'],
        isDeleted = json['is_deleted'],
        lastMessage = PrivateMessageModel.fromJson(json['last_message']),
        recipient = RecipientModel.fromJson(json['recipient']);

}
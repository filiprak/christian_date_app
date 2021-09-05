class RecipientModel {

  int id;
  int userId;
  String userLink;
  String avatar;
  int threadId;
  int unreadCount;
  bool senderOnly;
  bool isDeleted;

  RecipientModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        userLink = json['user_link'],
        avatar = json['user_avatars']['full'],
        threadId = json['thread_id'],
        unreadCount = json['unread_count'],
        senderOnly = json['sender_only'] != 0,
        isDeleted = json['is_deleted'] != 0;
}

class RecipientModel {

  int id;
  int userId;
  int unreadCount;
  bool senderOnly;
  bool isDeleted;

  String login;
  String nicename;
  String email;
  String displayName;
  String avatar;

  RecipientModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        unreadCount = json['unread_count'],
        senderOnly = json['sender_only'],
        isDeleted = json['is_deleted'],
        login = json['user_login'],
        nicename = json['user_nicename'],
        email = json['user_email'],
        displayName = json['display_name'],
        avatar = json['avatar'];

  bool exists() {
    return login != null && login.length > 0;
  }
}

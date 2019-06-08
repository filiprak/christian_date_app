
class ActivityModel {

  int id;
  int userId;
  String type;
  int itemId;
  int secondaryItemId;
  DateTime date;
  bool isSpam;
  String avatar;
  String action;
  String content;

  ActivityModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        type = json['type'],
        itemId = json['item_id'],
        secondaryItemId = json['secondary_item_id'],
        date = DateTime.tryParse(json['date_recorded']),
        isSpam = (json['is_spam'] == 1),
        action = json['action'],
        content = json['content'],
        avatar = json['avatar'] {
    date = DateTime.utc(date.year, date.month, date.day, date.hour, date.minute, date.second, date.millisecond, date.microsecond);
  }

}
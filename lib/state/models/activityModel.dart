
import 'package:christian_date_app/state/models/utils.dart';

class ActivityModel {

  int id;
  int userId;
  String type;
  String title;
  int primaryItemId;
  int secondaryItemId;
  DateTime date;
  bool isSpam;
  String avatar;
  String content;

  ActivityModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        type = json['type'],
        title = json['title'],
        primaryItemId = json['primary_item_id'],
        secondaryItemId = json['secondary_item_id'],
        date = DateTime.tryParse(json['date']),
        isSpam = (json['status'] == 'spam'),
        content = json['content']['rendered'],
        avatar = normalizeUrl(json['user_avatar']['full']) {
    date = DateTime.utc(date.year, date.month, date.day, date.hour, date.minute, date.second, date.millisecond, date.microsecond);
  }

}
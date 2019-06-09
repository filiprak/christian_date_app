
class PrivateMessageModel {

  int id;
  int senderId;
  String subject;
  String message;
  DateTime date;

  PrivateMessageModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        senderId = json['sender_id'],
        subject = json['subject'],
        message = json['message'],
        date = DateTime.tryParse(json['date_sent']) {

    date = DateTime.utc(date.year, date.month, date.day, date.hour, date.minute, date.second, date.millisecond, date.microsecond);
  }

}
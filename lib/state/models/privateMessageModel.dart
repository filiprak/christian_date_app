
class PrivateMessageModel {

  int id;
  int senderId;
  int threadId;
  String subject;
  String message;
  DateTime date;

  PrivateMessageModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        senderId = json['sender_id'],
        threadId = json['thread_id'],
        subject = json['subject']['raw'],
        message = json['message']['raw'],
        date = DateTime.tryParse(json['date_sent']) {
    date = DateTime.utc(date.year, date.month, date.day, date.hour, date.minute, date.second, date.millisecond, date.microsecond);
  }

}
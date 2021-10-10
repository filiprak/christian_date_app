
class PrivateMessageModel {

  int id;
  int senderId;
  int threadId;
  String subject;
  String message;
  DateTime date;
  bool self;

  PrivateMessageModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        senderId = json['sender_id'],
        threadId = json['thread_id'],
        subject = json['subject'],
        message = json['message'],
        self = json.containsKey('self') ? json['self'] : false,
        date = DateTime.tryParse(json['date_sent']) {

    date = DateTime.utc(date.year, date.month, date.day, date.hour, date.minute, date.second, date.millisecond, date.microsecond);
  }

}
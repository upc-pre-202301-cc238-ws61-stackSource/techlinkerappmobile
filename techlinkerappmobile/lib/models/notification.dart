import 'package:techlinkerappmobile/models/user.dart';

class Notification {
  String? content;
  DateTime? date;
  User? emitterId;
  int? id;
  User? reciverId;

  Notification(
      {this.content,
      this.date,
      this.emitterId,
      this.id,
      this.reciverId,}
      );

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      content: json['content'],
      date: json['date'],
      emitterId: json['emitterId'],
      id: json['id'],
      reciverId: json['reciverId'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'date': date,
      'emitterId': emitterId,
      'id': id,
      'reciverId': reciverId,
    };
  }
}

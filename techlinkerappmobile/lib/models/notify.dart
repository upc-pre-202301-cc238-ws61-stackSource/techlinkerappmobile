import 'package:techlinkerappmobile/models/user.dart';

class Notify {
  String? content;
  DateTime? date;
  User? emitterId;
  int? id;
  User? reciverId;

  Notify(
      {this.content,
      this.date,
      this.emitterId,
      this.id,
      this.reciverId,}
      );

  factory Notify.fromJson(Map<String, dynamic> json) {
    return Notify(
      content: json['content'],
      date: DateTime.parse(json['date']),
      emitterId: User.fromJson(json['emitter']),
      id: json['id'],
      reciverId: User.fromJson(json['receiver']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'date': date,
      'emitter': emitterId?.toJson(),
      'id': id,
      'receiver': reciverId?.toJson(),
    };
  }
}

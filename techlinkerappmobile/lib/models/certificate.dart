import 'education.dart';

class Certificate {
  String description;
  Education education;
  String iconUrl;
  int id;
  DateTime obtainedDate;
  String title;

  Certificate({
    required this.description,
    required this.education,
    required this.iconUrl,
    required this.id,
    required this.obtainedDate,
    required this.title,
  });

  //a empty constructor
  Certificate.empty()
      : description = '',
        education = Education.empty(),
        iconUrl = '',
        id = 0,
        obtainedDate = DateTime.now(),
        title = '';

  factory Certificate.fromJson(Map<String, dynamic> json) {
    return Certificate(
      description: json['description'],
      education: Education.fromJson(json['education']),
      iconUrl: json['iconUrl'],
      id: json['id'],
      obtainedDate: DateTime.parse(json['obtainedDate']),
      title: json['title'],
    );
  }
}

import 'education.dart';

class StudyCenter {
  String description;
  Education education;
  DateTime entryDate;
  DateTime graduationDate;
  String iconUrl;
  int id;
  String name;
  int progress;

  StudyCenter({
    required this.description,
    required this.education,
    required this.entryDate,
    required this.graduationDate,
    required this.iconUrl,
    required this.id,
    required this.name,
    required this.progress,
  });

  //a empty constructor
  StudyCenter.empty()
      : description = '',
        education = Education.empty(),
        entryDate = DateTime.now(),
        graduationDate = DateTime.now(),
        iconUrl = '',
        id = 0,
        name = '',
        progress = 0;

  factory StudyCenter.fromJson(Map<String, dynamic> json) {
    return StudyCenter(
      description: json['description'],
      education: Education.fromJson(json['education']),
      entryDate: DateTime.parse(json['entryDate']),
      graduationDate: DateTime.parse(json['graduationDate']),
      iconUrl: json['iconUrl'],
      id: json['id'],
      name: json['name'],
      progress: json['progress'],
    );
  }
}

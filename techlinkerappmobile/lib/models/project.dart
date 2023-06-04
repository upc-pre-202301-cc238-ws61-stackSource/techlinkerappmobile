import 'digital_profile.dart';

class Project {
  String description;
  DigitalProfile digitalProfile;
  String iconUrl;
  int id;
  String name;
  String projectUrl;

  Project({
    required this.description,
    required this.digitalProfile,
    required this.iconUrl,
    required this.id,
    required this.name,
    required this.projectUrl,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      description: json['description'],
      digitalProfile: DigitalProfile.fromJson(json['digitalProfile']),
      iconUrl: json['iconUrl'],
      id: json['id'],
      name: json['name'],
      projectUrl: json['projectUrl'],
    );
  }
}

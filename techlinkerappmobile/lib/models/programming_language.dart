import 'package:techlinkerappmobile/models/digital_profile.dart';

class ProgrammingLanguage {
  String description;
  DigitalProfile digitalProfile;
  String iconLink;
  int id;
  String name;

  ProgrammingLanguage({
    required this.description,
    required this.digitalProfile,
    required this.iconLink,
    required this.id,
    required this.name,
  });

  factory ProgrammingLanguage.fromJson(Map<String, dynamic> json) {
    return ProgrammingLanguage(
      description: json['description'],
      digitalProfile: DigitalProfile.fromJson(json['digitalProfile']),
      iconLink: json['iconLink'],
      id: json['id'],
      name: json['name'],
    );
  }
}

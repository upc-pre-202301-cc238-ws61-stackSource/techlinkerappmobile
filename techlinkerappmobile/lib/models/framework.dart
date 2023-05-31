import 'package:techlinkerappmobile/models/developer_study_center.dart';
import 'dart:convert';

class Framework {
  String description;
  DigitalProfile digitalProfile;
  String iconLink;
  int id;
  String name;

  Framework({
    required this.description,
    required this.digitalProfile,
    required this.iconLink,
    required this.id,
    required this.name,
  });

  factory Framework.fromJson(String jsonString) {
    final jsonData = json.decode(jsonString);
    return Framework(
      description: jsonData['description'],
      digitalProfile: DigitalProfile.fromJson(jsonData['digitalProfile']),
      iconLink: jsonData['iconLink'],
      id: jsonData['id'],
      name: jsonData['name'],
    );
  }
}

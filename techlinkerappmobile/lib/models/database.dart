import 'package:techlinkerappmobile/models/digital_profile.dart';

class Database {
  String description;
  DigitalProfile digitalProfile;
  String iconLink;
  int id;
  String name;

  Database({
    required this.description,
    required this.digitalProfile,
    required this.iconLink,
    required this.id,
    required this.name,
  });

  //a empty constructor
  Database.empty()
      : description = '',
        digitalProfile = DigitalProfile.empty(),
        iconLink = '',
        id = 0,
        name = '';

  factory Database.fromJson(Map<String, dynamic> json) {
    return Database(
      description: json['description'],
      digitalProfile: DigitalProfile.fromJson(json['digitalProfile']),
      iconLink: json['iconLink'],
      id: json['id'],
      name: json['name'],
    );
  }
}

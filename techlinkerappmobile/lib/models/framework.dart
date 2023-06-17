import 'dart:convert';

import 'package:techlinkerappmobile/models/digital_profile.dart';

class Framework {
  String? description;
  DigitalProfile? digitalProfile;
  String? iconLink;
  int id;
  String? name;

  Framework({
    this.description,
    this.digitalProfile,
    this.iconLink,
    required this.id,
    this.name,
  });

  factory Framework.fromJson(Map<String, dynamic> json) {
    return Framework(
      description: json['description'],
      digitalProfile: DigitalProfile.fromJson(json['digitalProfile']),
      iconLink: json['iconLink'],
      id: json['id'],
      name: json['name'],
    );
  }
}

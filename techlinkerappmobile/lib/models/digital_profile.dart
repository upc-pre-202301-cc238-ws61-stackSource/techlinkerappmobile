import 'developer.dart';

class DigitalProfile {
  Developer developer;
  int id;
  String name;

  DigitalProfile({
    required this.developer,
    required this.id,
    required this.name,
  });

  factory DigitalProfile.fromJson(Map<String, dynamic> json) {
    return DigitalProfile(
      developer: Developer.fromJson(json['developer']),
      id: json['id'],
      name: json['name'],
    );
  }
}

import 'digital_profile.dart';

class Education {
  String? career;
  DigitalProfile? digitalProfile;
  int? id;

  Education({
    this.career,
    this.digitalProfile,
    this.id,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      career: json['career'],
      digitalProfile: DigitalProfile.fromJson(json['digitalProfile']),
      id: json['id'],
    );
  }


//create a toJson method
  Map<String, dynamic> toJson() {
    return {
      'career': career,
      'digitalProfile': digitalProfile,
      'id': id,
    };
  }

}

//import material package
class StudyCenterUniqueItem {
  String? description;
  Education? education;
  DateTime? entryDate;
  DateTime? graduationDate;
  String? iconUrl;
  int? id;
  String? name;
  int? progress;

  StudyCenterUniqueItem(
      {this.description,
      this.education,
      this.entryDate,
      this.graduationDate,
      this.iconUrl,
      this.id,
      this.name,
      this.progress});

  StudyCenterUniqueItem.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    education = json['education'] != null
        ? new Education.fromJson(json['education'])
        : null;
    entryDate = json['entryDate'];
    graduationDate = json['graduationDate'];
    iconUrl = json['iconUrl'];
    id = json['id'];
    name = json['name'];
    progress = json['progress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    if (this.education != null) {
      data['education'] = this.education!.toJson();
    }
    data['entryDate'] = this.entryDate;
    data['graduationDate'] = this.graduationDate;
    data['iconUrl'] = this.iconUrl;
    data['id'] = this.id;
    data['name'] = this.name;
    data['progress'] = this.progress;
    return data;
  }

  static List<StudyCenterUniqueItem> studyCenters() {
    return [
      StudyCenterUniqueItem(
        description: 'Description of School',
        entryDate: DateTime.now(),
        graduationDate: DateTime.now(),
        iconUrl:
            'https://i0.wp.com/blog.webtraining.zone/wp-content/uploads/2018/01/curso-profesional-vue.jpg?resize=825%2C510&ssl=1',
        name: 'School',
        progress: 80,
      ),
      StudyCenterUniqueItem(
        description: 'Description of Secondary School',
        entryDate: DateTime.now(),
        graduationDate: DateTime.now(),
        iconUrl:
            'https://i0.wp.com/blog.webtraining.zone/wp-content/uploads/2018/01/curso-profesional-vue.jpg?resize=825%2C510&ssl=1',
        id: 2,
        name: 'Secondary School',
        progress: 90,
      ),
      StudyCenterUniqueItem(
        description: 'Description of University',
        entryDate: DateTime.now(),
        graduationDate: DateTime.now(),
        iconUrl:
            'https://i0.wp.com/blog.webtraining.zone/wp-content/uploads/2018/01/curso-profesional-vue.jpg?resize=825%2C510&ssl=1',
        id: 3,
        name: 'University',
        progress: 75,
      ),
    ];
  }
}

class Education {
  String? career;
  DigitalProfile? digitalProfile;
  int? id;

  Education({this.career, this.digitalProfile, this.id});

  Education.fromJson(Map<String, dynamic> json) {
    career = json['career'];
    digitalProfile = json['digitalProfile'] != null
        ? DigitalProfile.fromJson(json['digitalProfile'])
        : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['career'] = career;
    if (digitalProfile != null) {
      data['digitalProfile'] = digitalProfile!.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}

class DigitalProfile {
  Developer? developer;
  int? id;
  String? name;

  DigitalProfile({this.developer, this.id, this.name});

  DigitalProfile.fromJson(Map<String, dynamic> json) {
    developer = json['developer'] != null
        ? new Developer.fromJson(json['developer'])
        : null;
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.developer != null) {
      data['developer'] = this.developer!.toJson();
    }
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Developer {
  String? bannerImage;
  String? description;
  String? email;
  String? firstName;
  int? id;
  String? image;
  String? lastName;
  String? password;
  String? phone;
  String? role;

  Developer(
      {this.bannerImage,
      this.description,
      this.email,
      this.firstName,
      this.id,
      this.image,
      this.lastName,
      this.password,
      this.phone,
      this.role});

  Developer.fromJson(Map<String, dynamic> json) {
    bannerImage = json['bannerImage'];
    description = json['description'];
    email = json['email'];
    firstName = json['firstName'];
    id = json['id'];
    image = json['image'];
    lastName = json['lastName'];
    password = json['password'];
    phone = json['phone'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bannerImage'] = this.bannerImage;
    data['description'] = this.description;
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['id'] = this.id;
    data['image'] = this.image;
    data['lastName'] = this.lastName;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['role'] = this.role;
    return data;
  }
}
